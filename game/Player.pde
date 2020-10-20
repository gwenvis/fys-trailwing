
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

class Player {
  private int playerHP, currentArmourLevel;
  private PVector playerPos;
  private float playerSpeed, jumpPower, jumpGravity, playerJump, gravityPull, currentArmourSpeedMultiplier, playerVelocity, speedUp;
  boolean jump, barrierLeft, barrierRight, shieldIsUp, armourHit;
  PImage image;

  TileCollision tileCollision = new TileCollision();

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
    image.resize(100, 100);

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

    if (tileCollision.direction.y == -1 && gravityPull != 0) {
      playerPos.y = tileCollision.position.y;
      gravityPull = 0;
      jump = false;
    } else if (jump) {
      jump();
    }


    if (armourHit) {
      currentArmourSpeedMultiplier = armourLevels.get(currentArmourLevel);
      armourHit = false;
    }

    barrierLeft = playerBarrierLeft();
    barrierRight = playerBarrierRight();

    playerPos.y += gravityPull*jumpGravity;
  }

  void move() {
    playerVelocity = playerSpeed*currentArmourSpeedMultiplier;
    if (Input.keyCodePressed(LEFT)&&!barrierLeft && tileCollision.direction.x != -1) {
      playerPos.x-=playerVelocity;
    }
    if (Input.keyCodePressed(RIGHT)&&!barrierRight && tileCollision.direction.x != 1) {
      playerPos.x+=playerVelocity;
    }
    if (Input.keyCodePressed(UP)) {
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
    playerPos.y+=playerJump;
    playerJump = jumpPower + (gravityPull*jumpGravity);
  }

  void armourLevelsList() {
    armourLevels.add(1f);
    armourLevels.add(1.5f);
    armourLevels.add(3f);
    armourLevels.add(4.5f);
    armourLevels.add(6f);
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
