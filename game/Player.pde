/* 
 * @author Chantal Boodt 
 */

class Player {
  //Used in Enemy class
  protected boolean shieldIsUpLeft;
  protected int fireball;
  protected PVector shieldPos;

  //Used in playGame  
  Obstacle obstacle = null;
  public float currentArmourSpeedMultiplier;
  public float playerSpeed;

  //Used in AchievementsDatabase class
  public boolean fireballHit;
  public int coinsTotal;

  //Used in playGame and HUD
  public int coinAmount;
  public int shieldAmount; 
  public int hudArmourlvl, currentArmourLevel;

  //Used in playGame, HUD and AchievementsDatabase
  public float score;

  //Used in Enemy, playGame and TileManager
  public PVector playerPos;
  public PVector size = Config.PLAYER_SIZE;

  //Only used in Player class  
  private boolean barrierLeft, barrierRight;
  private boolean shieldIsUpRight, shieldLeft, shieldRight, shieldHit;
  private boolean timerSet;
  private boolean playerHit;
  private boolean jump, landing, running;
  private boolean jumpBoost = false;
  private boolean invincibility = false;

  private int shieldDurability, maxShieldAmount, currentShield;
  private int maxArmourLevel;
  private int postureChangeSpeed, postureChangeSpeedJump;
  private int maxCoinAmount, coinMultiplyer;
  private int screenCalcPercentage, screenCalcPercentageLeft, screenCalcPercentageRight;
  private int zero, two, three;
  private int speedUpTimer, speedUpCoolDown;

  private float barierCalcX, barierCalcY;
  private float playerVelocity, speedUp;
  private float jumpPower, jumpGravity, playerJump, gravityPull; 

  private float currentPowerupTimer = zero;
  private PImage invincibleSignImage;
  private PImage shieldLeftBlueImage, shieldLeftGreenImage, shieldLeftRedImage;
  private PImage shieldRightBlueImage, shieldRightGreenImage, shieldRightRedImage;


  //particlesystem required variables
  private boolean ToRight = true;
  private boolean particlePresent, hitParticlePresent;
  private boolean hitParticleHitShield, hitParticleHitPlayer;
  private boolean onGround, barrel;

  private int white;
  private int particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB;
  private int particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB; 
  private int estimatedParticleHeight, approximateShieldOffset;
  private int hitStartColourR, hitStartColourG, hitStartColourB;
  private int hitEndColourR, hitEndColourG, hitEndColourB;

  private float particleSystemX, particleSystemY, hitX, hitY;

  private String ID = "RunDust", hitID = "Hit";

  private ParticleSystem dust;
  private ParticleSystem hitObstacle;

  //Arraylists
  ArrayList<Float> armourLevels = new ArrayList<Float>();
  ArrayList<PImage> shields = new ArrayList<PImage>();

  /* 
   * @author Antonio Bottelier 
   */
  private Animation playerWalk;

  /* 
   * @author Cody Bolleboom 
   */
  TileCollision tileCollision = new TileCollision();
  TileManager manager;

  SessionDatabase highscoredb = new SessionDatabase();
  Session session;

  /* 
   * Creates Player and its functionality
   */
  Player(float x, float y) {
    //Used numbers
    zero = Config.ZERO;
    two = Config.DIVIDE_IN_HALF;
    three = Config.HIT_SHIELD_OFFSET;
    white = Config.COLOUR_WHITE;

    //Fireball amount
    fireball = zero;

    //Everything used for timers
    speedUpTimer = zero;
    speedUpCoolDown = Config.SPEED_UP_COOLDOWN;
    timerSet = false;

    //Used for calculating area a player can move in
    screenCalcPercentage = Config.SCREEN_CALC;
    screenCalcPercentageLeft = Config.SCREEN_CALC_LEFT;
    screenCalcPercentageRight = Config.SCREEN_CALC_RIGHT;

    //Player
    playerPos = new PVector(zero, zero);
    playerPos.x = x;
    playerPos.y = y;
    playerJump = zero;   

    postureChangeSpeed = 3;
    postureChangeSpeedJump = 5000;
    playerSpeed = Config.PLAYER_SPEED;
    speedUp = Config.PLAYER_SPEED_UP;
    gravityPull = zero;

    coinMultiplyer = zero;
    playerWalk = animations.PLAYER_WALK;    

    jumpPower = Config.PLAYER_JUMP_POWER;
    jumpGravity = Config.PLAYER_JUMP_GRAVITY;

    jump=false;
    barrierLeft=false;
    barrierRight=false;
    barierCalcX = size.x/two;
    barierCalcY = size.y/two;

    //Current coin amount and maximum amount
    coinAmount = zero;
    maxCoinAmount = Config.MAX_COIN_AMOUNT;

    //Everything used for the shield  
    shieldPos = new PVector(zero, zero);
    shieldPos.x = zero;
    shieldPos.y = zero;

    currentShield = zero;
    shieldIsUpLeft = false;
    shieldIsUpRight = false;

    maxShieldAmount = Config.MAX_SHIELD_AMOUNT;
    shieldAmount = Config.SHIELD_START_AMOUNT;
    shieldDurability = Config.SHIELD_START_DURABILITY;

    shieldLeftBlueImage = loadImage("ShieldLeftBlue.png");
    shieldRightBlueImage = loadImage("ShieldRightBlue.png");
    shieldLeftGreenImage = loadImage("ShieldLeftGreen.png");
    shieldRightGreenImage = loadImage("ShieldRightGreen.png");
    shieldLeftRedImage = loadImage("ShieldLeftRed.png");
    shieldRightRedImage = loadImage("ShieldRightRed.png");
    shields();

    //Everything used for the armour
    currentArmourLevel = zero;
    maxArmourLevel = Config.MAX_ARMOUR_LEVEL;
    hudArmourlvl = maxArmourLevel - currentArmourLevel;
    armourLevelsList();
    currentArmourSpeedMultiplier = armourLevels.get(currentArmourLevel);

    //Power-up invincibility
    invincibility = false;
    invincibleSignImage = loadImage("Invincibility_sign.png");

    //particlesystem dust
    ID = "RunDust";
    ToRight = true;

    estimatedParticleHeight = Config.ESTIMATED_PARTICLE_HEIGHT;
    approximateShieldOffset = Config.ESTIMATED_DISTANCE_SHIELD_PARTICLE;

    particleSystemStartColourR = white;
    particleSystemStartColourG = white;
    particleSystemStartColourB = white;

    particleSystemEndColourR = white;
    particleSystemEndColourG = white;
    particleSystemEndColourB = white;

    particleSystemX = playerPos.x - (size.x / Config.POS_CALC);
    particleSystemY = playerPos.y + (size.x / Config.POS_CALC);

    dust = new ParticleSystem(ID, particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB, particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB, particleSystemX, particleSystemY, false);

    //particlesystem hit
    hitID = "Hit";
    hitStartColourR = Config.HIT_START_COLOUR_R;
    hitStartColourG = Config.HIT_START_COLOUR_G;
    hitStartColourB = Config.HIT_START_COLOUR_B;

    hitEndColourR = Config.HIT_END_COLOUR_R;
    hitEndColourG = Config.HIT_END_COLOUR_G;
    hitEndColourB = Config.HIT_END_COLOUR_B;

    hitX = playerPos.x + (size.x / Config.POS_CALC);
    hitY = playerPos.y;

    hitObstacle = new ParticleSystem(hitID, hitStartColourR, hitStartColourG, hitStartColourB, hitEndColourR, hitEndColourG, hitEndColourB, hitX, hitY, ToRight);
  }

  /* 
   * Draws player, invincibility sign, shield and particlesystem
   */
  void draw() {
    imageMode(CENTER);

    //Checks if player is invincible or not
    if (invincibility) {
      image(invincibleSignImage, playerPos.x, playerPos.y);
      tint(#0000AA);
    }
    playerWalk.draw(playerPos.x, playerPos.y);

    tint(white, white);
    //Checks if shield is currently being used
    if (shieldAmount != zero && (shieldIsUpLeft||shieldIsUpRight)) {
      image(shields.get(currentShield), shieldPos.x, shieldPos.y);
    }

    //Checks if player is running or landing
    if (landing || onGround || particlePresent) {
      if (landing) {
        dust.particleID = "LandDust";
      } else if (running && onGround) {
        dust.particleID = "RunDust";
      } else {
      }
      //draw particlesystem
      dust.draw();
    }

    //Checks if player is hit by a barrel or fireball
    if ((barrel && (hitParticleHitPlayer || hitParticleHitShield)) || hitParticlePresent ) {
      //draw particlesystem
      hitObstacle.draw();
      hitParticleHitPlayer = false;
      hitParticleHitShield = false;
      hitObstacle.draw = false;
    }
  }

  /* 
   * Updates movements, timers, 
   */
  void update() {
    //Checks if particlesystem is empty
    if (dust.particles.isEmpty()) {
      particlePresent = false;
    }
    if (hitObstacle.particles.isEmpty()) {
      hitParticlePresent = false;
    }

    //Checks if timer has ended and resets it
    if (!timerSet) {
      speedUpTimer = millis(); 
      timerSet = true;
    }

    //Timer has not ended calculate playerspeed
    if (millis() - speedUpTimer > speedUpCoolDown) {
      playerSpeed = playerSpeed * speedUp;
      timerSet = false;
    }

    //player position resets when player falls in a hole
    if (playerPos.y >= height - (barierCalcY)) {
      fallPositionChange();
      fireball++;
    }

    //Player not on tiles and jumping up
    if (tileCollision.direction.y != -1) {

      playerWalk.setAnimationSpeed(postureChangeSpeed);
      gravityPull++;
      onGround = false;
      dust.draw = false;
    }

    //Player jumps into floating tile
    if (tileCollision.direction.y == 1) {

      playerWalk.setAnimationSpeed(postureChangeSpeed);
      jumpBoost = false;
      gravityPull = 55;
    }

    //Player running on the ground
    if (tileCollision.direction.y == Config.DOWN && gravityPull != zero) {
      playerPos.y = tileCollision.position.y;

      particlePresent = true;
      onGround = true;
      dust.draw = true;

      gravityPull = zero;
      jump = false;
    } else if (jump && tileCollision.direction.y != Config.UP) {
      //Player jumps, particlesystem disabled
      jump();

      dust.draw = false;
    }

    if (tileCollision.direction.y != Config.DOWN && gravityPull == zero) {
      //Made by Cody
      playerPos.sub(tileCollision.direction.x * manager.speed, zero);
    }

    //Player falls into lava
    if (obstacle != null && obstacle.layer.equals("lava")) {
      //Made by Cody
      currentArmourLevel = 10000;
    }

    //Player picks up a coin
    if (obstacle != null && obstacle.layer.equals("coin")) {
      coinAmount++;
      obstacle = null;
    }

    //Player hits an obstacle
    if (obstacle != null && obstacle.layer.equals("obstacle")) {
      hitParticlePresent = true;

      hitObstacle.draw = true;

      //Checks if the shield is used on the right side where the obstacles are
      if (shieldIsUpRight) {
        //Shield is being used
        hitParticleHitShield = true;
        shieldHit = true;
        shieldHit();
      } else {
        //No shield, player is hit
        hitParticleHitPlayer = true;
        playerHit = true;
        if (playerHit) {
          damage();
        }        
        if (playerPos.y >= height - (Config.CHUNK_BOTTOM_OFFSET+(barierCalcY))) {
          //Player fals into a hole
        } else {
          if (!invincibility) {
            //If player is not invincible the player or its armour gets damaged
            currentArmourLevel += obstacle.damage;
            currentArmourSpeedMultiplier = armourLevels.get(currentArmourLevel > armourLevels.size() - 1 ? armourLevels.size() - 1 : currentArmourLevel);
          }
        }
      }
      obstacle = null;
    }

    //Ends duration of the power-up
    currentPowerupTimer--;
    if (currentPowerupTimer <= zero) {
      jumpBoost = false;
      invincibility = false;
    }

    //Checks barrier on area player can move in
    barrierLeft = playerBarrierLeft();
    barrierRight = playerBarrierRight();

    //Update amount of armour player has left, score
    hudArmourlvl = maxArmourLevel - currentArmourLevel;
    score = manager.score + (maxCoinAmount * coinMultiplyer);

    //Update playerposition
    playerPos.y += gravityPull * jumpGravity;

    //Checks which way the player is running and adjusts the placement of the particlesystem  
    if (!dust.toRight) {
      dust.particleSystemStartX = playerPos.x - (size.x / two);
    } else {
      dust.particleSystemStartX = playerPos.x + (size.x / two);
    }
    dust.particleSystemStartY = playerPos.y + (size.y / two) - estimatedParticleHeight;

    //Checks if a particle hit the shield and gives coordinates to particlesystem hit
    if (hitParticleHitShield) {
      hitObstacle.particleSystemStartX = shieldPos.x + shieldLeftBlueImage.width/two + approximateShieldOffset;
      hitObstacle.particleSystemStartY = shieldPos.y - shieldLeftBlueImage.height/three;
    } else {        
      hitObstacle.particleSystemStartX  = playerPos.x + barierCalcX;
      hitObstacle.particleSystemStartY = playerPos.y;

      //Checks if the player has fallen into a hole and disables particlesystem and barrel
      if (playerPos.y >= height - (Config.CHUNK_BOTTOM_OFFSET+(barierCalcY)) || playerPos.y <= (barierCalcY)) {
        hitParticlePresent = false;
        barrel = false;
      } else {
        barrel = true;
      }

      //Do following three functions
      coins();
      shield();
      move();
    }
  }

  /* 
   * Describes all movements that need to be made 
   */
  void move() {
    playerVelocity = playerSpeed * currentArmourSpeedMultiplier;

    //Checks if the player is able of walking to the left
    if (Input.keyCodePressed(LEFT)&&!barrierLeft && tileCollision.direction.x != Config.LEFT) {
      playerPos.x= playerPos.x - playerVelocity - manager.speed;
      dust.toRight = true;
    }

    //Checks if the player is able of walking to the right
    if (Input.keyCodePressed(RIGHT)&&!barrierRight && tileCollision.direction.x != Config.RIGHT) {
      playerPos.x += playerVelocity + manager.speed;
      dust.toRight = false;
    }

    //Checks if the player is not actively walking to the left or right
    if (!Input.keyCodePressed(LEFT)&&!Input.keyCodePressed(RIGHT))
    {
      dust.toRight = false;
    }

    //Player is not falling down and pressed the x button
    if (Input.keyPressed('x') && tileCollision.direction.y == Config.DOWN) {
      jump = true;
    }    

    //Player pressed the a button
    if (Input.keyPressed('a')) {
      //Shield used on the right side
      shieldRight = false;
      shieldLeft = true;
      shieldIsUpLeft = true;
    } else {
      //Shield on the left side is disabled
      shieldIsUpLeft = false;
    }

    //Player pressed the s button
    if (Input.keyPressed('s')) {
      //Shield used on the left side
      shieldRight = true;
      shieldLeft = false;
      shieldIsUpRight = true;
    } else {
      //Shield on the right side is disabled
      shieldIsUpRight = false;
    }
  }  

  /* 
   * Checks which shield is being used and if a shield is picked up 
   */
  void shield() {
    //Checks which shield should be used
    whichShield();

    //Calculate shield movement
    shieldPos.y = playerPos.y;
    if (currentShield == 0||currentShield == 2||currentShield==4) {
      shieldPos.x = playerPos.x - (two*size.x/three);
    } 

    if (currentShield == 1||currentShield == 3||currentShield == 5) {
      shieldPos.x = playerPos.x + (two*size.x/three);
    }

    //Shield picked up
    if (obstacle != null && obstacle.layer.equals("shield")) {
      if (shieldAmount<maxShieldAmount) {
        shieldAmount++;
      }
    }
  }

  /* 
   * Checks which shield is being used and how much hits it can take 
   */
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
        currentShield = zero;
      }
      if (shieldRight) {
        currentShield = 1;
      }
    }
  }

  /* 
   * Checks if a shield has been hit and Calculates the new durability
   * And which shield should be used next
   */
  void shieldHit() {
    if (shieldHit) {
      shieldDurability -= obstacle.damage; 
      shieldHit = false;
    }

    //Shield has been hit
    if ((shieldLeft && shieldDurability > zero)||(shieldRight && shieldDurability > zero)) {
      shieldDurability = shieldDurability-1;
    }

    //Shield has been broken
    if (shieldDurability <= zero) {
      shieldAmount--;
      shieldDurability = 3;
    }
  }

  /* 
   * Checks if the player or the shield has been hit and calculates damage to it
   */
  void fireballHit() {
    fireballHit = true;
    if (shieldIsUpLeft && shieldLeft) {
      shieldHit();
    } else {
      damage();
    }
  }

  /* 
   * Calculates lasting armour of the player
   */
  void damage() {
    if (!invincibility) {
      if (currentArmourLevel >= maxArmourLevel) {
        //No armour left
        death();
      } else if (playerHit) {  
        currentArmourLevel++;
        playerHit = false;
      }
    }
  }

  /* 
   * Checks coin amount
   */
  void coins() {
    if (coinAmount == maxCoinAmount) {
      //Max number of coins collected 
      if (shieldAmount >= maxShieldAmount) {
        //Max number of shields not reached, add shield
        shieldAmount++;
      } else {
        //Adds a number that multiplies by 10 tot the score
        coinMultiplyer++;
      }
      coinAmount = zero;
    }
  }

  /* 
   * Player died gives all necessary information to different classes
   */
  void death() {
    session.coins = coinAmount;
    session.distance = (int)manager.score;

    highscoredb.updateSession(session.getId(), session);
    coinsTotal = (coinMultiplyer * maxCoinAmount) + coinAmount;
    achievementsDb.achievementCheck(int(manager.score), coinsTotal, manager.chunkpool, fireballHit);
    gameState = "GAMEOVER";
  }

  /* 
   * Replace player above the top of the screen
   */
  void fallPositionChange() {
    playerPos.y = zero - (barierCalcY);
  }

  /* 
   * Checks if player used powerup during jump
   */
  void jump() {
    playerWalk.setAnimationSpeed(postureChangeSpeedJump);
    if (jumpBoost)
    {
      playerPos.y += playerJump*Config.POWERUP_JUMP_BOOST;
    } else {
      playerPos.y += playerJump;
    }
    playerJump = jumpPower + (gravityPull*jumpGravity);
  }

  /* 
   * Checks if the player picked up a power-up
   */
  void givePowerUp(PowerupType type) {
    //Made by Cody/ Anton
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

  /* 
   * Adds float to arraylist
   */
  void armourLevelsList() {
    armourLevels.add(1f);
    armourLevels.add(1.05f);
    armourLevels.add(1.10f);
    armourLevels.add(1.15f);
    armourLevels.add(1.20f);
    armourLevels.add(1.25f);
    armourLevels.add(1.30f);
    armourLevels.add(1.35f);
    armourLevels.add(1.40f);
  }

  /* 
   * Adds PImage to arraylist
   */
  private void shields() {
    shields.add(shieldLeftBlueImage);
    shields.add(shieldRightBlueImage);
    shields.add(shieldLeftGreenImage);
    shields.add(shieldRightGreenImage);
    shields.add(shieldLeftRedImage);
    shields.add(shieldRightRedImage);
  }

  /* 
   * Defines left barrier of walkable area
   * Checks if the player reached the barrier and returs true or false
   */
  private boolean playerBarrierLeft() {
    float leftBarrier = width/screenCalcPercentage * screenCalcPercentageLeft;
    if (playerPos.x - (barierCalcX)<= leftBarrier) {
      return true;
    }
    return false;
  }

  /* 
   * Defines right barrier of walkable area
   * Checks if the player reached the barrier and returs true or false
   */
  private boolean playerBarrierRight() {
    float rightBarrier = width/screenCalcPercentage * screenCalcPercentageRight;
    if (playerPos.x + (barierCalcX)>= rightBarrier) {
      return true;
    }
    return false;
  }
}
