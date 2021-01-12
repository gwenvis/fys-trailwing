/*
Made by Patrick Eikema
 
 everything to do with the fireball(s)+particlesystem modified by Chantal 
 */

class Enemy {
  float hitX;
  float speed;
  float x, y;
  float distance;
  float attackW, attackH;
  PImage fireBall;
  boolean angry, ToRight;
  int angryTimer, angryCooldown;
  int AngryDurationTimer, attackDurationCooldown;
  int fireBallTimer, fireBallDurationCooldown, approximateShieldOffset = 15;
  int particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB;
  int particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB;
  int fireballAmount, fireballStartTimeCalc;
  Player player;
  boolean attack;
  private boolean lastFrameAngry;
  private boolean lastFrameAttack;
  private boolean canPlayAttackSound = false;

  private int movedDistance;
  private float playerX;
  private float playerWidthHalf;
  private float shieldWidth;

  private int fireballsDelay;
  float dragonBorder;
  private float distanceDragonFireball;
  private float particleSystemX, particleSystemY;
  private float fireBallSpeed;
  public String ID;
  ArrayList<ParticleSystem> fireballs = new ArrayList<ParticleSystem>();
  ArrayList<Float> particleSystemsY = new ArrayList<Float>();
  ArrayList<Float> particleSystemsX = new ArrayList<Float>();

  ParticleSystem fireballParticleSystem;
  SpriteAnimation dragon; 

  Enemy(Player player) {

    //initialisation
    this.player = player;
    dragon = new SpriteAnimation("dragonSprites.png", 3, 8);

    //Size & pos Enemy+
    this.x = 150;
    this.y = player.playerPos.y -50;
    this.speed = 6;
    this.attackW = (width/10)*3;
    this.attackH = 50;

    for (int i = 0; i < dragon.frameImage.length; i++) {
      dragon.frameImage[i].resize(dragon.frameImage[i].width/5*4, dragon.frameImage[i].height/5*4);
    }


    //attackvariables
    this.angry = false;
    this.angryTimer = 0;
    this.angryCooldown = 8000; //  Time in ms he takes to get angry
    this.AngryDurationTimer = 0;
    this.attackDurationCooldown = 7000;  //  Time in ms he stays angry
    this.fireBallTimer = 0;
    this.attack = false;
    this.particleSystemX = x + distanceDragonFireball;

    this.particleSystemY = y+movedDistance;

    this.fireBallSpeed = 15;

    playerX = player.playerPos.x;
    playerWidthHalf = player.size.x/2;
    shieldWidth = player.shieldLeftBlueImage.width/2;

    //particlesystem fireball
    ID = "Fireball";

    movedDistance = 100;
    dragonBorder = (movedDistance / 4) * 3;
    fireballsDelay = 500;
    distanceDragonFireball = dragon.frameImage[0].width/5*4 /2;

    particleSystemStartColourR = 255;
    particleSystemStartColourG = 255;
    particleSystemStartColourB = 0;

    particleSystemEndColourR = 255;
    particleSystemEndColourG = 0;
    particleSystemEndColourB = 0;
  }

  void draw() {
    imageMode(CENTER);

    dragon.draw(x, y);
  }

  /*
 * @author Patrick
   */
  void movement(float playerY) {
    playerX = player.playerPos.x;
    if (y < playerY - dragonBorder) {
      y += speed;
    } else if (y > playerY + dragonBorder) {
      y -= speed;
    }
  }

  /*
 * @author Patrick
   * Modified by Chantal Boodt
   * Checks fireballs and their funcition (shooting)
   */
  void attack() {
    fireballAmount = player.fireball;
    if (fireballs.size()==fireballAmount) {
    } else {
      fireballAdd();
    }

    if(fireballAmount == 0) return;

    // timer that changes angry to true and draws the fireBall when angry. 
    if (millis()-angryTimer > angryCooldown  ) {
      angry = true;
      for (int i = fireballs.size()-1; i>= 0; i--) {
        ParticleSystem fireball = fireballs.get(i);
        fireball.particleID = "Fireball";
      }
      fireBallTimer = millis();
      angryTimer = millis();
      AngryDurationTimer = millis();
    } else if (angry && millis()-AngryDurationTimer > attackDurationCooldown) {
      AngryDurationTimer = millis();
      angry = false;
    }

    if (angry && millis()-fireBallTimer > fireBallDurationCooldown) {
      // Time to attack, starts spawning fireballs
      attack = true;
      canPlayAttackSound = false;
      lastFrameAttack = true;

      for (int i = fireballs.size()-1; i>= 0; i--) {
        fireballStartTimeCalc = i - 1;
        if (fireballStartTimeCalc == -1) {
          fireballStartTimeCalc = 0;
        }
        fireBallDurationCooldown = Config.FIREBALL_STARTING_TIME + (fireballStartTimeCalc * fireballsDelay);
        ParticleSystem fireball = fireballs.get(i);
        fireball.draw = true;

        //folow dragono untill shooting
        particleSystemY = y + movedDistance;
        particleSystemX = x + distanceDragonFireball;

        particleSystemsY.set(i, particleSystemY);
        particleSystemsX.set(i, particleSystemX);
      }
    }
    else
    {
      canPlayAttackSound = true;
    }

    if (attack) {
      // Attack movement
      for (int i = fireballs.size()-1; i>= 0; i--) {
        particleSystemX = particleSystemsX.get(i);
        particleSystemY = particleSystemsY.get(i);
        particleSystemX += fireBallSpeed;

        float pY = player.playerPos.y;
        
        //fireball follows player
        if(particleSystemY < pY)
        {
          particleSystemY += Config.VERTICAL_FIREBALL_SPEED;
        }
        else
        {
          particleSystemY -= Config.VERTICAL_FIREBALL_SPEED;
        }

        particleSystemsY.set(i, particleSystemY);
        particleSystemsX.set(i, particleSystemX);
      }
    }

    if(angry && angry != lastFrameAngry)
    {
      soundBank.playSound(SoundType.DRAGON_BRUL);
    }

    if(attack && lastFrameAttack == true && canPlayAttackSound)
    {
      soundBank.playSound(SoundType.FIRE_SHOOT);
      lastFrameAttack = false;
    }

    lastFrameAngry = angry;
  }

  /*
 * @author Patrick
   * Modified by Chantal Boodt
   * checks collisions and changes which particle system is used
   */
  void collision() {

    if (player.shieldIsUpLeft) {
      //shield is drawn approximatily 5 pixels from the canvas boarder
      hitX = player.shieldPos.x - (shieldWidth - approximateShieldOffset);
    } else {
      hitX = playerX - (playerWidthHalf);
    }

    for (int i = fireballs.size()-1; i>= 0; i--) {
      ParticleSystem fireball = fireballs.get(i);
      particleSystemX = particleSystemsX.get(i);
      if (particleSystemX >= hitX && particleSystemX < hitX + player.size.x && particleSystemY >= player.playerPos.y - player.size.y/2 && particleSystemY < player.playerPos.y + player.size.y/2) {
        particleSystemX = 10000;
        fireball.particleID = "Hit";
        fireball.draw =false;
        player.fireballHit();
      }
      particleSystemsX.set(i, particleSystemX);
    }
  }

  /*
 * @author Patrick
   * Modified by Chantal Boodt
   * draws the fireball arrays and checks their movement
   */
  void drawAttack() {
    if (attack) {
      for (int i = 0; i< fireballs.size(); i++)
      {
        ParticleSystem fireball = fireballs.get(i);
        fireball.particleSystemStartX  = particleSystemX;
        fireball.particleSystemStartY = particleSystemY;
        fireball.draw();
      }
    }
  }

  /*
 * @author Chantal Boodt
   * Adds new fireball to the arraylist
   */
  void fireballAdd() {
    fireballs.add(new ParticleSystem(ID, particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB, particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB, particleSystemX, particleSystemY, false));
    particleSystemsY.add(particleSystemY);
    particleSystemsX.add(particleSystemX);
  }
}
