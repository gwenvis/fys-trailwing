class HUD {
  Player player;
  int score, coins, shieldAmount;
  float coinsX, coinsY, scoreX, scoreY, armorX, armorY, shieldX, shieldY, coinsTextX, coinsTextY, shieldTextX, shieldTextY;
  PImage coin, shield;
  PImage currentArmor;
  color white;
  int textSize;
  PImage[] armor;


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
    armor = new PImage[9];
    
    for(int i = 0; i < 9; i ++){
     armor[i] = loadImage("armor"+i+".png"); 
     armor[i].resize(armor[i].width/9, armor[i].height/9);
    }
    
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
    
    currentArmor = armor[armorlvl];
    
  }


}
