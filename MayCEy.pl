saludos(['hola','Hola','Buenas', 'buenas', 'Buenas noches','Buenas tardes']).

despedidas(['Adios','Hasta luego','Cambio y fuera','adios','hasta luego','cambio y fuera']).

emergencias(['Mayday, mayday', 'mayday, mayday']).

avionesPequenos(['cessna', 'beechcraft', 'embraerPhenom']).
avionesMedianos(['boing717', 'embraer190', 'airBusA220']).
avionesGrandes(['boing747', 'airBusA340', 'airbusA380']).

emergeciasSolicitud(['Perdida de motor', 'Llamar a Bomberos'],
      ['Parto en Medio Vuelo', 'Llamar a medico'],
      ['Paro Cardiaco de Pasajero', 'Llamar a medico'],
      ['Secuestro', 'Llamar a la OIJ y fuerza publica'],
      ['7500','se desplegaran los bomberos y el cuerpo policial']).

atencionEmergencias([]).

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

	findall(TipoMsjRecibido,tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),ListaCompleta),
	findall(MsjDeMCy,tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido),ListaMsMayCey),

	%verificarDato(ListaHistorialChat,ListaCompleta,ListaHistorialChatNew),

	append(ListaHistorialChat,ListaCompleta,ListaHistorialChatNew),

	pregunta(ListaMsMayCey),
	writeln(' '),

	/*write('Lista del historial del chat: '),
	writeln(ListaHistorialChatNew),
	writeln(' '),*/

        chatMayCEy(ListaHistorialChatNew,MsjEsperadoTemp).



tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):-%saludo
        saludos(ListaSaludos),
        identificar(MsjDeUsuario,ListaSaludos),
	%writeln('Saludo identificado'),
	MsjDeMCy='Hola ¿en que lo puedo ayudar?',
        TipoMsjRecibido='saludo'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %emergencia
        emergencias(ListaEmergencias),
        identificar(MsjDeUsuario,ListaEmergencias),
	%writeln('Emergencia identificada'),
	MsjDeMCy='Por favor indique su emergencia',
        TipoMsjRecibido='emergencia'.

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
        MsjDeMCy='Gracias, ¿Qué tipo de Aeronave es?'.
	/*TipoMsjRecibido='Error',
        MsjDeMCy='Error, por favor identifiquese de nuevo'.*/

/*tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion
        identificar(MsjDeUsuario,['matricula','Matricula']),
	%writeln('Matricula identificada'),
	TipoMsjRecibido='Matricula',
        MsjDeMCy='Gracias, ¿Qué tipo de Aeronave es?'.

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion
	identificar(MsjDeUsuario,['vuelo','Vuelo']),
	%writeln('Vuelo identificado'),
        TipoMsjRecibido='Vuelo',
        MsjDeMCy='Gracias, ¿Qué tipo de Aeronave es?'.
*/

tipodemensaje(MsjDeUsuario,MsjDeMCy,TipoMsjRecibido):- %identificacion de aviones P
	avionesPequenos(X),
        identificar(MsjDeUsuario,X),
	%writeln('identificacion de Avion Pequeño Realizada'),
        MsjDeMCy='Avion Pequeño Identificado',
        TipoMsjRecibido='avionPequeño'.

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
    miembro(Avion, avionesPequeños),
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

miembroL([X|R],L2):-
	miembro(X,L2);
	miembroL(R,L2).

miembro(X,[X|_]):-!.
miembro(X,[_|R]):-miembro(X,R).

mostrar([]):-!.
mostrar([C|Lista]):-write(C),nl,mostrar(Lista).

