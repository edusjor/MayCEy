saludos(['hola', 'buenas', 'Buenos días','Buenas tardes'], "Hola ¿en qué lo puedo ayudar?").

emergencias(['Mayday, mayday', 'mayday, mayday'], "Buenas, por favor indique su emergencia").

agradecimientos(['Gracias', 'Muchas gracias'], "Con mucho gusto").
agradecimientos(['gracias', 'muchas gracias'], "Con mucho gusto").

despedidas(['Adios','Hasta luego','Cambio y fuera'],"Hasta luego").
despedidas(['adios','hasta luego','cambio y fuera'],"Hasta luego").

emergeciasSolicitud(["Perdida de motor", "Llamar a Bomberos"],
      ["Parto en Medio Vuelo", "Llamar a médico"],
      ["Paro Cardiaco de Pasajero", "Llamar a médico"],
      ["Secuestro", "Llamar a la OIJ y fuerza pública"]).

tipoemergencia(7500,"se desplegaran los bomberos").




oracion(S0,S):- sintagma_nominal(S0,S1),
sintagma_verbal(S1,S).
sintagma_nominal(S0,S):- determinante(S0,S1),
nombre(S1,S).
sintagma_verbal(S0,S):- verbo(S0,S).
sintagma_verbal(S0,S):- verbo(S0,S1),sintagma_nominal(S1,S).
determinante([el|S],S).
determinante([la|S],S).
nombre([hombre|S],S).
nombre([manzana|S],S).
verbo([come|S],S).



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hecho principal, se en carga de escribir el texto en la terminal,
% Toma el texto que el usuario escribe, procesarlo y responderle
% En la ListaChat se guarda un cierto historial de lo que la
% conversación con el usuario ha sido para que con cada mensaje que
% envia el usuario, el bot pueda recordar que es lo que han estado
% hablando
chatMayCEy(ListaChat):-
        write('-Usuario: '),
	read(Texto),

        writeln(' '),
        write('-MayCEy: '),

        responder(Texto,Resp,ElemLChat), %procesa el texto y recibe la respuesta para el usuario
        writeln(Resp),
        writeln(' '),

        append(ListaChat, [ElemLChat], ListaChatResult), %se agrega a la lista los detalles para
                                                         %recordar de lo que va el chat(saludo,emergencia,id,despedida)
        chatMayCEy(ListaChatResult).




%para verificar si X elemento es miembro de una lista
miembro(X,[X|_]).
miembro(X,[_|R]):-miembro(X,R).

responder(Texto,Resp,ElemLChat):-%saludo
        saludos(ListaSaludos,Resp),
        miembro(Texto,ListaSaludos),
        ElemLChat='saludo'. %busca si el texto es un saludo

responder(Texto,Resp,ElemLChat):-%emergencia
    emergencias(ListaDeEmergencias,Resp),
    miembro(Texto,ListaDeEmergencias),
    ElemLChat='emergencia'.

responder(Texto,Resp,ElemLChat):-%agradecimiento
    agradecimientos(ListaDeAgradecimientos,Resp),
    miembro(Texto,ListaDeAgradecimientos),
    ElemLChat='agradecimiento'.

responder(Texto,Resp,ElemLChat):-%despedida
    despedidas(ListaDeDespedidas,Resp),
    miembro(Texto,ListaDeDespedidas),
    Texto \= "Cambio y fuera",
    Texto \= "cambio y fuera",
    ElemLChat='despedida'.

responder(Texto,Resp,ElemLChat):-%despedida cambio y fuera, responde un mensaje vacio
    Texto == "Cambio y fuera",
    Resp = " ",
    ElemLChat='fin chat'.

responder(Texto,Resp,ElemLChat):-%si entra aqui es porque no hubo coincidencia
        Resp="Lo siento, no entiendo tu mensaje",
        ElemLChat='',
        Texto=" ". %solo para quitar el warming

