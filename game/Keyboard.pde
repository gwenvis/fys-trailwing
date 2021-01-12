/*
  * @author Patrick
 * limit added by Antonio
 */
public static class Keyboard
{
  public static String update(String s, int limit)
  {
    char[] alphabet = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', ' ', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '!', '?'};
    char[] alphabetCaps = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', ' ', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '!', '?'};
    for (int i = 0; i < alphabet.length; i++) {
      if (Input.keyClicked(alphabet[i]) && (s.length() < limit || limit == -1)) {
        s = s + alphabet[i];
      } else if (Input.keyClicked(alphabetCaps[i]) && (s.length() < limit || limit == -1)) {
        s = s + alphabetCaps[i];
      } else if (Input.keyClicked(BACKSPACE) && s.length()>0) {
        return s.substring( 0, s.length()-1 );
      }
    }

    return s;
  }

  public static String update(String s) { 
    return update(s, -1);
  }
}
