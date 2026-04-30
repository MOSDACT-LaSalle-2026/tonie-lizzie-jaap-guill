// TO NIE OR NOT TO NIE
// Writen for Creative Coding 2026 by:
// Lizzie Keigler
// Jaap Evenhuis
// Guillermo Cardozo
//
//For those in this world who are lucky enough to get the chance to come 
//to Spain to live here for a time, not only do you get the wonderful opportunity 
//to try delicious food, see the incredible architecture, immerse yourself in the 
//culture… you also get the extremely enjoyable and not at all frustrating 
//experience of registering yourself for a Número de Identificación de Extranjero (NIE). 
//This number is needed for almost all services in Spain like : 
//rental contracts, electricity, phonenumber. Without it, you are basically 
//an unwelcome guest. In order to get this number, you will have to make an 
//appointment, and the register it in person.  Good luck in trying to get this 
//appointment!
//By combining sound elements of bureaucratic systems, a daunting background 
//track accompanies you in the process.
//Through "To NIE or not to NIE", you are drawn into the NIE application process 
//through an interactive game that evokes the emotions of a foreigner living in Spain. 
//Have fun and good luck getting your NIE appointment!  

import processing.sound.*;
SoundFile file, waka, intro, win, glitch, playBG, dead;

// --- Resolution scaling ---
float scaleX, scaleY;
final float BASE_W = 3024;  // your laptop's resolution
final float BASE_H = 1964;

int phase = 1;
int lastPhase = -1;
PImage bg;
PImage initbg;
PImage pacmanCursor;
int time = 0;
int lastPlayed = 0;
int cooldown = 400;

void setup() {
  fullScreen(JAVA2D);
  imageMode(CENTER);

  // Calculate scale factors relative to your original design resolution
  scaleX = width / BASE_W;
  scaleY = height / BASE_H;

  bg = loadImage("PacmanBackground3.png");
  initbg = loadImage("initialscreen.png");
  pacmanCursor = loadImage("pacman.mouse.png");
  noCursor();

  bgW = width * 0.9;
  bgH = height * 0.9;
  bgX = width / 2.0;
  bgY = height / 2.0;

  file  = new SoundFile(this, "dead.wav");
  waka  = new SoundFile(this, "waka.mp3");
  intro = new SoundFile(this, "intro.wav");
  win   = new SoundFile(this, "win.wav");
  glitch = new SoundFile(this, "glitch.wav");
  playBG = new SoundFile(this, "playBG.wav");
  dead   = new SoundFile(this, "dead.wav");

  phase = 1;
  time = 0;
  initializehunt();
  intro.loop();
}

void draw() {
  int now = millis();
  dt = (now - lastTime) / 1000.0;
  lastTime = now;

  if (phase != lastPhase) {
    intro.stop();
    playBG.stop();
    win.stop();
    glitch.stop();

    if (phase == 1) intro.loop();
    if (phase == 2) intro.loop();
    if (phase == 3) playBG.loop();
    if (phase == 4) win.play();
    if (phase == 5) glitch.loop();
    if (phase == 6) dead.play();

    lastPhase = phase;
  }

  if (phase == 1) {
    loop();
    drawinitialscreen();
    initializehunt();
  }
  if (phase == 2) {
    drawIntro();
    initialdrawingcharacters();
  }
  if (phase == 3) huntforappointments();
  if (phase == 4) {
    loop();
    drawOverlayText("Congratulations! You were able to get an appointment.\n\nPress ENTER to continue.");
  }
  if (phase == 5) {
    loop();
    drawsystemglitch();
    gtime++;
    if (gtime > 50) phase = 6;
  }
  if (phase == 6) {
    loop();
    drawOverlayText("Sorry you were not able to get an appointment.\n\nPress SPACE to try again.");
  }

  drawCursor();
}

void mousePressed() {
  if (gameOver) return;
  if (phase == 1) phase = 2;
  else if (phase == 2) phase = 3;
  revisecatches();
}

void keyPressed() {
  if (key == ' ' && phase == 1) phase = 2;
  else if ((key == ENTER || key == ' ') && phase == 4) phase = 5;
  else if (key == ' ' && phase == 5) phase = 1;
  else if (key == ' ' && phase == 6) phase = 1;
}
