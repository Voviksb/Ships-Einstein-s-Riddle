%Ships Grid Puzzle
%
% There are 5 ships in a port, each can be identified by:
% (Nationality, Destination, Cargo, Color, DepartureHour)
% Also ships are anchored in some order, it can be relative to the other
% ship or absolute position, e.g. on the border.
%
% We know some facts about ships, each fact is described below in the
% facts section.
%
% Questions we need to answer:
% 1) Which ship goes to Port Said?
% 2) Which ship carries tea?

% Knowledge Base
% Facts we know:
ships(Ships) :-
    % ship(nationality, destination, cargo, color, departureHour)
    length(Ships, 5),

    % 1) The Greek ship leaves at six and carries coffee
    member(ship(greek,_,coffee,_,six), Ships),

    % 2) The Ship in the middle has a black exterior
    Ships = [_,_,ship(_,_,_,black,_),_,_],

    % 3) The English ship leaves at nine
    member(ship(english,_,_,_,nine), Ships),

    % 4) The French ship with blue exterior is to the left from a ship that carries coffee
    leftFrom(ship(french,_,_,blue,_), ship(_,_,coffee,_,_), Ships),

    % 5) To the right of the ship carrying cocoa is a ship going to Marseille
    rightFrom(ship(_,marseille,_,_,_), ship(_,_,cocoa,_,_), Ships),

    % 6) The Brazilian ship is heading for Manila
    member(ship(brazilian,manila,_,_,_), Ships),

    % 7) Next to the ship carrying rice is a ship with a green exterior
    isNextTo(ship(_,_,rice,_,_), ship(_,_,_,green,_), Ships),

    % 8) A ship going to Genoa leaves at five
    member(ship(_,genoa,_,_,five), Ships),

    % 9) The Spanish ship leaves at seven and is to the right of the ship going to Marseille
    rightFrom(ship(spanish,_,_,_,seven), ship(_,marseille,_,_,_), Ships),

    % 10) The ship with a red exterior goes to Hamburg
    member(ship(_,hamburg,_,red,_), Ships),

    % 11) Next to the ship leaving at seven is a ship with a white exterior
    isNextTo(ship(_,_,_,_,seven), ship(_,_,_,white,_), Ships),

    % 12) The ship on the border carries corn
    atTheBorder(ship(_,_,corn,_,_), Ships),

    % 13) The ship with a black exterior leaves at eight
    member(ship(_,_,_,black,eight), Ships),

    % 14) The ship carrying corn is anchored next to the ship carrying rice
    isNextTo(ship(_,_,corn,_,_), ship(_,_,rice,_,_), Ships),

    % 15) The ship to Hamburg leaves at six
    member(ship(_,hamburg,_,_,six), Ships),

    % One ship goes to Port Said
    member(ship(_,said,_,_,_), Ships),

    % One ship carries Tea
    member(ship(_,_,tea,_,_), Ships).

% Rules
% Defines whether Ship B anchored to the right from Ship A. To the right
% means on the right side from given point, not only right next to
rightFrom(B, A, Ships) :-
    append(_, [A|Ls], Ships),
    append(_, [B|_], Ls).

% Defines whether Ship A anchored to the left from Ship B. Same as with
% to the right, means on the left side from given point, not only left
% next to
leftFrom(A, B, Ships) :- rightFrom(B, A, Ships).

% Defines whether Ship A stand right next to Ship B in any direction
isNextTo(A, B, Ships) :- nextto(A, B, Ships) ; nextto(B, A, Ships).

% Defines whether Ship A anchored at the corner, left or right one.
atTheBorder(A, Ships) :-
     append([A|_],_,Ships) ; append(_,[A], Ships).

% Answers to the questions:
% 1) Which ship goes to Port Said?
% Spanish ship goes to Port Said
goesToPortSaid(Ship) :-
    ships(Ships),
    member(ship(Ship,said,_,_,_), Ships).

% 2) Which ship carries tea?
% 2 possible solutions, French and Brazilian ships can carry tea
carriesTea(Ship) :-
    ships(Ships),
    member(ship(Ship,_,tea,_,_), Ships).

% Some abstract queries:
whichShipIs(Ship, Port, Cargo, Color, DepartureHour) :-
    ships(Ships),
    member(ship(Ship, Port, Cargo, Color, DepartureHour), Ships).

goesToPort(Ship, Port) :-
    ships(Ships),
    member(ship(Ship,Port,_,_,_), Ships).

carries(Ship, Cargo) :-
    ships(Ships),
    member(ship(Ship,_,Cargo,_,_), Ships).

ofColor(Ship, Color) :-
    ships(Ships),
    member(ship(Ship,_,_,Color,_), Ships).

leavesAt(Ship, DepartureHour) :-
    ships(Ships),
    member(ship(Ship,_,_,_,DepartureHour), Ships).
