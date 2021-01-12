import java.util.Map;

/*
 *  The input class will handle all Processing related input so they
 *  are not affected by Windows delays and will be held down the entire time.
 *  Also provides functionality for presses that happened at the moment.
 *
 *  Author: Antonio Bottelier
 */
public static class Input {

  // Generate the hashsmaps required for input handling
  private static HashMap<Character, Boolean> keyDict = new HashMap<Character, Boolean>();
  private static HashMap<Integer, Boolean> keyCodeDict = new HashMap<Integer, Boolean>();
  private static HashMap<Integer, Boolean> mouseDict = new HashMap<Integer, Boolean>();

  // Frame dependent input hashmaps
  private static HashMap<Character, Boolean> frameKeyDict = new HashMap<Character, Boolean>();
  private static HashMap<Integer, Boolean> frameKeyCodeDict = new HashMap<Integer, Boolean>();
  private static HashMap<Integer, Boolean> frameMouseDict = new HashMap<Integer, Boolean>();

  /*
   *  Check if key is currently down.
   */
  public static boolean keyPressed(char _key) {
    if (keyDict.containsKey(_key)) {
      return keyDict.get(_key);
    }

    return false;
  }

  /*
   *  Check if the key with the requested keycode is currently down.
   */
  public static boolean keyCodePressed(int keycode) {
    if (keyCodeDict.containsKey(keycode)) {
      return keyCodeDict.get(keycode);
    }

    return false;
  }

  /* 
   *  Check if the specified mouse button is currently pressed;
   *    POSSIBLE: LEFT, MIDDLE, RIGHT
   */
  public static boolean mouseButtonPressed(int mouseButton) {
    if (mouseDict.containsKey(mouseButton)) {
      return mouseDict.get(mouseButton);
    }

    return false;
  }

  /*
   *  Check if the key was clicked this frame.
   */
  public static boolean keyClicked(char key) {
    if (frameKeyDict.containsKey(key)) {
      return frameKeyDict.get(key);
    }

    return false;
  }

  /*  
   *  Check if the key code was clicked this frame.
   */
  public static boolean keyCodeClicked(int keyCode) {
    if (frameKeyCodeDict.containsKey(keyCode)) {
      return frameKeyCodeDict.get(keyCode);
    }

    return false;
  }

  /*
   *  Check if the mouse button was clicked this frame.
   */
  public static boolean mouseButtonClicked(int mouseButton) {
    if (frameMouseDict.containsKey(mouseButton)) {
      return frameMouseDict.get(mouseButton);
    }

    return false;
  }

  private static void keyCodeUpdate(int _keyCode, boolean pressed) {
    keyCodeDict.put(_keyCode, pressed);

    // if the key has been released, remove it from the frame dependent
    // hashmaps, otherwise add it.
    if (!pressed) frameKeyCodeDict.remove(_keyCode);
    else if (!frameKeyCodeDict.containsKey(_keyCode)) frameKeyCodeDict.put(_keyCode, pressed);
  }

  private static void keyUpdate(char _key, boolean pressed) {
    keyDict.put(_key, pressed);

    // if the key has been released, remove it from the frame dependent
    // hashmaps, otherwise add it.
    if (!pressed) frameKeyDict.remove(_key);
    else if (!frameKeyDict.containsKey(_key)) frameKeyDict.put(_key, pressed);
  }

  /*
   *   -- Internal Processing handlers. --
   *     these functions will update the hashmaps. 
   */
  public static void keyPressed(char _key, int coded, int _keyCode) {
    if (_key == coded)
      keyCodeUpdate(_keyCode, true);
    else keyUpdate(_key, true);
  }

  public static void keyReleased(char _key, int coded, int _keyCode) {
    if (_key == coded)
      keyCodeUpdate(_keyCode, false);
    else keyUpdate(_key, false);
  }

  public static void mousePressed(int _mouseButton) {
    mouseDict.put(_mouseButton, true);

    if (frameMouseDict.containsKey(_mouseButton))
      frameMouseDict.put(_mouseButton, false);
    else
      frameMouseDict.put(_mouseButton, true);
  }

  public static void mouseReleased(int _mouseButton) {
    mouseDict.put(_mouseButton, false);
    if (frameMouseDict.containsKey(_mouseButton)) frameMouseDict.remove(_mouseButton);
  }

  /*
   * The update() function should be called at the end of every frame
   * to clear the current frame's key input
   */
  public static void update() {
    for (HashMap.Entry<Character, Boolean> f : frameKeyDict.entrySet()) {
      frameKeyDict.put(f.getKey(), false);
    }

    for (HashMap.Entry<Integer, Boolean> f : frameKeyCodeDict.entrySet()) {
      frameKeyCodeDict.put(f.getKey(), false);
    }

    for (HashMap.Entry<Integer, Boolean> f : frameMouseDict.entrySet()) {
      frameMouseDict.put(f.getKey(), false);
    }
  }
}
