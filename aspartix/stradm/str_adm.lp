%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Encoding for strongly admissible sets
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Guess extension
in(X) :- arg(X), not out(X).
out(X):- arg(X), not in(X).

%% Compute restricted fixed-point
fixedPoint(X) :- in(X), defeated(Y):att(Y,X).
defeated(X):-arg(X), fixedPoint(Y), att(Y,X).

%% Compare fixed-point and guess
:- in(X), not fixedPoint(X).

#show in/1.