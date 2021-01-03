//Made by Patrick, modified by Anton

class LoginScreen implements IKeyboardCallback {
  PImage background;
  float loginTextX, loginTextY, nickNameHintX, nickNameHintY, nickNameTextX, nickNameTextY, pressEnterTextX, pressEnterTextY;
  float loginRectX, loginRectY, loginRectW, loginRectH, loginStrokeWeight, loginStroke;
  int loginSize;
  color black;
  color white;
  color grey;
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



  LoginScreen() {
    this.loginTextX = width/2;
    this.loginTextY = height/4;
    this.loginRectX = width/2;
    this.loginRectY = height/3+100;
    this.loginRectW = width/4;
    this.loginRectH = 100;
    this.nickNameHintX = loginRectX-loginRectW/2+20;
    this.nickNameHintY = loginRectY+5;
    this.nickNameTextX = loginRectX-loginRectW/2+20;
    this.nickNameTextY = loginRectY+5;
    this.pressEnterTextX = loginRectX-110;
    this.pressEnterTextY = loginRectY + loginRectH*1.2;
    this.loginStrokeWeight = 4;
    this.loginStroke = 150;
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
    grey = color(150);
   
    keyboardHud = new KeyboardHUD(this, new PVector(width/2-150, height - 300), 10);
    keyboardHud.position.x = width/2 - keyboardHud.getWidth() / 2;
  }
  
  //writes nickname to db
  public void onSubmit(String submittedString)
  {
    if (nickName != "" && nickName != "|")
    {
      playerdb.login(nickName);
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

    //textBox
    rectMode(CENTER);
    fill(white);
    if (rectSelected) {
      strokeWeight(loginStrokeWeight);
      stroke(loginStroke);
    } else {
      strokeWeight(0);
    }
    rect(loginRectX, loginRectY, loginRectW, loginRectH, cornerRadius);
    fill(nickNameColor);
    textSize(nickNameFontSize);
    textAlign(CORNER);

    // Makes a flashing '|' when textbox is selected, and if not selected gives a hint. also checks if theres a typed nickname and tells how to continue
    if (nickName.length() == 0) {
      if (nickNameHint == "|") {
        fill(black);
      } else {
        fill(grey);
      }
      text(nickNameHint, nickNameHintX,nickNameHintY);
    } else {
      fill(black);
      text(nickName, nickNameTextX,nickNameTextY);
      fill(grey);
      text("Press 'z' on empty square to continue.", pressEnterTextX,pressEnterTextY );
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
