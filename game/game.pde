import samuelal.squelized.*;
import java.util.Properties;
import processing.sound.*;

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
LoginScreen login;
Hiscore hiscore;
CommentsDatabase commentDatabase;
MusicManager musicManager;

void setup() {
  gameState = "LOGIN";
  background(255);
  fullScreen(P2D);
  frameRate(60);
  play = new PlayGame();
  start = new StartMenu();
  manager = new TileManager(Config.DEFAULT_CAMERA_MOVEMENT_SPEED);
  player = new Player(width/2, height - Config.PLAYER_BOTTOM_OFFSET);
  enemy = new Enemy(player);
  hiscore = new Hiscore();
  login = new LoginScreen();
  commentDatabase = new CommentsDatabase();
  musicManager = new MusicManager(this);
  PFont font = createFont("Arial", 64);
  textFont(font);
}

void draw()
{
  gameStates();
  musicManager.update();
  Input.update();
}

void keyPressed() {
  //send pressed key to input class

  Input.keyPressed(key, CODED, keyCode);
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
  if (gameState == "LOGIN") {
    login.screen();
  } else if (gameState == "START") {
    start.screen();
    start.menuSelecter();
    start.audioSlider();
  } else if (gameState == "PLAY") {
    play.update();
    play.draw();

    if(play.commentOverlayEnabled)
    {
      play.drawCommentOverlay();
    }
  } else if ( gameState == "HISCORE") {
    hiscore.screen();
  }
}
