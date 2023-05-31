int prepareLift = 0;
int lifting = 0;
int throwing = 0;
int time_from_lift;
int time_from_throw;
int ending = 0;
int execute_lift_object = 0;

int obstacleFound_i = 0;
int obstacleFound_j = 0;

void init_lift_object()
{
    prepareLift = 0;
    lifting = 0;
    throwing = 0;
    obstacleFound_i = 0;
    obstacleFound_j = 0;

    execute_lift_object = 0;
    ending = 0;
}

void lift_object()
{
    if (prepareLift == 1) {
        q2 = 0.0 * PI / 180.0;
        q3 = 65.0 * PI / 180.0;

        prepareLift = 0;
        lifting = 1;
        execute_lift_object = 1;

        time_from_lift = frameCount;
    }

    if (lifting == 1 && frameCount - time_from_lift > 40) {
        obstacles[obstacleFound_i][obstacleFound_j] = 0;
        lifted_box();

        q2 = -35.0 * PI / 180.0;
        q3 = 45.0 * PI / 180.0;
 
        throwing = 1;
        lifting = 0;

        //time = frameCount;
        execute_lift_object = 0;
    }

    if (throwing == 1) {
        if (currentRow == 0) {
            q1 = compute_correct_obstacle_direction("DW");
            q2 = 40.0 * PI / 180.0;
            q3 = 0;

            throwing = 0;
            ending = 1;
            v1 = 0;
            v2 = 0;

            time_from_throw = frameCount;
        }
        if (currentRow == obstaclesRows - 1) {
            q1 = compute_correct_obstacle_direction("UP");
            q2 = 40.0 * PI / 180.0;
            q3 = 0;

            throwing = 0;
            ending = 1;
            v1 = 0;
            v2 = 0;

            time_from_throw = frameCount;
        }
        if (currentColumn == 0) {
            q1 = compute_correct_obstacle_direction("LT");
            q2 = 40.0 * PI / 180.0;
            q3 = 0;

            throwing = 0;
            ending = 1;
            v1 = 0;
            v2 = 0;

            time_from_throw = frameCount;
        }
        if (currentColumn == obstaclesColumns - 1) {
            q1 = compute_correct_obstacle_direction("RT");
            q2 = 40.0 * PI / 180.0;
            q3 = 0;

            throwing = 0;
            ending = 1;
            v1 = 0;
            v2 = 0;

            time_from_throw = frameCount;
        }
    }
}

int check_neighbour_obstacles()
{
    if (currentColumn + 1 < obstaclesColumns) {
        if (obstacles[currentRow][currentColumn + 1] == 2) {
            obstacleFound_i = currentRow;
            obstacleFound_j = currentColumn + 1;
            q1 = compute_correct_obstacle_direction("RT");

            prepareLift = 1;

            return 1;
        }
    }
    
    if (currentRow + 1 < obstaclesRows) {
        if (obstacles[currentRow + 1][currentColumn] == 2) {
            obstacleFound_i = currentRow + 1;
            obstacleFound_j = currentColumn;
            q1 = compute_correct_obstacle_direction("UP");

            prepareLift = 1;
    
            return 1;
        }
    }
    
    if (currentRow - 1 >= 0) {
        if (obstacles[currentRow - 1][currentColumn] == 2) {
            obstacleFound_i = currentRow - 1;
            obstacleFound_j = currentColumn;
            q1 = compute_correct_obstacle_direction("DW");

            prepareLift = 1;
    
            return 1;
        }
    }
    
    if (currentColumn - 1 >= 0) {
        if (obstacles[currentRow][currentColumn - 1] == 2) {
            obstacleFound_i = currentRow;
            obstacleFound_j = currentColumn - 1;
            q1 = compute_correct_obstacle_direction("LT");

            prepareLift = 1;

            return 1;
        }
    }

    return 0;
}

float compute_correct_obstacle_direction(String s_case)
{
    int s = 0;
    float angle = convert_to_positive(thetaDes);
    if (abs(angle) <= 0.01) s = 0;
    if (abs(angle - PI/2) <= 0.01) s = 1;
    if (abs(angle - PI) <= 0.01) s = 2;
    if (abs(angle - 3*PI/2) <= 0.01) s = 3;
    if (s_case == "UP") {
        if (s == 0) return PI/2;
        if (s == 1) return PI;
        if (s == 2) return -PI/2;
        if (s == 3) return 0;
    } else if (s_case == "DW") {
        if (s == 0) return -PI/2;
        if (s == 1) return 0;
        if (s == 2) return PI/2;
        if (s == 3) return PI;
    } else if (s_case == "LT") {
        if (s == 0) return PI;
        if (s == 1) return -PI/2;
        if (s == 2) return 0;
        if (s == 3) return PI/2;
    } else if (s_case == "RT") {
        if (s == 0) return 0;
        if (s == 1) return PI/2;
        if (s == 2) return PI;
        if (s == 3) return -PI/2;
    }
    return 0.0;
}
void lifted_box()
{
    pushMatrix();
    translate(xUniciclo, -yUniciclo);
    translate(-uniciclo_size, 0, uniciclo_size);
    rotate(-theta);

    rotateZ(q1Real);
    translate(0, 0, 2*scala);
    rotateX(-PI/2);

    rotateZ(q2Real);
    translate(1.5 * scala, 0, 0);

    rotateZ(q3Real);
    translate(scala, 0, 0);

    translate(joint_size/2+object_size, 0, 0);

    fill(90);
    box(object_size);

    popMatrix();
}
