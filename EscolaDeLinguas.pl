﻿
% 3x Professores
%  Prof. Annette: Frances, Portugues, Espanhol, Alemao
%  Prof. Boris:   Russo, Italiano, Frances, Espanhol, Portugues
%  Prof. Charles: Ingles, Cubano, Espanhol, Russo, Italiano

% 2x Funcionarias administrativas
% 2x Salas

% Cursos: Espanhol, Frances, Ingles, (Italiano, Alemao, Russo)

% Restricoes:
%  cada Curso (4h-8h)/semana
%  cada Professor (1/2)/cursos
%  Annette 25€/h,  Boris 40€/h,  Charles 30€/h
%  Manutencao 15h/Curso/Funcionaria
%  Cada funcionaria trabalha 40h/semana, 15€/h,  (pode trabalhar (1h-5h)/semana extra, 25€/h, ou contratar uma funcionaria part-time, trabalha (1h-10h)/semana, 10€/h)
%  Cada sala so pode ter uma aula de cada vez
%  Cada aluno paga 10€/h
%  Cada curso tem duracao de 1 ano

% Objectivo:
%  maximizar o lucro, reduzindo os custos operacionais
%  admitindo que cada curso preenchera as vagas disponiveis (15/curso)

% Income: 10*NAlunos*HorasCurso  *  NCursos
% Outcome: 
%     Salario Professores: (25  +  30  +  40)*Horas, Horas in 4..16
%     Salario Funcionarios: 

:- use_module(library(clpfd)).
:- use_module(library(lists)).

% Cursos = [Espanhol,Frances,Ingles,Italiano,Alemao,Russo,Portugues]
%              1        2      3       4       5      6       7         

profs(['Annete','Charles','Boris']).
curso(1,'Espanhol').
curso(2,'Frances').
curso(3,'Ingles').
curso(4,'Italiano').
curso(5,'Alemao').
curso(6,'Russo').
curso(7,'Portugues').

/*
curso_prof([1,2,5,7],    %Prof. Annette
		   [1,3,4,6],    %Prof. Charles
		   [1,2,4,6,7]). %Prof. Boris
*/

%prof_curso([[1,2,3],[1,3],[2],[2,3],[1],[2,3],[1,3]]).		   
indisp_prof_curso([[],[2],[1,3],[1],[2,3],[1],[2]]).
		   
%precoProf([25,30,40]).

% Curso-Vaga
caso1([1-15,2-15,3-15]).
caso2([1-13,2-15,3-11,4-14]).
caso3([1-1,2-1,3-1,4-1,5-1]).
caso4([1-1,2-1,3-1,4-1,5-1,6-1]).

%IndCurso - lista dos indices dos cursos,  TotalVaga - Somatorio das vagas de tudos cursos
sep_caso([],IndCurso,IndCurso,0).
sep_caso([NCurso-Vaga|Resto],Acc,IndCurso,TotalVaga):-
		sep_caso(Resto,[NCurso|Acc],IndCurso,Acum),
		TotalVaga is Acum+Vaga.

% verifica se nr de cursos de cada professor está entre 1 e 2
verifica_nr_cursos_prof(_,0).
verifica_nr_cursos_prof(NProf,N):- count(N,NProf,#=,Count),Count#=1 #\ Count#=2,
						N1 is N-1,
						verifica_nr_cursos_prof(NProf,N1).

aplica_prof_aux([],_).	
aplica_prof_aux([IndispProf1|T],NProf1):-
		NProf1 #\= IndispProf1, aplica_prof_aux(T,NProf1).
												
aplica_prof(_IndispProfCurso,[],_NProf).
aplica_prof(IndispProfCurso,[Ind1|Resto],[NProf1|NProfResto]):-
		nth1(Ind1,IndispProfCurso,IndispProf), aplica_prof_aux(IndispProf,NProf1),
		aplica_prof(IndispProfCurso,Resto,NProfResto).

horas_por_professor(_,_,_HProf,0).
horas_por_professor(HCurso,NProf,HProf,NP):-
				horas_aux(HCurso,NProf,NP,Total),
				nth1(NP,HProf,Total),
				NP1 is NP-1,
				horas_por_professor(HCurso,NProf,HProf,NP1).
					
horas_aux([],[],_,0).				
horas_aux([HCurso1|HResto],[NProf1|NResto],NP,Total):-
		(NP #= NProf1) #<=> A, horas_aux(HResto,NResto,NP,Acum),
		Total #= Acum+HCurso1*A.
		
print_plano([],[],_,_).				
print_plano([H|Hs],[P|Ps],ListaProfs,[Ind1|Inds]):-	
				write(' Curso de '), curso(Ind1,Curso), write(Curso), nl,
				nth1(P,ListaProfs,NomeP),
				write('    Professor: '), write(NomeP), nl,
				write('    Numero Horas Semanais: '), write(H), nl,
				print_plano(Hs,Ps,ListaProfs,Inds).

						
escola(Caso):-
		length(Caso,N), length(HCurso,N), length(NProf,N),
		profs(ListaProfs), length(ListaProfs,NP),length(HProf,NP),
		
		domain(HCurso,4,8), % lista com as horas de cada curso (indice)
		domain(NProf,1,3),  % lista c professor p cada curso (indice)
		
		%curso_prof(CursoProf), prof_curso(ProfCurso),
		indisp_prof_curso(IndispProfCurso),	
		sep_caso(Caso,[],IndCurso,TotalVaga),
		aplica_prof(IndispProfCurso,IndCurso,NProf),
		verifica_nr_cursos_prof(NProf,NP),
		
		sum(HCurso,#=,TotalHCurso),
		Income #= TotalHCurso*TotalVaga*10, % receita total por semana

		horas_por_professor(HCurso,NProf,HProf,NP),		

		HExtra in 0..10, HPt in 0..10,
		(N*15) #=< 2*40 + HExtra + HPt,
		CustoFunc #= (2*40*15 + HExtra*25 + HPt*10),
		
		scalar_product([25,30,40],HProf,#=,CustoProf),

		%Income#>CustoProf+CustoFunc,
		LucroSemanal #= Income - CustoProf - CustoFunc,
		List=[HExtra,HPt],
		append(HCurso,NProf,L1),
		labeling([minimize(CustoFunc)],List),
		labeling([maximize(LucroSemanal)],L1),
		
		write('Maximo Lucro Semanal: '), write(LucroSemanal), nl,
		write('Plano:'),nl,		
		%criar ListaCursos com nomes dos cursos de IndCursos
		print_plano(HCurso,NProf,ListaProfs,IndCurso).
		
		
solve(Caso):-
		statistics(walltime,[Start,_]),
        nl, escola(Caso),
		statistics(walltime,[End,_]), 
		Time is End - Start,
		nl, format('Solutions in ~3d seconds.~n', [Time]),nl,
        fd_statistics,nl.	
	

		
	
		
		
		
		
		
		
		
		
		
		