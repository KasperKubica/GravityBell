class GameBall {
  float xPos;
  float yPos;
  float xVel;
  float yVel;
  float xAcc;
  float yAcc;
  int visible = 0;
  boolean droppable = true;
  boolean gameReady = true;
  ArrayList<Fragment> fragments;
  
  
  GameBall() {

  }
  
  void drop() {
    visible = 255;
    if (droppable && thisLevel.dropzone.inDropArea) {
      if (released == false) {
        xPos = mouseX;
        yPos = mouseY;
      }
      droppable = false;
      counting = true;
      released = true;
      detonable = true;
    }
  }
  
  void display() {
    if (droppable == false && gameReady) {
      fill(255, visible);
      ellipse(xPos, yPos, 20, 20);
      if (xPos <= -10) {
        xPos = xPos + 800;
      }
      if (xPos >= 810) {
        xPos = xPos - 800;
      }
      if (yPos <= -10) {
        yPos = yPos + 800;
      }
      if (yPos >= 810) {
        yPos = yPos - 800;
      }
      xAcc = thisLevel.gravX;
      yAcc = thisLevel.gravY;
      xVel = xVel + .5 * xAcc;
      yVel = yVel + .5 * yAcc;
      xPos = xPos + xVel;
      yPos = yPos + yVel;
    }
  }
  
  void detonate() {
    thisLevel.dropzone.inDropArea = false;
    droppable = true;
    gameReady = false;
    visible = 0;
    fragments = new ArrayList<Fragment>();
    for(int i = 0; i < 30; i++) {
      fragments.add(new Fragment(xPos, yPos, xVel, yVel));
    }
    xPos = 0;
    yPos = 0;
    thisLevel.dropzone.inDropArea = false;
  }
  
  void clearValues() {
    xPos = 0;
    yPos = 0;
    xVel = 0;
    yVel = 0;
    xAcc = 0;
    yAcc = 0;
    dragStartX = 0;
    dragStartY = 0;
  }
}
