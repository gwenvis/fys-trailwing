PImage sky, backgroundImage, clouds, cave, armor_0, armor_1, armor_2, armor_3, armor_4, armor_5, armor_6, armor_7, armor_8, startMenuBackground, backButton, hiscores, coinHUD, shieldHUD;
PFont font;
//String armor0;

public void loadAssets () {
  //Images
  sky = loadImage("data/background/sky.png");
  backgroundImage = loadImage("data/background/background2.png");
  clouds = loadImage("data/background/clouds.png");
  cave = loadImage("data/background/cave.png");
  armor_0 = loadImage("armor0.png");
  armor_1 = loadImage("armor1.png");
  armor_2 = loadImage("armor2.png");
  armor_3 = loadImage("armor3.png");
  armor_4 = loadImage("armor4.png");
  armor_5 = loadImage("armor5.png");
  armor_6 = loadImage("armor6.png");
  armor_7 = loadImage("armor7.png");
  armor_8 = loadImage("armor8.png");
  startMenuBackground = loadImage("startMenuBackground.jpg");
  backButton = loadImage("backIcon.png");
  hiscores = loadImage("hiscores.png");
  coinHUD = loadImage("coinHUD.png");
  shieldHUD = loadImage("shieldHUD.png");

  //Font
  font = createFont("Arial", 64);
}
