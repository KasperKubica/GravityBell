class GameBell {
  float xLocn;
  float yLocn;
  float spinPosition = 0;
  float spinSpeed;
  
  GameBell(float xLoc, float yLoc) {
    xLocn = xLoc;
    yLocn = yLoc;
    spinSpeed = .1;
  }
  
  void display() {
    pushMatrix();
    translate(xLocn, yLocn);
    rotate(spinPosition);
    stroke(255);
    noFill();
    arc(0, -10, 20, 20, 0 + .4, PI - .4);
    arc(0, 10, 20, 20, -PI + .4, 0 - .4);
    arc(10, 0, 20, 20, PI / 2 + .4, 3 * PI /2 - .4);
    arc(-10, 0, 20, 20, - PI / 2 + .4, PI /2 - .4);
    noStroke();
    spinPosition = spinPosition + spinSpeed;
    popMatrix();
  }
  
  void blur() {
    spinSpeed = .5;
  }
}
