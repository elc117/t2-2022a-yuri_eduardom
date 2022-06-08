%%  eliza(+Stimuli, -Response) is det.
%   @param  Stimuli is a list of atoms (words).
%   @author Richard A. O Keefe (The Craft of Prolog)
%   @coautores Eduardo de Medeiros e Yuri Morais

/*
 * Declara os possíveis temas.
 */

theme(sensible).
theme(food).
theme(sports).

/*
 * Cria a relação entre tema e palavra.
 */

related_to_theme(sensible, politics).

related_to_theme(food, pizza).
related_to_theme(food, lasagna).

related_to_theme(sports, soccer).
related_to_theme(sports, volleyball).

/*
 * Aqui vai a mensagem que você quer anexar às respostas de um tema específico. 
 */

append_message(food, [i, see, you, are, talking, about, food, .]).
append_message(sports, [i, see, you, are, talking, about, sports, .]).

/*
 * Verifica se há alguma palavra ligada ao Tema na lista.
 */

is_related_to_theme(Tema, [Palavra|Tail]) :-
          related_to_theme(Tema, Palavra);
          is_related_to_theme(Tema, Tail),
          !.

/*
 * Anexa a mensagem atrelada ao Tema em Mensagem.
 */

append_topic(Tema, Mensagem, AppendedMensagem) :-
    append_message(Tema, Anexo),
    append(Anexo, Mensagem, AppendedMensagem).

/*
 * Por tentativa e erro, itera pelos temas declarados.
 * Verifica se a Resposta está relacionada a alguma tema X.
 */

append_to_response(Resposta, AppendedResposta) :-
    theme(X),
    is_related_to_theme(X, Resposta),
    append_topic(X, Resposta, AppendedResposta),
    !.

/*
 * Caso a Resposta não estiver relacionada a nenhum tema declarado,
 * não anexa nada.
 */

append_to_response(Resposta, Resposta).

/*
 * Eliza não gosta de falar sobre assuntos sensíveis.
 */

eliza(Stimuli, [i, do, not, answer, stimuli, with, sensible, words]) :-
    is_related_to_theme(sensible, Stimuli),
    !.

/*
 * Por tentativa e erro, procura algum template que dê match.
 * Se Stimuli estiver relacionado a algum tema declarado,
 * anexa a mensagem do tema respectivo.
 */

eliza(Stimuli, AppendedResponse) :-  
   	template(InternalStimuli, InternalResponse),
	match(InternalStimuli, Stimuli),
	match(InternalResponse, Response),
    append_to_response(Response, AppendedResponse),
	!.

/*
 * Algumas declarões não exaustivas de template.
 */

template([w(do), w(you), s(Y), w(?)],[s([yes, i, do]), s(Y)]).
template([w(do), w(i), s(Y), w(?)],[s([i, do, not, know, if, you]), s(Y)]).
template([w(do), w(we), s(Y), w(?)],[s([i, do, not, know, if, you]), s(Y)]).

template([s([i,am]),s(X)], [s([why,are,you]),s(X),w('?')]).
template([s([we,are]),s(X)], [s([why,are,you]),s(X),w('?')]).
template([s([they,are]),s(X)], [s([why,are,they]),s(X),w('?')]).
template([s([you,are]),s(X)], [s([why,am,i]),s(X),w('?')]).
template([w(X),w(is),s(Y)], [s([why,is]),w(X),s(Y),w('?')]).

template([w(my),w(X),w(is),s(Y)], [s([why,is,your]),w(X),s(Y),w('?')]).
template([w(your),w(X),w(is),s(Y)], [s([why,is,my]),w(X),s(Y),w('?')]).
template([w(our),w(X),w(is),s(Y)], [s([why,is,your]),w(X),s(Y),w('?')]).
template([w(Z),w(X),w(is),s(Y)], [s([why,is]),w(Z),w(X),s(Y),w('?')]).

template([w(i),s(X),w(you)], [s([why,do,you]),s(X),w(me),w('?')]).
template([w(i),s(X),w(Y)], [s([why,do,you]),s(X),w(Y),w('?')]).

template([s([am, i]),s(Y),w(?)],
     	[s([i,do,not,know,if]),s([you, are]),s(Y),w('?')]).
template([s([are, we]),s(Y),w(?)],
     	[s([i,do,not,know,if]),s([you, are]),s(Y),w('?')]).
template([w(Z),w(X),s(Y),w(?)],
     	[s([i,do,not,know,if]),w(X),w(Z),s(Y),w('?')]).

match([],[]).
match([Item|Items],[Word|Words]) :-
	match(Item, Items, Word, Words).

match(w(Word), Items, Word, Words) :-
	match(Items, Words).
match(s([Word|Seg]), Items, Word, Words0) :-
	append(Seg, Words1, Words0),
	match(Items, Words1).

/** <examplos>

s(X): Qualquer sequencia de palavras separadas por virgula
w(X): Apenas uma palavra

?- eliza([w(Pronome_pessoal), w(Verbo_to_be), s(X)], Response).
	?- eliza([you, are, beautiful)
?- eliza([w(Pronome_possessivo), w(X), w(Verbo_to_be), s(Y)], Response).
	?- eliza([my, car, is, fast], Response).
?- eliza([do, w(Pronome_pessoal), s(X), w(X), ?], Response).
	?- eliza([do, you, like, soccer, ?], Response).
?- eliza([w(Pronome_pessoal), w(Verbo), s(Y)], Response).
	?- eliza([i, love, you], Response).
?- eliza([w(Verbo_to_be), w(X), s(Y), w(?)], Response).
	?- eliza([am, i, crazy, ?], Response).
*/

/*
 * EXERCÍCIO PROPOSTO:
 * Usando o seguinte predicato. Declare um template cuja resposta seja aleatória.
 * Sobre a função random: https://www.swi-prolog.org/pldoc/man?predicate=random/3
 */

random_answer([i, do]) :-
    random(1, 4, 1),
    !.
random_answer([maybe]) :-
    random(1, 4, 2),
    !.
random_answer([i, do, not]).
