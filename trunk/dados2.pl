% Cursos = [Espanhol,Frances,Ingles,Italiano,Alemao,Russo,Portugues,Chines,Coreano]
%              1        2      3       4       5      6       7       8       9

profs(['Annete','Charles','Boris','Jorge','Miao']).
curso(1,'Espanhol').
curso(2,'Frances').
curso(3,'Ingles').
curso(4,'Italiano').
curso(5,'Alemao').
curso(6,'Russo').
curso(7,'Portugues').
curso(8,'Chines').
curso(9,'Coreano').

/*
curso_prof([1,2,5,7],    %Prof. Annette
		   [1,3,4,6],    %Prof. Charles
		   [1,2,4,6,7],  %Prof. Boris
		   [1,3,7,9],    %Prof. Jorge
		   [3,7,8,9]).   %Prof. Miao
*/
   
indisp_prof_curso([[5],[2,4,5],[1,3],[1,4,5],[2,3,4,5],[1,4,5],[2],[1,2,3,4],[1,2,3]]).
		   
preco_prof([25,30,40,35,35]).

max_hextra(30).
max_hpt(30).

% Curso-Vaga
caso1([1-15,2-15,3-15,5-15,8-15]).
caso2([1-13,3-11,4-8,5-14,7-10,8-15]).
caso3([2-9,3-8,4-5,5-10,6-2,7-9,8-12,9-9]).
caso4([1-1,2-7,3-12,4-6,5-2,6-3,7-10,8-12,9-10]).




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%        Resultados das opcoes de labeling          %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
 
 Labeling  maximize(LucroSemanal)
 ----------------------------------------------
| C\Op | normal|   ff  |  ffc  |  min  |  max  |
 ----------------------------------------------
|Caso1 | 0.175 | 0.177 | 0.180 | 0.193 | 0.185 |
 ----------------------------------------------
|Caso2 | 0.232 | 0.208 | 0.226 | 0.219 | 0.221 |
 ----------------------------------------------
|Caso3 | 0.326 | 0.295 | 0.291 | 0.287 | 0.310 |
 ----------------------------------------------
|Caso4 | 0.362 | 0.357 | 0.376 | 0.322 | 0.381 |
 ----------------------------------------------