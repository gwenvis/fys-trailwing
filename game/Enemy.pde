/*
Made by Patrick Eikema
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
  int particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB, particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB;
  Player player;
  boolean attack;
  float particleSystemX, particleSystemY;
  float fireBallSpeed;
  String ID;

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
    this.attackDurationCooldown = 4000;  //  Time in ms he stays angry
    this.fireBallTimer = 0;
    this.fireBallDurationCooldown = 3200;  //Time  it takes to shoot the fireBall WHEN angry. (fireBall duration = attackDurationCooldown - fireBallDurationCooldown)
    this.attack = false;
    this.particleSystemX = x + dragon.frameImage[0].width/5*4 /2;
    //this.particleSystemY = y + size/2;

    this.particleSystemY = y;

    this.fireBallSpeed = 15;
    //this.fireBallW = fireBall.width/6;
    //this.fireBallH = fireBall.height/6;

    //particlesystem fireball
    ID = "Fireball";

    particleSystemStartColourR = 255;
    particleSystemStartColourG = 255;
    particleSystemStartColourB = 0;

    particleSystemEndColourR = 255;
    particleSystemEndColourG = 0;
    particleSystemEndColourB = 0;

    fireballParticleSystem = new ParticleSystem(ID, particleSystemStartColourR, particleSystemStartColourG, particleSystemStartColourB, particleSystemEndColourR, particleSystemEndColourG, particleSystemEndColourB, particleSystemX, particleSystemY, false);
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



    // timer that changes angry to true and draws the fireBall when angry. 
    if (millis()-angryTimer > angryCooldown  ) {
      angry = true;
      fireballParticleSystem.particleID = "Fireball";
      fireBallTimer = millis();



      angryTimer = millis();
      AngryDurationTimer = millis();
    } else if (angry && millis()-AngryDurationTimer > attackDurationCooldown) {
      AngryDurationTimer = millis();
      angry = false;
    }

    if (angry && millis()-fireBallTimer > fireBallDurationCooldown) {
      attack = true;
      fireballParticleSystem.draw = true;

      //folow dragono untill shooting
      particleSystemY = y;
      particleSystemX = x + dragon.frameImage[0].width/5*4 /2;
    }

    if (attack) {
      particleSystemX += fireBallSpeed;
    }
  }


  void collision() {

    // if (particleSystemX + fireBallW/2 > player.playerPos.x - player.size.x/2 && particleSystemX - fireBallW/2 < player.playerPos.x + player.size.x/2 && particleSystemY + fireBallH/2 > player.playerPos.y - player.size.y/2 && particleSystemY - fireBallH/2 < player.playerPos.y + player.size.y/2) {
    if (player.shieldIsUpLeft) {
      //shield is drawn approximatily 5 pixels from the canvas boarder
      hitX = player.shieldPos.x - (player.shieldLeftBlueImage.width/2 - approximateShieldOffset);
    } else {
      hitX = player.playerPos.x - (player.size.x/2);
    }

    //checks collision between fireball and player
    if (particleSystemX >= hitX && particleSystemX < hitX + player.size.x && particleSystemY >= player.playerPos.y - player.size.y/2 && particleSystemY < player.playerPos.y + player.size.y/2) {
      particleSystemX = 10000;
      fireballParticleSystem.particleID = "Hit";
      fireballParticleSystem.draw =false;
      player.fireballHit();
    }
  }

  void drawAttack() {
    if (attack) {
      //imageMode(CENTER);
      //image(fireBall, particleSystemX, particleSystemY, fireBallW, fireBallH );
      fireballParticleSystem.particleSystemStartX = particleSystemX;
      fireballParticleSystem.particleSystemStartY = particleSystemY;
      fireballParticleSystem.draw();
    }
  }

  /* 
   TO DO: 
   -Make the dragon move more smoothly
   -Flying dragon sprites??
   -When the dragon flies through an obstacle, destroy it.
   -Better angry animation
   
   */
}
