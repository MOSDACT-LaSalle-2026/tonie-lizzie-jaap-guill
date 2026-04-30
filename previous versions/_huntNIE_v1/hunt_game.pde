ArrayList<Bicho> bichos = new ArrayList<Bicho>();
boolean gameOver = false;   // boolean to marc a catch


void initializehunt() {
  for (int i = 0; i < 50; i++) {
    bichos.add(new Bicho());
  }
  
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

  // if there was a catch stop!
  if (gameOver) 
    noLoop();
  
}

void revisecatches() {
  for (int i = bichos.size() - 1; i >= 0; i--) {
    Bicho b = bichos.get(i);

    if (b.isCaptured()) {

      b.captured = true;
      b.cbicho   = color(255, 120, 0);  // change captured color

      gameOver = true;   // GAMOVER

      break;
    }
  }
  
}
