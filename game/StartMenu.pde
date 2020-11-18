//Made by Patrick Eikema

class StartMenu {
  PImage background;
  //MENU OPTIONS
  float startX, startY;
  float hiScoreX, hiScoreY;
  float quitX, quitY;
  color green;
  color red;
  color white;
  color black;
  color fillStart;
  color fillQuit;
  color fillHiScore;
  int indexSelecter;
  int textFont;
  float menuOptionH, startW, hiScoreW, quitW;
  //SOUND STUFF 
  boolean soundIsPlaying;
  PImage soundIconSmall, soundIconBig;
  PImage soundIconSmallMuted, soundIconBigMuted;
  float soundIconX, soundIconY;
  float smallSoundIconW, smallSoundIconH, bigSoundIconW, bigSoundIconH;
  boolean isSoundMuted;
  float sliderX1, sliderX2, sliderY;
  float sliderBallX, sliderBallY, sliderBallR;
  float sliderStrokeWeight;
  float distanceBall;

  //ArrayList<Button> buttons;
  // constructor for buttons = float x, float y, String text, int fontSize, int index

  StartMenu() {
    background = loadImage("/startMenuBackground.jpg");
    background.resize(displayWidth, displayHeight);

    //MENU OPTIONS
    textFont = 60;
    green = color(0, 255, 100);
    red = color(245, 42, 42);
    white = color(255);
    black = color(0);
    fillStart = color(green);
    fillQuit = color(255);
    fillHiScore = color(255);
    indexSelecter = 0;
    startX = width/2;
    startY = height/2-100;
    hiScoreX = width/2;
    hiScoreY = height/2;
    quitX = width/2;
    quitY = height/2+100;
    menuOptionH = 60;

    //SOUND STUFF
    soundIsPlaying = false;
    soundIconSmall = loadImage("/soundIconSmall.png");
    soundIconBig = loadImage("/soundIconBig.png");
    soundIconSmallMuted = loadImage("/soundIconSmallMuted.png");
    soundIconBigMuted = loadImage("/soundIconBigMuted.png");
    isSoundMuted = false;
    smallSoundIconW = 50;
    smallSoundIconH = 39;
    bigSoundIconW = 55;
    bigSoundIconH = 43;
    soundIconX = 50;
    soundIconY = height-70;
    sliderX1 = soundIconX + 70;
    sliderX2 = sliderX1+200;
    sliderY = soundIconY;
    sliderBallX = sliderX2;
    sliderBallY = sliderY;
    sliderBallR = 20;
    sliderStrokeWeight = 6;
    distanceBall = 1;


    //buttons = new ArrayList<Button>();
    //buttons.add(new Button(100,100, "START", 60, 1));
  }


  void screen() {
    //Starts the audio
    if (!soundIsPlaying && gameState == "START") { 
      backgroundMusicStartScreen.loop();
      soundIsPlaying = true;
    }  


    //background image
    imageMode(CENTER);
    image(background, width/2, height/2);

    //draws the start or quit menu options
    textSize(textFont);
    textAlign(CENTER);
    fill(fillStart);
    text("Start", startX, startY); 
    fill(fillHiScore);
    text("Hi-Scores", hiScoreX, hiScoreY);
    fill(fillQuit);
    text("Quit", quitX, quitY);
    startW = textWidth("Start");
    hiScoreW = textWidth("Hi-Scores");
    quitW = textWidth("Quit");

    //for(int i = 0; i < buttons.size(); i++){
    //  buttons.get(i).drawTextButton();
    //  }



    //drawing the sound icon, when hovering over it makes it bigger
    if (mouseX > soundIconX - smallSoundIconW/2 && mouseX < soundIconX + smallSoundIconW/2 && mouseY > soundIconY - smallSoundIconH/2 && mouseY < soundIconY + smallSoundIconH/2) {
      if (!isSoundMuted) {
        image(soundIconBig, soundIconX, soundIconY);
      } else {
        image(soundIconBigMuted, soundIconX, soundIconY);
      }
    } else {
      if (isSoundMuted) {
        image(soundIconSmallMuted, soundIconX, soundIconY);
      } else {
        image(soundIconSmall, soundIconX, soundIconY);
      }
    }

    //if hover over sound icon & click, mute it
    if (mouseX > soundIconX - smallSoundIconW/2 && mouseX < soundIconX + smallSoundIconW/2 && mouseY > soundIconY - smallSoundIconH/2 && mouseY < soundIconY + smallSoundIconH/2 && Input.mouseButtonClicked(LEFT)) {
      isSoundMuted = !isSoundMuted;
    }

    if (isSoundMuted) {
      backgroundMusicStartScreen.amp(0.0);
    } else {
      backgroundMusicStartScreen.amp(distanceBall);
    }
  } 

  //checks what option is selected and when pressed ENTER it changes the gamestate of the selected menu option
  void keyPress() {
    
  }

  //void mouseClick(){
  //  if (Input.mouseButtonClicked(LEFT) && gameState == "START" && indexSelecter == 0) {
  //    gameState = "PLAY";
  //  } else if (Input.mouseButtonClicked(LEFT) && gameState == "START" && indexSelecter == 1) {
  //    gameState = "HISCORE";
  //  } else if (Input.mouseButtonClicked(LEFT) && gameState == "START" && indexSelecter == 2) {
  //    exit();
  //  }
  //}


  void menuSelecter() {
    
    println("Enter / return clicked:" + (Input.keyClicked(ENTER) || Input.keyClicked(RETURN)));
    
    if((Input.keyClicked(ENTER) || Input.keyClicked(RETURN)) && gameState == "START")
    {
      switch(indexSelecter)
      {
        case 0:
          gameState = "PLAY";
          break;
        case 1:
          gameState = "HISCORE";
          break;
        case 2:
          exit();
          break;
        default:
          println("An error has occurred in StartMenu: menuSelecter()");
          break;
      }
    }
    
    //when 's' is clicked, go down in menu, when w is clicked it goes up
    if (Input.keyClicked('s') && indexSelecter < 2 ||Input.keyCodeClicked(DOWN) && indexSelecter < 2) {
      indexSelecter += 1;
    } else if (Input.keyClicked('w') && indexSelecter > 0|| Input.keyCodeClicked(UP) && indexSelecter > 0) {
      indexSelecter -= 1;
    }

    //changes color based on what is selected
    if (indexSelecter == 0) {
      fillStart = color(green);
    } else {
      fillStart = color(white);
    }

    if (indexSelecter == 1) {
      fillHiScore = color(green);
    } else {
      fillHiScore = color(white);
    }

    if (indexSelecter == 2) {
      fillQuit = color(red);
    } else {

      fillQuit = color(white);
    }


    //      if(mouseX > startX-startW/2 && mouseX < startX + startW/2 && mouseY > startY - menuOptionH/2 && mouseY < startY + menuOptionH/2){
    //    indexSelecter = 0;
    //  } else if(mouseX > hiScoreX-hiScoreW/2 && mouseX < hiScoreX + hiScoreW/2 && mouseY > hiScoreY - menuOptionH/2 && mouseY < hiScoreY + menuOptionH/2){
    //   indexSelecter =1; 
    //  } else if(mouseX > quitX-quitW/2 && mouseX < quitX + quitW/2 && mouseY > quitY - menuOptionH/2 && mouseY < quitY + menuOptionH/2){
    //    indexSelecter =2;
    //  }
  }


  void audioSlider() {
    distanceBall = (sliderBallX - sliderX1)/100/2;
    if (mouseX > 0 && mouseX < width/10*1.5 && mouseY > height/10*9 && mouseY < height) {
      //sliderline
      stroke(white);
      strokeWeight(sliderStrokeWeight);
      line(sliderX1, sliderY, sliderX2, sliderY);
      //sliderball
      strokeWeight(1);
      stroke(white);
      fill(black);
      ellipse(sliderBallX, sliderBallY, sliderBallR, sliderBallR);
    }

    if (Input.mouseButtonPressed(LEFT)) {
      sliderBallX = mouseX;

      //keeps sliderball in bounds
      if (sliderBallX < sliderX1) {
        sliderBallX = sliderX1;
      }
      if (sliderBallX > sliderX2) {
        sliderBallX = sliderX2;
      }
    }
  }
}
