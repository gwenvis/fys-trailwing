
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.TimeUnit;

class Player {
  int shieldDurability, shieldAmount, currentArmourLevel, coinAmount, currentShield;
  private PVector playerPos, shieldPos;
  private float playerSpeed, jumpPower, jumpGravity, playerJump, gravityPull, currentArmourSpeedMultiplier, playerVelocity;
  boolean jump, barrierLeft, barrierRight, shieldIsUpLeft, shieldIsUpRight, shieldLeft, shieldRight;
  boolean jumpBoost = false;
  boolean invincibility = false;
  float currentPowerupTimer = 0, score, coinMultiplyer;
  PImage playerImage, shieldLeftBlueImage, shieldRightBlueImage, shieldLeftGreenImage, shieldRightGreenImage, shieldLeftRedImage, shieldRightRedImage;
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
  ArrayList<PImage> shields = new ArrayList<PImage>();

  Player(float x, float y) {
    playerPos = new PVector(0, 0);
    playerPos.x = x;
    playerPos.y = y;
    playerJump = 0;
    gravityPull = 0;
    coinAmount = 0;
    currentShield = 0;
    shieldPos = new PVector(50, 50);
    shieldPos.x = 0;
    shieldPos.y = 0;
    shieldAmount = 2;
    shieldDurability = 3;
    coinMultiplyer = 0;

    shieldIsUpLeft=false;
    shieldIsUpRight=false;

    jumpPower = Config.PLAYER_JUMP_POWER;
    jumpGravity = Config.PLAYER_JUMP_GRAVITY;
    playerSpeed = Config.PLAYER_SPEED;

    jump=false;
    barrierLeft=false;
    barrierRight=false;
    playerImage = loadImage("new_player.png");
    playerImage.resize((int)size.x, (int)size.y);

    shieldLeftBlueImage = loadImage("ShieldLeftBlue.png");
    shieldRightBlueImage = loadImage("ShieldRightBlue.png");
    shieldLeftGreenImage = loadImage("ShieldLeftGreen.png");
    shieldRightGreenImage = loadImage("ShieldRightGreen.png");
    shieldLeftRedImage = loadImage("ShieldLeftRed.png");
    shieldRightRedImage = loadImage("ShieldRightRed.png");
    shields();

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

  void draw() {
    imageMode(CENTER);
    image(playerImage, playerPos.x, playerPos.y);

    if (shieldIsUpLeft||shieldIsUpRight) {
      image(shields.get(currentShield), shieldPos.x, shieldPos.y);
      //shieldIsUp = false;
    }
  }

  void update() {

    //cutscene? -cartoon vallen
    if (playerPos.y >= height - (Config.PLAYER_SIZE.y/2)) {
      fallPositionChange();
    }

    if (tileCollision.direction.y != -1) {
      gravityPull++;
    }

    if (tileCollision.direction.y == 1) {
      //gravityPull++;
      jumpBoost = false;
      gravityPull = 25;
    }

    if (tileCollision.direction.y == Config.DOWN && gravityPull != 0) {
      playerPos.y = tileCollision.position.y;
      gravityPull = 0;
      jump = false;
    } else if (jump && tileCollision.direction.y != Config.UP) {
      jump();
    }

    if (tileCollision.direction.y != Config.DOWN && gravityPull == 0) {
      playerPos.sub(tileCollision.direction.x * manager.speed, 0);
    }

    if (obstacle != null && obstacle.layer.equals("coin")) {
      coinAmount++;
      obstacle = null;
    }

    if (obstacle != null && obstacle.layer.equals("obstacle")) {
      if (shieldIsUpLeft||shieldIsUpRight) {
        if (shieldDurability <= 1) {
          shieldAmount -= 1;
          shieldDurability = 3;
        } else {
          shieldDurability -= 1;
        }
      } else {
        currentArmourLevel += obstacle.damage;
        damage();
        currentArmourSpeedMultiplier = armourLevels.get(currentArmourLevel > armourLevels.size() - 1 ? armourLevels.size() - 1 : currentArmourLevel);
      }
      obstacle = null;
    }

    currentPowerupTimer--;
    if (currentPowerupTimer <= 0) {
      jumpBoost = false;
      invincibility = false;
    }

    barrierLeft = playerBarrierLeft();
    barrierRight = playerBarrierRight();


    score = manager.score + (10 * coinMultiplyer);
    playerPos.y += gravityPull*jumpGravity;
    coins();
    shield();
    move();
  }

  void move() {
    playerVelocity = playerSpeed/**currentArmourSpeedMultiplier*/;
    if (Input.keyCodePressed(LEFT)&&!barrierLeft && tileCollision.direction.x != Config.LEFT) {
      playerPos.x= playerPos.x - playerVelocity - manager.speed;
    }
    if (Input.keyCodePressed(RIGHT)&&!barrierRight && tileCollision.direction.x != Config.RIGHT) {
      playerPos.x+=playerVelocity + manager.speed;
    }
    if (Input.keyPressed(' ') && tileCollision.direction.y == Config.DOWN) {
      jump = true;
    }    
    if (Input.keyCodePressed(DOWN)) {
      shieldRight = false;
      shieldLeft = true;
      shieldIsUpLeft = true;
    } else {
      shieldIsUpLeft = false;
    }
    if (Input.keyCodePressed(UP)) {
      shieldRight = true;
      shieldLeft = false;
      shieldIsUpRight = true;
    } else {
      shieldIsUpRight = false;
    }
  }  

  void shield() {
    whichShield();

    shieldPos.y = playerPos.y;
    if (currentShield==0||currentShield==2||currentShield==4) {
      shieldPos.x = playerPos.x - (2*Config.PLAYER_SIZE.x/3);
    } 

    if (currentShield==1||currentShield==3||currentShield==5) {
      shieldPos.x = playerPos.x + (2*Config.PLAYER_SIZE.x/3);
    }

    if (obstacle != null && obstacle.layer.equals("shield")) {
      if (shieldAmount>=5) {
        shieldAmount++;
      }
    }
  }

  void whichShield() {
    if (shieldDurability==1) {
      if (shieldLeft) {
        currentShield = 4;
      }
      if (shieldRight) {
        currentShield = 5;
      }
    } else if (shieldDurability==2) {
      if (shieldLeft) {
        currentShield = 2;
      }
      if (shieldRight) {
        currentShield = 3;
      }
    } else {
      if (shieldLeft) {
        currentShield = 0;
      }
      if (shieldRight) {
        currentShield = 1;
      }
    }
  }

  void shieldHit() {
    if (shieldRight&&obstacle != null && obstacle.layer.equals("obstacle")) {
      shieldDurability = shieldDurability - int(obstacle.damage);
      obstacle = null;
    }

    if ((shieldLeft&&shieldDurability>1)||(shieldRight&&shieldDurability>1)) {
      shieldDurability = shieldDurability-1;
    }

    if (shieldDurability<=1) {
      shieldAmount -= 1;
      shieldDurability = 3;
    }
  }

  void damage() {
    if (currentArmourLevel >= 6) {
      death();
    } else {
      currentArmourLevel++;
    }
  }

  void coins() {
    if (coinAmount == Config.MAX_COIN_AMOUNT) {
      if (shieldAmount<=5) {
        shieldAmount++;
      } else {
        coinMultiplyer++;
      }
      coinAmount = 0;
    }
  }

  void death() {
    gameState = "GAMEOVER";
  }

  void fallPositionChange() {
    playerPos.y = 0 - (Config.PLAYER_SIZE.y/2);
  }


  void jump() {
    if (jumpBoost)
    {
      playerPos.y+=playerJump*Config.POWERUP_JUMP_BOOST;
    } else
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
    armourLevels.add(1f);
    armourLevels.add(5f);
    armourLevels.add(10f);
    armourLevels.add(15f);
    armourLevels.add(20f);
    armourLevels.add(25f);
  }
  void shields() {
    shields.add(shieldLeftBlueImage);
    shields.add(shieldRightBlueImage);
    shields.add(shieldLeftGreenImage);
    shields.add(shieldRightGreenImage);
    shields.add(shieldLeftRedImage);
    shields.add(shieldRightRedImage);
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

  boolean shieldRaised() {
    return false;
  }
}
