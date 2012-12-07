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
		   
preco_prof([25,30,40]).

max_hextra(10).
max_hpt(10).

% Curso-Vaga
caso1([1-15,2-15,3-15]).
caso2([1-13,2-15,3-11,4-14]).
caso3([1-1,2-1,3-1,4-1,5-1]).
caso4([1-1,2-1,3-1,4-1,5-1,6-1]).
