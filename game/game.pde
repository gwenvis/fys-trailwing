import samuelal.squelized.*;
import java.util.Properties;
import processing.sound.*;
//import processing.video.*;

//SoundFile file;
TileManager manager;
Player player;
float circleX = 2000;
float xSpeed = 5;
int radius = 10;
boolean ballHit = false;
String gameState;
Database achievementsDb;
Enemy enemy;
PlayGame play;
StartMenu start;
LoginScreen login;
Hiscore hiscore;
GameOver gameOver;
SoundFile backgroundMusicStartScreen;
CommentsDatabase commentDatabase;
SoundFile backgroundMusicGameOverScreen;
HUD hud;
ButtonLayout buttonLayout;

void setup() {
  gameState = "START";
  background(255);
  size(1920, 1080, P2D);
  frameRate(60);
  play = new PlayGame();
  start = new StartMenu();
  manager = new TileManager(Config.DEFAULT_CAMERA_MOVEMENT_SPEED);
  player = new Player(width/2, height - Config.PLAYER_BOTTOM_OFFSET);
  enemy = new Enemy(player);
  backgroundMusicStartScreen = new SoundFile(this, "backgroundMusic.wav");
  backgroundMusicGameOverScreen = new SoundFile(this, "gameOver.wav");
  hiscore = new Hiscore();
  login = new LoginScreen();
  gameOver = new GameOver();
  buttonLayout = new ButtonLayout();
  commentDatabase = new CommentsDatabase();
  PFont font = createFont("Arial", 64);
  textFont(font);
  hud = new HUD();

  achievementsDb = new Database("jdbc:mysql://oege.ie.hva.nl/zboodtcd?serverTimezone=UTC", true, "boodtcd", "egRabMlz#xM$NI");
}

void draw()
{
  gameStates();
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
  } else if (gameState == "BUTTONLAYOUT") {
    buttonLayout.draw(); 
    buttonLayout.spaceCheck();
  }

  if (play.commentOverlayEnabled)
  {
    play.drawCommentOverlay();
  } else if ( gameState == "HISCORE") {
    hiscore.screen();
  } else if (gameState == "GAMEOVER") {
    gameOver.screen();
  }
}
