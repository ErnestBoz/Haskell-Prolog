
%Warmup
number(Digits, Number) :-
    number(Digits, 0, Number).


number([], Accumulator, Accumulator).

number([Head | Tail], Accumulator, Number) :-
    NewAccumulator is Accumulator * 10 + Head,
    number(Tail, NewAccumulator, Number).


perm([], []).
perm(L, [H|T]) :-
    select(H, L, Rest),
    perm(Rest, T).

unique_elements([]).
unique_elements([H|T]) :-
    \+ member(H, T),
    unique_elements(T).

contains_all_digits(AS, BS) :-
    append(AS, BS, AllDigits),
    sort(AllDigits, SortedDigits),
    SortedDigits = [1, 2, 3, 4, 5, 6, 7, 8, 9].

% Generator3
generator3([AS, BS]) :-
    perm([1, 2, 3, 4, 5, 6, 7, 8, 9], AllDigits),   
    append(AS, BS, AllDigits),

    unique_elements(AS),
    unique_elements(BS),

    contains_all_digits(AS, BS),

    AS \= [],
    BS \= [].

is_palindrome(L):-
    reverse(L, L).



number_to_list(0, [0]).
number_to_list(Number, List) :-
    Number > 0,
    number_to_list_helper(Number, ReverseList),
    reverse(ReverseList, List).


number_to_list_helper(0, []).
number_to_list_helper(Number, [Digit | Tail]) :-
    Number > 0,
    Digit is Number mod 10,
    Rest is Number // 10,
    number_to_list_helper(Rest, Tail).

first_is_4([4|_]).

%Selector3
selector3([AS, BS]) :-
    
    number(AS, A),
    number(BS, B),

    A \= B,
    AS \= [],
    BS \= [],

    (A < B -> Smallest = A ; Smallest = B),
    Smallest mod 10 =:= 3,

    Product is A * B,
    number_to_list(Product, L),
    is_palindrome(L),
    first_is_4(L),

    Summa is A + B + 100,
    number_to_list(Summa, M),
    is_palindrome(M).
    
main
    :- generator3( X ) , selector3( X ) , write( X ) .
    

    
