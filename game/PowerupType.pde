enum PowerupType { 
    INVINCIBILITY(0),
    SUPER_JUMP(1);
  
    private final int value;
    private PowerupType(int value) { this.value = value; }
    private int getValue() { return value; }
}
