class Button {
  float x, y, w, h;
  String text;
  PImage sprite;
  int index;
  int fontSize;
  boolean selected;
  color normalColor;
  color selectedColor;
  //mouseover sprite
  //mouseover text & clicktext

  Button(float x, float y, String text, int fontSize, int index) {
    this.x = x;
    this.y = y;
    this.text = text;
    this.fontSize = fontSize;
    this.index = index;
    this.w = textWidth(text);
    this.h = fontSize;
  }


  void drawTextButton() {
    
    textSize(fontSize);
    textAlign(CENTER);
    fill(255);
    text(text, x, y);
  }

  void mouseOverButton() {
    if (mouseX > x-w/2 && mouseX < x + w/2 && mouseY > y-h/2 && mouseY < y + h/2) {
      println("nu wel!");
    }
  }
}
