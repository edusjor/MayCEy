saludos(['hola', 'buenas', 'Buenas noches','Buenas tardes'], 'Hola �en que lo puedo ayudar?').

emergencias(['Mayday, mayday', 'mayday, mayday'], 'Buenas, por favor indique su emergencia').

agradecimientos(['Gracias', 'Muchas gracias'], 'Con mucho gusto').
agradecimientos(['gracias', 'muchas gracias'], 'Con mucho gusto').

despedidas(['Adios','Hasta luego','Cambio y fuera'],'Hasta luego').
despedidas(['adios','hasta luego','cambio y fuera'],'Hasta luego').

solicitud(['aterrizar','despegar'],'Por favor identifiquese').

emergeciasSolicitud(["Perdida de motor", "Llamar a Bomberos"],
      ["Parto en Medio Vuelo", "Llamar a médico"],
      ["Paro Cardiaco de Pasajero", "Llamar a médico"],
      ["Secuestro", "Llamar a la OIJ y fuerza pública"]).

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
        write('-MayCEy: '),

        procesarMensaje(MsjDeUsuario,TipoMsjRecibido,MsjDeMCy,ListaHistorialChat,MsjEsperadoTemp), %procesa el texto y recibe la respuesta para el usuario
        writeln(MsjDeMCy),
        writeln(' '),

        append(ListaHistorialChat, [TipoMsjRecibido],ListaHistorialChatNew),

        chatMayCEy(ListaHistorialChatNew,MsjEsperadoTemp).


%si es un primer mensaje de saludo
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













%para verificar si X elemento es miembro de una lista
miembro(X,[X|_]).
miembro(X,[_|R]):-miembro(X,R).

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):-%saludo
        saludos(ListaSaludos,MsjDeMCy),
        miembro(MsjDeUsuario,ListaSaludos),
        TipoMsjRecibido='saludo'. %busca si el texto es un saludo

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %emergencia
        saludos(ListaEmergencias,MsjDeMCy),
        miembro(MsjDeUsuario,ListaEmergencias),
        TipoMsjRecibido='emergencia'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion

        identificar(MsjDeUsuario,'Vuelo'),
        identificar(MsjDeUsuario,'Aerolinea'),
        identificar(MsjDeUsuario,'Matricula'),
        TipoMsjRecibido='identificacion',
        MsjDeMCy='Gracias!.'.








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

identificar(Text,Palabra):-
	findall(B,sub_atom(Text,_,_,_,B),ListaPalabras),
	%mostrar(ListaPalabras),
	miembro(Palabra,ListaPalabras).
	%write('Palabra indetificada').
