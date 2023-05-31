float final_thetaDes = thetaDes;
float initial_thetaDes = thetaDes; 

float UP = 3 * PI/2;
float DW = PI/2;
float LT = PI;
float RT = 0;

int index1, index2;
int iteration = 0;

void init_path()
{
    final_thetaDes = thetaDes;
    initial_thetaDes = thetaDes;

    UP = 3 * PI/2;
    DW = PI/2;
    LT = PI;
    RT = 0;

    iteration = 0;
}

void next_position()
{
    //forward case
    if (forward == 1) {
        xDesUniciclo = xDesUniciclo;
        yDesUniciclo = yDesUniciclo - radius;
        forward = 0;

        if (final_thetaDes != UP)
            final_thetaDes = UP;
        if (initial_thetaDes != UP)
            initial_thetaDes = find_closest_orientation(UP);

        stop_first_rotation = 0;

        currentRow += 1;
    }
    //backward case
    if (backward == 1) {
        xDesUniciclo = xDesUniciclo;
        yDesUniciclo = yDesUniciclo + radius;
        backward = 0;

        if (final_thetaDes != DW)
            final_thetaDes = DW;
        if (initial_thetaDes != DW)
            initial_thetaDes = find_closest_orientation(DW);

        stop_first_rotation = 0;

        currentRow -= 1;
    }
    //right case
    if (right == 1) {
        xDesUniciclo = xDesUniciclo + radius;
        yDesUniciclo = yDesUniciclo;
        right = 0;

        if (final_thetaDes != RT)
            final_thetaDes = RT;
        if (initial_thetaDes != RT)
            initial_thetaDes = find_closest_orientation(RT);

        stop_first_rotation = 0;

        currentColumn += 1;
    }
    //left case
    if (left == 1) {
        xDesUniciclo = xDesUniciclo - radius;
        yDesUniciclo = yDesUniciclo;
        left = 0;

        if (final_thetaDes != LT)
            final_thetaDes = LT;
        if (initial_thetaDes != LT)
            initial_thetaDes = find_closest_orientation(LT);
        stop_first_rotation = 0;

        currentColumn -= 1;
    }
    //forward-right case
    if (forwardRight == 1) {
        xDesUniciclo = xDesUniciclo + radius;
        yDesUniciclo = yDesUniciclo - radius;
        forwardRight = 0;

        compute_indexes_to_analyze("FR");

        if (abs(sensorsValue[index1] - maxDistance) <= 1)
            initial_thetaDes = find_closest_orientation(3*PI/2);
        if (abs(sensorsValue[index2] - maxDistance) <= 1)
            initial_thetaDes = find_closest_orientation(0);
        stop_first_rotation = 0;

        currentRow += 1;
        currentColumn += 1;
    }
    //forward-left case
    if (forwardLeft == 1) {
        xDesUniciclo = xDesUniciclo - radius;
        yDesUniciclo = yDesUniciclo - radius;
        forwardLeft = 0;

        compute_indexes_to_analyze("FL");

        if (abs(sensorsValue[index1] - maxDistance) <= 1)
            initial_thetaDes = find_closest_orientation(3*PI/2);
        if (abs(sensorsValue[index2] - maxDistance) <= 1)
            initial_thetaDes = find_closest_orientation(PI);
        stop_first_rotation = 0;

        currentRow += 1;
        currentColumn -= 1;
    }
    //backward-right case
    if (backwardRight == 1) {
        xDesUniciclo = xDesUniciclo + radius;
        yDesUniciclo = yDesUniciclo + radius;
        backwardRight = 0;

        compute_indexes_to_analyze("BR");

        if (abs(sensorsValue[index1] - maxDistance) <= 1)
            initial_thetaDes = find_closest_orientation(PI/2);
        if (abs(sensorsValue[index2] - maxDistance) <= 1)
            initial_thetaDes = find_closest_orientation(0);
        stop_first_rotation = 0;

        currentRow -= 1;
        currentColumn += 1;
    }
    //backward-left case
    if (backwardLeft == 1) {
        xDesUniciclo = xDesUniciclo - radius;
        yDesUniciclo = yDesUniciclo + radius;
        backwardLeft = 0;

        compute_indexes_to_analyze("BL");

        if (abs(sensorsValue[index1] - maxDistance) <= 1)
            initial_thetaDes = find_closest_orientation(PI/2);
        if (abs(sensorsValue[index2] - maxDistance) <= 1)
            initial_thetaDes = find_closest_orientation(PI);
        stop_first_rotation = 0;

        currentRow -= 1;
        currentColumn -= 1;
    }
}

void compute_indexes_to_analyze(String s_case)
{
    float angle = convert_to_positive(final_thetaDes);
    if (s_case == "BL") {
        if (abs(angle - 0) <= 0.01) {
            index1 = LEFT;
            index2 = BACK;
        }
        if (abs(angle - PI/2) <= 0.01) {
            index1 = FRONT;
            index2 = LEFT;
        }
        if (abs(angle - PI) <= 0.01) {
            index1 = RIGHT;
            index2 = FRONT;
        }
        if (abs(angle - 3*PI/2) <= 0.01) {
            index1 = BACK;
            index2 = RIGHT;
        }
    }
    if (s_case == "BR") {
        if (abs(angle - 0) <= 0.01) {
            index1 = LEFT;
            index2 = FRONT;
        }
        if (abs(angle - PI/2) <= 0.01) {
            index1 = FRONT;
            index2 = RIGHT;
        }
        if (abs(angle - PI) <= 0.01) {
            index1 = RIGHT;
            index2 = BACK;
        }
        if (abs(angle - 3*PI/2) <= 0.01) {
            index1 = BACK;
            index2 = LEFT;
        }
    }
    if (s_case == "FR") {
        if (abs(angle - 0) <= 0.01) {
            index1 = RIGHT;
            index2 = FRONT;
        }
        if (abs(angle - PI/2) <= 0.01) {
            index1 = BACK;
            index2 = RIGHT;
        }
        if (abs(angle - PI) <= 0.01) {
            index1 = LEFT;
            index2 = BACK;
        }
        if (abs(angle - 3*PI/2) <= 0.01) {
            index1 = FRONT;
            index2 = LEFT;
        }
    }
    if (s_case == "FL") {
        if (abs(angle - 0) <= 0.01) {
            index1 = RIGHT;
            index2 = BACK;
        }
        if (abs(angle - PI/2) <= 0.01) {
            index1 = BACK;
            index2 = LEFT;
        }
        if (abs(angle - PI) <= 0.01) {
            index1 = LEFT;
            index2 = FRONT;
        }
        if (abs(angle - 3*PI/2) <= 0.01) {
            index1 = FRONT;
            index2 = RIGHT;
        }
    }
}

void compute_final_orientation()
{
    float tmp;
    float best = 0;
    float angle = convert_to_positive(theta);
    float m = abs(angle);
    int k = 0;

    while (abs(angle - k * PI/2) > abs(angle - (k+1) * PI/2))
        k++;
    best = k * PI/2;

    if (theta < 0)
        while (abs(best - theta) > abs(best - 2*PI - theta))
            best -= 2*PI;

    final_thetaDes = best;
}

float convert_to_positive(float theta)
{
    while (theta < 0)
        theta += 2*PI;
    return theta;
}

float find_closest_orientation(float orientation)
{
    float best = orientation;
    if (theta >= 0)
        while (abs(best - theta) > abs(best + 2*PI - theta))
            best += 2*PI;
    else
        while (abs(best - theta) > abs(best - 2*PI - theta))
            best -= 2*PI;
    return best;
}

void exploring()
{
    if (abs(sensorsValue[RIGHT] - maxDistance) <= 1)
        compute_correct_direction("RT");
    else if (abs(sensorsValue[FRONT_RIGHT] - maxDistance) <= 1)
        compute_correct_direction("FR");
    else if (abs(sensorsValue[FRONT] - maxDistance) <= 1)
        compute_correct_direction("FW");
    else if (abs(sensorsValue[BACK] - maxDistance) <= 1 &&
                abs(sensorsValue[LEFT] - maxDistance) <= 1)
        compute_correct_direction("LF");
    else if (abs(sensorsValue[BACK_LEFT] - maxDistance) <= 1)
        compute_correct_direction("BL");
    else if (abs(sensorsValue[BACK_RIGHT] - maxDistance) <= 1)
        compute_correct_direction("BR");
    else if (abs(sensorsValue[BACK] - maxDistance) <= 1)
        compute_correct_direction("BW");
}

void compute_correct_direction(String s_case)
{
    int s = 0;
    float angle = convert_to_positive(thetaDes);
    if (abs(angle) <= 0.01) s = 0;
    if (abs(angle - PI/2) <= 0.01) s = 1;
    if (abs(angle - PI) <= 0.01) s = 2;
    if (abs(angle - 3*PI/2) <= 0.01) s = 3;
    if (s_case == "FW") {
        reset_indexes();
        if (s == 0) right = 1;
        if (s == 1) backward = 1;
        if (s == 2) left = 1;
        if (s == 3) forward = 1;
    } else if (s_case == "FL") {
        reset_indexes();
        if (s == 0) backwardRight = 1;
        if (s == 1) backwardLeft = 1;
        if (s == 2) forwardLeft = 1;
        if (s == 3) forwardRight = 1;
    } else if (s_case == "FR") {
        reset_indexes();
        if (s == 0) forwardRight = 1;
        if (s == 1) backwardRight = 1;
        if (s == 2) backwardLeft = 1;
        if (s == 3) forwardLeft = 1;
    } else if (s_case == "BW") {
        reset_indexes();
        if (s == 0) left = 1;
        if (s == 1) forward = 1;
        if (s == 2) right = 1;
        if (s == 3) backward = 1;
    } else if (s_case == "BR") {
        reset_indexes();
        if (s == 0) forwardLeft = 1;
        if (s == 1) forwardRight = 1;
        if (s == 2) backwardRight = 1;
        if (s == 3) backwardLeft = 1;
    } else if (s_case == "BL") {
        reset_indexes();
        if (s == 0) backwardLeft = 1;
        if (s == 1) forwardLeft = 1;
        if (s == 2) forwardRight = 1;
        if (s == 3) backwardRight = 1;
    } else if (s_case == "LF") {
        reset_indexes();
        if (s == 0) backward = 1;
        if (s == 1) left = 1;
        if (s == 2) forward = 1;
        if (s == 3) right = 1;
    } else if (s_case == "RT") {
        reset_indexes();
        if (s == 0) forward = 1;
        if (s == 1) right = 1;
        if (s == 2) backward = 1;
        if (s == 3) left = 1;
    }
}

void reset_indexes()
{
    forward = 0;
    backward = 0;
    right = 0;
    left = 0;
    backwardLeft = 0;
    backwardRight = 0;
    forwardLeft = 0;
    forwardRight = 0;
}
