public class MainMenuScreen implements IScreen {
  Button[] buttons = new Button[2];
  Color normalColor = new Color(0);
  Color highlightedColor = new Color(255, 0,0);
  int currentSelectedIndex = 0;

  void setup() {
    buttons[0] = new Button("Start", new PVector(width / 2, height/2-100), normalColor, highlightedColor);
    buttons[1] = new Button("Quit", new PVector(width / 2, height/2+100), normalColor, highlightedColor);
    buttons[currentSelectedIndex].selected = true;
  }

  void draw() {
    background(255);
    textAlign(CENTER);
    textSize(64);

    boolean up = Input.keyClicked('w') || Input.keyCodeClicked(UP);
    boolean down = Input.keyClicked('s') || Input.keyCodeClicked(DOWN);
    boolean confirm = Input.keyClicked('e') || Input.keyClicked(ENTER) || Input.keyClicked(RETURN);

    if(up || down) {
      buttons[currentSelectedIndex].selected = false;
      if(down) {
        currentSelectedIndex++;
        if(currentSelectedIndex == buttons.length) currentSelectedIndex = 0;
      } else if (up) {
        currentSelectedIndex--;
        if(currentSelectedIndex == -1) currentSelectedIndex = buttons.length - 1;
      }
    }

    if(confirm) {
      switch(currentSelectedIndex) {
        case 0:
          switchScreen(new RunnerScreen());
          break;
        case 1:
          exit();
          break;
      }
    }
    
    buttons[currentSelectedIndex].selected = true;

    for(Button button : buttons) {
      button.draw();
    }
  }

  void destroy() { }
}

public class Button {
  String text;
  boolean selected = false;
  PVector position;
  Color normalColor;
  Color highlightedColor;

  Button(String text, PVector position, Color normalColor, Color highlightedColor) {
    this.text = text;
    this.position = position;
    this.normalColor = normalColor;
    this.highlightedColor = highlightedColor;
  }

  void draw() {
    Color c = selected ? highlightedColor : normalColor;
    fill(c.r, c.g, c.b);
    text(text, position.x, position.y);
  }
}

public class Color {
  float r, g, b;

  Color(float r, float g, float b) {
    this.r = r;
    this.b = b;
    this.g = g;
  }

  Color(float col) {
    this.r = col;
    this.g = col;
    this.b = col;
  }
}
