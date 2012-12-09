﻿% Cursos = [Espanhol,Frances,Ingles,Italiano,Alemao,Russo,Portugues]
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




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%        Resultados das opcoes de labeling          %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
/*
 Labeling Normal (maximize(LucroSemanal)
 -----------------------------------------------
| Ca\Te | test1 | test2 | test3 | test4 | test5 |
 -----------------------------------------------
| Caso1 | 0.142 | 0.131 | 0.142 | 0.139 | 0.146 |
 -----------------------------------------------
| Caso2 | 0.165 | 0.173 | 0.173 | 0.165 | 0.165 |
 -----------------------------------------------
| Caso3 | 0.198 | 0.198 | 0.200 | 0.186 | 0.178 |
 -----------------------------------------------
| Caso4 | 0.225 | 0.220 | 0.237 | 0.219 | 0.210 |
 -----------------------------------------------
 
  Labeling ff (maximize(LucroSemanal)
 -----------------------------------------------
| Ca\Te | test1 | test2 | test3 | test4 | test5 |
 -----------------------------------------------
| Caso1 | 0.142 | 0.139 | 0.144 | 0.130 | 0.133 |
 -----------------------------------------------
| Caso2 | 0.169 | 0.159 | 0.170 | 0.151 | 0.193 |
 -----------------------------------------------
| Caso3 | 0.194 | 0.206 | 0.198 | 0.199 | 0.193 |
 -----------------------------------------------
| Caso4 | 0.216 | 0.222 | 0.214 | 0.226 | 0.204 |
 -----------------------------------------------

  Labeling ffc (maximize(LucroSemanal)
 -----------------------------------------------
| Ca\Te | test1 | test2 | test3 | test4 | test5 |
 -----------------------------------------------
| Caso1 | 0.137 | 0.149 | 0.142 | 0.138 | 0.142 |
 -----------------------------------------------
| Caso2 | 0.162 | 0.165 | 0.165 | 0.156 | 0.170 |
 -----------------------------------------------
| Caso3 | 0.187 | 0.193 | 0.195 | 0.177 | 0.183 |
 -----------------------------------------------
| Caso4 | 0.210 | 0.208 | 0.223 | 0.224 | 0.225 |
 -----------------------------------------------
 
   Labeling min (maximize(LucroSemanal)
 -----------------------------------------------
| Ca\Te | test1 | test2 | test3 | test4 | test5 |
 -----------------------------------------------
| Caso1 | 0.139 | 0.138 | 0.141 | 0.138 | 0.139 |
 -----------------------------------------------
| Caso2 | 0.168 | 0.163 | 0.171 | 0.161 | 0.168 |
 -----------------------------------------------
| Caso3 | 0.179 | 0.198 | 0.197 | 0.193 | 0.197 |
 -----------------------------------------------
| Caso4 | 0.221 | 0.217 | 0.222 | 0.218 | 0.215 |
 -----------------------------------------------
 
    Labeling max (maximize(LucroSemanal)
 -----------------------------------------------
| Ca\Te | test1 | test2 | test3 | test4 | test5 |
 -----------------------------------------------
| Caso1 | 0.133 | 0.141 | 0.143 | 0.147 | 0.145 |
 -----------------------------------------------
| Caso2 | 0.167 | 0.154 | 0.168 | 0.170 | 0.176 |
 -----------------------------------------------
| Caso3 | 0.191 | 0.197 | 0.184 | 0.192 | 0.205 |
 -----------------------------------------------
| Caso4 | 0.225 | 0.212 | 0.199 | 0.208 | 0.219 |
 -----------------------------------------------
 
  Labeling  maximize(LucroSemanal)
 ----------------------------------------------
| C\Op | normal|   ff  |  ffc  |  min  |  max  |
 ----------------------------------------------
|Caso1 | 0.140 | 0.137 | 0.141 | 0.139 | 0.142 |
 ----------------------------------------------
|Caso2 | 0.168 | 0.168 | 0.164 | 0.166 | 0.167 |
 ----------------------------------------------
|Caso3 | 0.192 | 0.198 | 0.187 | 0.193 | 0.194 |
 ----------------------------------------------
|Caso4 | 0.222 | 0.216 | 0.218 | 0.219 | 0.213 |
 ----------------------------------------------


*/