saludos(['hola', 'buenas', 'Buenas noches','Buenas tardes']).

agradecimientos(['Gracias','Muchas gracias','gracias','muchas gracias'], 'Con mucho gusto').

despedidas(['Adios','Hasta luego','Cambio y fuera'],'Hasta luego').
despedidas(['adios','hasta luego','cambio y fuera'],'Hasta luego').

solicitud(['aterrizar','despegar'],'Por favor identifíquese').

emergencia(['Mayday, mayday', 'mayday, mayday']).

avionesPequeños(['Cessna', 'Beechcraft', 'Embraer Phenom']).
avionesMedianos(['Boing 717', 'Embraer 190', 'AirBus A220']).
avionesGrandes(['Boing 747', 'AirBus A340', 'AirBus A380']).

pista('P1', 1, '').
pista('P2-1', 2, 'Este a Oeste').
pista('P2-2', 2, 'Oeste a Este').
pista('P3', 3, '').

emergencias(['Perdida de motor', 'Llamar a Bomberos'],
      ['Parto en Medio Vuelo', 'Llamar a medico'],
      ['Paro Cardiaco de Pasajero', 'Llamar a medico'],
      ['Secuestro', 'Llamar a la OIJ y fuerza publica']).

verificarVelocidad(Vel):-
    Vel >= 240,
    write('Por favor disminuya su velocidad para lograr aterrizar'), !;
    write('Puede aterrizar sin problemas').

miembro(X,[X|_]):-!.
miembro(X,[_|R]):-miembro(X,R).

asignarPista(Vel):-
    verificarVelocidad(Vel).

asignarPista(Avion, Dir):-
    (avionesPequeños(X); avionesMedianos(X); avionesGrandes(X)),
    miembro(Avion, X),
    Dir == '',
    write('P3 asignada'), !.

asignarPista(Avion, Dir):-
    (avionesPequeños(X); avionesMedianos(X)),
    miembro(Avion, X),
    Dir == 'Este a Oeste',
    write('P2-1 asignada'), !,
    Dir == 'Oeste a Este',
    write('P2-2 asignada'), !.

asignarPista(Avion, Dir):-
    avionesPequeños(X),
    miembro(Avion, X),
    Dir == '',
    write('P1 asignada'), !.

