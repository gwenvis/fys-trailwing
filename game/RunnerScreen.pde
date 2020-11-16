public class RunnerScreen implements IScreen {

  TileManager manager;
  Player player;
  float circleX = 2000;
  float xSpeed = 5;
  int radius = 10;
  boolean ballHit = false;
  Enemy enemy;
  int coins = 0;

  void setup() 
  {
    manager = new TileManager(Config.DEFAULT_CAMERA_MOVEMENT_SPEED);
    player = new Player(width/2, height - Config.PLAYER_BOTTOM_OFFSET);
    enemy = new Enemy();
  }

  void draw()
  {
    if (Input.keyClicked(ESC)) switchScreen(new MainMenuScreen());

    background(255);
    player.manager = manager;
    player.init();
    manager.listener();
    if (manager.speed <= manager.speedCap) {
      manager.speed += Config.CAMERA_SPEED_UP_SPEED;
    } else if (manager.speed > manager.speedCap) {
      manager.speed -= Config.CAMERA_SPEED_UP_SPEED;
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
    player.tileCollision = collision;
    player.obstacle = manager.ObstacleCheckCollision(player.playerPos, player.size);

    if (player.obstacle != null) {
      if (player.obstacle.layer.equals("coin")) {
        coins++;
      } else if (player.obstacle.layer.equals("shop") && Input.keyClicked('e')) {
        coins--;
        if (player.currentArmourLevel - 1 >= 0)
        player.currentArmourLevel -= 1;
        player.obstacle = null;
      }
    }

    textSize(32);
    text(coins, 10, 30);
  }

  void drawUI() {
  }

  void destroy() {
  }
}
