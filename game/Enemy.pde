class Enemy {

  float size;
  float x,y;
  float distance;
  float attackW, attackH;
  PImage dragonSprite;
  PImage laser;



  Enemy() {
    this.dragonSprite = loadImage("dragonSprite.png");
    this.laser = loadImage("Laser.png");
    this.size = 200;
    this.attackW = (width/10)*3;
    this.attackH = 50;
    this.distance = width/2+50;
  }

  void draw(float playerX, float playerY) {
    x =  playerX - distance;
    image(dragonSprite,x, playerY-100, size, size);
  }


  void movement() {
  }

  void attack(float playerX, float playerY) {
    if (minute() % 2 == 0 && second() % 59 == 0) {
      x =  playerX - distance;  
      image(laser, x+size, playerY-25,distance-size+30,attackH);
    }
  }
}
