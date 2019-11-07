saludos(['hola', 'buenas', 'Buenas noches','Buenas tardes']).

agradecimientos(['Gracias','Muchas gracias','gracias','muchas gracias'], 'Con mucho gusto').

despedidas(['Adios','Hasta luego','Cambio y fuera'],'Hasta luego').
despedidas(['adios','hasta luego','cambio y fuera'],'Hasta luego').

solicitud(['aterrizar','despegar'],'Por favor identifiquese').

emergencias(['Mayday, mayday', 'mayday, mayday']).

avionesPequenos(['cessna', 'beechcraft', 'embraerPhenom']).
avionesMedianos(['boing717', 'embraer190', 'airBusA220']).
avionesGrandes(['boing747', 'airBusA340', 'airbusA380']).

emergeciasSolicitud(['Perdida de motor', 'Llamar a Bomberos'],
      ['Parto en Medio Vuelo', 'Llamar a medico'],
      ['Paro Cardiaco de Pasajero', 'Llamar a medico'],
      ['Secuestro', 'Llamar a la OIJ y fuerza publica']).

tipoemergencia(7500,"se desplegaran los bomberos").





%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hecho principal, se encarga de escribir el texto en la terminal,
% Toma el msj que el usuario escribe, procesa y responde
% En la ListaHistorialChat se guarda un cierto historial del
% tipo de msjs que ha recibido del usuario
% MsjEsperadoTemp es lo que mayCEy esta esperando recibir en
% cada respuesta del usuario, para primer mensaje habra un '0'
chatMayCEy:-
        chatMayCEy([],'0').
chatMayCEy(ListaHistorialChat,MsjEsperadoTemp):-
        write('-Usuario: '),
	read(MsjDeUsuario),
        writeln(' '),
        writeln('-MayCEy: '),

	findall(TipoMsjRecibido,tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),ListaCompleta),
	tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),

        writeln(MsjDeMCy),
        writeln(' '),

        append(ListaHistorialChat,ListaCompleta,ListaHistorialChatNew),

	write('Lista del historial del chat: '),
	writeln(ListaHistorialChatNew),

        chatMayCEy(ListaHistorialChatNew,MsjEsperadoTemp).


/*%si es un primer mensaje de saludo
procesarMensaje(MsjDeUsuario,TipoMsjRecibido,MsjDeMCy,ListaHistorialChat,MsjEsperadoTemp):-
        MsjEsperadoTemp=='0', %el chat con el usuario apenas va a empezar
        tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),
        ListaHistorialChat=ListaHistorialChat.

%si es un primer mensaje de emergencia
procesarMensaje(MsjDeUsuario,TipoMsjRecibido,MsjDeMCy,ListaHistorialChat,MsjEsperadoTemp):-
        MsjEsperadoTemp=='0', %el chat con el usuario apenas va a empezar
        tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),
        TipoMsjRecibido=='emergencia',
        ListaHistorialChat=ListaHistorialChat.

% procesarMensaje(MsjDeUsuario,TipoMsjRecibido,MsjDeMCy,ListaHistorialChat,MsjEsperadoTemp):-
  %      MsjEsperadoTemp


% si es usa solicitud de identifiacion
procesarMensaje(MsjDeUsuario,TipoMsjRecibido,MsjDeMCy,ListaHistorialChat,MsjEsperadoTemp):-
        MsjEsperadoTemp=='identificacion',
        tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),
        ListaHistorialChat=ListaHistorialChat.

*/

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):-%saludo
        saludos(ListaSaludos),
        identificar(MsjDeUsuario,ListaSaludos),
	writeln('Saludo identificado'),
	MsjDeMCy='Hola �en que lo puedo ayudar?',
        TipoMsjRecibido='saludo'. %busca si el texto es un saludo

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %emergencia
        emergencias(ListaEmergencias),
        identificar(MsjDeUsuario,ListaEmergencias),
	writeln('Emergencia identificada'),
	MsjDeMCy='Por favor indique su emergencia',
        TipoMsjRecibido='emergencia'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %aterrizar
	identificar(MsjDeUsuario,['aterrizar']),
	writeln('Aterrizaje identificado'),
	MsjDeMCy= 'aterrizar asignado',
        TipoMsjRecibido='aterrizar'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %despegar
	identificar(MsjDeUsuario,['despegar']),
	writeln('despegue identificado'),
	MsjDeMCy= 'despegue asignado',
        TipoMsjRecibido='despegar'.
tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion
	identificar(MsjDeUsuario,['aerolinea','Aerolinea']),
	writeln('Aerolinea identificada'),
	TipoMsjRecibido='identificacion de areolinea realizada',
        MsjDeMCy='Aerolinea identificada!.'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion
        identificar(MsjDeUsuario,['matricula','Matricula']),
	writeln('Matricula identificada'),
	TipoMsjRecibido='identificacion de matricula realizada',
        MsjDeMCy='Matricula identificada!.'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion
	identificar(MsjDeUsuario,['vuelo','Vuelo']),
	writeln('Vuelo identificado'),
        TipoMsjRecibido='identificacion de vuelo realizado',
        MsjDeMCy='Vuelo identificado!.'.


tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion de aviones P
	avionesPequenos(X),
        identificar(MsjDeUsuario,X),
	writeln('identificacion de Avion Peque�o Realizada'),
        MsjDeMCy='identificacion de Avion Peque�o Realizada',
        TipoMsjRecibido='avion peque�o identidicado!.'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion de aviones M
	avionesMedianos(Y),
        identificar(MsjDeUsuario,Y),
	writeln('identificacion de Avion Mediano Realizada'),
        MsjDeMCy='identificacion de Avion Mediano Realizada',
        TipoMsjRecibido='avion mediano identidicado!.'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion de aviones G
	avionesGrandes(Z),
        identificar(MsjDeUsuario,Z),
	writeln('identificacion de Avion Grande Realizada'),
        MsjDeMCy='identificacion de Avion Grande Realizada',
        TipoMsjRecibido='avion grande identidicado!.'.


identificar(Text,Lista):-
	findall(B,sub_atom(Text,_,_,_,B),ListaPalabras),
	miembroL(Lista,ListaPalabras).

miembroL([X|R],L2):-
	miembro(X,L2);
	miembroL(R,L2).

miembro(X,[X|_]):-!.
miembro(X,[_|R]):-miembro(X,R).


responder(Texto,Resp,ElemLChat):-%agradecimiento
    agradecimientos(ListaDeAgradecimientos,Resp),
    miembro(Texto,ListaDeAgradecimientos),
    ElemLChat='agradecimiento'.

responder(Texto,Resp,ElemLChat):-%aterrizar
    identificar(Texto,'aterrizar'),
    solicitud(ListaDeSolicitud,Resp),
    miembro('aterrizar',ListaDeSolicitud),
    ElemLChat='aterrizar'.

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
        Resp='Lo siento, no entiendo tu mensaje',
        ElemLChat=' ',
        Texto=Texto. %solo para quitar el warming
