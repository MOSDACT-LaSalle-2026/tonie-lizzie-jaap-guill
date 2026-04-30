//hunt game

ArrayList<Bicho> bichos = new ArrayList<Bicho>();
boolean gameOver = false;   // boolean to mark a catch
boolean catchedbug = false;
PImage pacimage;

void initialdrawingcharacters() {
  imageMode(CENTER);
  
  image(bichos.get(0).ibicho, 320, 510, bichos.get(0).r*2, bichos.get(0).r*2);
  image(bichos.get(1).ibicho, 430, 510, bichos.get(1).r*2, bichos.get(1).r*2);
  image(bichos.get(2).ibicho, 430, 580, bichos.get(2).r*2, bichos.get(2).r*2);
  
  image(bichos.get(3).ibicho, 850, 510, bichos.get(3).r*2, bichos.get(3).r*2);
  image(bichos.get(4).ibicho, 960, 510, bichos.get(4).r*2, bichos.get(4).r*2);
  image(bichos.get(5).ibicho, 850, 580, bichos.get(5).r*2, bichos.get(5).r*2);

  image(bichos.get(6).ibicho, 430, 360, bichos.get(6).r*2, bichos.get(6).r*2);
  image(bichos.get(7).ibicho, 540, 360, bichos.get(7).r*2, bichos.get(7).r*2);
  image(bichos.get(8).ibicho, 640, 360, bichos.get(8).r*2, bichos.get(8).r*2);
  image(bichos.get(9).ibicho, 750, 360, bichos.get(9).r*2, bichos.get(9).r*2);
  image(bichos.get(10).ibicho, 850, 360, bichos.get(10).r*2, bichos.get(10).r*2);

  image(bichos.get(11).ibicho, 640, 440, bichos.get(11).r*2, bichos.get(11).r*2);


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
  drawBackground();
  
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

      catchedbug = true;
      phase = 4;

      gameOver = true;   // GAMEOVER
    }
  }
  
}
