
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
%              1        2       3       4       5      6      7            

curso([1,2,5,7],    %Prof. Annette
      [1,3,4,6],  %Prof. Charles
	  [1,2,4,6,7]). %Prof. Boris

precoProf([25,30,40]).

% Curso-Vaga
caso1([1-15,2-15,3-15]).
caso2([1-13,2-15,3-11,4-14]).
caso3([1-12,2-11,3-14,4-15,5-13]).
caso4([1-13,2-14,3-13,4-15,5-14,6-14]).

solve(Caso,Sol):-
		statistics(walltime,[Start,_]),
        nl, escola(Caso,Sol),
		statistics(walltime,[End,_]), 
		Time is End - Start,
		nl, format('Solutions in ~3d seconds.~n', [Time]),nl,
        fd_statistics,nl.
		
escola(Caso,Sol):-
		Sol = [HCurso, HProf], %HoraExtFun, PartTime], 
		%HCurso = [HEsp, HFra, HIng],
		HProf = [HAnn, HCha, HBor],
		
		List = [HEsp, HFra, HIng, HAnn, HCha, HBor],
		
		length(Caso,N), length(HCurso,N),
		domain(HCurso,4,8),
		domain(HProf,4,16),
		
%		HoraExtFun in 0..15,
%		PartTime in 0..10,
		
		sum(HCurso,#=,TotalHCurso),
				
		Income #= TotalHCurso*TotalVaga*10,
		
%		ext_Fun(TotalHCurso,CustoExt),
		
		scalar_product([25,30,40],HProf,#=,CustoProf),
		%CustoFun #= 2*40*15 + CustoExt,
		Income#>CustoProf #/\ Income#>2*40*15,
		LucroSemanal #= Income - CustoProf - 2*40*15,
		LucroSemanal #> 0,
		
		labeling([maximize(LucroSemanal)],List),
		write('Maximo Lucro Semanal: '), write(LucroSemanal), nl,
		write('Plano:'),nl,
		write('   Hora do Curso Espanhol: '), write(HEsp), nl,
		write('   Hora do Curso Frances:  '), write(HFra), nl,
		write('   Hora do Curso Ingles:   '), write(HIng), nl.
		%write(Sol),nl.

		
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
		
		
		
		
		
		
		
		
		
		
		
		
		