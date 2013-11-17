import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

int currentLevel = 0;
int finalLevel = 8;
int framesElapsed = 0;
int score;
int totalScore = 0;
float dragStartX;
float dragStartY;
float dragCurrentX;
float dragCurrentY;
float releaseX;
float releaseY;
boolean detonating = false;
boolean counting = false;
boolean winning = false;
boolean failing = false;
boolean retryable = false;
boolean advancable = false;
boolean released = false;
boolean menusUp = true;
boolean dragging = false;
boolean draggable;
boolean releasing = false;
boolean detonable = false;
PImage title;
PFont font;
PFont boldFont;

Minim minim;
AudioPlayer soundtrack;
AudioPlayer bellSound;
AudioPlayer failSound;
GameBall ball;
Level thisLevel;

void setup() {
  size(800,800);
  smooth();
  frameRate(30);
  noStroke();
  boldFont = loadFont("boldfont.vlw");
  font = loadFont("gamefont.vlw");
  textAlign(CENTER);
  
  title = loadImage("title.jpg");
  
  minim = new Minim(this);
  soundtrack = minim.loadFile("LoopSong.mp3");
  bellSound = minim.loadFile("BellSound.mp3");
  failSound = minim.loadFile("PlanetHit.mp3");
  soundtrack.play();
  soundtrack.loop();
  
  ball = new GameBall();
  
  newLevel(currentLevel);
}

void mouseDragged() {
  if (dragging == false && released == false && draggable) {
    if(thisLevel.dropzone.inDropArea) {
      dragging = true;
    }
  }
  if (dragging && released == false && draggable) {
    ellipse(dragStartX, dragStartY, 20, 20);
    dragCurrentX = mouseX;
    dragCurrentY = mouseY;
  }
}

void mouseReleased() {
  if (dragging) {
    dragging = false;
    ball.xVel = (dragStartX - dragCurrentX) / 5;
    ball.yVel = (dragStartY - dragCurrentY) / 5;
    ball.xPos = dragStartX;
    ball.yPos = dragStartY;
    releasing = true;
    releaseX = dragCurrentX;
    releaseY = dragCurrentY;
  }
}

void mouseClicked() {
  if (retryable) {
    framesElapsed = 0;
    score = 0;
    winning = false;
    failing = false;
    detonating = false;
    counting = false;
    newLevel(currentLevel);
    retryable = false;
    released = false;
    ball.clearValues();
    thisLevel.dropzone.inDropArea = false;
  }
  if (advancable) {
    currentLevel++ ;
    if (currentLevel == finalLevel + 1) {
      currentLevel = 0;
      totalScore = 0;
    }
    framesElapsed = 0;
    score = 0;
    winning = false;
    failing = false;
    detonating = false;
    counting = false;
    newLevel(currentLevel);
    advancable = false;
    released = false;
    ball.clearValues();
    thisLevel.dropzone.inDropArea = false;
  }
    ball.drop();
}

void draw() {
  background(0);
  thisLevel.displayLevel();
  ball.display();
  if (pow(ball.xPos - thisLevel.bell.xLocn,2) + pow(ball.yPos - thisLevel.bell.yLocn,2) <= 400) {
    pass();
    thisLevel.bell.blur();
    detonable = false;
  }  
  if (detonating) {
    for(int i = ball.fragments.size()-1; i >= 0; i--) {
      Fragment fragment = ball.fragments.get(i);
      fragment.display();
    }
  }
  if (counting) {
    framesElapsed++ ;
  }
  
  if (framesElapsed >= score + 90 && winning) {
    winDraw();
  }
  if (framesElapsed >= score + 90 && failing) {
    failDraw();
  }
  
  if (menusUp) {
    menuDraw();
  }
  
  if (keyPressed && key == ' ' && detonable == true) {
    fail();
    detonable = false;
  }
  
  if ((mousePressed && draggable || dragging) && thisLevel.dropzone.inDropArea  && released == false) {
    fill(255,255);
    if(dragStartX == 0 && dragStartY == 0) {
      dragStartX = mouseX;
      dragStartY = mouseY;
    }
      ellipse(dragStartX, dragStartY, 20, 20);
  } 
  
  if (dragging) {
    stroke(255,255);
    line(dragStartX, dragStartY, dragCurrentX, dragCurrentY);
    noStroke();
  }
  
  if (releasing) {
    fill(255,255);
    ellipse(dragStartX, dragStartY, 20, 20);
    stroke(255,255);
    line(dragStartX, dragStartY, releaseX, releaseY);
    noStroke();
    releaseX = releaseX + ball.xVel;
    releaseY = releaseY + ball.yVel;
    if (abs(releaseX - dragStartX) <= 10 && abs(releaseY - dragStartY) <= 10) {
      releasing = false;
      released = true;
      ball.drop();
    }
  }
}

void newLevel(int whichLevel) {
  thisLevel = new Level(whichLevel);
  ball.gameReady = true;
}

void pass() {
  textFont(font);  
  textSize(40);
  ball.detonate();
  detonating = true;
  winning = true;
  advancable = true;
  thisLevel.dropzone.inDropArea = false;
  bellSound.rewind();
  bellSound.play();
  score = framesElapsed;
  totalScore = totalScore + score;
}

void fail() {
  textFont(font);  
  textSize(40);
  ball.detonate();
  detonating = true;
  failing = true;
  retryable = true;
  failSound.rewind();
  failSound.play();
  score = framesElapsed;
}

void winDraw() {
  fill(0, 5 * (framesElapsed - score - 90));
  rect(0,0,800,800);
  fill(255, 5 * (framesElapsed - score - 90));
  text("Good job", 400, 350);
  text("Score: " + score, 400, 450);
  fill(200, 5 * (framesElapsed - score - 200));
  if (currentLevel != finalLevel) {
    text("Next level?", 400, 550);
  } else {
    text("Congratulations, your total score is " + totalScore, 400, 550);
    text("Play again?", 400, 625);
  }
  advancable = true;  
}

void failDraw() {
  fill(0, 5 * (framesElapsed - score - 90));
  rect(0,0,800,800);
  fill(255, 5 * (framesElapsed - score - 90));
  text("Try again?", 400, 400);
  retryable = true;
}

void menuDraw() {
  fill(0,255 - (frameCount - 400) * 3);
  rect(0,0,800,800);
  if (frameCount < 30) {
    tint(255,0);
  } else if (30 <= frameCount && frameCount <= 90) {
    fill(255, (frameCount - 30) * 4);
    text("Kasper Kubica presents", 400, 400);
  } else if (90 <= frameCount) {
    fill(255, 255 - (frameCount - 90) * 4);
    text("Kasper Kubica presents", 400, 400);    
  }
  if (frameCount < 300) {
    tint(255, (frameCount - 180) * 4);
  }  else {
   tint(255, 255 - 4 * (frameCount - 300));
  }
  image(title, 0, 0);
  if (frameCount > 550) {
    menusUp = false;
  }
}

void stop() {
  soundtrack.close();
  failSound.close();
  bellSound.close();
  minim.stop();
  super.stop();
}
