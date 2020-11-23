class ButtonManager {
  ArrayList<Button> buttons;
  ButtonManager(ArrayList buttons) {
    this.buttons = buttons;
  }


  void indexSelecter() {
    for (int i = 0; i < buttons.size(); i++) {
      if (mouseX > buttons.get(i).x-buttons.get(i).w/2 && mouseX < buttons.get(i).x + buttons.get(i).w/2 && mouseY > buttons.get(i).y-buttons.get(i).h/2 && mouseY < buttons.get(i).y + buttons.get(i).h/2 && Input.mouseButtonClicked(LEFT)) {
        buttons.get(i).selected = true;
        for (int j = 0; j <buttons.size(); j++) {
          if (j != i) {
            buttons.get(j).selected = false;
          }
        }
      }
    }
  }
}
