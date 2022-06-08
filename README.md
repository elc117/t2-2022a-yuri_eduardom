# Trabalho 2 - Outras aplicações de Prolog

## Dupla: Yuri e Eduardo de M.

## Motivação

Em nosso trabalho, focamos em desenvolver novas funcionalidades em uma aplicação de IA, chamada Eliza Chatbot. Além disso, desenvolvemos um verificador de CPF.

## Verificador de CPF

Verificador de CPF, usando recursão e "pattern matching".

###### 

## Eliza Chatbot

Eliza responde a estímulos do usuário. Alguns templates de estímulos foram declarados para aumentar as possíveis interações com Eliza, mas a implementação principal é o sistema de temas: Eliza é capaz de identificar temas a partir dos estímulos do usuário e modificar as respostas dela de acordo com cada tema.

## Exercício proposto

Usando o seguinte predicato. Declare um template cuja resposta seja aleatória.

Sobre a função random: https://www.swi-prolog.org/pldoc/man?predicate=random/3
```
random_answer([i, do]) :-
    random(1, 4, 1),
    !.
random_answer([maybe]) :-
    random(1, 4, 2),
    !.
random_answer([i, do, not]).
```
