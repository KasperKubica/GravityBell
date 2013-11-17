class Planet {
  float xLocn;
  float yLocn;
  float planSizen;
  
  Planet(float xLoc, float yLoc, float planSize) {
    xLocn = xLoc;
    yLocn = yLoc;
    planSizen = planSize;
  }
  
  void display() {
    ellipse(xLocn, yLocn, planSizen, planSizen);
    if (dist(xLocn, yLocn, ball.xPos, ball.yPos) <= planSizen / 2 + 10) {
      fail();
      detonable = false;
    }
  }
  
  float getGravX() {
    return cos(atan2((yLocn - ball.yPos),(xLocn - ball.xPos))) * pow(planSizen,2) / (pow(xLocn - ball.xPos,2) + pow(yLocn - ball.yPos,2));
  }
  
  float getGravY() {
    return sin(atan2((yLocn - ball.yPos),(xLocn - ball.xPos))) * pow(planSizen,2) / (pow(xLocn - ball.xPos,2) + pow(yLocn - ball.yPos,2));
  }
}
