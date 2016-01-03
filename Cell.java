import java.util.List;

public class Cell {
  public static final int ALL = (1 << 9) - 1;
  public static final int NONE = 0;

  public int left_bit;
  public int fix_number;

  public Cell() {
    left_bit = ALL;
    fix_number = NONE;
  }

  private void fixCheck(){
    fix_number = Integer.bitCount(left_bit) == 1 ? Integer.numberOfTrailingZeros(left_bit) + 1 : NONE;
  }

  public boolean isFix(){
    return fix_number != 0;
  }

  public void fix(int n) {
    if (n <= 0 || 10 <= n) return;
    left_bit = 1 << n - 1;
    fix_number = n;
  }

  public void clear(){
    left_bit = ALL;
    fix_number = NONE;
  }

  public void delete(int bit){
    left_bit &= ~bit;
    fixCheck();
  }

  public void setBit(int bit){
    left_bit = bit;
    fixCheck();
  }

  public void toggle(int n){
    if (n <= 0 || 10 <= n) return;
    left_bit ^= 1 << n - 1;
    fixCheck();
  }

}
