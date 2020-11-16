import processing.sound.*;
import processing.video.*;

/*import processing.sound.*;
 SoundFile file;*/
TileManager manager;
Player player;
float circleX = 2000;
float xSpeed = 5;
int radius = 10;
boolean ballHit = false;
String gameState;
Enemy enemy;
PlayGame play;
StartMenu start;
Hiscore hiscore;
SoundFile backgroundMusicStartScreen;

void setup() {
  gameState = "START";
  background(255);
  fullScreen(P2D);
  frameRate(60);
  play = new PlayGame();
  start = new StartMenu();
  manager = new TileManager(Config.DEFAULT_CAMERA_MOVEMENT_SPEED);
  player = new Player(width/2, height - Config.PLAYER_BOTTOM_OFFSET);
  enemy = new Enemy(player);
  backgroundMusicStartScreen = new SoundFile(this, "backgroundMusic.wav");
  hiscore = new Hiscore();
}

void draw()
{
  gameStates();
  Input.update();
}

void keyPressed() {
  //send pressed key to input class
  Input.keyPressed(key, CODED, keyCode);
  start.keyPress();
}

void keyReleased() {
  //send released key to input class
  Input.keyReleased(key, CODED, keyCode);
}

void mousePressed() {
  //send pressed mouseside to input class
  Input.mousePressed(mouseButton);
}

void mouseReleased() {
  //send released mouseside to input class
  Input.mouseReleased(mouseButton);
}


void gameStates() {
  if (gameState == "START") {
    start.screen();
    start.menuSelecter();
  } else if (gameState == "PLAY") {
    play.playGame();
  } else if( gameState == "HISCORE"){
    hiscore.screen(); 
  }
}

void movieEvent(Movie backgroundVideo){
 backgroundVideo.read(); 
 
 }
