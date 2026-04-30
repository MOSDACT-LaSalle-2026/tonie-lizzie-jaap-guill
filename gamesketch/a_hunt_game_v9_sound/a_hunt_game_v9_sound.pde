import processing.sound.*;  //sound library
SoundFile file, waka, intro, win, glitch,playBG,dead;   //soundfiles



// main block for program

int phase = 1;      // phase == 1 --> intro text and setting up stage
                    // phase == 2 --> setup the game with background and ready everything
                    // phase == 3 --> play the game
                    // phase == 4 --> we have a winner
                    // phase == 5 --> oops... system error...
                    // phase == 6 --> sorry you did not ge the appointment
int lastPhase = -1; //  soundmanageradd this with your other globals

PImage bg;
PImage initbg;
PImage pacmanCursor;

int time = 0;
int lastPlayed = 0; // waka sound
int cooldown = 400; // ms between plays
 
void setup() {
  fullScreen(JAVA2D);
  imageMode(CENTER);

  bg = loadImage("PacmanBackground3.png");
  initbg = loadImage("initialscreen.png");
  pacmanCursor = loadImage("pacman.mouse.png");
  noCursor();

  bgW = width * 0.9;
  bgH = height * 0.9;
  bgX = width / 2.0;
  bgY = height / 2.0;
  
  
// sounds
  file = new SoundFile(this, "dead.wav");
  waka = new SoundFile(this, "waka.mp3");
  intro = new SoundFile(this, "intro.wav");
  win = new SoundFile(this, "win.wav");
  glitch = new SoundFile(this, "glitch.wav");
  playBG =  new SoundFile(this, "playBG.wav");
    dead =  new SoundFile(this, "dead.wav");
//sounds

  phase = 1;
  time = 0;
  initializehunt();
        intro.loop();
}

void draw() {
// variables to control the speed of movement intependently of framerate
  int now = millis();
  dt = (now - lastTime) / 1000.0;
  lastTime = now;
  
// --- Sound manager: only runs when phase changes ---
  if (phase != lastPhase) {
    // Stop all sounds first
    intro.stop();
    playBG.stop();
    win.stop();
    glitch.stop();

    // Start the right music for the new phase
    if (phase == 1) intro.loop();
    if (phase == 2) intro.loop();   // still on intro screen
    if (phase == 3) playBG.loop();
    if (phase == 4) win.play();     // or win.play() if it's a one-shot
    if (phase == 5) glitch.loop();  // or glitch.play()
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
  if (phase == 3) {
    huntforappointments();
  }
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
