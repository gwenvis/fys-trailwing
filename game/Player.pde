
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

class Player {
  private int playerHP, currentArmourLevel;
  private PVector playerPos;
  private float playerSpeed, jumpPower, jumpGravity, playerJump, gravityPull, currentArmourSpeedMultiplier, playerVelocity, speedUp;
  boolean jump, barrierLeft, barrierRight, shieldIsUp, armourHit;
  boolean jumpBoost = false;
  boolean invincibility = false;
  float currentPowerupTimer = 0;
  PImage image;
  PVector size = Config.PLAYER_SIZE;

  TileCollision tileCollision = new TileCollision();
  Obstacle obstacle = null;
  TileManager manager;

  /*
    schedule creates tasks to be excecuted with various delays and return a task object that can be used to cancel or check execution
   excecuterservice submits tasks with a delay (0 is possible) 
   newScheduledThreadPool(1) creates a new threadpool to excecute
   */
  ScheduledExecutorService executor = Executors.newScheduledThreadPool(1);

  ArrayList<Float> armourLevels = new ArrayList<Float>();

  Player(float x, float y) {
    playerPos = new PVector(0, 0);
    playerPos.x = x;
    playerPos.y = y;
    playerJump = 0;
    gravityPull = 0;

    jumpPower = Config.PLAYER_JUMP_POWER;
    jumpGravity = Config.PLAYER_JUMP_GRAVITY;
    //playerHP = 100;
    playerSpeed = Config.PLAYER_SPEED;

    armourHit=false;
    jump=false;
    barrierLeft=false;
    barrierRight=false;
    image = loadImage("new_player.png");
    image.resize((int)size.x, (int)size.y);

    //command that has to be excecuted infinitily until end is reached, which isn't specified in this case
    Runnable speedUp = new Runnable() {
      public void run() {
        speedingUp();
      }
    };

    //speedingUp() first excecuted after 0 seconds, excecuted every 3 seconds
    executor.scheduleAtFixedRate(speedUp, 0, 3, TimeUnit.SECONDS);

    currentArmourLevel = 0;
    armourLevelsList();
    currentArmourSpeedMultiplier = armourLevels.get(currentArmourLevel);
  }

  void init() {
    draw();
    move();
  }

  void draw() {
    update();
    imageMode(CENTER);
    image(image, playerPos.x, playerPos.y);
  }

  void update() {
    //print(playerPos);
    //print("\n");
    if (tileCollision.direction.y == 0) {
      gravityPull++;
    }

    if (tileCollision.direction.y == Config.DOWN && gravityPull != 0) {
      playerPos.y = tileCollision.position.y;
      gravityPull = 0;
      jump = false;
    } else if (jump) {
      jump();
    }

    if (tileCollision.direction.y != Config.DOWN && gravityPull == 0) {
      playerPos.sub(tileCollision.direction.x * manager.speed, 0);
    }

    if (obstacle != null && obstacle.layer.equals("obstacle")) {
      currentArmourLevel += obstacle.damage;
      currentArmourSpeedMultiplier = armourLevels.get(currentArmourLevel > armourLevels.size() - 1 ? armourLevels.size() - 1 : currentArmourLevel);
      obstacle = null;
    }
    
    currentPowerupTimer--;
    if(currentPowerupTimer <= 0) {
      jumpBoost = false;
      invincibility = false;
    }

    barrierLeft = playerBarrierLeft();
    barrierRight = playerBarrierRight();

    playerPos.y += gravityPull*jumpGravity;
  }

  void move() {
    playerVelocity = playerSpeed/**currentArmourSpeedMultiplier*/;
    if (Input.keyCodePressed(LEFT)&&!barrierLeft && tileCollision.direction.x != Config.LEFT) {
      playerPos.x-=playerVelocity;
    }
    if (Input.keyCodePressed(RIGHT)&&!barrierRight && tileCollision.direction.x != Config.RIGHT) {
      playerPos.x+=playerVelocity;
    }
    if (Input.keyCodePressed(UP) && tileCollision.direction.y == Config.DOWN) {
      // if keypressed is arrow up then jump is true
      jump = true;
    }    
    if (Input.keyCodePressed(DOWN)) {
      //ATTENTION change to hit by enemy, pressed=> multiplier changes to much
      armourHit = true;
      currentArmourLevel++;
    }
  }

  void jump() {
    if(jumpBoost)
    {
      playerPos.y+=playerJump*Config.POWERUP_JUMP_BOOST;
    }
    else
      playerPos.y+=playerJump;
    playerJump = jumpPower + (gravityPull*jumpGravity);
  }

  void givePowerUp(PowerupType type) {
    switch(type) {
      case INVINCIBILITY:
        invincibility = true;
        break;
      case SUPER_JUMP:
        jumpBoost = true;
        break;
    }

    currentPowerupTimer = Config.POWERUP_ACTIVE_TIMER * frameRate;
  }

  void armourLevelsList() {
    armourLevels.add(5f);
    armourLevels.add(10f);
    armourLevels.add(15f);
    armourLevels.add(20f);
    armourLevels.add(25f);
  }

  void speedingUp() {
    playerSpeed = playerSpeed * .8f;
  }

  Boolean playerBarrierLeft() {
    float leftBarrier = width/100 * 20;
    if (playerPos.x <= leftBarrier) {
      return true;
    }
    return false;
  }
  Boolean playerBarrierRight() {
    float rightBarrier = width/100 * 80;
    //playerWidth is 100
    if (playerPos.x + 50>= rightBarrier) {
      return true;
    }
    return false;
  }
}
