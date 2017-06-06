programa(fernando,cobol).
programa(fernando,visualBasic).
programa(fernando,java).
programa(julieta,java).
programa(marcos,java).
programa(santiago,java).
programa(santiago,ecmsScript).
rol(fernando,analistaFuncional).
rol(andres,projectLeader).

persona(Alguien):- esProgramador(Alguien).
persona(Alguien):- rol(Alguien,_).

lenguaje(cobol).
lenguaje(visualBasic).
lenguaje(java).
lenguaje(puntoNet).
lenguaje(ecmsScript).

esProgramador(Alguien):- programa(Alguien,_).


proyecto(sumatra,[julieta,marcos,andres],[cobol]).
proyecto(prometeus,[fernando,santiago],[java,puntoNet]).
esProyecto(Proyecto):- proyecto(Proyecto,_,_).

estaOk(Persona,Proyecto):- esProyecto(Proyecto),
	rol(Persona,analistaFuncional).

estaOk(Persona,Proyecto):- esProyecto(Proyecto),
	rol(Persona,projectLeader).

estaOk(Persona,Proyecto):-
	persona(Persona),
  esProyecto(Proyecto),
	programa(Persona,Lenguaje),
	proyecto(Proyecto,_,Lista),
	member(Lenguaje,Lista).


