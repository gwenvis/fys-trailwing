/*import processing.sound.*;
SoundFile file;*/
TileManager manager;
Player player;
float circleX = 2000;
float xSpeed = 5;
int radius = 10;
boolean ballHit = false;

void setup() {
  fullScreen();
  frameRate(60);
  manager = new TileManager(10);
  player = new Player(width/2, height/2);
}

void draw()
{
  background(255);
  Input.update();
  player.init();
  manager.listener();
  manager.moveGroups();
  manager.drawGroups();

  ellipse(circleX, 600, radius, radius);


  if (ballHit == false) {
    circleX-=xSpeed;
  }

  if (circleX == player.playerPos.x+110) {
    if (player.shieldIsUp == true) {
      ballHit = true;
      println("Ball hits shield!");
      println(player.playerPos.x+110);
      println(circleX);
      println(ballHit);
    }
  }

  if (circleX > 2000) {
    ballHit = false;
  }

  if (ballHit == true) {
    circleX+=xSpeed;
  }

  println(player.shieldIsUp);
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
