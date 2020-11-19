class Hiscore {
  PImage background;
  PImage backIcon;
  PImage scroll;
  float backgroundX, backgroundY;
  int backgroundW, backgroundH;
  float backIconX, backIconY, backIconW, backIconH;
  //things in scroll
  float scrollX, scrollY, scrollW, scrollH;
  int fontSizeTitles;
  float hiscoresX;
  float hiscoresY;
  float achievementsX;
  float achievementsY;
  boolean hiscoresSelected;
  boolean achievementsSelected;
  color hiscoresColor; 
  color achievementsColor;
  ArrayList <Button> titleButtons;
  ButtonManager manager;

  Hiscore() {
    this.backgroundX = width/2;
    this.backgroundY = height/2;
    this.backgroundW = displayWidth;
    this.backgroundH = displayHeight;
    this.background = loadImage("startMenuBackground.jpg");
    this.background.resize(backgroundW, backgroundH);
    this.backIcon = loadImage("backIcon.png");
    this.scroll = loadImage("hiscores.png");
    this.backIconX = 40;
    this.backIconY = 40;
    this.backIconW = backIcon.width/10;
    this.backIconH = backIcon.width/11;
    this.scrollX = width/2;
    this.scrollY = height/2;
    this.scrollW = scroll.width*1.7;
    this.scrollH = scroll.height*1.7;
    this.fontSizeTitles = 40;
    this.hiscoresX = scrollX-150;
    this.hiscoresY = scrollY-scrollH/2 + scrollH/4;
    this.achievementsX = scrollX + 150;
    this.achievementsY = hiscoresY;
    this.hiscoresSelected = false;
    this.achievementsSelected = false;
    this.hiscoresColor = color(255);
    this.achievementsColor = color(0);
    this.titleButtons = new ArrayList<Button>();
    this.titleButtons.add(new Button(achievementsX, achievementsY, "Achievements", fontSizeTitles, 0));
    this.titleButtons.add(new Button(hiscoresX, hiscoresY, "Hi-Scores", fontSizeTitles, 1));
    this.manager = new ButtonManager(titleButtons);
  }


  void screen() {
    imageMode(CENTER);
    image(background, backgroundX, backgroundY);
    image(backIcon, backIconX, backIconY, backIconW, backIconH);

    scroll();

    //Handles keyinputs, first checks if backspace is pressed (goes back)
    if (Input.keyClicked(BACKSPACE)) {
      gameState = "START"; 
      //Checks if back icon is clicked
    } else if (backIconClicked()) {
      gameState = "START";
    }
  }

  void scroll() {

    image(scroll, scrollX, scrollY, scrollW, scrollH);
    fill(hiscoresColor);
    fill(achievementsColor);
    
    manager.indexSelecter();
    
    for (int i = 0; i < titleButtons.size(); i++) {
      titleButtons.get(i).drawTextButton();
      }

    }
    
    
  

  //returns true if back icon is clicked
  boolean backIconClicked() {
    if (Input.mouseButtonClicked(LEFT) && mouseX > backIconX-backIconW/2 && mouseX < backIconX + backIconW/2 && mouseY > backIconY - backIconH/2 && mouseY < backIconY + backIconH/2) {
      return true;
    }
    return false;
  }


  //returns true is achievements is clicked
  //boolean achievementClicked(){
  //  if(Input.mouseButtonClicked(LEFT) && 
  //}
}
