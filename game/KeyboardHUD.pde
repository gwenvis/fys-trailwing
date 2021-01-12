/**
 * @author Antonio Bottelier
 *
 * KeyboardHUD is a keyboard that is displayed on the screen
 * and is able to be controlled with a controller.
 *
 * The keyboard is implemented with an interface and has callbacks
 * when something happens so it can be displayed inside of the game.
 */
public class KeyboardHUD
{
  private final int ROW_V_MARGIN = 4;
  private final int KEY_MARGIN = 5;
  private final int KEY_WIDTH = 30;
  private final int KEY_HEIGHT = 65;
  private final String RETURN_KEY = "↵";
  private final String BACKSPACE_KEY = "«";
  private final String DISCARD_KEY = "×";
  private final String SPACE_KEY = "_";

  public PVector position;
  private IKeyboardCallback keyboardCallback;
  private String[][] keys = {
    {"q", "w", "e", "r", "t", "y", "u", "i", "o", "p"}, 
    {"a", "s", "d", "f", "g", "h", "j", "k", "l", "↵"}, 
    {"z", "x", "c", "v", "b", "n", "m", "_", "×", "«"}
  };
  private int selectedKeyX = 0;
  private int selectedKeyY = 0;

  public String value = "";
  private int limit = 0;

  public KeyboardHUD(IKeyboardCallback keyboardCallback, PVector position)
  {
    this.keyboardCallback = keyboardCallback;
    this.position = position;
    limit = -1;
  }

  public KeyboardHUD(IKeyboardCallback keyboardCallback, PVector position, int limit)
  {
    this.keyboardCallback = keyboardCallback;
    this.position = position;
    this.limit = limit;
  }

  public float getWidth()
  {
    int length = keys[0].length;
    return KEY_WIDTH * length + KEY_MARGIN * length;
  }

  public int getLimit()
  {
    return limit;
  }

  public void update()
  {
    if (Input.keyCodeClicked(UP))
    {
      selectedKeyY--;
      if (selectedKeyY < 0) selectedKeyY = keys.length - 1;
      soundBank.playSound(SoundType.BUTTON_NAVIGATE);
    } else if (Input.keyCodeClicked(DOWN))
    {
      selectedKeyY++;
      if (selectedKeyY > keys.length - 1) selectedKeyY = 0;
      soundBank.playSound(SoundType.BUTTON_NAVIGATE);
    } else if (Input.keyCodeClicked(LEFT))
    {
      selectedKeyX--;
      if (selectedKeyX < 0) selectedKeyX = keys[selectedKeyY].length - 1;
      soundBank.playSound(SoundType.BUTTON_NAVIGATE);
    } else if (Input.keyCodeClicked(RIGHT))
    {
      selectedKeyX++;
      if (selectedKeyX > keys[selectedKeyY].length - 1) selectedKeyX = 0;
      soundBank.playSound(SoundType.BUTTON_NAVIGATE);
    }

    if (Input.keyClicked('z') || Input.keyClicked('Z'))
    {
      String k = keys[selectedKeyY][selectedKeyX];

      if (k.equals(RETURN_KEY))
      {
        submit();
      } else if (k.equals(BACKSPACE_KEY))
      {
        backspace();
      } else if (k.equals(DISCARD_KEY))
      {
        discard();
        value = "";
      } else if (k.equals(SPACE_KEY))
      {
        addCharacter(" ");
      } else
      {
        addCharacter(k);
      }
    }
  }

  public void draw()
  {
    for (int i = 0; i < keys.length; i++)
    {
      float y = position.y + KEY_HEIGHT * i + ROW_V_MARGIN * i;

      for (int j = 0; j < keys[i].length; j++)
      {
        float x = position.x + KEY_WIDTH * j + KEY_MARGIN * j;
        boolean selected = i == selectedKeyY && j == selectedKeyX;

        color c = selected ? color(255, 255, 255) : color(255, 255, 255, 150);

        fill(c);
        rectMode(CORNER);
        rect(x, y, KEY_WIDTH, KEY_HEIGHT);

        stroke(0);
        fill(0);
        textSize(16);
        text(keys[i][j], x + KEY_WIDTH / 2, y + KEY_HEIGHT / 2);
      }
    }
  }

  public void discard()
  {
    keyboardCallback.onDiscard();
  }

  public void submit()
  {
    keyboardCallback.onSubmit(value);
  }

  public void backspace()
  {
    if (value.length() > 0) value = value.substring(0, value.length()-1);
    keyboardCallback.onValueChanged(value);
  }

  public void addCharacter(String character)
  {
    if ((limit == -1 || value.length() < limit))
    {
      value += character;
      keyboardCallback.onValueChanged(value);
    }
  }
}
