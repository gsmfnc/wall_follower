float v1 = 0;
float v2 = 0;
float theta = PI/2;
float thetaDes = PI/2;

float e_p;
float kv1 = 3;
float kv2 = 6;

float kp = 0.1;

int forward = 0;
int forwardRight = 0;
int forwardLeft = 0;
int backward = 0;
int backwardRight = 0;
int backwardLeft = 0;
int left = 0;
int right = 0;

float dt = 1 / 60.0;

int nGiri = 0;

int stop_first_rotation = 0;
int stop_final_rotation = 1;

static final int P = 0;
static final int BB = 1;
int control_mode = P;

float cosPhi = 0;
float wpM = 100;
float v1Des;
float v2Des;
float a1 = 0;
float a2 = 0;
float ka1 = 100;
float ka2 = 100;
float alpha1, alpha2; //coefficienti per valutare saturazione
float alpha1Bar, alpha2Bar; //coefficienti alpha corretti
float vincolo; //vincolo saturazione attuatori

float r = 8; //raggio ruote in pixel
float d = 20; //distanza tra le ruote in pixel
float W = 5; //spessore ruota in pixel
float R = 1.2*sqrt(pow(r,2)+pow(d/2+W/2,2)); //raggio robot

float A1Max = .3*r*wpM;


void init_controller()
{
    v1 = 0;
    v2 = 0;
    theta = PI/2;
    thetaDes = PI/2;
    forward = 0;
    forwardRight = 0;
    forwardLeft = 0;
    backward = 0;
    backwardRight = 0;
    backwardLeft = 0;
    left = 0;
    right = 0;
    nGiri = 0;
    stop_first_rotation = 0;
    stop_final_rotation = 1;
}

void controller()
{
    e_p = sqrt(pow(xDesUniciclo-xUniciclo, 2) +
            pow(yDesUniciclo-yUniciclo, 2));
    if (execute_lift_object == 0 && ending == 0) {
        if (abs(initial_thetaDes - theta) > 0.1 && stop_first_rotation == 0) {
            v1 = 0;
            thetaDes = initial_thetaDes;
            kv2 = 2;
            v2 = kv2 * (thetaDes - theta);
        } else if (e_p > 1) {
            if (control_mode == P) {
                proportional();
            } else if (control_mode == BB) {
                bang_bang();
            }
            stop_first_rotation = 1;
            stop_final_rotation = 0;
        } else {
            measureDistance();
            explore_neighbourhood();
            v1 = 0;
            if (check_neighbour_obstacles() == 1) {
                lift_object();
                v2 = 0;
                return;
            }
            if (stop_final_rotation == 0) {
                compute_final_orientation();
                stop_final_rotation = 1;
            }
            thetaDes = final_thetaDes;
            if (control_mode == P) {
                kv2 = 2;
                v2 = kv2 * (thetaDes - theta);
            } else if (control_mode == BB) {
                kv2 = 2;
                ka2 = 60;
                v2Des = kv2*(thetaDes-theta);
                a2 = ka2*(v2Des-v2);
                alpha2 = a2/(2*r*wpM/d);
                if (abs(alpha2)>1) // se sono in saturazione
                {
                    alpha2Bar = alpha2/vincolo;
                    a2 = alpha2Bar*2*r*wpM/d;
                }
                v2 = v2 + a2*dt;
            }

            if (abs(thetaDes - theta) <= 0.005 && manual == 0) {
                exploring();
                if (throwing == 1)
                    lift_object();
            }
        }
    }

    theta = theta + v2 * dt;
    xUniciclo = xUniciclo + v1 * cos(theta) * dt;
    yUniciclo = yUniciclo + v1 * sin(theta) * dt;
}

void pid()
{
    q1Real = q1Real + kp * (q1 - q1Real);
    q2Real = q2Real + kp * (q2 - q2Real);
    q3Real = q3Real + kp * (q3 - q3Real);
}

void proportional()
{
    kv2 = 4.5;
    thetaDes = atan2(yDesUniciclo - yUniciclo, xDesUniciclo - xUniciclo) +
            nGiri*2*PI;
    if (abs(thetaDes + 2*PI - theta) < abs(thetaDes - theta)) {
        thetaDes = thetaDes + 2*PI;
        nGiri += 1;
    } else {
        if (abs(thetaDes - 2*PI - theta) < abs(thetaDes - theta)) {
            thetaDes = thetaDes - 2*PI;
            nGiri -= 1;
        }
    }
    
    v2 = kv2 * (thetaDes - theta);
    v1 = kv1 * ((xDesUniciclo - xUniciclo) * cos(theta) +
        (yDesUniciclo - yUniciclo) * sin(theta));
}

void bang_bang()
{
    // assegno velocità secondo legge bang-bang    
    cosPhi = (cos(theta)*(xDesUniciclo-xUniciclo)+
                sin(theta)*(yDesUniciclo-yUniciclo))/e_p;
    v1Des = sqrt(2*A1Max*e_p)*cosPhi;

    kv2 = 5.5;
    thetaDes = atan2(yDesUniciclo - yUniciclo, xDesUniciclo - xUniciclo) +
            nGiri*2*PI;
    if (abs(thetaDes + 2*PI - theta) < abs(thetaDes - theta)) {
        thetaDes = thetaDes + 2*PI;
        nGiri += 1;
    } else {
        if (abs(thetaDes - 2*PI - theta) < abs(thetaDes - theta)) {
            thetaDes = thetaDes - 2*PI;
            nGiri -= 1;
        }
    }
    // assegno velocità angolare secondo legge proporzionale        
    v2Des = kv2*(thetaDes-theta);

    // Calcolo accelerazioni con legge proporzionale
    a1 = ka1*(v1Des-v1);    
    a2 = ka2*(v2Des-v2);      
  
    // Determino coefficienti carico motori per assicurare le accelerazioni richieste
    alpha1 = a1/(r*wpM);
    alpha2 = a2/(2*r*wpM/d);
  
    vincolo = abs(alpha1)+abs(alpha2);
    if (abs(alpha1)+abs(alpha2)>1) // se sono in saturazione
    {
      // Riassegno carichi in modo da evitare saturazione
      alpha1Bar = alpha1/vincolo;
      alpha2Bar = alpha2/vincolo;
      a1 = alpha1Bar*r*wpM;
      a2 = alpha2Bar*2*r*wpM/d;
    }
  
    //Cinematica uniciclo (con legge dinamica velocità)
    v1 = v1 + a1*dt;
    v2 = v2 + a2*dt;
}
