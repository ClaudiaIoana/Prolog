merge_sorted([],[],[]).
merge_sorted(L, [], L).
merge_sorted([], L, L).
merge_sorted([H1,H11|T1], [H2|T2], L):-H1 == H11,!,
    merge_sorted([H11|T1], [H2|T2], L).
merge_sorted([H1|T1], [H2,H11|T2], L):-H11 == H2,!,
    merge_sorted([H1|T1], [H11|T2], L).
merge_sorted([H1|T1], [H2|T2], L):- H1 < H2,!,
    L = [H1|R],
    merge_sorted(T1, [H2|T2], R).
merge_sorted([H1|T1], [H2|T2], L):- H1 > H2,!,
    L = [H2|R],
    merge_sorted([H1|T1], T2, R).
merge_sorted([H1|T1], [H2|T2], L):- H1 == H2,!,
    L = [H1|R],
    merge_sorted(T1, T2, R).

test_merge_sorted:-
    merge_sorted([1, 2], [], [1, 2]),
    merge_sorted([1, 1, 3], [2,3], [1, 2, 3]),
    merge_sorted([2, 3, 4], [3, 4, 6, 7], [2, 3, 4, 6, 7]),
    merge_sorted([45], [2, 3], [2, 3, 45]).

merge_sublists([], []):-!.
merge_sublists([H1|T], R) :-
    is_list(H1),!,
    merge_sublists(T, L),
    merge_sorted(H1, L, R).
merge_sublists([H1|T], R) :-
    \+is_list(H1),!,
    merge_sublists(T, R).

test_merge_sublists:-
	merge_sublists([1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8],[1, 2, 3, 4, 6, 7, 9, 10, 11]),
    merge_sublists([1, 2, 3,6], []),
    merge_sublists([3, 4, [6, 7]], [6, 7]).
