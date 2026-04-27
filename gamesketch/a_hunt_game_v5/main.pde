// a hunt 4 NIE v5

int phase = 1;      // phase == 1 --> intro, fog, text to start
                    // phase == 3 --> play the game
                    // phase == 4 --> we have a winner
                    // phase == 5 --> oops... appointment no longer available...
                    // phase == 6 --> sorry you did not ge the appointment

int time = 0;

void settings() {
  size(800, 600, P2D);
  pixelDensity(1);  
}


void setup() {
  phase = 1;
  time = 0;
  setupfog();
  initializehunt();
}

void draw() {
  if (phase == 1) {
    loop();
    drawfogstring("This is the most effective way to get an appointment and process your NIE. \n\nPress <space> to start...");
    initializehunt();
  }
  if (phase == 2) {
    initialdrawing();
  }
  if (phase == 3) {
    huntforappointments();
    //drawjustfog();
  }
  if (phase == 4) {
    loop();
    drawfogstring("Congratulations!  You were able to get an appointment. \n\nPress ENTER to continue to setup your appointment.");
  }
  if (phase == 5) {
    loop();
    drawsystemglitch();
    gtime++;
    if (gtime > 50) phase = 6;
  }
  if (phase == 6) {
    loop();
    setupfog();
    drawfogstring("Sorry you were not able to get an appointment.  \n\nPlease try again next sunday at 8pm. Press <space>.");
  }

}

void mousePressed() {

  if (gameOver) return;   // no permitir más capturas
  if (phase == 2) phase = 3;

  revisecatches();
}

void keyPressed() {
  if (key == ' ' && phase == 1) phase = 2;
  if (key == ENTER && phase == 4) phase = 5;
  if (key == ' ' && phase == 5) phase = 1;
  if (key == ' ' && phase == 6) phase = 1;
}
