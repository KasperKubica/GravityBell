class InstructionSet {
  int setNumber;
  int textStrength = 255;
  
  InstructionSet(int level){
    setNumber = level;
  }
  
  void display() {
    textStrength -= framesElapsed / 2;
    fill(255, textStrength);
    textFont(boldFont);  
    textSize(20);
    if (setNumber == 0) {
      text("Release the bead from the box", 258, 132);
      text("Ring the gravity bell", 515, 458);   
    } 
    if (setNumber == 1) {
      text("Planets attract the bead", 653, 308);
      text("Bigger is stronger", 460, 705);
      text("Closer is stronger", 314, 358);
    }
    if (setNumber == 2) {
      text("Give it velocity", 380, 103);
    }
    if (setNumber == 3) {
      text("Your score is how long the bead stays adrift", 500, 700);
    }
    if (setNumber == 4) {
      text("Space is contiguous", 600, 200);
    }
    if (setNumber == 5) {
      text("Sometimes, you just need to trust the drop", 300, 700);
    }
    textFont(font);  
    textSize(40);    
  }
  
}
