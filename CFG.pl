frase(S):- oracion(S,[]).

oracion(S0,S):- sintagma_nominal(S0,S1), sintagma_verbal(S1,S).

sintagma_nominal(S0,S):- determinante(S0,S1), sujeto(S1,S), !.
sintagma_nominal(S0,S):- sujeto(S0,S), !.

sintagma_verbal(S0,S):- verbo(S0,S1), compl_dir(S1,S).
sintagma_verbal(S0,S):- compl_dir(S0,S1), verbo(S1,S).

compl_dir(S0,S):- preposicion(S0,S1), sintagma_nominal(S1,S), !.
compl_dir(S0,S):- sintagma_nominal(S0,S), !.

sujeto(S0,S):- nombre(S0,S), !.
sujeto(S0,S):- nombre(S0,S1), que(S1, S), !.

que([que|S0],S):-sintagma_verbal(S0,S).

preposicion([a|S],S).

determinante([el|S],S).
determinante([la|S],S).
determinante([las|S], S).
determinante([los|S], S).
determinante([un|S], S).
determinante([una|S], S).
determinante([unos|S], S).
determinante([unas|S], S).
determinante([lo|S], S).
determinante([este|S], S).
determinante([esta|S], S).
determinante([estos|S], S).
determinante([estas|S], S).
determinante([ese|S], S).
determinante([esa|S], S).
determinante([esos|S], S).
determinante([esas|S], S).
determinante([aquel|S], S).
determinante([aquellos|S], S).
determinante([aquella|S], S).
determinante([aquellas|S], S).
determinante([nuestro|S], S).
determinante([nuestra|S], S).
determinante([nuestros|S], S).
determinante([nuestras|S], S).
determinante([su|S], S).
determinante([sus|S], S).
determinante([suyo|S], S).
determinante([suya|S], S).
determinante([suyos|S], S).
determinante([suyas|S], S).
determinante([que|S], S).
determinante([cuanto|S], S).
determinante([cual|S], S).

nombre([maycey|S],S).
nombre([tec-airlines|S],S).
nombre([alfa|S],S).
nombre([bravo|S],S).
nombre([charlie|S],S).
nombre([delta|S],S).
nombre([echo|S],S).
nombre([fox|S],S).
nombre([golf|S],S).
nombre([hotel|S],S).
nombre([india|S],S).
nombre([juliett|S],S).
nombre([kilo|S],S).
nombre([lima|S],S).
nombre([mike|S],S).
nombre([november|S],S).
nombre([oscar|S],S).
nombre([papa|S],S).
nombre([quebec|S],S).
nombre([romeo|S],S).
nombre([sierra|S],S).
nombre([tango|S],S).
nombre([uniform|S],S).
nombre([victor|S],S).
nombre([whiskey|S],S).
nombre([x-ray|S],S).
nombre([yankee|S],S).
nombre([zulu|S],S).

verbo([despegar|S],S).
verbo([aterrizar|S],S).
