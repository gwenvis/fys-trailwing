//import java.util.concurrent.ScheduledExecutorService;
//import java.util.concurrent.Executors;
//import java.util.concurrent.TimeUnit;

class Player {
  int shieldDurability, shieldAmount, hudArmourlvl, coinAmount, currentShield;
  private int currentArmourLevel, speedUpTimer, speedUpCoolDown, armourLoss;
  private PVector playerPos, shieldPos;
  private float playerSpeed, jumpPower, jumpGravity, playerJump, gravityPull, currentArmourSpeedMultiplier, playerVelocity;
  boolean jump, barrierLeft, barrierRight, shieldIsUpLeft, shieldIsUpRight, shieldLeft, shieldRight, timerSet;
  boolean jumpBoost = false;
  boolean invincibility = false;
  float currentPowerupTimer = 0, score, coinMultiplyer;
  PImage playerImage, shieldLeftBlueImage, shieldRightBlueImage, shieldLeftGreenImage, shieldRightGreenImage, shieldLeftRedImage, shieldRightRedImage;
  PVector size = Config.PLAYER_SIZE;

  TileCollision tileCollision = new TileCollision();
  Obstacle obstacle = null;
  TileManager manager;

  ArrayList<Float> armourLevels = new ArrayList<Float>();
  ArrayList<PImage> shields = new ArrayList<PImage>();

  Player(float x, float y) {
    speedUpTimer = 0;
    speedUpCoolDown = 3000;
    timerSet = false;

    playerPos = new PVector(0, 0);
    playerPos.x = x;
    playerPos.y = y;
    playerJump = 0;
    gravityPull = 0;
    coinAmount = 0;
    currentShield = 0;
    shieldPos = new PVector(0, 0);
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

    armourLoss = 4;
    currentArmourLevel = 0;
    hudArmourlvl = 9 - currentArmourLevel;

    armourLevelsList();
    currentArmourSpeedMultiplier = armourLevels.get(currentArmourLevel);
  }

  void draw() {
    imageMode(CENTER);
    playerImage.resize((int)size.x, (int)size.y);
    image(playerImage, playerPos.x, playerPos.y);

    if (shieldAmount != 0 && (shieldIsUpLeft||shieldIsUpRight)) {
      image(shields.get(currentShield), shieldPos.x, shieldPos.y);
    }
  }

  void update() {
    if (!timerSet) {
      speedUpTimer = millis(); 
      timerSet = true;
    }

    if (millis() - speedUpTimer > speedUpCoolDown) {
      playerSpeed = playerSpeed * .8f;
      timerSet = false;
    }

    //cutscene? -cartoon vallen
    if (playerPos.y >= height - (Config.PLAYER_SIZE.y/2)) {
      fallPositionChange();
    }

    if (tileCollision.direction.y != -1) {
      gravityPull++;
    }

    if (tileCollision.direction.y == 1) {
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
      if (shieldIsUpRight) {
        shieldHit();
      } else {
        currentArmourLevel += obstacle.damage;
        size.x -= obstacle.damage * armourLoss;
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

    hudArmourlvl = 9 - currentArmourLevel;
    score = manager.score + (10 * coinMultiplyer);
    playerPos.y += gravityPull * jumpGravity;



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
      playerPos.x += playerVelocity + manager.speed;
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
      if (shieldAmount<5) {
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
    if ((shieldLeft&&shieldDurability>0)||(shieldRight&&shieldDurability>0)) {
      shieldDurability = shieldDurability-1;
    }

    if (shieldDurability<=0) {
      shieldAmount -= 1;
      shieldDurability = 3;
    }
  }

  void fireballHit() {
    if (shieldIsUpLeft && shieldLeft) {
      shieldHit();
    } else {
      damage();
    }
  }

  void damage() {
    if (currentArmourLevel >= 9) {
      death();
    } else {
      currentArmourLevel++;
      size.x -= armourLoss;
    }
  }

  void coins() {
    if (coinAmount == Config.MAX_COIN_AMOUNT) {
      if (shieldAmount>=5) {
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
      playerPos.y += playerJump*Config.POWERUP_JUMP_BOOST;
    } else
      playerPos.y += playerJump;
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
    armourLevels.add(1.005f);
    armourLevels.add(1.10f);
    armourLevels.add(1.15f);
    armourLevels.add(1.20f);
    armourLevels.add(1.25f);
    armourLevels.add(1.30f);
    armourLevels.add(1.35f);
    armourLevels.add(1.40f);
  }
  void shields() {
    shields.add(shieldLeftBlueImage);
    shields.add(shieldRightBlueImage);
    shields.add(shieldLeftGreenImage);
    shields.add(shieldRightGreenImage);
    shields.add(shieldLeftRedImage);
    shields.add(shieldRightRedImage);
  }

  Boolean playerBarrierLeft() {
    float leftBarrier = width/100 * 20;
    if (playerPos.x - (Config.PLAYER_SIZE.x/2)<= leftBarrier) {
      return true;
    }
    return false;
  }

  Boolean playerBarrierRight() {
    float rightBarrier = width/100 * 80;
    if (playerPos.x + (Config.PLAYER_SIZE.x/2)>= rightBarrier) {
      return true;
    }
    return false;
  }
}
