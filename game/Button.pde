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
    this.h = fontSize;
    this.selectedColor = color(255);
    this.normalColor = color(0);
  }


  void drawTextButton() {
    this.w = textWidth(text);
    textSize(fontSize);
    textAlign(CENTER, CENTER);

    if (selected) {
      fill(selectedColor);
    } else {
      fill(normalColor);
    }

    text(text, x, y);

  }
}
