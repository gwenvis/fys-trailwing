class HUD {
  Player player;
  int armorlvl, score, coins;
  float coinsX, coinsY, scoreX, scoreY, armorlvlX, armorlvlY;

  HUD() {
    this.coinsX = 50;
    this.coinsY = 50;
    this.armorlvlX = 200;
    this.armorlvlY = 50;
    this.scoreX = 50;
    this.scoreY = 100;
  }


  void draw() {
    fill(0);
    textSize(20);
    text("Coins: " + coins, coinsX, coinsY);
    text("armorlvl: " + armorlvl, armorlvlX, armorlvlY);
    text("score: " + score, scoreX, scoreY);
  }

  void updateHUD(int coinAmount, int score, int armorlvl) {
    this.coins = coinAmount;
    this.score = score;
    this.armorlvl = armorlvl;
  }
}
