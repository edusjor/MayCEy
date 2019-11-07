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

pista('P1', 1, '').
pista('P2-1', 2, 'Este a Oeste').
pista('P2-2', 2, 'Oeste a Este').
pista('P3', 3, '').


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
        writeln(' '),
	write('-Usuario: '),
	read(MsjDeUsuario),

        writeln(' '),
        write('-MayCEy: '),

	%%%%%%%%%%%%%%%%%%% Se identifica si el texto ingresado esta dentro de la gramatica %%%%%%%%%%%%%%%%%%%
	findall(TipoMsjRecibido,tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),ListaCompleta),
	findall(MsjDeMCy,tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),ListaMsMayCey),

	append(ListaHistorialChat,ListaCompleta,ListaHistorialChatNew),

	%%%%%%%%%%%%%%%%%%%%%%%% Verifica si la pregunta es cambio y fuera para cortar la conversacion %%%%%%%%%%%%%%%%%%%%%
	pregunta(ListaMsMayCey),
	pregunta=='Cambio Y Fuera'->!;
	writeln(' '),

        chatMayCEy(ListaHistorialChatNew,MsjEsperadoTemp).


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
        identificar(MsjDeUsuario,X),
	%writeln('identificacion de Avion Peque�o Realizada'),
        MsjDeMCy='Avion Peque�o Identificado',
        TipoMsjRecibido='avionPeque�o'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion de aviones M
	avionesMedianos(Y),
        identificar(MsjDeUsuario,Y),
	%writeln('identificacion de Avion Mediano Realizada'),
        MsjDeMCy='Avion Mediano Identificado',
        TipoMsjRecibido='avionMediano'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion de aviones G
	avionesGrandes(Z),
        identificar(MsjDeUsuario,Z),
	%writeln('identificacion de Avion Grande Realizada'),
        MsjDeMCy='Avion Grande Identificado',
        TipoMsjRecibido='avionGrande'.


%%%%%%%%%%%%%%%%%%%%%%%%%Preguntas%%%%%%%%%%%%%%%%%%%%%%%%%%%

pregunta([]):-!.
pregunta([C|Lista]):-
	Lista==[]->write(C);
	pregunta(Lista).


%%%%%%%%%%%%%%%%%%%%%%%%%%Pistas%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

asignarPista(Avion, Vel, Dir):-
    verificarVelocidad(Vel),
    miembro(Avion, avionesPeque�os),
    write('P1 asignada'),
    miembro(Avion, avionesMedianos),
    Dir == 'Este a Oeste',
    write('P2-1 asignada'),
    Dir == 'Oeste a Este',
    write('P2-2 asignada');
    write('P3 asignada').

verificarVelocidad(Vel):-
    Vel >= 240,
    write('Por favor disminuya su velocidad para lograr aterrizar');
    write('Puede aterrizar sin problemas').


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

mostrar([]):-!.
mostrar([C|Lista]):-write(C),nl,mostrar(Lista).

