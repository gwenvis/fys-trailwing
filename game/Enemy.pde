/*
Made by Patrick Eikema
 */

/* 
 everything to do with the fireball(s) modified by Chantal 
 everything to do with the particlesystem created by Chantal
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
  int particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB, particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB, fireballAmount;
  Player player;
  boolean attack;
  float particleSystemX, particleSystemY;
  float fireBallSpeed;
  String ID;
  ArrayList<ParticleSystem> fireballs = new ArrayList<ParticleSystem>();
  ArrayList<Float> particleSystemsY = new ArrayList<Float>();
  ArrayList<Float> particleSystemsX = new ArrayList<Float>();

  ParticleSystem fireballParticleSystem;
  SpriteAnimation dragon; 



  Enemy(Player player) {

    //initialisation
    this.player = player;
    dragon = new SpriteAnimation("dragonSprites.png", 3, 8);
    this.fireBall = loadImage("fireBall.png");


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
    this.fireBallDurationCooldown = 3200;  //Time  it takes to shoot the fireBall WHEN angry. (fireBall duration = attackDurationCooldown - fireBallDurationCooldown)
    this.attack = false;
    this.particleSystemX = x + dragon.frameImage[0].width/5*4 /2;

    this.particleSystemY = y+100;

    this.fireBallSpeed = 15;


    //particlesystem fireball
    ID = "Fireball";

    particleSystemStartColourR = 255;
    particleSystemStartColourG = 255;
    particleSystemStartColourB = 0;

    particleSystemEndColourR = 255;
    particleSystemEndColourG = 0;
    particleSystemEndColourB = 0;

    //fireballParticleSystem = new ParticleSystem(ID, particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB, particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB, particleSystemX, particleSystemY, false);
  }

  void draw() {
    imageMode(CENTER);

    dragon.draw(x, y);
  }


  void movement() {
    if (y < player.playerPos.y -100) {
      y += speed;
    } else if (y > player.playerPos.y +100) {
      y -= speed;
    }
  }


  void attack() {
    fireballAmount = player.fireball;
    if (fireballs.size()==fireballAmount) {
    } else {
      fireballAdd();
    }

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
      attack = true;
      for (int i = fireballs.size()-1; i>= 0; i--) {
        fireBallDurationCooldown = 3200 + (i * 500);
        ParticleSystem fireball = fireballs.get(i);
        //particleSystemY = particleSystemsY.get(i);
        //particleSystemX = particleSystemsX.get(i);
        fireball.draw = true;

        //folow dragono untill shooting
        particleSystemY = y;
        particleSystemX = x + size/2;

        particleSystemsY.set(i, particleSystemY);
        particleSystemsX.set(i, particleSystemX);
      }
    }

    if (attack) {
      for (int i = fireballs.size()-1; i>= 0; i--) {
        particleSystemX = particleSystemsX.get(i);
        particleSystemX += fireBallSpeed;
        particleSystemsX.set(i,particleSystemX);
      }
    }
  }


  void collision() {

    if (player.shieldIsUpLeft) {
      //shield is drawn approximatily 5 pixels from the canvas boarder
      hitX = player.shieldPos.x - (player.shieldLeftBlueImage.width/2 - approximateShieldOffset);
    } else {
      hitX = player.playerPos.x - (player.size.x/2);
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
      particleSystemsX.set(i,particleSystemX);
    }
  }

  void drawAttack() {
    if (attack) {
      //imageMode(CENTER);
      //image(fireBall, particleSystemX, particleSystemY, fireBallW, fireBallH );
      for (int i = 0; i< fireballs.size(); i++)
      {
        ParticleSystem fireball = fireballs.get(i);
        fireball.particleSystemStartX  = particleSystemX;
        fireball.particleSystemStartY = particleSystemY;
        fireball.draw();
      }
      /*
      fireballParticleSystem.particleSystemStartX = particleSystemX;
       fireballParticleSystem.particleSystemStartY = particleSystemY;
       fireballParticleSystem.draw();*/
    }
  }

  void fireballAdd() {
    fireballs.add(new ParticleSystem(ID, particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB, particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB, particleSystemX, particleSystemY, false));
    particleSystemsY.add(particleSystemY);
    particleSystemsX.add(particleSystemX);
  }

  /* 
   TO DO: 
   -Make the dragon move more smoothly
   -Flying dragon sprites??
   -When the dragon flies through an obstacle, destroy it.
   -Better angry animation
   
   */
}
