% purpose: familiarize ourself with prolog
% and logical languages by parsing lists


% mymember(value, list).
% base case
mymember(X, [Head|Tail]) :-
	% If member is Head or recurse
	X = Head; mymember(X,Tail).


% myeven(a_number).
% base case
myeven(0).
% X is even if X%2=0
myeven(X) :-
    0 is X mod 2.


% myevennumber(a_number, list).
% base case
myevennumber([],0).
% grab the head
myevennumber([Head|Tail], Count) :-
	% recurse the tail
	myevennumber(Tail, X),
	%test for evenness, if so increase count
	(myeven(Head) -> Count is X + 1;
	% other wise leave alone
	 Count = X).



% myminlist(list, minimum_value).
% base cases
myminlist(X, [X]).
% if maximum value is head
myminlist(M, [M | Tail]) :-
	myminlist(Y, Tail), M < Y.
% if maximum value comes from Tail
myminlist(M, [Head | Tail]) :- myminlist(M, Tail), M < Head.


palindrome(list)
% base case
palindrome([]).
% for as long as there's a list
palindrome([_]).
% and for every element
palindrome(X) :-
	% append head concatenated and compared
	append([Head|Tail], [Head], X),
	palindrome(Tail).


% leafcount(T,N)
% empty tree
leafcount(nil,0).
% a leaf, update count
leafcount(t(_,nil,nil),1).
% examine left subtree, nil right
leafcount(t(_,Left,nil),Count) :-
	% continue left
	Left = t(_,_,_), leafcount(Left,Count).
% examine right subtree, nil left
leafcount(t(_,nil,Right),Count) :-
	% continue right
	Right = t(_,_,_), leafcount(Right,Count).
% testing with both
leafcount(t(_,Left,Right), Count) :-
	Right = t(_,_,_), Left = t(_,_,_),
	% if with both split into right and left
	leafcount(Right, CountRight), leafcount(Left, CountLeft),
	% compile count
	Count is  CountRight + CountLeft.

