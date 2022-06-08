mult_digit(_, 1, 0). %condicao de parada da chamada recursiva
mult_digit([Digit|Tail], Mult, Sum) :- % Head -> Digit
  	Parcela is Digit * Mult,
	NewMult is Mult - 1,
	mult_digit(Tail, NewMult, ParcialSum),
	Sum is Parcela + ParcialSum.

get_digit(Remainder, 0) :-
	Remainder < 2.
get_digit(Remainder, NewDigit) :-
	NewDigit is 11 - Remainder.

list_without_last(L, L0) :-
	last(L, X),
	append(L0, [X], L).

cpf9digits(CPF, CPF9) :-
  	list_without_last(CPF, CPF10),
	list_without_last(CPF10, CPF9).

generate_digit(CPF, Mult, NewDigit) :-
	mult_digit(CPF, Mult, Sum),
	Remainder is mod(Sum, 11),
	get_digit(Remainder, NewDigit).

append_digit(CPF, Mult, CPFDone) :-
	generate_digit(CPF, Mult, NewDigit),
	append(CPF, [NewDigit], CPFDone).

validCPF(CPF) :-
	cpf9digits(CPF, CPF9),
    append_digit(CPF9, 10, CPF10),
	append_digit(CPF10, 11, CPF11),
	CPF = CPF11,
	!.
