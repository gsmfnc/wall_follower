//int prepareLift = 0;
//int lifting = 0;
//int throwing = 0;
//int time;
//
//int obstacleFound_i = 0;
//int obstacleFound_j = 0;
//
//void liftObstacle()
//{
//    if (prepareLift == 1)
//        if (checkNeighbourObstacles() == 1) {
//            q2 = 60.0 * PI / 180.0;
//            q3 = -60.0 * PI / 180.0;
//
//            prepareLift = 0;
//            lifting = 1;
//
//            time = frameCount;
//        }
//
//    if (lifting == 1 && frameCount - time > 120) {
//
//            obstacles[obstacleFound_i][obstacleFound_j] = 0;
//            liftedBox();
//
//            q2 = 22.0 * PI / 180.0;
//            q3 = -90.0 * PI / 180.0;
// 
//            throwing = 1;
//            lifting = 0;
//
//            time = frameCount;
//    }
//
//    if (throwing == 1) {
//        liftedBox();
//
//        if (frameCount - time > 120) {
//            if (currentRow == 0) {
//                q1 = -PI/2;
//                q2 = 40.0 * PI / 180.0;
//                q3 = 0;
//
//                throwing = 0;
//            }
//            if (currentRow == obstaclesRows - 1) {
//                q1 = PI/2;
//                q2 = 40.0 * PI / 180.0;
//                q3 = 0;
//
//                throwing = 0;
//            }
//            if (currentColumn == 0) {
//                q1 = PI;
//                q2 = 40.0 * PI / 180.0;
//                q3 = 0;
//
//                throwing = 0;
//            }
//            if (currentColumn == obstaclesColumns - 1) {
//                q1 = 0;
//                q2 = 40.0 * PI / 180.0;
//                q3 = 0;
//
//                throwing = 0;
//            }
//        }
//    }
//}
//
//int checkNeighbourObstacles()
//{
//    if (currentColumn + 1 < obstaclesColumns) {
//        if (obstacles[currentRow][currentColumn + 1] == 1) {
//            obstacleFound_i = currentRow;
//            obstacleFound_j = currentColumn + 1;
//            q1 = 0;
//
//            return 1;
//        }
//    }
//    
//    if (currentRow + 1 < obstaclesRows) {
//        if (obstacles[currentRow + 1][currentColumn] == 1) {
//            obstacleFound_i = currentRow + 1;
//            obstacleFound_j = currentColumn;
//            q1 = PI/2;
//    
//            return 1;
//        }
//    }
//    
//    if (currentRow - 1 >= 0) {
//        if (obstacles[currentRow - 1][currentColumn] == 1) {
//            obstacleFound_i = currentRow - 1;
//            obstacleFound_j = currentColumn;
//            q1 = -PI/2;
//    
//            return 1;
//        }
//    }
//    
//    if (currentColumn - 1 >= 0) {
//        if (obstacles[currentRow][currentColumn - 1] == 1) {
//            obstacleFound_i = currentRow;
//            obstacleFound_j = currentColumn - 1;
//            q1 = PI;
//
//            return 1;
//        }
//    }
//
//    return 0;
//}
//
//void liftedBox()
//{
//    pushMatrix();
//    translate(xUniciclo, yUniciclo);
//    translate(-radius/2, 0, radius);
//
//    rotateZ(q1Real);
//    translate(0, 0, scala);
//    rotateX(-PI/2);
//
//    rotateZ(q2Real);
//    translate(1.5 * scala, 0, 0);
//
//    rotateZ(q3Real);
//    translate(scala, 0, 0);
//
//    fill(90);
//    box(radius);
//
//    popMatrix();
//}
