programa(fernando,cobol).
programa(fernando,visualBasic).
programa(fernando,java).
programa(julieta,java).
programa(marcos,java).
programa(santiago,java).
programa(santiago,ecmsScript).
rol(fernando,analistaFuncional).
rol(andres,projectLeader).

lenguaje(cobol).
lenguaje(visualBasic).
lenguaje(java).
lenguaje(puntoNet).
lenguaje(ecmsScript).

proyecto(sumatra,[julieta,marcos,andres],[java,puntoNet]).
proyecto(prometeus,[fernando,santiago],[cobol]).


persona(Alguien):- esProgramador(Alguien).
persona(Alguien):- rol(Alguien,_).

esProgramador(Alguien):- programa(Alguien,_).

lenguajeProyecto(Proyecto,Lista):-
	esProyecto(Proyecto),
	proyecto(Proyecto,_,Lista).


esProyecto(Proyecto):- proyecto(Proyecto,_,_).

perteneceA(sumatra,Persona):-
	findall(Personas,proyecto(sumatra,Personas,_),ListaDe),
	flatten(ListaDe,Lista),
	member(Persona,Lista).

perteneceA(prometeus,Persona):-
	findall(Personas,proyecto(prometeus,Personas,_),ListaDe),
	flatten(ListaDe,Lista),
	member(Persona,Lista).

programadorDe(Proyecto,Persona):-
	findall(Personas,proyecto(Proyecto,Personas,_),ListaDe),
	flatten(ListaDe,Lista),
	member(Persona,Lista),
	esProgramador(Persona).

estaOk(Persona,Proyecto):- esProyecto(Proyecto),
	perteneceA(Proyecto,Persona),
	rol(Persona,analistaFuncional).

estaOk(Persona,Proyecto):- esProyecto(Proyecto),
	perteneceA(Proyecto,Persona),
	rol(Persona,projectLeader).

estaOk(Persona,Proyecto):-
	perteneceA(Proyecto,Persona),
	esProyecto(Proyecto),
	programa(Persona,Lenguaje),
	proyecto(Proyecto,_,Lista),
	member(Lenguaje,Lista).


miembrosBienAsignadosA(sumatra,Lista):-
	findall(Persona,estaOk(Persona,sumatra),Lista).

miembrosBienAsignadosA(prometeus,Lista):-
	findall(Persona,estaOk(Persona,prometeus),Lista).

miembrosBienAsignados(Lista):-
	esProyecto(Proyecto),
	findall(Personas,miembrosBienAsignadosA(Proyecto,Personas),Miembros),
	flatten(Miembros,Lista).

proyectoBienDefinido(Proyecto):-
	esProyecto(Proyecto),
	forall(perteneceA(Proyecto,Persona),estaOk(Persona,Proyecto)),
	findall(Persona,(perteneceA(Proyecto,Persona),rol(Persona,projectLeader)),Personas),
	length(Personas,C),
	C is 1.


tarea(fernando, evolutiva(compleja)).  
tarea(fernando, correctiva(8, brainfuck)).
tarea(fernando, algoritmica(150)).
tarea(marcos, algoritmica(20)).
tarea(julieta, correctiva(412, cobol)).
tarea(julieta, correctiva(21, go)).
tarea(julieta, evolutiva(simple)).

esTarea(Tarea):-
	findall(Tarea,tarea(_,Tarea),ListaDeTareas),
	member(Tarea,ListaDeTareas).

gradoDeSeniority(Programador,0):-
	persona(Programador),
	not(tarea(Programador,_)).


gradoDeSeniority(Programador,Grado):-
	persona(Programador),
	findall(Tarea,tarea(Programador,Tarea),ListaDeTareas),
	findall(Puntos,(esTarea(Tarea),member(Tarea,ListaDeTareas),puntos(Tarea,Puntos)),ListaDePuntos),
	sumlist(ListaDePuntos,Grado).

puntos(evolutiva(simple),3).
puntos(evolutiva(compleja),5).

puntos(correctiva(_,brainfuck),4).
puntos(correctiva(Lineas,_),4):-
	Lineas > 50.
puntos(correctiva(Lineas,_),0):-
	Lineas < 50.

puntos(algoritmica(Lineas),Puntos):-
	Puntos is Lineas/10.

grado(ListaDePuntos,Grado):-
	sumlist(ListaDePuntos,Grado).
