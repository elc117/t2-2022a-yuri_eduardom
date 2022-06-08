%%  eliza(+Stimuli, -Response) is det.
%   @param  Stimuli is a list of atoms (words).
%   @author Richard A. O'Keefe (The Craft of Prolog)

eliza(Stimuli, Response) :-
	template(InternalStimuli, InternalResponse),
	match(InternalStimuli, Stimuli),
	match(InternalResponse, Response),
	!.

template([s([i,am]),s(X)], [s([why,are,you]),s(X),w('?')]).
template([s([we,are]),s(X)], [s([why,are,you]),s(X),w('?')]).
template([s([they,are]),s(X)], [s([why,are,they]),s(X),w('?')]).
template([s([you,are]),s(X)], [s([why,am,i]),s(X),w('?')]).
template([w(X),w(is),s(Y)], [s([why,is]),w(X),s(Y),w('?')]).

template([w(my),w(X),w(is),s(Y)], [s([why,is,your]),w(X),s(Y),w('?')]).
template([w(your),w(X),w(is),s(Y)], [s([why,is,my]),w(X),s(Y),w('?')]).
template([w(our),w(X),w(is),s(Y)], [s([why,is,your]),w(X),s(Y),w('?')]).
template([w(Z),w(X),w(is),s(Y)], [s([why,is]),w(Z),w(X),s(Y),w('?')]).

template([w(do), w(you), s(Y), w(?)],[s([yes, i, do]), s(Y)]).
template([w(do), w(i), s(Y), w(?)],[s([i, do, not, know, if, you]), s(Y)]).
template([w(do), w(we), s(Y), w(?)],[s([i, do, not, know, if, you]), s(Y)]).

template([w(i),s(X),w(you)], [s([why,do,you]),s(X),w(me),w('?')]).
template([w(i),s(X),w(Y)], [s([why,do,you]),s(X),w(Y),w('?')]).

template([s([am, i]),s(Y),w(?)], [s([i,do,not,know,if]),s([you, are]),s(Y),w('?')]).
template([s([are, we]),s(Y),w(?)], [s([i,do,not,know,if]),s([you, are]),s(Y),w('?')]).
template([w(Z),w(X),s(Y),w(?)], [s([i,do,not,know,if]),w(X),w(Z),s(Y),w('?')]).

match([],[]).
match([Item|Items],[Word|Words]) :-
	match(Item, Items, Word, Words).

match(w(Word), Items, Word, Words) :-
	match(Items, Words).
match(s([Word|Seg]), Items, Word, Words0) :-
	append(Seg, Words1, Words0),
	match(Items, Words1).


/** <examples>

?- eliza([i, am, very, hungry], Response).
?- eliza([i, love, you], Response).

*/
