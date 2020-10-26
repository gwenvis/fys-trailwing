/*
Made by Patrick Eikema
 */

class Enemy {
  float speed;
  float size;
  float x, y;
  float distance;
  float attackW, attackH;
  PImage dragonSprite;
  PImage angryDragonSprite;
  PImage laser;
  boolean angry;
  int attackTimer, attackCooldown;
  int attackDurationTimer, attackDurationCooldown;
  int laserTimer, laserDurationCooldown;
  Player player;



  Enemy(Player player) {
    //initialisation
    this.player = player;
    this.dragonSprite = loadImage("dragonSprite.png");
    this.angryDragonSprite= loadImage("angryDragonSprite.png");
    this.laser = loadImage("Laser.png");

    //Size & pos
    this.x = 150;
    this.y = player.playerPos.y -5;
    this.speed = 4;
    this.size = 200;
    this.attackW = (width/10)*3;
    this.attackH = 50;
    //this.distance = width/2+50;
    
    //attackvariables
    this.angry = false;
    this.attackTimer = 0;
    this.attackCooldown = 8000; //  Time in ms he takes to get angry
    this.attackDurationTimer = 0;
    this.attackDurationCooldown = 4000;  //  Time in ms he stays angry
    this.laserTimer = 0;
    this.laserDurationCooldown = 3200;  //Time  it takes to shoot the laser WHEN angry. (Laser duration = attackDurationCooldown - laserDurationCooldown)
  }

  void draw() {
    imageMode(CENTER);

    if (!angry) {
      image(dragonSprite, x, y, size, size);
    } else {
      image(angryDragonSprite, x, y, size, size);
    }
  }


  void movement() {
    if (y < player.playerPos.y -20) {
      y += speed;
    } else if (y > player.playerPos.y +20) {
      y -= speed;
    }
  }


  void attack() {

    imageMode(CORNER);


    // timer that changes angry to true and draws the laser when angry. 
    if (millis()-attackTimer > attackCooldown  ) {
      angry = true;
      laserTimer = millis();



      attackTimer = millis();
      attackDurationTimer = millis();
    } else if (angry && millis()-attackDurationTimer > attackDurationCooldown) {
      attackDurationTimer = millis();
      attackTimer = millis();
      angry = false;
    }

    if (angry) {
      if (millis()-laserTimer > laserDurationCooldown) {
        this.distance = player.playerPos.x - x;
        image(laser, x+size/2, y, distance-size/2, attackH);
      }
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
