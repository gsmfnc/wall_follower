void textWriting()
{
    textSize(15);
    fill(0);
    stroke(125);

    frontSensValLbl.setText(Double.toString(sensorsValue[FRONT]));
    backSensValLbl.setText(Double.toString(sensorsValue[BACK]));
    rightSensValLbl.setText(Double.toString(sensorsValue[RIGHT]));
    leftSensValLbl.setText(Double.toString(sensorsValue[LEFT]));
    frontRightSensValLbl.setText(Double.toString(sensorsValue[FRONT_RIGHT]));
    frontLeftSensValLbl.setText(Double.toString(sensorsValue[FRONT_LEFT]));
    backRightSensValLbl.setText(Double.toString(sensorsValue[BACK_RIGHT]));
    backLeftSensValLbl.setText(Double.toString(sensorsValue[BACK_LEFT]));
}
