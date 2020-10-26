public class RunnerScreen implements IScreen {

  TileManager manager;
  Player player;
  float circleX = 2000;
  float xSpeed = 5;
  int radius = 10;
  boolean ballHit = false;
  Enemy enemy;

  void setup() 
  {
    manager = new TileManager(Config.DEFAULT_CAMERA_MOVEMENT_SPEED);
    player = new Player(width/2, height - Config.PLAYER_BOTTOM_OFFSET);
    enemy = new Enemy();
  }

  void draw()
  {
    if(Input.keyClicked(ESC)) switchScreen(new MainMenuScreen());

    background(255);
    player.manager = manager;
    player.init();
    manager.listener();
    if (manager.speed <= manager.speedCap) {
      manager.speed += Config.CAMERA_SPEED_UP_SPEED;
    }
    manager.speedCap = player.currentArmourSpeedMultiplier;

    manager.moveGroups();
    manager.drawGroups();
    
    enemy.attack(player.playerPos.x, player.playerPos.y);

    enemy.draw(player.playerPos.x, player.playerPos.y);
    
      //print(manager.ObstacleCheckCollision(player.playerPos, new PVector(100, 100)));
    TileCollision collision = manager.checkCollision(player.playerPos, player.size);
    //print(collision.direction);
    //print("\n");
    player.obstacle = manager.ObstacleCheckCollision(player.playerPos, player.size);
    player.tileCollision = collision;
  }

  void destroy() { }
}
