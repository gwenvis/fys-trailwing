/**
 * @author Antonio Bottelier
 *
 * Keyboard callback for all places where the keyboard hud is implemented.
 */
public interface IKeyboardCallback
{
  void onSubmit(String submittedString);
  void onValueChanged(String value);
  void onDiscard();
}
