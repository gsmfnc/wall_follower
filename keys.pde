float step = 25;
float couplingStep = 0.1;

void keyPressed()
{
    if (key == 'w' && currentRow - 1 >= 0) {
        forward = 0;
        forwardRight = 0;
        forwardLeft = 0;
        backward = 1;
        backwardRight = 0;
        backwardLeft = 0;
        left = 0;
        right = 0;
    }
    if (key == 'q' && currentRow - 1 >= 0 && currentColumn - 1 >= 0) {
        forward = 0;
        forwardRight = 0;
        forwardLeft = 0;
        backward = 0;
        backwardRight = 0;
        backwardLeft = 1;
        left = 0;
        right = 0;
    }
    if (key == 'e' && currentRow - 1 >= 0
            && currentColumn + 1 < obstaclesColumns) {
        forward = 0;
        forwardRight = 0;
        forwardLeft = 0;
        backward = 0;
        backwardRight = 1;
        backwardLeft = 0;
        left = 0;
        right = 0;
    }
    if (key == 's' && currentRow + 1 < obstaclesRows) {
        forward = 1;
        forwardRight = 0;
        forwardLeft = 0;
        backward = 0;
        backwardRight = 0;
        backwardLeft = 0;
        left = 0;
        right = 0;
    }
    if (key == 'a' && currentRow + 1 < obstaclesRows && currentColumn - 1 >= 0)
    {
        forward = 0;
        forwardRight = 0;
        forwardLeft = 1;
        backward = 0;
        backwardRight = 0;
        backwardLeft = 0;
        left = 0;
        right = 0;
    }
    if (key == 'd' && currentRow + 1 < obstaclesRows
            && currentColumn + 1 < obstaclesColumns) {
        forward = 0;
        forwardRight = 1;
        forwardLeft = 0;
        backward = 0;
        backwardRight = 0;
        backwardLeft = 0;
        left = 0;
        right = 0;
    }
    if (key == 'z' && currentColumn - 1 >= 0) {
        forward = 0;
        forwardRight = 0;
        forwardLeft = 0;
        backward = 0;
        backwardRight = 0;
        backwardLeft = 0;
        left = 1;
        right = 0;
    }
    if (key == 'x' && currentColumn + 1 < obstaclesColumns) {
        forward = 0;
        forwardRight = 0;
        forwardLeft = 0;
        backward = 0;
        backwardRight = 0;
        backwardLeft = 0;
        left = 0;
        right = 1;
    }

    if (key == 'r')
        q1 += couplingStep;
    if (key == 'f')
        q1 -= couplingStep;

    if (key == 't')
        q2 += couplingStep;
    if (key == 'g')
        q2 -= couplingStep;

    if (key == 'y')
        q3 += couplingStep;
    if (key == 'h')
        q3 -= couplingStep;

    if (key == 'l')
        prepareLift = 1;
}
