//hunt game

ArrayList<Bicho> bichos = new ArrayList<Bicho>();
boolean gameOver = false;   // boolean to mark a catch
boolean catchedbug = false;

// initializes character images into the vector
void initialdrawingcharacters() {
  
  image(bichos.get(0).ibicho, 340+60, 540+60, bichos.get(0).r*2, bichos.get(0).r*2);
  image(bichos.get(1).ibicho, 450+60, 540+60, bichos.get(1).r*2, bichos.get(1).r*2);
  image(bichos.get(2).ibicho, 450+60, 610+60, bichos.get(2).r*2, bichos.get(2).r*2);
  
  image(bichos.get(3).ibicho, 900+100, 540+60, bichos.get(3).r*2, bichos.get(3).r*2);
  image(bichos.get(4).ibicho, 1010+110, 540+60, bichos.get(4).r*2, bichos.get(4).r*2);
  image(bichos.get(5).ibicho, 900+100, 610+60, bichos.get(5).r*2, bichos.get(5).r*2);

  image(bichos.get(6).ibicho, 450+60, 380+50, bichos.get(6).r*2, bichos.get(6).r*2);
  image(bichos.get(7).ibicho, 570+60, 380+50, bichos.get(7).r*2, bichos.get(7).r*2);
  image(bichos.get(8).ibicho, 670+80, 380+50, bichos.get(8).r*2, bichos.get(8).r*2);
  image(bichos.get(9).ibicho, 790+80, 380+50, bichos.get(9).r*2, bichos.get(9).r*2);
  image(bichos.get(10).ibicho, 900+90, 380+50, bichos.get(10).r*2, bichos.get(10).r*2);

  image(bichos.get(11).ibicho, 670+80, 460+50, bichos.get(11).r*2, bichos.get(11).r*2);

}

// initializes the hunt for NIE.  Takes all variables to initiate the game
void initializehunt() {
  gameOver = false;
  catchedbug = false;
  gtime = 0;

  for (int i = bichos.size() - 1; i >= 0; i--) 
    bichos.remove(i);  
  for (int i = 0; i < 12; i++) 
    bichos.add(new Bicho());

  for (int i = 0; i < bichos.size(); i++) 
    bichos.get(i).ibicho = loadImage(i + ".png");
}

// main function to control the game
void huntforappointments() {
  drawBackground();  
  
  // delete non captured bugs that have moved out of the screen
  for (int i = bichos.size() - 1; i >= 0; i--) {
    Bicho b = bichos.get(i);
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

// function to review if there has been a catch to be able to change states
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
