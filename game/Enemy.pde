class Enemy {

  float size;
  float x,y;
  float distance;
  float attackW, attackH;
  PImage dragonSprite;



  Enemy() {
    this.dragonSprite = loadImage("dragonSprite.png");
    this.size = 200;
    this.attackW = (width/10)*3;
    this.attackH = 50;
    this.distance = width/2+50;
  }

  void draw(float playerX, float playerY) {
    
    image(dragonSprite,0,0,20,20);
    x =  playerX - distance;
    image(dragonSprite,x, playerY-100, size, size);
  }


  void movement() {
  }

  void attack(float playerX, float playerY) {
    if (minute() % 2 == 0 && second() % 59 == 0) {
      x =  playerX - distance;  
      fill(0);
      rect(x, playerY-25,distance+30,attackH);
    }
  }
}
