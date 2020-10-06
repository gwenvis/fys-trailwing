class Player {
  private int playerHP, angle;
  private PVector playerPos;
  private float playerSpeed, jumpTopY, jumpPower, jumpGravity, playerStartY;
  boolean jump, fall, shieldIsUp;
  PImage image;

  Player(float x, float y) {
    playerPos = new PVector(0, 0);
    playerPos.x = x;
    playerPos.y = y;
    playerStartY = playerPos.y;
    jumpTopY = playerPos.y - 120;
    jumpPower = -4.5f;
    jumpGravity = 4.5f;
    //playerHP = 100;
    playerSpeed = 5;
    //angle = 0;
    jump=false;
    fall=false;
    shieldIsUp=false;
    image = loadImage("Jojo_1.png");
  }
  
  void init(){
    draw();
    move();
    shield();
  }
  
  void draw() {
    update();
    //rect(playerX, playerY, 50, 50);
    image(image, playerPos.x, playerPos.y);
    image.resize(100, 100);
  }

  void update() {
    if (jump) {
      jump();
    }
  }

  void move() {
    if (Input.keyCodePressed(LEFT)) {
      playerPos.x-=playerSpeed;
      image = loadImage("Jojo_1.png");
      image.resize(100, 100);
    }
    if (Input.keyCodePressed(RIGHT)) {
      playerPos.x+=playerSpeed;
      image = loadImage("Jojo_1.png");
      image.resize(100, 100);
    }
    if (Input.keyCodePressed(UP)) {
      // if keypressed is arrow up then jump is true
      jump = true;
    }
    /*if (keyCode == DOWN) {
     playerY+=playerSpeed;
     image = loadImage("Jojo_2.png");
     //image.resize(1000, 1000);
     }*/
    if (Input.keyCodePressed(CONTROL)) {
      shieldIsUp = true;
      shield();
    }
  }

  void jump() {
    if (playerPos.y>jumpTopY && !fall) {
      playerPos.y += jumpPower;
    } else if (playerPos.y <= jumpTopY) {
      playerPos.y += jumpGravity;
      fall=true;
    } else if (playerPos.y>=playerStartY && fall) {
      jump=false;
      fall=false;
      keyCode = 0;
    } else {
      playerPos.y += jumpGravity;
    }
  }

  void shield() {
    if (shieldIsUp == true) {
      rect(playerPos.x+100, playerPos.y, 10, 100);
    }
  }
}
