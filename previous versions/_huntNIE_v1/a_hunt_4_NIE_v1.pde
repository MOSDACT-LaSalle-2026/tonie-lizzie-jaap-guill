int phase = 1;      // phase == 1 --> intro, fog, text to start
                    // phase == 2 --> 
                    // phase == 3 -->
                    // phase == 4 -->

void setup() {
  size(800, 600);
  phase = 2;
  initializehunt();
}

void draw() {
  if (phase == 1) {
  }
  if (phase == 2) {
    huntforappointments();
  }
}

void mousePressed() {

  if (gameOver) return;   // no permitir más capturas

  revisecatches();
}
