float maxDistance = 75;

float sensorsValue[] = {0, 0, 0, 0, 0, 0, 0, 0};
int no_sensors = 8;

static final int FRONT = 0;
static final int FRONT_LEFT = 1;
static final int LEFT = 2;
static final int BACK_LEFT = 3;
static final int BACK = 4;
static final int BACK_RIGHT = 5;
static final int RIGHT = 6;
static final int FRONT_RIGHT = 7;

float precision = 15;

void init_distance()
{
    for (int i = 0; i < no_sensors; ++i)
        sensorsValue[i] = 0;
}

void distanceSensors()
{
    stroke(255, 0, 0);
    pushMatrix();
    for (int k = 0; k < no_sensors; k++) {
        if (k == 0) strokeWeight(3);
        else strokeWeight(1);
        rotateZ(k * (PI/4));
        line(0, 0, maxDistance, 0); 
    }
    popMatrix();
    noStroke();
}

void measureDistance()
{
    float d = maxDistance;
    float tmp = 0;
    int row_sign = 2;
    int column_sign = 2;

    for (int k = 0; k < no_sensors; k++) {
        d = maxDistance;

        tmp = thetaDes;
        tmp += k * (PI / 4);

        if (cos(tmp) > 0.01)
            column_sign = 1;
        if (abs(cos(tmp)) <= 0.01)
            column_sign = 0;
        if (cos(tmp) < -0.01)
            column_sign = -1;
        if (sin(tmp) > 0.01)
            row_sign = -1;
        if (abs(sin(tmp)) <= 0.01)
            row_sign = 0;
        if (sin(tmp) < -0.01)
            row_sign = 1;
    
        if (row_sign != 2 && column_sign != 2) {
            int index_i = currentRow + row_sign;
            int index_j = currentColumn + column_sign;
            if (index_i >= 0 && index_i < obstaclesRows &&
                    index_j >= 0 && index_j < obstaclesColumns) {
                if (obstacles[index_i][index_j] == 1 ||
                            obstacles[index_i][index_j] == 2)
                    d = 2 / sqrt(2) * radius / 2;
            } else
                d = 2 / sqrt(2) * radius / 2;
        }
    
        sensorsValue[k] = Math.round(d*100)/100;
    }
}
