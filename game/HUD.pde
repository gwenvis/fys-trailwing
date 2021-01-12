class HUD {
  Player player;
  int score, coins, shieldAmount;
  float coinsX, coinsY, scoreX, scoreY, armorX, armorY, shieldX, shieldY, coinsTextX, coinsTextY, shieldTextX, shieldTextY;
  PImage armor8, armor7, armor6, armor5, armor4, armor3, armor2, armor1, armor0, coin, shield;
  PImage currentArmor;
  color white;
  int textSize;

  HUD() {
    this.coinsX = 150;
    this.coinsY = 50;
    this.coinsTextX = 180;
    this.coinsTextY = 55;
    this.armorX = 50;
    this.armorY = 50;
    this.shieldTextX = 280;
    this.shieldTextY = 55; 
    this.shieldX = 250;
    this.shieldY = 50;
    this.scoreX = 35;
    this.scoreY = 130;
    this.armor8 = loadImage("armor8.png");
    this.armor8.resize(armor8.width/9, armor8.height/9);
    this.armor7 = loadImage("armor7.png");
    this.armor7.resize(armor7.width/9, armor7.height/9);
    this.armor6 = loadImage("armor6.png");
    this.armor6.resize(armor6.width/9, armor6.height/9);
    this.armor5 = loadImage("armor5.png");
    this.armor5.resize(armor5.width/9, armor5.height/9);
    this.armor4 = loadImage("armor4.png");
    this.armor4.resize(armor4.width/9, armor4.height/9);
    this.armor3 = loadImage("armor3.png");
    this.armor3.resize(armor3.width/9, armor3.height/9);
    this.armor2 = loadImage("armor2.png");
    this.armor2.resize(armor2.width/9, armor2.height/9);
    this.armor1 = loadImage("armor1.png");
    this.armor1.resize(armor1.width/9, armor1.height/9);
    this.armor0 = loadImage("armor0.png");
    this.armor0.resize(armor0.width/9, armor0.height/9);
    this.coin = loadImage("coinHUD.png");
    this.coin.resize(int(coin.width*0.02), int(coin.height*0.02));
    this.shield = loadImage("shieldHUD.png");
    this.shield.resize(int(shield.width*0.25), int(shield.height*0.25));
    this.white = color(255);
    this.textSize = 20;
    //
  }

   //this draws the hud on screen
  void draw() {
    fill(white);
    textSize(textSize);
    textAlign(LEFT);
    image(coin, coinsX, coinsY);
    text(coins, coinsTextX, coinsTextY);
    image(currentArmor, armorX, armorY);
    text(shieldAmount, shieldTextX, shieldTextY);
    image(shield, shieldX, shieldY);
    text("score: " + score, scoreX, scoreY);
  }
  
  //Update function
  void updateHUD(int coinAmount, int score, int armorlvl, int shieldAmount) {
    this.coins = coinAmount;
    this.score = score;
    this.shieldAmount = shieldAmount;

    switch(armorlvl) {
    case 8:
      this.currentArmor = armor0;
      break;
    case 7:
      this.currentArmor = armor1;
      break;
    case 6:
      this.currentArmor = armor2;
      break;
    case 5:
      this.currentArmor = armor3;
      break;
    case 4:
      this.currentArmor = armor4;
      break;
    case 3: 
      this.currentArmor = armor5;
      break;
    case 2:
      this.currentArmor = armor6;
      break;
    case 1:
      this.currentArmor = armor7;
      break;
    case 0:
      this.currentArmor = armor8;
      break;
    }
  }


}
