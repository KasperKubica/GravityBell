class DropArea {
  float xPosn;
  float yPosn;
  float xWidn;
  float yWidn;
  float strokeStrength = 100;
  boolean inDropArea = false;
  
  DropArea(float xPos, float yPos, float xWid, float yWid) {
    xPosn = xPos;
    yPosn = yPos;
    xWidn = xWid;
    yWidn = yWid;
    inDropArea = false;
  }
  
  void display() {
    strokeStrength -= framesElapsed / 2;
    stroke(strokeStrength, 255);
    line(xPosn, yPosn, xPosn + 20, yPosn);
    line(xPosn, yPosn, xPosn, yPosn + 20);
    line(xPosn + xWidn, yPosn, xPosn + xWidn - 20, yPosn);
    line(xPosn + xWidn, yPosn, xPosn + xWidn, yPosn + 20);
    line(xPosn, yPosn + yWidn, xPosn + 20, yPosn + yWidn);
    line(xPosn, yPosn + yWidn, xPosn, yPosn + yWidn - 20);
    line(xPosn + xWidn, yPosn + yWidn, xPosn + xWidn - 20, yPosn + yWidn);
    line(xPosn + xWidn, yPosn + yWidn, xPosn + xWidn, yPosn + yWidn - 20);    
    noStroke();
    if (mouseX >= xPosn && mouseX <= xPosn + xWidn && mouseY >= yPosn && mouseY <= yPosn + yWidn || dragStartX >= xPosn && dragStartX <= xPosn + xWidn && dragStartY >= yPosn && dragStartY <= yPosn + yWidn) {
      inDropArea = true;
    } else {
      inDropArea = false;
    }
  }
  
}
