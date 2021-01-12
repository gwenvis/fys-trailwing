class Hiscore {
  //stuff in background
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
  boolean achieved;
  boolean hiscoresSelected;
  boolean achievementsSelected;
  color hiscoresColor; 
  color achievementsColor;
  ArrayList <TextButton> titleButtons;
  ButtonManager manager;
  PFont scrollFont;


  //database stuff
  ArrayList<Session> highscoreTable;
  Table achievementsTable;

  SessionDatabase highscoredb;

  //



  Hiscore() {
    //Background stuff
    this.backgroundX = width/2;
    this.backgroundY = height/2;
    this.backgroundW = displayWidth;
    this.backgroundH = displayHeight;
    this.background = loadImage("startMenuBackground.jpg");
    this.background.resize(backgroundW, backgroundH);
    this.backIcon = loadImage("backIcon.png");
    this.scroll = loadImage("hiscores.png");
    this.backIconW = backIcon.width/10*3;
    this.backIconH = backIcon.width/10*3;
    this.backIconX = backIconW/2;
    this.backIconY = 80;

    //Everything in the scroll
    this.scrollX = width/2;
    this.scrollY = height/2;
    this.scrollW = scroll.width*1.1;
    this.scrollH = scroll.height*1.1;
    this.fontSizeTitles = 40;
    this.hiscoresX = scrollX-150;
    this.hiscoresY = scrollY-scrollH/2 + scrollH/4;
    this.achievementsX = scrollX + 150;
    this.achievementsY = hiscoresY;
    this.hiscoresSelected = false;
    this.achievementsSelected = false;
    this.hiscoresColor = color(255);
    this.achievementsColor = color(0);
    this.titleButtons = new ArrayList<TextButton>();
    this.titleButtons.add(new TextButton(achievementsX, achievementsY, "Achievements", fontSizeTitles, color(0), color(255), 0));
    this.titleButtons.add(new TextButton(hiscoresX, hiscoresY, "Hi-Scores", fontSizeTitles, color(0), color(255), 1));
    this.manager = new ButtonManager(titleButtons);

    scrollFont = createFont("highscoreFont.ttf", 60);

    //creates database connection and gets the best sessions
    highscoredb = new SessionDatabase();
    highscoreTable = highscoredb.getBestSessionsPaginated(0, 7);

    achieved = true;
  }

  void updateAchievement() {
    achievementsDb.achievementCheck(0, 0, 0, true);
    achievementsTable = achievementsDb.readPlayerAchievement();
  }


  void screen() {
    //draws the background and backicon
    imageMode(CENTER);
    image(background, backgroundX, backgroundY);
    image(backIcon, backIconX, backIconY, backIconW, backIconH);



    scroll();

    //Handles keyinputs, first checks if backspace is pressed (goes back)
    if (Input.keyClicked(ESC) || Input.keyClicked(BACKSPACE)) {
      gameState = "START"; 
      //Checks if back icon is clicked
    } else if (backIconClicked()) {
      gameState = "START";
    }
  }

  //draws the scroll  and text inside of it.
  void scroll() {
    textFont(scrollFont);
    image(scroll, scrollX, scrollY, scrollW, scrollH);
    fill(hiscoresColor);
    fill(achievementsColor);

    //manages button selection
    manager.indexSelectedKeysHorizontal();

    //draws the buttons on screen.
    for (int i = 0; i < titleButtons.size(); i++) {
      titleButtons.get(i).drawTextButton();
    }

    fill(0, 50);
    rectMode(CENTER);

    //checks which button is selected and prints according table
    if (titleButtons.get(1).selected == true) {
      //highscore button selected
      printTable(highscoreTable);
      achieved = true;
    }

    if (titleButtons.get(0).selected == true) {
      //Achievements button selected
      if (achieved) {
        achieved = false;
      }
      printAchievementTable();
    }
  }




  //returns true if back icon is clicked
  boolean backIconClicked() {
    if (Input.mouseButtonClicked(LEFT) && mouseX > backIconX-backIconW/2 && mouseX < backIconX + backIconW/2 && mouseY > backIconY - backIconH/2 && mouseY < backIconY + backIconH/2) {
      return true;
    }
    return false;
  }


  /*
  * show the best sessions on screen
   */
  void printTable(ArrayList<Session> table) {
    textSize(30);
    fill(0);
    textAlign(CENTER);

    text("NAME", width/2-200, 350);
    text("HIGHSCORE", width/2, 350);
    text("COINS", width/2+200, 350);
    text("COINS", width/2+200, 350);


    textSize(40);
    for (int i = 0; i < table.size(); i++) {
      text(table.get(i).getPlayer(), width/2-200, 420 + 50 * i);
      text(table.get(i).getDistance(), width/2, 420 + 50 * i);
      text(table.get(i).getCoins(), width/2+200, 420 + 50 * i);
    }
  }

  /*
   * Show the achieved achievements (by the current player) on screen
   */
  void printAchievementTable() {    
    textSize(30);
    fill(0);
    textAlign(CENTER);

    text("NAME "+ playerdb.nickName, width/2, 310);

    textAlign(LEFT);
    text("ACHIEVEMENT", width/2-245, 390);
    text("DATE", width/2+100, 390);


    for (int i =0; i< achievementsTable.getRowCount(); i++) {
      TableRow row = achievementsTable.getRow(i);  
      for (int j = 0; j<row.getColumnCount(); j++) {
        text(row.getString(j), width/2-245 +(350 *j), 450 + (50 *i));
      }
    }
  }
}
