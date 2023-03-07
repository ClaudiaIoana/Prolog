%2. Are given n points in a plan (represented using its coordinates). Write a predicate to determine all
%subsets of collinear points

%subs(L1-list, R-list)
%flow model (i, o)
subs([], []).
subs([H|T], [H|R]):-
    subs(T, R).
subs([_|T], R):-
    subs(T, R).

%formula(C1- list, C2-list, C3-list, R-int)
%C1, C2, C3 - coordinates of the points
%flow model(i, i, i, o)
formula([X1,Y1],[X2,Y2],[X3,Y3], REZ):-
    REZ is X1*(Y2 - Y3)+X2*(Y3-Y1)+X3*(Y1-Y2).

%issol(L-list, R-int)
%flow model(i, o)
issol([], 0).
issol([_], 0):-!.
issol([_, _], 0):-!.
issol([L1,L2,L3|T], R):-
    formula(L1,L2,L3, R1),
    R1 =:= 0,!,
    R is R1,
    issol([L2, L3|T], R).
issol([L1,L2,L3|_], R):-
    formula(L1,L2,L3, R),
    R =\= 0,!.
 
%all(L1-list, L2-list)
%flow model(i, o)
all([], []):-!.
all([H1|T], R):-
    issol(H1, R1),
    R1 =:= 0,!,
    all(T, R3),
    R = [H1|R3].
all([H1|T], R):-
    issol(H1, R1),
    R1 =\= 0,!,
   	all(T, R).

%generate(L-list, R-list)
%flow model(i, o)
generate(L, R):-
    findall(R1, subs(L, R1), LR),
    all(LR, R).

test:-
    generate([[1,1],[2,2],[3,4],[5,5],[6,6]],[[[1, 1], [2, 2], [5, 5], [6, 6]],
		[[1, 1], [2, 2], [5, 5]],
		[[1, 1], [2, 2], [6, 6]],
		[[1, 1], [2, 2]],
		[[1, 1], [3, 4]],
		[[1, 1], [5, 5], [6, 6]],
		[[1, 1], [5, 5]],
		[[1, 1], [6, 6]],
		[[1, 1]],
		[[2, 2], [3, 4]],
		[[2, 2], [5, 5], [6, 6]],
		[[2, 2], [5, 5]],
		[[2, 2], [6, 6]],
		[[2, 2]],
		[[3, 4], [5, 5]],
		[[3, 4], [6, 6]],
		[[3, 4]],
		[[5, 5], [6, 6]],
		[[5, 5]],
		[[6, 6]],
		[]]),
    generate([[1,1],[2,2]],[[[1, 1], [2, 2]], [[1, 1]], [[2, 2]], []]),
    generate([[1,1],[1,3],[2,5]],[[[1, 1], [1, 3]],
		[[1, 1], [2, 5]],
		[[1, 1]],
		[[1, 3], [2, 5]],
		[[1, 3]],
		[[2, 5]],
		[]]).

