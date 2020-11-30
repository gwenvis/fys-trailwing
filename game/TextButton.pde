class TextButton {
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

  TextButton(float x, float y, String text, int fontSize,color normalColor, color selectedColor, int index) {
    this.x = x;
    this.y = y;
    this.text = text;
    this.fontSize = fontSize;
    this.h = fontSize;
    this.selectedColor = selectedColor;
    this.normalColor = normalColor;
    this.index = index;
  }


  void drawTextButton() {
    this.w = textWidth(text);
    textSize(fontSize);
    textAlign(CENTER, CENTER);

    colorChange();

    text(text, x, y);
  }


  void colorChange() {
    if (selected) {
      fill(selectedColor);
    } else {
      fill(normalColor);
    }
  }
}
