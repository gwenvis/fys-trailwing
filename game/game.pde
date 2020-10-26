/*import processing.sound.*;
 SoundFile file;*/
TileManager manager;
Player player;
float circleX = 2000;
float xSpeed = 5;
int radius = 10;
boolean ballHit = false;
Enemy enemy;

void setup() {
  background(255);
  fullScreen();
  frameRate(60);
  manager = new TileManager(Config.DEFAULT_CAMERA_MOVEMENT_SPEED);
  player = new Player(width/2, height - Config.PLAYER_BOTTOM_OFFSET);
  enemy = new Enemy(player);
}

void draw()
{
  background(255);
  Input.update();
  player.manager = manager;
  player.init();
  manager.listener();
  if (manager.speed <= manager.speedCap) {
    manager.speed += Config.CAMERA_SPEED_UP_SPEED;
  }
  manager.speedCap = player.currentArmourSpeedMultiplier;

  manager.moveGroups();
  manager.drawGroups();
  
  enemy.attack();

  enemy.draw();
  enemy.movement();
  
    //print(manager.ObstacleCheckCollision(player.playerPos, new PVector(100, 100)));
  TileCollision collision = manager.checkCollision(player.playerPos, player.size);
  //print(collision.direction);
  //print("\n");
  player.obstacle = manager.ObstacleCheckCollision(player.playerPos, player.size);
  player.tileCollision = collision;
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
