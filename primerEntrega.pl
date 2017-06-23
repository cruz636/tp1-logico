programa(fernando,cobol).
programa(fernando,visualBasic).
programa(fernando,java).
programa(julieta,java).
programa(marcos,java).
programa(santiago,java).
programa(santiago,emcascript).


rol(fernando,analistaFuncional).
rol(andres,projectLeader).
rol(Alguien,programador):- programa(Alguien,_).

proyecto(sumatra,[julieta,marcos,andres],[java,puntoNet]).
proyecto(prometeus,[fernando,santiago],[cobol]).
	
perteneceA(sumatra,Persona):-
	proyecto(sumatra,ListaDePersonas,_),
	member(Persona,ListaDePersonas).

perteneceA(prometeus,Persona):-
	proyecto(prometeus,ListaDePersonas,_),
	member(Persona,ListaDePersonas).

programadorDe(Proyecto,Persona):-
	proyecto(Proyecto,Lista,_),
	member(Persona,Lista),
	rol(Persona,programador).

estaBienAsignado(Persona,Proyecto):-
	perteneceA(Proyecto,Persona),
	rol(Persona,analistaFuncional).

estaBienAsignado(Persona,Proyecto):-
	perteneceA(Proyecto,Persona),
	rol(Persona,projectLeader).

estaBienAsignado(Persona,Proyecto):-
	perteneceA(Proyecto,Persona),
	programa(Persona,Lenguaje),
	proyecto(Proyecto,_,Lista),
	member(Lenguaje,Lista).
	
	
