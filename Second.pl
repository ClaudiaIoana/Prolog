%4.b.Write a predicate to add value 1 after every even element from a list.
% 2in inainte elem imp si 1 in spate la cele pare
/*
nr_digits(X, 10):- X<10.
nr_digits(X, R):- X>=10,
    X1 is X//10,
    nr_digits(X1, R1),
    R is R1 * 10.

change([],[]).
change([H|T], [HR|TR]):- 0 is H mod 2,
    HR is H*10+1,
    change(T, TR).
change([H|T], [HR|TR]):-1 is H mod 2,
   	nr_digits(H, R),
    HR is 2*R+H,
    change(T, TR).*/

change([], []).
change([H|T], [HR, HR1|TR]):- 0 is H mod 2,
    HR is H,
    HR1 is 1,
    change(T, TR).
change([H|T], [HR, HR1|TR]):- 1 is H mod 2,
    HR is 2,
    HR1 is H,
    change(T, TR).

test_change:-
    change([], []),
    change([12,34,56], [12, 1,34, 1,56, 1]),
    change([1], [2, 1]),
    change([0, 9, 4], [0, 1, 2, 9, 4, 1]).



%4.a. Write a predicate to determine the difference of two sets.
memberof(X, [X|_]).
memberof(X, [_|T]):- memberof(X, T).

difference_set([], _, []).
difference_set([H|T1],Set,Z):- memberof(H, Set), !,
    difference_set(T1,Set,Z).
difference_set([H|T], Set, [H|Set2]):- difference_set(T,Set,Set2).

test_difference_set:-
    difference_set([], [1,2,3], []),
    difference_set([12, 34, 233, 566, 3], [122, 0, 5], [12, 34, 233, 566, 3]),
	difference_set([1, 2, 3], [1, 3, 2], []), 
    difference_set([1, 1], [1], []),
    difference_set([1, 2, 43, 2, 15], [2, 3, 15], [1, 43]).
