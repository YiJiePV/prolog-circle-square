/*Square-Circle Program
  Author: Karena Qian
  Professor: Carlos Arias
  Purpose: This program implements the contained and intersects questions of the square-circle grammar introduced in the Rust Compiler program
  Date: November 12, 2022*/
/*Define a 2D point (X,Y)*/
point2d(X,Y) :- number(X),number(Y).
/*Define a circle with center (A,B) and radius R*/
circle(point2d(_A,_B), R) :- number(R).
/*Define a square with top-left corner (D,C) and side-length L*/
square(point2d(_D,_C), L) :- number(L).

/*Define the not negation predicate*/
not(P) :- P, !, fail ; true.
/*Within Relation
Is point (X, Y) within square with corners (A, B) and (C, D)?
Objects: X (x value of point) Y (y value of point) A (x value of square corner (A, B)) B (y value of square corner (A, B)) C (x value of square corner (C, D)) D (y value of square corner (C, D))*/
within(X, Y, A, C, B, D) :- 
    X >= A, 
    X < C, 
    Y =< B, 
    Y > D.
/*CornerInCorner Relation
Is at least one of the corners of square(point2d(A,B), L) within square(point2d(C,D), T)?
Objects: square(point2d(A,B), L) (square with top-left corner point2d(A,B) and side-length L) square(point2d(C,D), T) (square with top-left corner point2d(C,D) and side-length T)*/
cornerincorner(square(point2d(A,B), L), square(point2d(C,D), T)) :- 
    within(A, B, C, (C + T), D, (D - T)); 
    within((A + L), B, C, (C + T), D, (D - T)); 
    within((A + L), (B - L), C, (C + T), D, (D - T)); 
    within(A, (B - L), C, (C + T), D, (D - T)).
/* Contained Circle - Square Relation
Is circle with center (A,B) and radius R contained in square with upper left corner (C,D) and side length L?
Objects: circle(point2d(A,B), R) (circle with center point2d(A,B) and radius R) square(point2d(C,D), L) (square with top-left corner point2d(C,D) and side-length L)*/
contained(circle(point2d(A,B), R), square(point2d(C,D), L)) :- 
    S is C + (L / 2), 
    T is D - (L / 2), 
    Q is (2*((L / 2)**2))**(1/2), 
    contained(circle(point2d(A,B), R), circle(point2d(S,T), Q)).
/* Contained Circle - Circle Relation
Is circle with center (A,B) and radius R contained in circle with center (C,D) and radius Q?
Objects: circle(point2d(A,B), R) (circle with center point2d(A,B) and radius R) circle(point2d(C,D), Q) (circle with center point2d(C,D) and radius Q)*/
contained(circle(point2d(A,B), R), circle(point2d(C,D), Q)) :- (((A - C)**2 + (B - D)**2)**(1/2)) =< (Q - R).
/* Contained Square - Square Relation
Is square with upper left corner (A,B) and side length L contained in square with upper left corner (C,D) and side length T?
Objects: square(point2d(A,B), L) (square with top-left corner point2d(A,B) and side-length L) square(point2d(C,D), T) (square with top-left corner point2d(C,D) and side-length T)*/
contained(square(point2d(A,B), L), square(point2d(C,D), T)) :- 
    S is A + (L / 2), 
    P is B - (L / 2), 
    Q is (2*((L / 2)**2))**(1/2), 
    J is C + (T / 2), 
    K is D - (T / 2), 
    R is (2*((T / 2)**2))**(1/2), 
    contained(circle(point2d(S,P), Q), circle(point2d(J,K), R)).
/* Contained Square - Circle Relation
Is square with upper left corner (A,B) and side length L contained in circle with center (C,D) and radius R?
Objects: square(point2d(A,B), L) (square with top-left corner point2d(A,B) and side-length L) circle(point2d(C,D), R) (circle with center point2d(C,D) and radius R)*/
contained(square(point2d(A,B), L), circle(point2d(C,D), R)) :- 
    S is A + (L / 2), 
    T is B - (L / 2), 
    Q is (2*((L / 2)**2))**(1/2), 
    contained(circle(point2d(S,T), Q), circle(point2d(C,D), R)).
/* Intersect Circle - Square Relation
Does circle with center (A,B) and radius R intersect with square with upper left corner (C,D) and side length L?
Objects: circle(point2d(A,B), R) (circle with center point2d(A,B) and radius R) square(point2d(C,D), L) (square with top-left corner point2d(C,D) and side-length L)*/
intersects(circle(point2d(A,B), R), square(point2d(C,D), L)) :-  
    not(contained(circle(point2d(A,B), R), square(point2d(C,D), L))),
    not(contained(square(point2d(C,D), L), circle(point2d(A,B), R))),
    ((((A - C)**2 + (B - D)**2)**(1/2)) =< R; 
    (((A - (C + L))**2 + (B - D)**2)**(1/2)) =< R; 
    (((A - (C + L))**2 + (B - (D - L))**2)**(1/2)) =< R; 
    (((A - C)**2 + (B - (D - L))**2)**(1/2)) =< R; 
    intersects(square(point2d(C,D), L), square(point2d(A - R,B + R), R * 2))).
/* Intersect Circle - Circle Relation
Does circle with center (A,B) and radius R intersect with circle with center (C,D) and radius Q
Objects: circle(point2d(A,B), R) (circle with center point2d(A,B) and radius R) circle(point2d(C,D), Q) (circle with center point2d(C,D) and radius Q)*/
intersects(circle(point2d(A,B), R), circle(point2d(C,D), Q)) :- 
    (((A - C)**2 + (B - D)**2)**(1/2)) < (R + Q),
    not(contained(circle(point2d(A,B), R), circle(point2d(C,D), Q))),
    not(contained(circle(point2d(C,D), Q), circle(point2d(A,B), R))).
/* Intersect Square - Square Relation
Does square with upper left corner (A,B) and side length L intersect with square with upper left corner (C,D) and side length T?
Objects: square(point2d(A,B), L) (square with top-left corner point2d(A,B) and side-length L) square(point2d(C,D), T) (square with top-left corner point2d(C,D) and side-length T)*/
intersects(square(point2d(A,B), L), square(point2d(C,D), T)) :- 
    cornerincorner(square(point2d(A,B), L), square(point2d(C,D), T)), 
    cornerincorner(square(point2d(C,D), T), square(point2d(A,B), L)),
    not(contained(square(point2d(A,B), L), square(point2d(C,D), T))),
    not(contained(square(point2d(C,D), T), square(point2d(A,B), L))).
/* Intersect Square - Circle Relation
Does square with upper left corner (A,B) and side length L intersect with circle with center (C,D) and radius R?
Objects: square(point2d(A,B), L) (square with top-left corner point2d(A,B) and side-length L) circle(point2d(C,D), R) (circle with center point2d(C,D) and radius R)*/
intersects(square(point2d(A,B), L), circle(point2d(C,D), R)) :- intersects(circle(point2d(C,D), R), square(point2d(A,B), L)).
