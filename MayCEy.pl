saludos(['hola','Hola','Buenas', 'buenas', 'Buenas noches','Buenas tardes']).

despedidas(['Adios','Hasta luego','adios','hasta luego','Muchas gracias, adios']).

despedidaCambioYFuera(['Cambio y fuera','cambio y fuera']).

emergencias(['Mayday, mayday', 'mayday, mayday']).

avionesPequenos(['cessna', 'beechcraft', 'embraerPhenom']).
avionesMedianos(['boing717', 'embraer190', 'airBusA220']).
avionesGrandes(['boing747', 'airBusA340', 'airbusA380']).

emergenciasSolicitud([['perdida de motor', 'Se desplazaran los Bomberos'],
      ['parto en Medio Vuelo', 'Se desplazara al medico'],
      ['paro Cardiaco de Pasajero', 'Se enviara un medico'],
      ['secuestro', 'El OIJ y fuerza publica va en camino a la pista'],
      ['7500','se desplegaran los bomberos y el cuerpo policial']]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hecho principal, se encarga de escribir el texto en la terminal,
% Toma el msj que el usuario escribe, procesa y responde
% En la ListaHistorialChat se guarda un cierto historial del
% tipo de msjs que ha recibido del usuario
% MsjEsperadoTemp es lo que mayCEy esta esperando recibir en
% cada respuesta del usuario, para primer mensaje habra un '0'
chatMayCEy:-
        chatMayCEy([]).
chatMayCEy(ListaHistorialChat):-
        writeln(' '),
	write('-Usuario: '),
	read(MsjDeUsuario),

	writeln(''),
        write('-MayCEy: '),

	%%%%%%%%%%%%%%%%%%% Se identifica si el texto ingresado esta dentro de la gramatica %%%%%%%%%%%%%%%%%%%
	findall(TipoMsjRecibido,tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),ListaCompleta),
	findall(MsjDeMCy,tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),ListaMsMayCey),

	append(ListaHistorialChat,ListaCompleta,ListaHistorialChatNew),

	%%%%%%%%%%%%%%%%%%%%%%%% Verifica si la pregunta es cambio y fuera para cortar la conversacion %%%%%%%%%%%%%%%%%%%%%
	pregunta(ListaMsMayCey),
	writeln(''),

        chatMayCEy(ListaHistorialChatNew).


tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):-%saludo
        saludos(ListaSaludos),
        identificar(MsjDeUsuario,ListaSaludos),
	%writeln('Saludo identificado'),
	MsjDeMCy='Hola �en que lo puedo ayudar?',
        TipoMsjRecibido='saludo'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):-%saludo
        despedidas(ListaDespedidas),
        identificar(MsjDeUsuario,ListaDespedidas),
	%writeln('Saludo identificado'),
	MsjDeMCy='Hasta luego',
        TipoMsjRecibido='despedida'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):-%cambioYfuera
        despedidaCambioYFuera(ListaCamYFue),
        identificar(MsjDeUsuario,ListaCamYFue),
	%writeln('Saludo identificado'),
	MsjDeMCy='Cambio Y Fuera',
        TipoMsjRecibido='CambioYFuera'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %emergencia
        emergencias(ListaEmergencias),
        identificar(MsjDeUsuario,ListaEmergencias),
	%writeln('Emergencia identificada'),
	MsjDeMCy='Por favor indique su emergencia, e identifiquese',
        TipoMsjRecibido='emergencia'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %emergenciaRespuesta
	identificarEmergencias(MsjDeUsuario,Emergencia),
	%writeln('Emergencia identificada'),
	MsjDeMCy=Emergencia,
        TipoMsjRecibido='PrimerosAuxEnviados'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %aterrizar
	identificar(MsjDeUsuario,['aterrizar']),
	%writeln('Aterrizaje identificado'),
	MsjDeMCy= 'Por favor identifiquese',
        TipoMsjRecibido='aterrizar'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %despegar
	identificar(MsjDeUsuario,['despegar']),
	%writeln('despegue identificado'),
	MsjDeMCy= 'Por favor identifiquese',
	TipoMsjRecibido='despegar'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion
	identificar(MsjDeUsuario,['aerolinea','Aerolinea']),
        identificar(MsjDeUsuario,['matricula','Matricula']),
	identificar(MsjDeUsuario,['vuelo','Vuelo']),
	%writeln('Aerolinea, Matricula, Vuelo, identificados'),
	TipoMsjRecibido='Aerolinea,Matricula,Vuelo',
        MsjDeMCy='Gracias, �Qu� tipo de Aeronave es?'.
	/*TipoMsjRecibido='Error',
        MsjDeMCy='Error, por favor identifiquese de nuevo'.*/

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion de aviones P
	avionesPequenos(X),
        identificar(MsjDeUsuario,X)->
        asignarPista('Avion Pequeno',PistaAsignada,'Este a Oeste'),
        MsjDeMCy=PistaAsignada,
        TipoMsjRecibido='avionPeque�o'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion de aviones M
	avionesMedianos(Y),
        identificar(MsjDeUsuario,Y)->
        asignarPista('Avion Mediano',PistaAsignada,'Este a Oeste'),
        MsjDeMCy=PistaAsignada,
        TipoMsjRecibido='avionMediano'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion de aviones G
	avionesGrandes(Z),
        identificar(MsjDeUsuario,Z)->
	asignarPista('Avion Grande',PistaAsignada,'Este a Oeste'),
        MsjDeMCy=PistaAsignada,
        TipoMsjRecibido='avionGrande'.


%%%%%%%%%%%%%%%%%%%%%%%%%Preguntas%%%%%%%%%%%%%%%%%%%%%%%%%%%

pregunta([]):-!.
pregunta([C|Lista]):-
	Lista==[]->write(C);
	pregunta(Lista).


%%%%%%%%%%%%%%%%%%%%%%%%%%Pistas%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
asignarPista(Avion,Pista,Direccion):-
    Avion=='Avion Pequeno'->Pista='P1 asignada',!;
    Avion=='Avion Grande'->Pista='P3 asignada',!;
    Avion=='Avion Mediano'->Direccion == 'Este a Oeste',Pista='P2-1 asignada',!;
    Avion=='Avion Mediano'->Direccion == 'Oeste a Este',Pista='P2-2 asignada'.


%%%%%%%%%%%%%%%%%%%%%Identificacion de Palabras%%%%%%%%%%%%%%%%%%%%%%%

identificar(Text,Lista):-
	findall(B,sub_atom(Text,_,_,_,B),ListaPalabras),
	miembroL(Lista,ListaPalabras).


%%%%%%%%%%%%%%%%%%%%Identificacion de Emergencias%%%%%%%%%%%%%%%%%%%%
identificarEmergencias(Text,Emergencia):-
	findall(B,sub_atom(Text,_,_,_,B),ListaPalabras),
	emergenciasSolicitud(L),
	auxEmergencias(L,ListaPalabras,Emergencia).

auxEmergencias([[X|[Y|_]]|R],ListaPalabras,Emergencia):-
	miembro(X,ListaPalabras),
	Emergencia=Y,!;
	auxEmergencias(R,ListaPalabras,Emergencia).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

miembroL([X|R],L2):-
	miembro(X,L2);
	miembroL(R,L2).

miembro(X,[X|_]):-!.
miembro(X,[_|R]):-miembro(X,R).
