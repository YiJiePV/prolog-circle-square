/*
    Test File for Prolog Assignment Extra Challenge (3D points)
    This test file has 25 tests for the operations:
        Contains with spheres and cubes
        Intersects with spheres and cubes
*/

query(contained(sphere(point3d(8, 0, 0), 6), cube(point3d(6, 8, 8), 16))).    /*1. no*/   /* Contained Sphere - Cube*/
query(contained(sphere(point3d(5, 5, 5), 4), cube(point3d(10, 10, 10), 10))).   /*2. yes*/
query(contained(sphere(point3d(1, 0, 0), 6), cube(point3d(6, 8, 8), 16))).   /*3. no*/
query(contained(sphere(point3d(-5, 2, 5), 3), sphere(point3d(-4, 1, 4), 5))).  /*4. yes*/   /* Contained Sphere - Sphere */
query(contained(sphere(point3d(4, 8, 1), 8), sphere(point3d(8, 1, -4), 5))).   /*5. no*/
query(contained(sphere(point3d(-9, 2, 7), 6.5), sphere(point3d(0, 2, -1), 5))).   /*6. no*/
query(contained(cube(point3d(10, 10, 10), 10), sphere(point3d(5, 5, 5), 9))).    /*7. yes*/   /* Contained Cube - Sphere */
query(contained(cube(point3d(14, 14, 14), 14), sphere(point3d(5, 5, 5), 9))).    /*8. no*/
query(contained(cube(point3d(8, 8, 13), 8), sphere(point3d(5, 5, 5), 9))).  /*9. no*/
query(contained(cube(point3d(1, 2, 3), 6), cube(point3d(6, 8, 8), 16))).   /*10. yes*/   /* Contained Cube - Cube */
query(contained(cube(point3d(9.5, 4, 9.5), 4.5), cube(point3d(8, 8, 13), 8))).   /*11. no*/
query(contained(cube(point3d(13, 9, 9), 4), cube(point3d(8, 8, 13), 8))).  /*12. no*/
query(intersects(sphere(point3d(-5, 7, 8), 6.5), cube(point3d(8, 8, 13), 8))).  /*13. yes*/   /* Intersect Sphere - Cube */
query(intersects(sphere(point3d(-2, 5, 8), 3), cube(point3d(8, 8, 13), 8))).   /*14. yes*/
query(intersects(sphere(point3d(-5, 9, 1), 3), cube(point3d(8, 8, 13), 8))).   /*15. no*/
query(intersects(sphere(point3d(-5, 2, 5), 3), sphere(point3d(-4, 1, 4), 5))).  /*16. no*/   /* Intersect Sphere - Sphere */
query(intersects(sphere(point3d(4, 8, 1), 8), sphere(point3d(8, 1, -4), 5))).  /*17. yes*/
query(intersects(sphere(point3d(-9, 2, 7), 6.5), sphere(point3d(0, 2, -1), 5))). /*18. no*/
query(intersects(cube(point3d(12, 11, 9), 5), sphere(point3d(0, 2, -1), 10))).   /*19. yes*/   /* Intersect Cube - Sphere */
query(intersects(cube(point3d(10, 10, 10), 10), sphere(point3d(5, 5, 5), 9))). /*20. no*/
query(intersects(cube(point3d(12, 11, 9), 4), sphere(point3d(0, 2, -1), 7))).   /*21. no*/   
query(intersects(cube(point3d(13, 9, 9), 4), cube(point3d(8, 8, 13), 8))). /*22. no*/   /* Intersect Cube - Cube*/
query(intersects(cube(point3d(1, 2, 3), 6), cube(point3d(6, 8, 8), 16))).  /*23. no*/
query(intersects(cube(point3d(9.5, 4, 9.5), 4.5), cube(point3d(8, 8, 13), 8))). /*24. yes*/
query(intersects(cube(point3d(12, 11, 9), 5), cube(point3d(8, 8, 13), 8))). /*25. yes*/


writeln(T) :- write(T), nl.

main:- forall(query(Q), Q -> (writeln('yes')) ; (writeln('no'))),
	halt.