int phase = 1;      // phase == 1 --> intro, fog, text to start
                    // phase == 2 --> play the game
                    // phase == 3 --> we have a winner
                    // phase == 4 --> oops... appointment no longer available...
                    // phase == 5 --> sorry you did not ge the appointment

void settings() {
  pixelDensity(1);     
  size(800, 600, JAVA2D);
}


void setup() {
  phase = 1;
  setupfog();
  initializehunt();
}

void draw() {
  if (phase == 1) {
    loop();
    drawfog("This is the most effective way to get an appointment and process your NIE. \n\nPress <space> to start...");
    initializehunt();
  }
  if (phase == 2) {
    huntforappointments();
  }
  if (phase == 3) {
    loop();
    drawfog("Congratulations!  You were able to get an appointment. \n\nPress ENTER to continue to setup your appointment.");
  }
  if (phase == 4) {
    loop();
    drawfog("We are sorry.  The appointment is no longer available... Please try again next sunday at 8pm. \n\nPress <space>.");
  }
  if (phase == 5) {
    loop();
    drawfog("Sorry you were not able to get an appointment.  \n\nPlease try again next sunday at 8pm. Press <space>.");
  }
}

void mousePressed() {

  if (gameOver) return;   // no permitir más capturas

  revisecatches();
}

void keyPressed() {
  if (key == ' ' && phase == 1) phase = 2;
  if (key == ENTER && phase == 3) phase = 4;
  if (key == ' ' && phase == 4) phase = 1;
  if (key == ' ' && phase == 5) phase = 1;
}
