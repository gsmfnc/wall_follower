float time_step = 1 / 6.0;
float endscreen = pgwidth / time_step;

float oldq1 = q1Real;
float oldq2 = q2Real;
float oldq3 = q3Real;
float oldx = xUniciclo;
float oldy = yUniciclo;
float oldtheta = theta;

float oldq1REF = q1;
float oldq2REF = q2;
float oldq3REF = q3;
float oldxDes = xDesUniciclo;
float oldyDes = yDesUniciclo;
float oldthetaDes = thetaDes;

void draw_oscilloscope()
{
    oscilloscope_pg.beginDraw();

    oscilloscope_plot(oldq1REF, q1, oldq1, q1Real, 0, 1);
    oscilloscope_plot(oldq2REF, q2, oldq2, q2Real, 1, 1);
    oscilloscope_plot(oldq3REF, q3, oldq3, q3Real, 2, 1);
    oscilloscope_plot(oldxDes, xDesUniciclo, oldx, xUniciclo, 3, 0.01);
    oscilloscope_plot(oldyDes, yDesUniciclo, oldy, yUniciclo, 4, 0.01);
    oscilloscope_plot(oldthetaDes, thetaDes, oldtheta, theta, 5, 0.5);

    if (frameCount % endscreen == 0)
        init_oscilloscope(no_lines);

    oscilloscope_pg.endDraw();
    image(oscilloscope_pg, 10, 10);

    oldq1REF = q1;
    oldq2REF = q2;
    oldq3REF = q3;

    oldq1 = q1Real;
    oldq2 = q2Real;
    oldq3 = q3Real;

    oldx = xUniciclo;
    oldy = yUniciclo;
    oldtheta = theta;

    oldxDes = xDesUniciclo;
    oldyDes = yDesUniciclo;
    oldthetaDes = thetaDes;
}

void oscilloscope_plot(float oldREF, float actualREF, float old, float actual,
                        int i, float r_scale)
{
    oldREF *= r_scale;
    actualREF *= r_scale;
    old *= r_scale;
    actual *= r_scale;

    oscilloscope_pg.stroke(126);
    oscilloscope_pg.line(pgwidth - time_step * ((frameCount - 1) % endscreen),
                        pgheight/(no_lines+1) * (i+1) - oldREF * 10,
                        pgwidth - time_step * (frameCount % endscreen),
                        pgheight/(no_lines+1) * (i+1) - actualREF * 10);

    oscilloscope_pg.stroke(0);
    oscilloscope_pg.line(pgwidth - time_step * ((frameCount - 1) % endscreen),
                        pgheight/(no_lines+1) * (i+1) - old * 10,
                        pgwidth - time_step * (frameCount % endscreen),
                        pgheight/(no_lines+1) * (i+1) - actual * 10);
}
void init_oscilloscope(int no_lines)
{
    oscilloscope_pg.beginDraw();
    oscilloscope_pg.background(255, 255, 255);
    oscilloscope_pg.stroke(200);
    oscilloscope_pg.fill(0, 0, 0);
    for (int i = 0; i < no_lines; ++i) {
        oscilloscope_pg.line(0, pgheight/(no_lines+1) * (i+1),
                            pgwidth, pgheight/(no_lines+1) * (i+1));
        oscilloscope_pg.line(pgwidth/(no_lines+1) * (i+1), 0,
                            pgwidth/(no_lines+1) * (i+1), pgheight);
    }
    oscilloscope_pg.endDraw();
}
