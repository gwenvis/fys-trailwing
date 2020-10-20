class Player {
  private int playerHP, angle;
  private PVector playerPos;
  private PVector size = new PVector(100, 100); 
  private float playerSpeed, jumpTopY, jumpPower, jumpGravity, playerStartY;
  boolean jump, fall, shieldIsUp;
  PImage image;

  Player(float x, float y) {
    playerPos = new PVector(0, 0);
    playerPos.x = x;
    playerPos.y = y;
    playerStartY = playerPos.y;
    jumpTopY = playerPos.y - Config.PLAYER_JUMP_OFFSET;
    jumpPower = Config.PLAYER_JUMP_POWER;
    jumpGravity = Config.PLAYER_JUMP_GRAVITY;
    //playerHP = 100;
    playerSpeed = Config.PLAYER_SPEED;
    //angle = 0;
    jump=false;
    fall=false;
    shieldIsUp=false;
    image = loadImage("Jojo_1.png");
    image.resize((int)size.x, (int)size.y);
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
  }

  void update() {
    if (jump) {
      jump();
    }
  }

  void move() {
    if (Input.keyCodePressed(LEFT)) {
      playerPos.x-=playerSpeed;
    }
    if (Input.keyCodePressed(RIGHT)) {
      playerPos.x+=playerSpeed;
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
    } else {
      playerPos.y += jumpGravity;
    }
  }

  void givePowerUp(PowerupType type) {
    switch(type){
      case INVINCIBILITY:
        println("invincinibitly");
        break;
      case SUPER_JUMP:
        println("super mump");
        break;
    }
  }

  void shield() {
    if (shieldIsUp) {
      rect(playerPos.x+Config.SHIELD_OFFSET_X, playerPos.y, Config.SHIELD_WIDTH, Config.SHIELD_HEIGHT);
    }
  }
}
