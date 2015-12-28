import java.util.List;

public class Cell {
  private static final int MASK = (1 << 10) - 1;
  private static final int ALL = 0;
  private static final int NONE = 0;

  public int left_bit;
  public int fix_number;

  public Cell() {
    left_bit = ALL;
    fixed_number = NONE;
  }

  public boolean isFix(){
    return number != 0;
  }

  public void set(int n) {
    if (n <= 0 || 10 <= n) return;
    left_bit = ~1 << n - 1 & MASK;
    fixed_number = n;
  }

  public void toggle(int n){
    if (n <= 0 || 10 <= n) return;
    status
  }

}
