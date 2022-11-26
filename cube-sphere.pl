/*Assume all cubes are parallel to the x-y, y-z, and z-x planes*/
/*x-y-z orientation: x to the left on horizontal axis, y to the right on front-back axis, z on vertical axis*/
/*Define a 3D point (X,Y,Z)*/
point3d(X,Y,Z) :- number(X),number(Y),number(Z).
/*Define a sphere with center (A,B,C) and radius R*/
sphere(point3d(_A,_B,_C), R) :- number(R).
/*Define a cube with front-top-left corner (D,E,F) and side-length L*/
cube(point3d(_D,_E,_F), L) :- number(L).

/*Define the not negation predicate*/
not(P) :- P, !, fail ; true.
/*WithinCube Relation
Is point (X, Y, Z) within cube with corners (A, B, C)(front-top-left) and (D, E, F)(back-bottom-right)?
Objects: X (x value of point) Y (y value of point) Z (z value of point) A (x value of cube corner (A, B, C)) B (y value of cube corner (A, B, C)) C (z value of cube corner (A, B, C)) D (x value of cube corner (D, E, F)) E (y value of cube corner (D, E, F)) F (z value of cube corner (D, E, F))*/
withincube(X, Y, Z, A, B, C, D, E, F) :- 
    X =< A, 
    X >= D, 
    Y =< B, 
    Y >= E,
    Z =< C,
    Z >= F.
/*CornerInCorner Relation
Is at least one of the corners of cube(point3d(A,B,C), L) within cube(point3d(D,E,F), T)?
Objects: cube(point3d(A,B,C), L) (cube with front-top-left corner point3d(A,B,C) (facing the x-z plane from positive y direction) and side-length L) cube(point3d(D,E,F), T) (cube with front-top-left corner point3d(D,E,F) (facing the x-z plane from positive y direction) and side-length T)*/
cornerincorner(cube(point3d(A,B,C), L), cube(point3d(D,E,F), T)) :- 
    withincube(A, B, C, D, E, F, (D - T), (E - T), (F - T)); 
    withincube((A - L), B, C, D, E, F, (D - T), (E - T), (F - T)); 
    withincube(A, (B - L), C, D, E, F, (D - T), (E - T), (F - T)); 
    withincube(A, B, (C - L), D, E, F, (D - T), (E - T), (F - T));
    withincube((A - L), (B - L), C, D, E, F, (D - T), (E - T), (F - T));
    withincube((A - L), B, (C - L), D, E, F, (D - T), (E - T), (F - T));
    withincube(A, (B - L), (C - L), D, E, F, (D - T), (E - T), (F - T));
    withincube((A - L), (B - L), (C - L), D, E, F, (D - T), (E - T), (F - T)).
/* Contained Sphere - Cube Relation
Is sphere with center (A,B,C) and radius R contained in cube with front upper left corner (D,E,F) and side length L?
Objects: sphere(point3d(A,B,C), R) (sphere with center point3d(A,B,C) and radius R) cube(point3d(D,E,F), L) (cube with front-top-left corner point3d(D,E,F) (facing the x-z plane from positive y direction) and side-length L)*/
contained(sphere(point3d(A,B,C), R), cube(point3d(D,E,F), L)) :- 
    S is D - (L / 2), 
    T is E - (L / 2),
    U is F - (L / 2), 
    Q is (L/2)*(3**(1/2)), 
    contained(sphere(point3d(A,B,C), R), sphere(point3d(S,T,U), Q)),
    M is D - L,
    N is E - L,
    O is F - L,
    withincube(A + R, B, C, D, E, F, M, N, O),
    withincube(A - R, B, C, D, E, F, M, N, O),
    withincube(A, B + R, C, D, E, F, M, N, O),
    withincube(A, B - R, C, D, E, F, M, N, O),
    withincube(A, B, C + R, D, E, F, M, N, O),
    withincube(A, B, C - R, D, E, F, M, N, O).
/* Contained Sphere - Sphere Relation
Is sphere with center (A,B,C) and radius R contained in sphere with center (D,E,F) and radius Q?
Objects: sphere(point3d(A,B,C), R) (sphere with center point3d(A,B,C) and radius R) sphere(point3d(D,E,F), Q) (sphere with center point3d(D,E,F) and radius Q)*/
contained(sphere(point3d(A,B,C), R), sphere(point3d(D,E,F), Q)) :- (((A - D)**2 + (B - E)**2 + (C - F)**2)**(1/2)) =< (Q - R).
/* Contained Cube - Cube Relation
Is cube with front upper left corner (A,B,C) and side length L contained in cube with front upper left corner (D,E,F) and side length T?
Objects: cube(point3d(A,B,C), L) (cube with front-top-left corner point3d(A,B,C) (facing the x-z plane from positive y direction) and side-length L) cube(point3d(D,E,F), T) (cube with front-top-left corner point3d(D,E,F) (facing the x-z plane from positive y direction) and side-length T)*/
contained(cube(point3d(A,B,C), L), cube(point3d(D,E,F), T)) :- 
    S is A - (L / 2), 
    P is B - (L / 2),
    U is C - (L / 2), 
    Q is (L/2)*(3**(1/2)), 
    J is D - (T / 2), 
    K is E - (T / 2),
    M is F - (T / 2), 
    R is (T/2)*(3**(1/2)),  
    contained(sphere(point3d(S,P,U), Q), sphere(point3d(J,K,M), R)).
/* Contained Cube - Sphere Relation
Is cube with front upper left corner (A,B,C) and side length L contained in sphere with center (D,E,F) and radius R?
Objects: cube(point3d(A,B,C), L) (cube with front-top-left corner point3d(A,B,C) (facing the x-z plane from positive y direction) and side-length L) sphere(point3d(D,E,F), R) (sphere with center point3d(D,E,F) and radius R)*/
contained(cube(point3d(A,B,C), L), sphere(point3d(D,E,F), R)) :- 
    S is A - (L / 2), 
    P is B - (L / 2),
    U is C - (L / 2), 
    Q is (L/2)*(3**(1/2)), 
    contained(sphere(point3d(S,P,U), Q), sphere(point3d(D,E,F), R)).
/* Intersect Sphere - Cube Relation
Does sphere with center (A,B,C) and radius R intersect with cube with front upper left corner (D,E,F) and side length L?
Objects: sphere(point3d(A,B,C), R) (sphere with center point3d(A,B,C) and radius R) cube(point3d(D,E,F), L) (cube with front-top-left corner point3d(D,E,F) (facing the x-z plane from positive y direction) and side-length L)*/
intersects(sphere(point3d(A,B,C), R), cube(point3d(D,E,F), L)) :-  
    not(contained(sphere(point3d(A,B,C), R), cube(point3d(D,E,F), L))),
    not(contained(cube(point3d(D,E,F), L), sphere(point3d(A,B,C), R))),
    ((((A - D)**2 + (B - E)**2 + (C - F)**2)**(1/2)) =< R;
    (((A - (D - L))**2 + (B - E)**2 + (C - F)**2)**(1/2)) =< R;
    (((A - D)**2 + (B - (E - L))**2 + (C - F)**2)**(1/2)) =< R;
    (((A - D)**2 + (B - E)**2 + (C - (F - L))**2)**(1/2)) =< R;
    (((A - (D - L))**2 + (B - (E - L))**2 + (C - F)**2)**(1/2)) =< R;
    (((A - (D - L))**2 + (B - E)**2 + (C - (F - L))**2)**(1/2)) =< R;
    (((A - D)**2 + (B - (E - L))**2 + (C - (F - L))**2)**(1/2)) =< R;
    (((A - (D - L))**2 + (B - (E - L))**2 + (C - (F - L))**2)**(1/2)) =< R;
    intersects(cube(point3d(D,E,F), L), cube(point3d(A + R,B + R,C + R), R * 2))).
/* Intersect Sphere - Sphere Relation
Does sphere with center (A,B,C) and radius R intersect with sphere with center (D,E,F) and radius Q
Objects: sphere(point3d(A,B,C), R) (sphere with center point3d(A,B,C) and radius R) sphere(point3d(D,E,F), Q) (sphere with center point3d(D,E,F) and radius Q)*/
intersects(sphere(point3d(A,B,C), R), sphere(point3d(D,E,F), Q)) :- 
    not(contained(sphere(point3d(A,B,C), R), sphere(point3d(D,E,F), Q))),
    not(contained(sphere(point3d(D,E,F), Q), sphere(point3d(A,B,C), R))),
    (((A - D)**2 + (B - E)**2 + (C - F)**2)**(1/2)) < (R + Q).
/* Intersect Cube - Cube Relation
Does cube with front upper left corner (A,B,C) and side length L intersect with cube with front upper left corner (D,E,F) and side length T?
Objects: cube(point3d(A,B,C), L) (cube with front-top-left corner point3d(A,B,C) (facing the x-z plane from positive y direction) and side-length L) cube(point3d(D,E,F), T) (cube with front-top-left corner point3d(D,E,F) (facing the x-z plane from positive y direction) and side-length T)*/
intersects(cube(point3d(A,B,C), L), cube(point3d(D,E,F), T)) :- 
    cornerincorner(cube(point3d(A,B,C), L), cube(point3d(D,E,F), T)), 
    cornerincorner(cube(point3d(D,E,F), T), cube(point3d(A,B,C), L)),
    not(contained(cube(point3d(A,B,C), L), cube(point3d(D,E,F), T))),
    not(contained(cube(point3d(D,E,F), T), cube(point3d(A,B,C), L))).
/* Intersect Cube - Sphere Relation
Does cube with front upper left corner (A,B,C) and side length L intersect with sphere with center (D,E,F) and radius R?
Objects: cube(point3d(A,B,C), L) (cube with front-top-left corner point3d(A,B,C) (facing the x-z plane from positive y direction) and side-length L) sphere(point3d(D,E,F), R) (sphere with center point3d(D,E,F) and radius R)*/
intersects(cube(point3d(A,B,C), L), sphere(point3d(D,E,F), R)) :- intersects(sphere(point3d(D,E,F), R), cube(point3d(A,B,C), L)).
