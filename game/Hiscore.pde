class Hiscore {
  PImage background;
  PImage backIcon;

  Hiscore() {
    background = loadImage("/startMenuBackground.jpg");
    background.resize(displayWidth, displayHeight);
    backIcon = loadImage("/backIcon.png");
    backIcon.resize(35,30);
  }


  void screen() {
    imageMode(CENTER);
    image(background, width/2, height/2);
    image(backIcon,30,30);
    
    
    fill(80,80,80);
    rectMode(CENTER);
    rect(width/2,height/2,width/2,height/10*8,10,10,10,10);

  }
}
