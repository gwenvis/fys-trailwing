/* Made by Chantal Boodt *///

class Player {
  int shieldDurability, shieldAmount, hudArmourlvl, coinAmount, currentShield, fireball;
  private int currentArmourLevel, speedUpTimer, speedUpCoolDown, armourLoss;
  private PVector playerPos, shieldPos;
  private float playerSpeed, jumpPower, jumpGravity, playerJump, gravityPull, currentArmourSpeedMultiplier, playerVelocity;
  boolean jump, barrierLeft, barrierRight, shieldIsUpLeft, shieldIsUpRight, shieldLeft, shieldRight, timerSet, shieldHit, playerHit, landing, running;
  boolean jumpBoost = false;
  boolean invincibility = false;
  float currentPowerupTimer = 0, score, coinMultiplyer;
  PImage playerImage, shieldLeftBlueImage, shieldRightBlueImage, shieldLeftGreenImage, shieldRightGreenImage, shieldLeftRedImage, shieldRightRedImage, invincibleSignImage;
  PVector size = Config.PLAYER_SIZE;
  private Animation playerWalk;

  //particlesystem required variables
  String ID = "RunDust", hitID = "Hit";
  int particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB, particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB, estimatedParticleHeight = 10;
  int hitStartColourR, hitStartColourG, hitStartColourB, hitEndColourR, hitEndColourG, hitEndColourB, approximateShieldOffset = 15;
  float particleSystemX, particleSystemY, hitX, hitY;
  boolean ToRight = true, particlePresent, hitParticlePresent, hitParticleHitShield, hitParticleHitPlayer, onGround, barrel;
  ParticleSystem dust;
  ParticleSystem hitObstacle;

  TileCollision tileCollision = new TileCollision();
  Obstacle obstacle = null;
  TileManager manager;

  ArrayList<Float> armourLevels = new ArrayList<Float>();
  ArrayList<PImage> shields = new ArrayList<PImage>();

  Player(float x, float y) {
    fireball = 0;
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
    playerWalk = animations.PLAYER_WALK;

    shieldIsUpLeft=false;
    shieldIsUpRight=false;

    jumpPower = Config.PLAYER_JUMP_POWER;
    jumpGravity = Config.PLAYER_JUMP_GRAVITY;
    playerSpeed = Config.PLAYER_SPEED;

    jump=false;
    barrierLeft=false;
    barrierRight=false;
    invincibleSignImage = loadImage("Invincibility_sign.png");
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

    //particlesystem dust
    ID = "RunDust";
    hitID = "Hit";
    ToRight = true;

    particleSystemStartColourR = 255;
    particleSystemStartColourG = 255;
    particleSystemStartColourB = 255;

    particleSystemEndColourR = 255;
    particleSystemEndColourG = 255;
    particleSystemEndColourB = 255;

    particleSystemX = playerPos.x - (size.x / 2);
    particleSystemY = playerPos.y + (size.x / 2);

    hitStartColourR = 102;
    hitStartColourG = 51;
    hitStartColourB = 0;

    hitEndColourR = 153;
    hitEndColourG = 76;
    hitEndColourB = 0;

    hitX = playerPos.x + (size.x / 2);
    hitY = playerPos.y;

    dust = new ParticleSystem(ID, particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB, particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB, particleSystemX, particleSystemY, false);
    hitObstacle = new ParticleSystem(hitID, hitStartColourR, hitStartColourG, hitStartColourB, hitEndColourR, hitEndColourG, hitEndColourB, hitX, hitY, ToRight);
  }

  void draw() {
    imageMode(CENTER);

    if (invincibility) {
      image(invincibleSignImage, playerPos.x, playerPos.y);
      tint(#0000AA);
    }
    //playerImage.resize((int)size.x, (int)size.y);
    //image(playerImage, playerPos.x, playerPos.y);
	playerWalk.draw(playerPos.x, playerPos.y);

    tint(255, 255);
    if (shieldAmount != 0 && (shieldIsUpLeft||shieldIsUpRight)) {
      image(shields.get(currentShield), shieldPos.x, shieldPos.y);
    }

    if (landing || onGround || particlePresent) {
      if (landing) {
        dust.particleID = "LandDust";
      } else if (running && onGround) {
        dust.particleID = "RunDust";
      } else {
      }
      dust.draw();
    }

    if ((barrel && (hitParticleHitPlayer || hitParticleHitShield)) || hitParticlePresent ) {
      hitObstacle.draw();
      hitParticleHitPlayer = false;
      hitParticleHitShield = false;
      hitObstacle.draw = false;
    }
  }

  void update() {

    if (dust.particles.isEmpty()) {
      particlePresent = false;
    }
    if (hitObstacle.particles.isEmpty()) {
      hitParticlePresent = false;
    }

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
      fireball++;
    }

    if (tileCollision.direction.y != -1) {
      gravityPull++;

      onGround = false;
      dust.draw = false;
    }

    if (tileCollision.direction.y == 1) {
      jumpBoost = false;
      gravityPull = 55;
    }
    if (tileCollision.direction.y == Config.DOWN && gravityPull != 0) {
      playerPos.y = tileCollision.position.y;

      particlePresent = true;
      onGround = true;
      dust.draw = true;

      gravityPull = 0;
      jump = false;
    } else if (jump && tileCollision.direction.y != Config.UP) {
      jump();

      dust.draw = false;
    }

    if (tileCollision.direction.y != Config.DOWN && gravityPull == 0) {
      playerPos.sub(tileCollision.direction.x * manager.speed, 0);
    }

    if (obstacle != null && obstacle.layer.equals("coin")) {
      coinAmount++;
      obstacle = null;
    }

    if (obstacle != null && obstacle.layer.equals("obstacle")) {
      hitParticlePresent = true;

      hitObstacle.draw = true;

      if (shieldIsUpRight) {
        hitParticleHitShield = true;
        shieldHit = true;
        shieldHit();
      } else {
        hitParticleHitPlayer = true;
        playerHit = true;
        if (playerHit) {
          damage();
        }        
        if (playerPos.y >= height - (Config.CHUNK_BOTTOM_OFFSET+(Config.PLAYER_SIZE.y/2))) {
        } else {
          if (!invincibility) {
            currentArmourLevel += obstacle.damage;
            size.x -= obstacle.damage * armourLoss;
            currentArmourSpeedMultiplier = armourLevels.get(currentArmourLevel > armourLevels.size() - 1 ? armourLevels.size() - 1 : currentArmourLevel);
          }
        }
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

    if (!dust.toRight) {
      dust.particleSystemStartX = playerPos.x - (size.x / 2);
    } else {
      dust.particleSystemStartX = playerPos.x + (size.x / 2);
    }
    dust.particleSystemStartY = playerPos.y + (size.y / 2) - estimatedParticleHeight;

    if (hitParticleHitShield) {
      hitObstacle.particleSystemStartX = shieldPos.x + shieldLeftBlueImage.width/2 + approximateShieldOffset;
      hitObstacle.particleSystemStartY = shieldPos.y - shieldLeftBlueImage.height/3 *1;
    } else {        
      hitObstacle.particleSystemStartX  = playerPos.x + size.x/2;
      hitObstacle.particleSystemStartY = playerPos.y;

      if (playerPos.y >= height - (Config.CHUNK_BOTTOM_OFFSET+(Config.PLAYER_SIZE.y/2))) {
        hitParticlePresent = false;
        barrel = false;
      } else {
        barrel = true;
      }

      coins();
      shield();
      move();
    }
  }

  void move() {
    playerVelocity = playerSpeed/**currentArmourSpeedMultiplier*/;
    if (Input.keyCodePressed(LEFT)&&!barrierLeft && tileCollision.direction.x != Config.LEFT) {
      playerPos.x= playerPos.x - playerVelocity - manager.speed;

      dust.toRight = true;
    }

    if (Input.keyCodePressed(RIGHT)&&!barrierRight && tileCollision.direction.x != Config.RIGHT) {
      playerPos.x += playerVelocity + manager.speed;

      dust.toRight = false;
    }

    if (!Input.keyCodePressed(LEFT)&&!Input.keyCodePressed(RIGHT))
    {
      dust.toRight = false;
    }

    if (Input.keyPressed('x') && tileCollision.direction.y == Config.DOWN) {
      jump = true;
    }    

    if (Input.keyPressed('a')) {
      shieldRight = false;
      shieldLeft = true;
      shieldIsUpLeft = true;
    } else {
      shieldIsUpLeft = false;
    }
    if (Input.keyPressed('s')) {
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
    if (shieldHit) {
      shieldDurability -= obstacle.damage; 
      shieldHit = false;
    }

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
    if (invincibility) {
      if (currentArmourLevel >= 9) {
        death();
      } else if (playerHit) {
        playerHit = false;
      } else {      
        currentArmourLevel++;
        size.x -= armourLoss;
      }
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
    } else {
      playerPos.y += playerJump;
    }
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
