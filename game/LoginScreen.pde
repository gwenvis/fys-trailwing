class LoginScreen implements IKeyboardCallback {
  PImage background;
  float loginTextX, loginTextY;
  float loginRectX, loginRectY, loginRectW, loginRectH;
  int loginSize;
  color black;
  color white;
  int cornerRadius;
  String nickName;
  String nickNameHint;
  color nickNameColor;
  int nickNameFontSize;
  boolean rectSelected;
  KeyboardHUD keyboardHud; 
  int hintTimer, hintCD;
  boolean hintTimerSet;
  boolean removeLetter;

  Database db;

  LoginScreen() {
    this.loginTextX = width/2;
    this.loginTextY = height/4;
    this.loginRectX = width/2;
    this.loginRectY = height/3+100;
    this.loginRectW = width/4;
    this.loginRectH = 100;
    this.loginSize = 50;
    this.cornerRadius = 3;
    this.nickName = "";
    this.nickNameHint = "Type nickname here...";
    this.nickNameColor = color(100);
    this.nickNameFontSize = 30;
    this.rectSelected = false;
    this.hintTimer = 0;
    this.hintCD = 1000;
    this.hintTimerSet = false;
    this.removeLetter = false;

    //colors
    black = color(10);
    white = color(#FAFAFA);

    //db
    db = new Database("jdbc:mysql://oege.ie.hva.nl:3306/zbottela", true, "bottela", "VKRrXbEOm#Pvqb");

    keyboardHud = new KeyboardHUD(this, new PVector(width/2-150, height - 300), 10);
    keyboardHud.position.x = width/2 - keyboardHud.getWidth() / 2;
  }

  public void onSubmit(String submittedString)
  {
    if (nickName != "" && nickName != "|")
    {
      String date = String.valueOf(year())+"-"+String.valueOf(month()+"-"+String.valueOf(day()));
      db.updateQuery(String.format("INSERT INTO player(name, created_on) VALUES('%s','%s')", nickName, date));
      gameState = "START";
    }
  }

  public void onValueChanged(String value)
  {
    nickName = value;
  }

  public void onDiscard()
  {
    nickName = "";
  }

  void screen() {
    background(black);
    textSize(loginSize);
    textAlign(CENTER);
    fill(white);
    text("Login", loginTextX, loginTextY);

    keyboardHud.update();
    keyboardHud.draw();

    //NicknameRect
    rectMode(CENTER);
    fill(white);
    if (rectSelected) {
      strokeWeight(4);
      stroke(150);
    } else {
      strokeWeight(0);
    }
    rect(loginRectX, loginRectY, loginRectW, loginRectH, cornerRadius);
    fill(nickNameColor);
    textSize(nickNameFontSize);
    textAlign(CORNER);

    if (nickName.length() == 0) {
      if (nickNameHint == "|") {
        fill(0);
      } else {
        fill(150);
      }
      text(nickNameHint, loginRectX-loginRectW/2+20, loginRectY+5);
    } else {
      fill(0);
      text(nickName, loginRectX-loginRectW/2+20, loginRectY+5);
      fill(150);
      text("Press enter to continue.", loginRectX-110, loginRectY + loginRectH*1.2);
    }


    //if click on textfield, highlight it
    if (mouseX >loginRectX - loginRectW/2 && mouseX < loginRectX + loginRectW/2 && mouseY > loginRectY-loginRectH/2 && mouseY < loginRectY +loginRectH/2) {
      if (Input.mouseButtonClicked(LEFT)) {
        rectSelected = true;
      }
    } else {
      if (Input.mouseButtonClicked(LEFT)) {
        nickNameHint = "Type nickname here...";
        rectSelected = false;
      }
    }


    // CHECKS KEY INPUT IF textbox is selected & showcases the user that he/she can write with the '|' 
    if (rectSelected) {
      if (!hintTimerSet) {
        hintTimer = millis(); 
        hintTimerSet = true;
      }
      if (millis()-hintTimer < hintCD) {
        nickNameHint = "|";
      } else if (millis()-hintTimer > hintCD && millis()-hintTimer < hintCD*2) {
        nickNameHint = "";
      } else {
        hintTimerSet = false;
      }
      keyInput();
    }
  }

  //if the user writes a letter when the textbox is selected, its copied to String: nickName
  void keyInput() {
    nickName = Keyboard.update(nickName, 11);
  }
}
