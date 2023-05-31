float obstacles_size = 50;
float object_size = 25;

float ringWidthSize = 700;
float ringHeightSize = 450;

float obstaclesColumns = ringWidthSize / radius;
float obstaclesRows = ringHeightSize / radius;

float first_map[][] = {
    {1, 1, 1, 1, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 1, 1, 0, 1, 0, 1, 1, 0, 1, 1, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1},
    {1, 0, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
    {1, 0, 1, 0, 0, 1, 0, 1, 0, 1, 0, 1, 0, 1},
    {1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1},
    {1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1}
};
int[] first_map_object = {0, 4};

float second_map[][] = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1},
    {1, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 0, 1},
    {1, 0, 1, 1, 0, 1, 0, 0, 0, 1, 0, 1, 0, 1},
    {1, 0, 1, 0, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1},
    {1, 0, 1, 1, 1, 1, 0, 1, 0, 1, 0, 1, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 0, 1, 1, 1, 0, 1},
    {1, 1, 1, 1, 1, 1, 2, 1, 0, 0, 0, 0, 0, 1}
};
int[] second_map_object = {8, 6};

float third_map[][] = {
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1},
    {1, 1, 1, 0, 1, 1, 0, 0, 0, 0, 0, 0, 0, 1},
    {1, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 1, 0, 1},
    {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1},
    {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1},
    {1, 0, 1, 1, 1, 1, 0, 1, 1, 1, 0, 1, 0, 1},
    {2, 0, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 0, 1},
    {1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1}
};
int[] third_map_object = {7, 0};

float obstacles[][] = first_map;

int currentColumn = 6;
int currentRow = 4;

void init_environment()
{
    currentColumn = 6;
    currentRow = 4;
    first_map[first_map_object[0]][first_map_object[1]] = 2;
    second_map[second_map_object[0]][second_map_object[1]] = 2;
    third_map[third_map_object[0]][third_map_object[1]] = 2;
}

void ring()
{
    noFill();
    stroke(0, 0, 0);
    strokeWeight(10);

    pushMatrix();

    translate(- ringWidthSize / 2, - ringHeightSize / 2, 0); 
    rect(0, 0, ringWidthSize, ringHeightSize);

    //draws floor's grid
    strokeWeight(1);
    for (int i = 0; i < obstaclesRows; i++) {
        line(0, i*radius, ringWidthSize, i*radius);
    }
    for (int i = 0; i < obstaclesColumns; i++) {
        line(i*radius, 0, i*radius, ringHeightSize);
    }

    popMatrix();

    noStroke();
}

void obstacles()
{
    float obstacleX, obstacleY;

    pushMatrix();

    translate(- ringWidthSize / 2 + radius / 2,
        - ringHeightSize / 2 + radius / 2, radius / 2);

    fill(90);
    for (int i = 0; i < obstaclesRows; i++) {
        for (int j = 0; j < obstaclesColumns; j++) {
            if (obstacles[i][j] == 1) {
                obstacleX = j * radius;
                obstacleY = i * radius;

                pushMatrix();

                translate(obstacleX, obstacleY);
                box(obstacles_size);

                popMatrix();
            } else if (obstacles[i][j] == 2) {
                pushMatrix();

                translate(j * radius, i * radius);
                translate(0, radius/3);
                box(object_size);

                popMatrix();
            }
        }
    }

    popMatrix();
}
