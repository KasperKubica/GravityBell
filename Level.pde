class Level {
  int level;
  float gravX;
  float gravY;
  ArrayList<Planet> planets;
  GameBell bell;
  DropArea dropzone;
  InstructionSet instructions;
  
  Level(int levelSelect) {
    detonable = false;
    level = levelSelect;
    instructions = new InstructionSet(level);
    planets = new ArrayList<Planet>();
    
    if (level == 0) {
      draggable = false;
      planets.add(new Planet(400, 600, 100));
      bell = new GameBell(400, 450);
      dropzone = new DropArea(100, 100, 600, 100);
    }
    if (level == 1) {
      draggable = false;
      planets.clear();
      planets.add(new Planet(500, 300, 40));
      planets.add(new Planet(200, 350, 20));
      planets.add(new Planet(600, 700, 70));
      bell = new GameBell(400, 400);
      dropzone = new DropArea(100, 100, 300, 200);
    }
    if (level == 2) {
      draggable = true;
      planets.clear();
      planets.add(new Planet(400, 400, 200));
      bell = new GameBell(400, 700);
      dropzone = new DropArea(300, 75, 200, 150);
    }
    if (level == 3) {
      draggable = true;
      planets.clear();
      planets.add(new Planet(120, 150, 200));
      planets.add(new Planet(120, 650, 200));
      planets.add(new Planet(280, 280, 200));
      planets.add(new Planet(280, 520, 200)); 
      bell = new GameBell(650, 400);
      dropzone = new DropArea(50, 300, 80, 200);
    }
    if (level == 4) {
      draggable = true;
      planets.clear();
      planets.add(new Planet(120, 150, 200));
      planets.add(new Planet(120, 650, 200));
      planets.add(new Planet(280, 280, 200));
      planets.add(new Planet(280, 520, 200));
      planets.add(new Planet(400, 400, 50)); 
      bell = new GameBell(650, 400);
      dropzone = new DropArea(50, 300, 80, 200);
    }
    if (level == 5) {
      draggable = true;
      planets.clear();
      planets.add(new Planet(300, 500, 80));
      planets.add(new Planet(600, 350, 62));
      planets.add(new Planet(350, 300, 40));
      planets.add(new Planet(700, 450, 50));
      bell = new GameBell(650,400);
      dropzone = new DropArea(100, 100, 50, 50);
    }
    if (level == 6) {
      draggable = true;
      planets.clear();
      planets.add(new Planet(400, 100, 50));
      planets.add(new Planet(400, 700, 50));
      planets.add(new Planet(100, 400, 50));
      planets.add(new Planet(700, 400, 50));
      planets.add(new Planet(400, 400, 70));
      planets.add(new Planet(200, 200, 50));
      planets.add(new Planet(200, 600, 50));
      planets.add(new Planet(600, 200, 50));
      planets.add(new Planet(600, 600, 50));
      bell = new GameBell(400, 250);
      dropzone = new DropArea(350, 500, 100, 100);
    }
    if (level == 7) {
      draggable = true;
      planets.clear();
      planets.add(new Planet(300, 400, 200));
      planets.add(new Planet(600, 300, 50));
      bell = new GameBell(550, 500);
      dropzone = new DropArea(50, 300, 100, 200);
    }
    if (level == 8) {
      draggable = true;
      planets.clear();
      planets.add(new Planet(200, 370, 70));
      planets.add(new Planet(550, 470, 50));
      bell = new GameBell(400, 500);
      dropzone = new DropArea(725, 375, 50, 50);
    }
  }
  
  void displayLevel() {
    bell.display();
    if ((ball.droppable && ball.gameReady) || framesElapsed <= 50) {
      dropzone.display();
      instructions.display();
    }
    fill(255,255);
    gravX = 0;
    gravY = 0;
    for(int i = planets.size()-1; i >= 0; i--) {
      Planet planet = planets.get(i);
      planet.display();
      gravX = gravX + planet.getGravX();
      gravY = gravY + planet.getGravY();
    }
  }
}
