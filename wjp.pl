reverse([],[]).
reverse([H|T], ReversedList):-
    reverse(T, RevTemp), append(RevTemp, [H], ReversedList).

display_list([]).
display_list([A|B]) :-
  write(A),
  display_list(B).

state(2,_,_,Moves):-
        reverse(Moves, Rev),
        display_list(Rev),
        !.
state(X,Y, Visited, Moves):- X < 4,
        not(member([4,Y],Visited)),
        state(4,Y,[[4,Y]|Visited], ["Fill the 4-Gallon Jug\n"|Moves]).


state(X,Y, Visited, Moves):- Y < 3,
        not(member([X,3],Visited)),
        state(X,3,[[X,3]|Visited], ["Fill the 3-Gallon Jug\n"|Moves]).

state(X,Y, Visited, Moves):- X > 0,
        not(member([0,Y],Visited)),
        state(0,Y, [[0,Y]|Visited], ["Empty the 4-Gallon jug on ground\n"|Moves] ).

state(X,Y, Visited, Moves):- Y > 0,
        not(member([X,0],Visited)),
        state(X,0,[[X,0]|Visited], ["Empty the 3-Gallon jug on ground\n"|Moves] ).

state(X,Y, Visited, Moves):- X + Y >= 4,
        Y > 0,
        NEW_Y is Y - (4 - X),
        not(member([4,NEW_Y],Visited)),
        state(4,NEW_Y,[[4,NEW_Y]|Visited], ["Pour water from 3-Gallon jug to 4-gallon until it is full\n"|Moves] ).

state(X,Y, Visited, Moves):- X + Y >=3,
        X > 0,
        NEW_X is X - (3 - Y),
        not(member([NEW_X,3],Visited)),
        state(NEW_X,3,[[NEW_X,3]|Visited], ["Pour water from 4-Gallon jug to 3-gallon until it is full\n"|Moves] ).

state(X,Y, Visited, Moves):- X + Y =< 4,
        Y > 0,
        NEW_X is X + Y,
        not(member([NEW_X,0],Visited)),
        state(NEW_X,0,[[NEW_X,0]|Visited] , ["Pour all the water from 3-Gallon jug to 4-gallon\n"|Moves] ).

state(X,Y, Visited, Moves):- X + Y =< 3,
        X > 0,
        NEW_Y is X + Y,
        not(member([0,NEW_Y],Visited)),
        state(0,NEW_Y, [[0,NEW_Y]|Visited], ["Pour all the water from 4-Gallon jug to 3-gallon\n"|Moves]  ).

state(0,2, Visited, Moves):-
        not(member([2,0],Visited)),
        state(2,0,[[2,0]|Visited], ["Pour 2 gallons from 3-Gallon jug to 4-gallon\n"|Moves] ).

state(2,Y,Visited, Moves):-
        not(member([0,Y],Visited)),
        state(0,Y,[[0,Y]|Visited], ["Empty 2 gallons from 4-Gallon jug on the ground\n"|Moves] ).

% Query to be fired :
jugs(X,Y):-
  state(X,Y,[[X,Y]],[]).
