int manual = 0;

public void mapDP_click1(GDropList source, GEvent event)
{
    if (mapDP.getSelectedText().equals("First labyrinth"))
        obstacles = first_map;
    if (mapDP.getSelectedText().equals("Second labyrinth"))
        obstacles = second_map;
    if (mapDP.getSelectedText().equals("Third labyrinth"))
        obstacles = third_map;

    init_controller();
    init_distance();
    init_environment();
    init_exploring();
    init_fpv2();
    init_lift_object();
    init_path();
}

public void controller_mode_click(GDropList source, GEvent event)
{
    if (controllerModeDP.getSelectedText().equals("Bang-bang"))
        control_mode = BB;
    if (controllerModeDP.getSelectedText().equals("Proportional"))
        control_mode = P;
}

public void modeCB_clicked(GCheckbox source, GEvent event) {
    if (modeCB.isSelected() == true)
        manual = 1;
    else
        manual = 0;
}

public void next_btn_click(GButton source, GEvent event) {
    if (abs(thetaDes - theta) <= 0.005 && manual == 1) {
        exploring();
        if (throwing == 1)
            lift_object();
    }
}

public void createGUI()
{
    G4P.messagesEnabled(false);
    G4P.setGlobalColorScheme(GCScheme.BLUE_SCHEME);
    G4P.setCursor(ARROW);

    mapDP = new GDropList(this, width/2, 10, 130, 80, 3);
    mapDP.setItems(loadStrings("mapDPList"), 0);
    mapDP.addEventHandler(this, "mapDP_click1");

    controllerModeDP = new GDropList(this, 10, 230, 130, 80, 2);
    controllerModeDP.setItems(loadStrings("dp_controllers"), 0);
    controllerModeDP.addEventHandler(this, "controller_mode_click");

    modeCB = new GCheckbox(this, width - 240, height - 30, 80, 20);
    modeCB.setIconAlign(GAlign.LEFT, GAlign.MIDDLE);
    modeCB.setText("Manual");
    modeCB.setOpaque(false);
    modeCB.addEventHandler(this, "modeCB_clicked");

    nextBtn = new GButton(this, width - 160, height - 40, 80, 30);
    nextBtn.setText("Next");
    nextBtn.addEventHandler(this, "next_btn_click");

    topLbl = new GLabel(this, width/2 - 120, 14, 120, 20);
    topLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    topLbl.setText("Choose a labyrinth:");
    topLbl.setOpaque(false);

    frontSensLbl = new GLabel(this, 10, height - 50, 70, 20);
    frontSensLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    frontSensLbl.setText("Front:");
    frontSensLbl.setOpaque(true);

    frontSensValLbl = new GLabel(this, 80, height - 50, 70, 20);
    frontSensValLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    frontSensValLbl.setText("");
    frontSensValLbl.setOpaque(false);

    backSensLbl = new GLabel(this, 10, height - 30, 70, 20);
    backSensLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    backSensLbl.setText("Back:");
    backSensLbl.setOpaque(false);

    backSensValLbl = new GLabel(this, 80, height - 30, 70, 20);
    backSensValLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    backSensValLbl.setText("");
    backSensValLbl.setOpaque(true);

    rightSensLbl = new GLabel(this, 160, height - 50, 70, 20);
    rightSensLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    rightSensLbl.setText("Right:");
    rightSensLbl.setOpaque(true);

    rightSensValLbl = new GLabel(this, 230, height - 50, 70, 20);
    rightSensValLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    rightSensValLbl.setText("");
    rightSensValLbl.setOpaque(false);

    leftSensLbl = new GLabel(this, 160, height - 30, 70, 20);
    leftSensLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    leftSensLbl.setText("Left:");
    leftSensLbl.setOpaque(false);

    leftSensValLbl = new GLabel(this, 230, height - 30, 70, 20);
    leftSensValLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    leftSensValLbl.setText("");
    leftSensValLbl.setOpaque(true);

    frontRightSensLbl = new GLabel(this, 310, height - 50, 70, 20);
    frontRightSensLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    frontRightSensLbl.setText("Front Right:");
    frontRightSensLbl.setOpaque(true);

    frontRightSensValLbl = new GLabel(this, 380, height - 50, 70, 20);
    frontRightSensValLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    frontRightSensValLbl.setText("");
    frontRightSensValLbl.setOpaque(false);

    frontLeftSensLbl = new GLabel(this, 310, height - 30, 70, 20);
    frontLeftSensLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    frontLeftSensLbl.setText("Front Left:");
    frontLeftSensLbl.setOpaque(false);

    frontLeftSensValLbl = new GLabel(this, 380, height - 30, 70, 20);
    frontLeftSensValLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    frontLeftSensValLbl.setText("");
    frontLeftSensValLbl.setOpaque(true);

    backRightSensLbl = new GLabel(this, 460, height - 50, 70, 20);
    backRightSensLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    backRightSensLbl.setText("Back Right:");
    backRightSensLbl.setOpaque(true);

    backRightSensValLbl = new GLabel(this, 530, height - 50, 70, 20);
    backRightSensValLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    backRightSensValLbl.setText("");
    backRightSensValLbl.setOpaque(false);

    backLeftSensLbl = new GLabel(this, 460, height - 30, 70, 20);
    backLeftSensLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    backLeftSensLbl.setText("Back Left:");
    backLeftSensLbl.setOpaque(false);

    backLeftSensValLbl = new GLabel(this, 530, height - 30, 70, 20);
    backLeftSensValLbl.setTextAlign(GAlign.CENTER, GAlign.MIDDLE);
    backLeftSensValLbl.setText("");
    backLeftSensValLbl.setOpaque(true);
}

GDropList mapDP;
GDropList controllerModeDP;
GCheckbox modeCB;
GButton nextBtn;
GLabel topLbl; 

GLabel frontSensLbl;
GLabel frontSensValLbl;
GLabel backSensLbl;
GLabel backSensValLbl;
GLabel rightSensLbl;
GLabel rightSensValLbl;
GLabel leftSensLbl;
GLabel leftSensValLbl;
GLabel frontRightSensLbl;
GLabel frontRightSensValLbl;
GLabel frontLeftSensLbl;
GLabel frontLeftSensValLbl;
GLabel backRightSensLbl;
GLabel backRightSensValLbl;
GLabel backLeftSensLbl;
GLabel backLeftSensValLbl;
