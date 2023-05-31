float explored_map[][] = {
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1},
    {-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1}
};

void init_exploring()
{
    for (int i = 0; i < obstaclesRows; ++i)
        for (int j = 0; j <obstaclesColumns; ++j)
            explored_map[i][j] = -1;
}

void explore_neighbourhood()
{
    float tmp = 0;
    int row_sign = 2;
    int column_sign = 2;

    for (int k = 0; k < no_sensors; k++) {
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
                    index_j >= 0 && index_j < obstaclesColumns)
                if (sensorsValue[k] < maxDistance)
                    explored_map[index_i][index_j] = 1;
                else
                    explored_map[index_i][index_j] = 0;
        }
    }
}

void draw_explored_map()
{
    pg.beginDraw();
    pg.background(255, 255, 255);
    for (int i = 0; i < obstaclesColumns; i++) {
        pg.line(i*pgwidth/obstaclesColumns, 0,
             i*pgwidth/obstaclesColumns, pgheight);
    }
    for (int i = 0; i < obstaclesRows; i++) {
        pg.line(0, i*pgheight/obstaclesRows,
             pgwidth, i*pgheight/obstaclesRows);
    }
    for (int i = 0; i < obstaclesRows; i++) {
        for (int j = 0; j < obstaclesColumns; j++) {
            if (explored_map[i][j] == 1.0)
                pg.fill(255, 0, 0);
            else if (explored_map[i][j] == 0.0)
                pg.fill(0, 255, 0);
            else
                pg.fill(255, 255, 255);
            pg.rect(j*pgwidth/obstaclesColumns,
                    i*pgheight/obstaclesRows,
                    pgwidth/obstaclesColumns, pgheight/obstaclesRows);
        }
    }
    pg.endDraw();
    image(pg, 970, 10);
}
