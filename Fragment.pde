class Fragment {
  float xPosn;
  float yPosn;
  float xVeln;
  float yVeln;
 
 Fragment(float xPos, float yPos, float xVel, float yVel) {
   xPosn = xPos + random(-10, 10);
   yPosn = yPos + random(-10, 10);
   xVeln = xVel + random(-2, 2);
   yVeln = yVel + random(-2, 2);
 }
 
 void display() {
   ellipse(xPosn, yPosn, 3, 3);
   xPosn += xVeln;
   yPosn += yVeln;
 }
  
}
