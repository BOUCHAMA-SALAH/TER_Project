%
% Compute the cone of influence - This version works correctly even if the queried argument is not part of the AF
%
% 

coneArg(X):-queryArg(X),arg(X).

coneAtt(X,Y):- coneArg(Y), att(X,Y).
coneArg(X) :- coneAtt(X,Y).

#show coneArg/1. 
#show coneAtt/2. 
