//Made by Anton and Patrick

public static class Keyboard
{
  public static String update(String s)
  {
    char[] alphabet = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', ' ', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', '!', '?'};
    char[] alphabetCaps = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', ' ', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '!', '?'};
    for (int i = 0; i < alphabet.length; i++) {
      if (Input.keyClicked(alphabet[i])) {
        s = s + alphabet[i];
      } else if (Input.keyClicked(alphabetCaps[i])) {
        s = s + alphabetCaps[i];
      } else if (Input.keyClicked(BACKSPACE) && s.length()>0) {
        return s.substring( 0, s.length()-1 );
      }
    }

    return s;
  }
}
