import java.util.List;

public class Cell {
  private static final int ALL = (1 << 10) - 1;
  private static final int NONE = 0;

  public int left_bit;
  public int fix_number;

  public Cell() {
    left_bit = ALL;
    fix_number = NONE;
  }

  public boolean isFix(){
    return fix_number != 0;
  }

  public void fix(int n) {
    if (n <= 0 || 10 <= n) return;
    left_bit = 1 << n - 1;
    fix_number = n;
  }

  public void delete(int bit){
    left_bit &= ~bit;
  }

  public void clear(){
    left_bit = ALL;
    fix_number = NONE;
  }

  public void toggle(int n){
    if (n <= 0 || 10 <= n) return;
    left_bit ^= 1 << n - 1;
  }

}
