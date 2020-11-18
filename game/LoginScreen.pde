class LoginScreen {
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

    //colors
    black = color(10);
    white = color(#FAFAFA);
  }

  void screen() {
    background(black);
    textSize(loginSize);
    textAlign(CENTER);
    fill(white);
    text("Login", loginTextX, loginTextY);

    //NicknameRect
    rectMode(CENTER);
    fill(white);
    rect(loginRectX, loginRectY, loginRectW, loginRectH, cornerRadius);
    fill(nickNameColor);
    textSize(nickNameFontSize);
    textAlign(CORNER);

    if (nickName == "") {
      text(nickNameHint, loginRectX-loginRectW/2+20, loginRectY+5);
    } else {
      text(nickName, loginRectX-loginRectW/2+20, loginRectY+5);
    }
    
    if(Input.keyClicked(ENTER) || Input.keyClicked(RETURN))
    {
      gameState = "START";
    }
  }

  void keyPress() {
    if (key != ENTER && key != BACKSPACE) {
      nickName = nickName + key;
    } else if (key == BACKSPACE) {
      nickName = nickName.substring( 0, nickName.length()-1 );
    }
  }
}
