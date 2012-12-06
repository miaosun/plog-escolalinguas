
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

   
profs(['Annete','Charles','Boris','ABC']).

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
caso3([1-12,2-11,3-14,4-15,5-13]).
caso4([1-13,2-14,3-13,4-15,5-14,6-14]).

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

nth_member(1,[X|_],X).
nth_member(N,[_|L],X):-
	N>1, M is N-1,
	nth_member(M,L,X).

aplica_prof_aux([],_).	
aplica_prof_aux([IndispProf1|T],NProf1):-
		NProf1 #\= IndispProf1, aplica_prof_aux(T,NProf1).
												
aplica_prof(_IndispProfCurso,[],_NProf).
aplica_prof(IndispProfCurso,[Ind1|Resto],[NProf1|NProfResto]):-
		nth_member(Ind1,IndispProfCurso,IndispProf), aplica_prof_aux(IndispProf,NProf1),
		aplica_prof(IndispProfCurso,Resto,NProfResto).
		
		
		
horas_por_professor(_,_,HProf,0).
horas_por_professor(HCurso,NProf,HProf,NP):-
				horas_aux(HCurso,NProf,NP,Acum,Total),
				element(NP,HProf,Acum),
				NP1#=NP-1,
				horas_por_professor([HCurso,NProf,HProf,NP1).
					
horas_aux([],[],_,Acum,Total):- write(Total).				
horas_aux([HC|TC],[HP|TP],N,Acum,Total) :- (N #= HP) #=> (Total #= Acum+HC),
		horas_aux([TC],[TP],N,Acum,Total).

/*
abc([],_).
abc([H1|T1],[H|T]) :-
			abc([T1],[T]), H = H1.
			*/
			
print_plano([],[]).				
print_plano([H|Hs],[P|Ps],ListaProfs,[C|Cs]):-	
				write(' Curso de '), write(C), nl,
				element(P,[ListaProfs],NomeP),
				write(' Professor: '), write(NomeP), nl,
				write('Numero Horas Semanais: '), write(H), nl,
				print_plano(Hs,Ps,ListaProfs,Cs).
						
escola(Caso):-
		%Sol = [NProf-HCurso], %HoraExtFun, PartTime], 
		%HCurso = [HEsp, HFra, HIng],
%		HProf = [HAnn, HCha, HBor],	
%		List = [HEsp, HFra, HIng, HAnn, HCha, HBor],		
%		HoraExtFun in 0..15,
%		PartTime in 0..10,

		length(Caso,N), length(HCurso,N), length(NProf,N),
		profs(ListaProfs), length(ListaProfs,NP),
		
		domain(HCurso,4,8), % lista com as horas de cada curso (indice)
		domain(NProf,1,3),  % lista c professor p cada curso (indice)
		
		%curso_prof(CursoProf), prof_curso(ProfCurso),
		indisp_prof_curso(IndispProfCurso),
	
		sep_caso(Caso,[],IndCurso,TotalVaga),
		aplica_prof(IndispProfCurso,IndCurso,NProf),
		verifica_nr_cursos_prof(NProf,NP),
		
		sum(HCurso,#=,TotalHCurso),
		%sum(HProf,#=,TotalHProf),

		Income #= TotalHCurso*TotalVaga*10, % receita total por semana
		
%		ext_Fun(TotalHCurso,CustoExt),
		
		%%%%%%%%%%%%%%%%%%falta implementar HProf%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		%%%%%    HCurso([H1,H2,H3,H4,H5])
		%%%%%    NProf([ 1,3, 1, 2, 3])
		%%%%%    HProf([H1+H3,H4,H2+H5]).
		%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
		horas_por_professor(HCurso,NProf,HProf,NP),
		

		domain(hExtra,0,5), domain(hPt,0,10),
		(N*15) <= 2*40 + 2*hExtra + hPt,
		CustoFunc #= (2*40*15 + 2*hExtra*25 + hPt*10),
		
		scalar_product([25,30,40],HProf,#=,CustoProf),
		%CustoFun #= 2*40*15 + CustoExt,
		%Income#>CustoProf #/\ Income#>2*40*15,
		LucroSemanal #= Income - CustoProf - HFunc,
		%LucroSemanal #> 0,
		
		labeling([maximize(LucroSemanal)],List),
		write('Maximo Lucro Semanal: '), write(LucroSemanal), nl,
		write('Plano:'),nl,
		
		%criar ListaCursos com nomes dos cursos de IndCursos
		print_plano(HCurso,NProf,ListaProfs,ListaCursos).
		
		

		solve(Caso):-
		statistics(walltime,[Start,_]),
        nl, escola(Caso),
		statistics(walltime,[End,_]), 
		Time is End - Start,
		nl, format('Solutions in ~3d seconds.~n', [Time]),nl,
        fd_statistics,nl.	
		
		
		
/*		
ext_Fun(TotalHCurso, CustoExt):-
		MaxHFun = 2*40,
		((TotalHCurso =< MaxHFun, CustoExt = 0);		
		 (HoraExt #= TotalHCurso-MaxHFun,		 
		  HoraExtFun in 1..10, %25€/h (sao 2 funcionarios)
		  PartTime in 1..10,  %10€/h		  
		  %HoraExt #= HoraExtFun + PartTime,		 
		  CustoExtFun #= 25*HoraExtFun,
		  CustoPartTime #= 10*PartTime,
		  CustoExt #= CustoExtFun + CustoPartTime,
		  labeling([minimize(CustoExt)],[HoraExt,PartTime]))).
*/		
		
		
	
		
		
		
		
		
		
		
		
		
		