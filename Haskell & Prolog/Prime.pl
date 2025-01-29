%Warmup
%Mondays start day
mondays(D, S, Mondays) :-
    findall(Monday, (between(1, D, Monday), (Monday + S - 1) mod 7 =:= 1), Mondays).

%Saturday start day
saturdays(D, S, Saturdays) :-
    findall(Saturday, (between(1, D, Saturday), (Saturday + S - 1) mod 7 =:= 6), Saturdays).



%Generator4
generator4([[M1, D1, S1], [M2, D2, S2]]) :-
 
    between(1, 12, M1),
    between(28, 31, D1),
    between(1, 7, S1),
    mondays(D1, S1, Monday1),         
    length(Monday1, CountMonday1),        
    
    M2 is (M1 mod 12) + 1,                  
    between(28, 31, D2),
    between(1, 7, S2),
    mondays(D2, S2, Monday2),               
    length(Monday2, CountMonday2),         

    CountMonday1 \= CountMonday2,

    valid_mondays(M1, D1, S1, M2, D2, S2),
    start_day(M1, S1, S2).

    %S2 is S1+1,
start_day(Month, StartDay, ResultDay) :-
    days_in_month(Month, Days),
    TempSum is StartDay + Days - 1,
    ResultDay is (TempSum mod 7) + 1.

% Number of days in each month
days_in_month(1, 31).
days_in_month(2, Days) :- between(28, 29, Days).
days_in_month(3, 31).
days_in_month(4, 30).
days_in_month(5, 31).
days_in_month(6, 30).
days_in_month(7, 31).
days_in_month(8, 31).
days_in_month(9, 30).
days_in_month(10, 31).
days_in_month(11, 30).
days_in_month(12, 31).

%letters in different months
month_letters(1, 7).   
month_letters(2, 8).   
month_letters(3, 5).   
month_letters(4, 5).   
month_letters(5, 3).   
month_letters(6, 4).   
month_letters(7, 4).   
month_letters(8, 6).   
month_letters(9, 9).   
month_letters(10, 7).  
month_letters(11, 8).  
month_letters(12, 8). 

% primeDays(28, [2,3,5,7,11,13,17,19,23]).
% primeDays(29, [2,3,5,7,11,13,17,19,23,29]).
% primeDays(30, [2,3,5,7,11,13,17,19,23,29]).
% primeDays(31, [2,3,5,7,11,13,17,19,23,29,31]).

    

valid_mondays(M1, D1, _, M2, D2, _) :-
    M1 \= M2,
    (M1 = 12, M2 = 1 -> D1 = D2 ; D1 \= D2). 


%Selector4
selector4([[M1, D1, S1], [M2, D2, S2]]) :-

    T1 = D1,
    U1 = D2,

    month_letters(M1, T2),
    month_letters(M2, U2),

    prime_days(D1, T3),
    prime_days(D2, U3),

    mondays(D1, S1, Mondays1),
    mondays(D2, S2, Mondays2),
    length(Mondays1, T4),
    length(Mondays2, U4),

    prime_saturdays(D1, S1, T5),
    prime_saturdays(D2, S2, U5),

    T1 \= U1,
    T2 \= U2,
    T3 \= U3,
    T4 \= U4,
    T5 \= U5,
   
    sum_list([T1, T2, T3, T4, T5], SumT),
    sum_list([U1, U2, U3, U4, U5], SumU),
    is_prime(SumT),
    is_prime(SumU),

    retractall(previous_pairs(_, _, _, _, _)), 
    assertz(previous_pairs(T1, T2, T3, T4, T5)).
   

is_prime(2).
is_prime(3).
is_prime(P) :- integer(P), P > 3, P mod 2 =\= 0, \+ has_factor(P,3).

has_factor(N,L) :- N mod L =:= 0.
has_factor(N,L) :- L * L < N, L2 is L + 2, has_factor(N,L2).

prime_days(DaysInMonth, Count) :-
    findall(Day, 
        (between(1, DaysInMonth, Day), is_prime(Day)), 
        PrimeDays),
    length(PrimeDays, Count).

prime_saturdays(DaysInMonth, StartDay, Count) :-
    saturdays(DaysInMonth, StartDay, Saturdays),
    include(is_prime, Saturdays, PrimeSaturdays),
    length(PrimeSaturdays, Count).


main 
	:- generator4(X),selector4(X),write(X).


