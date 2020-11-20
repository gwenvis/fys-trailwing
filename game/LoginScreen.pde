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
  boolean rectSelected;

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
      text(nickNameHint, loginRectX-loginRectW/2+20, loginRectY+5);
    } else {
      text(nickName, loginRectX-loginRectW/2+20, loginRectY+5);
      text("Press Enter to continue.", loginRectX-20, loginRectY + loginRectH*1.2);
    }

    if ((Input.keyClicked(ENTER) || Input.keyClicked(RETURN)) && nickName != "" && nickName != "|")
    {
      gameState = "START";
    }

    //if click on textfield, highlight it
    if (mouseX >loginRectX - loginRectW/2 && mouseX < loginRectX + loginRectW/2 && mouseY > loginRectY-loginRectH/2 && mouseY < loginRectY +loginRectH/2) {
      if(Input.mouseButtonClicked(LEFT)){
      rectSelected = true;
      nickNameHint = "|";
      }
    } else {
      if(Input.mouseButtonClicked(LEFT)){
     nickNameHint = "Type nickname here...";
     rectSelected = false;
      }
    }


    // CHECKS KEY INPUT
    if (rectSelected) {
      keyInput();
    }
  }

  void keyInput() {
    char[] alphabet = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'};
    char[] alphabetCaps = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
    for (int i = 0; i < alphabet.length; i++) {
      if (Input.keyClicked(alphabet[i])) {
        nickName = nickName + alphabet[i];
      } else if (Input.keyClicked(alphabetCaps[i])) {
        nickName = nickName + alphabetCaps[i];
      } else if (Input.keyClicked(BACKSPACE) && nickName.length()>0) {
        nickName = nickName.substring( 0, nickName.length()-1 );
      }
    }
  }
}
