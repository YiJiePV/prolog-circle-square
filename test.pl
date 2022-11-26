/*
    Test File for Prolog Assignment
    This test file has 25 tests for the operations:
        Contains with circles and squares
        Intersects with circles and squares
*/

query(contained(circle(point2d(5, 5), 4), square(point2d(6, 4), 1))).    /*1. no*/   /* Contained Circle - Square*/
query(contained(circle(point2d(4, 7), 2), square(point2d(1, 10), 7))).   /*2. yes*/
query(contained(circle(point2d(5, 5), 4), square(point2d(1, 10), 7))).   /*3. no*/
query(contained(circle(point2d(4, 7), 1.5), circle(point2d(5, 5), 4))).  /*4. yes*/   /* Contained Circle - Circle */
query(contained(circle(point2d(4, 7), 2), circle(point2d(5, -1), 3))).   /*5. no*/
query(contained(circle(point2d(5, 5), 4), circle(point2d(5, -1), 3))).   /*6. no*/
query(contained(square(point2d(6, 4), 1), circle(point2d(5, 5), 4))).    /*7. yes*/   /* Contained Square - Circle */
query(contained(square(point2d(8, 6), 2), circle(point2d(5, 5), 4))).    /*8. no*/
query(contained(square(point2d(-1, 12), 3), circle(point2d(4, 7), 2))).  /*9. no*/
query(contained(square(point2d(6, 4), 1), square(point2d(1, 10), 7))).   /*10. yes*/   /* Contained Square - Square */
query(contained(square(point2d(8, 6), 2), square(point2d(1, 10), 7))).   /*11. no*/
query(contained(square(point2d(8, 6), 2), square(point2d(-1, 12), 3))).  /*12. no*/
query(intersects(circle(point2d(5, 5), 4), square(point2d(1, 10), 7))).  /*13. yes*/   /* Intersect Circle - Square */
query(intersects(circle(point2d(5, 5), 4), square(point2d(8, 6), 2))).   /*14. yes*/
query(intersects(circle(point2d(4, 7), 2), square(point2d(6, 4), 1))).   /*15. no*/
query(intersects(circle(point2d(4, 7), 2), circle(point2d(5, -1), 3))).  /*16. no*/   /* Intersect Circle - Circle */
query(intersects(circle(point2d(5, 5), 4), circle(point2d(5, -1), 3))).  /*17. yes*/
query(intersects(circle(point2d(5, 5), 4), circle(point2d(4, 7), 1.5))). /*18. no*/
query(intersects(square(point2d(8, 6), 2), circle(point2d(5, 5), 4))).   /*19. yes*/   /* Intersect Square - Circle */
query(intersects(square(point2d(-1, 12), 3), circle(point2d(4, 7), 2))). /*20. no*/
query(intersects(square(point2d(6, 4), 1), circle(point2d(5, 5), 4))).   /*21. no*/   
query(intersects(square(point2d(6, 4), 1), square(point2d(-1, 12), 3))). /*22. no*/   /* Intersect Square - Square*/
query(intersects(square(point2d(1, 10), 7), square(point2d(6, 8), 1))).  /*23. no*/
query(intersects(square(point2d(-1, 12), 3), square(point2d(1, 10), 7))). /*24. yes*/
query(intersects(square(point2d(1, 10), 7), square(point2d(-1, 12), 3))). /*25. yes*/


writeln(T) :- write(T), nl.

main:- forall(query(Q), Q -> (writeln('yes')) ; (writeln('no'))),
	halt.