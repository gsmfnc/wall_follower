import g4p_controls.*;

float radius = 50;

float uniciclo_size = 25;

float xDesUniciclo = 0;
float yDesUniciclo = 0;

float xUniciclo = 0;
float yUniciclo = 0;

float q1 = 0;
float q2 = 0;
float q3 = 0;

float q1Real = 0;
float q2Real = 0;
float q3Real = 0;

float scala = 35;
float joint_size = 12.5;
float end_effector_width = 34;

PGraphics pg;
PGraphics oscilloscope_pg;
int no_lines = 6;

float pgwidth = 200;
float pgheight = 200;

void setup()
{
    size(1000+200, 600, P3D);
    createGUI();

    pg = createGraphics((int) pgwidth, (int) pgheight);
    oscilloscope_pg = createGraphics((int) pgwidth, (int) pgheight);
    init_oscilloscope(no_lines);
}

void draw()
{
    background(173, 216, 230);
    pushMatrix();

    translate(width/2, height/2);
    rotateX(PI/5);

    directionalLight(255, 255, 255, 0, 0, -1.5);
    ambientLight(200, 200, 200);

    ring();
    obstacles();

    positionChecking();

    next_position();
    controller();
    pid();

    if (execute_lift_object == 1)
        lift_object();

    if (throwing == 1 || (frameCount - time_from_throw < 40 && frameCount > 40))
        lifted_box();

    pushMatrix();
    translate(xDesUniciclo-uniciclo_size, -yDesUniciclo, uniciclo_size/2);
    fill(123, 123, 123, 123);
    box(uniciclo_size);
    popMatrix();

    translate(xUniciclo, -yUniciclo);
    uniciclo();
    antropomorfo();

    popMatrix();
    textWriting();
    draw_explored_map();
    draw_oscilloscope();
}

void uniciclo()
{
    pushMatrix();

    fill(123, 123, 123);
    translate(-uniciclo_size, 0, uniciclo_size/2);
    rotate(-theta);
    box(uniciclo_size);

    distanceSensors();

    popMatrix();
}

void antropomorfo()
{
    pushMatrix();

    translate(-uniciclo_size, 0, uniciclo_size);
    rotate(-theta);

    link(q1Real, 2, -PI/2, 0);
    link(q2Real, 0, 0, 1.5);
    link(q3Real, 0, 0, 1);
    pinza();

    popMatrix();
}

void link(float theta, float d, float alpha, float a)
{
    fill(#CEA61F);
    rotateZ(theta);
    sphere(joint_size);

    translate(0, 0, scala * d/2.0);
    box(joint_size, joint_size, scala * d);
    translate(0, 0, scala * d/2.0);

    rotateX(alpha);
    sphere(joint_size);
    translate(scala*a/2.0, 0, 0);
    box(scala * a, joint_size, joint_size);
    translate(scala*a/2.0, 0, 0);
}

void pinza() {
    pushMatrix();
    translate(joint_size/4, 0, 0);
    box(joint_size/2, joint_size/2, end_effector_width);
    translate(joint_size/2, 0, end_effector_width/2);
    box(2*joint_size, joint_size/2, joint_size/3);
    translate(0, 0, -end_effector_width);
    box(2*joint_size, joint_size/2, joint_size/3);
    popMatrix();
}

void init_fpv2()
{
    xDesUniciclo = 0;
    yDesUniciclo = 0;

    xUniciclo = 0;
    yUniciclo = 0;

    q1 = 0;
    q2 = 0;
    q3 = 0;

    q1Real = 0;
    q2Real = 0;
    q3Real = 0;
}
