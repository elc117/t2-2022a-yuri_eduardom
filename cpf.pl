%%  Verificador de CPF em Prolog
%   @autores Eduardo de Medeiros e Yuri Morais

/*
 * chamada recursiva com um acumulador e decremento
 */
mult_digit(_, 1, 0). 
mult_digit([Digit|Tail], Mult, Sum) :- % Head -> Digit
  	Parcela is Digit * Mult,
	NewMult is Mult - 1,
	mult_digit(Tail, NewMult, ParcialSum),
	Sum is Parcela + ParcialSum.

/*
 * o novo digito vai satisfazer uma dessas duas condicoes, e entao sera retornado um novo numero
 */
get_digit(Remainder, 0) :-
	Remainder < 2.
get_digit(Remainder, NewDigit) :-
	NewDigit is 11 - Remainder.

/*
 * gera novo digito retornado dos condicionais
 */
generate_digit(CPF, Mult, NewDigit) :-
	mult_digit(CPF, Mult, Sum),
	Remainder is mod(Sum, 11),
	get_digit(Remainder, NewDigit).

/*
 * recebe um novo digito e adiciona na lista
 */
append_digit(CPF, Mult, CPFDone) :-
	generate_digit(CPF, Mult, NewDigit),
	append(CPF, [NewDigit], CPFDone).

/*
 * retira o ultimo numero da lista
 */
list_without_last(L, L0) :-
	last(L, X),
	append(L0, [X], L).

/*
 * é gerado um novo CPF sem os 2 ultimos digitos, que sao os verificadores.
 */
cpf9digits(CPF, CPF9) :-
  	list_without_last(CPF, CPF10),
	list_without_last(CPF10, CPF9).

/*
 * recebe o CPF do usuario e chama as outras funcoes. Ao final compara o CPF gerado com o CPF recebido no inicio.
 */
validCPF(CPF) :-
	cpf9digits(CPF, CPF9),
    append_digit(CPF9, 10, CPF10),
	append_digit(CPF10, 11, CPF11),
	CPF = CPF11,
	!.