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
	findall(Persona,proyecto(sumatra,Persona,_),ListaDe),
	flatten(ListaDe,Lista),
	member(Persona,Lista).

perteneceA(prometeus,Persona):-
	findall(Persona,proyecto(prometeus,Persona,_),ListaDe),
	flatten(ListaDe,Lista),
	member(Persona,Lista).


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


miembrosBienAsignados(Lista):-
	findall(Persona,estaOk(Persona,_),Lista).
