//hunt game

ArrayList<Bicho> bichos = new ArrayList<Bicho>();
boolean gameOver = false;   // boolean to mark a catch
boolean catchedbug = false;
PImage pacimage;

void initialdrawing() {
  int i = 0;
  int d = int(width*0.5/8);
  int px = int(width*0.25);
  int py = int(height*0.7);

  background(0);

  for (i = 0; i <=4 ; i++) {
    Bicho b = bichos.get(i);
    image(b.ibicho, px, py, b.r*2, b.r*2);
    px += 2*d;
  }
  px = int(width*0.25) + d;
  py -=2*d;
  for (i = 5; i <=8 ; i++) {
    Bicho b = bichos.get(i);
    image(b.ibicho, px, py, b.r*2, b.r*2);
    px += 2*d;
  }
  px = int(width*0.25) + 2*d;
  py -=2*d;
  for (i = 9; i <=11 ; i++) {
    Bicho b = bichos.get(i);
    image(b.ibicho, px, py, b.r*2, b.r*2);
    px += 2*d;
  }
  
}

void initializehunt() {
  gameOver = false;
  catchedbug = false;

  for (int i = bichos.size() - 1; i >= 0; i--) 
    bichos.remove(i);  
  for (int i = 0; i < 12; i++) 
    bichos.add(new Bicho());

  for (int i = 0; i < bichos.size(); i++) 
    bichos.get(i).ibicho = loadImage(i + ".png");
}

void huntforappointments() {
  background(10);
  
  for (int i = bichos.size() - 1; i >= 0; i--) {
    Bicho b = bichos.get(i);

    // delete non captured bugs
    if (!b.captured && b.dead) {
      bichos.remove(i);
      continue;
    }

    // don't move if there was a catch
    if (!b.captured) {
      b.update();
    }

    b.display();
  }

  if (bichos.size() == 0) {
    gameOver = true;
    phase = 6;
  }

  if (gameOver) noLoop();
  
}

void revisecatches() {
  for (int i = bichos.size() - 1; i >= 0; i--) {
    Bicho b = bichos.get(i);

    if (b.isCaptured()) {
      b.captured = true;
      b.cbicho   = color(255, 120, 0);  // change captured color

      catchedbug = true;
      phase = 4;

      gameOver = true;   // GAMOVER
    }
  }
  
}
