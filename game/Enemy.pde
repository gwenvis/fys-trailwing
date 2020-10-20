class Enemy {

  float size;
  float x, y;
  float distance;
  float attackW, attackH;
  PImage dragonSprite;
  PImage angryDragonSprite;
  PImage laser;
  boolean angry;



  Enemy() {
    this.dragonSprite = loadImage("dragonSprite.png");
    this.angryDragonSprite= loadImage("angryDragonSprite.png");
    this.laser = loadImage("Laser.png");
    this.size = 200;
    this.attackW = (width/10)*3;
    this.attackH = 50;
    this.distance = width/2+50;
    this.angry = false;
  }

  void draw(float playerX, float playerY) {
    x =  playerX - distance;

    if (!angry) {
      image(dragonSprite, x, playerY-size/2, size, size);
    } else {
      image(angryDragonSprite, x, playerY-size/2, size, size);
    }
  }


  void movement() {
  }

  void attack(float playerX, float playerY) {
    if (minute() % 1 == 0) {
      if (second() % 58 == 0 || second() % 59 == 0) {
        angry = true;
      }
    } else {
      angry = false;
    }


    if (minute() % 1 == 0 && second() % 59 == 0) {
      x =  playerX - distance;  
      image(laser, x+size, playerY-25, distance-size+30, attackH);
    }
  }
}
