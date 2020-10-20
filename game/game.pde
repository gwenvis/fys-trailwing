/*import processing.sound.*;
SoundFile file;*/
TileManager manager;
Player player;
float circleX = 2000;
float xSpeed = 5;
int radius = 10;
boolean ballHit = false;

void setup() {
  background(255);
  fullScreen();
  frameRate(60);
  manager = new TileManager(Config.CAMERA_MOVEMENT_SPEED);
  player = new Player(width/2, height - Config.PLAYER_BOTTOM_OFFSET);
}

void draw()
{
  background(255);
  Input.update();
  player.init();
  manager.listener();
  manager.moveGroups();
  manager.drawGroups();

  //ellipse(circleX, 600, radius, radius);


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

  //print(manager.ObstacleCheckCollision(player.playerPos, new PVector(100, 100)));
  TileCollision collision = manager.checkCollision(player.playerPos, new PVector(100, 100));
  //print(collision.direction);
  //print("\n");
  player.tileCollision = collision;
  player.playerPos.sub(collision.direction.x * manager.speed, 0);
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
