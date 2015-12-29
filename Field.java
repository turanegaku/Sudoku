import java.util.ArrayList;
import java.util.List;

public class Field {
  private Cell[][] cell;
  private boolean [][] error;

  public Field(){
    cell = new Cell[9][9];
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        cell[y][x] = new Cell();
      }
    }
    error = new boolean [9][9];
  }

  public boolean isFix(int x, int y){
    return cell[y][x].isFix();
  }

  public boolean isError(int x, int y){
    return error[y][x];
  }

  public int getBit(int x, int y){
    return cell[y][x].left_bit;
  }

  public void setBit(int x, int y, int bit){
    cell[y][x].setBit(bit);
  }

  public int getNumber(int x, int y){
    return cell[y][x].fix_number;
  }

  public boolean isLeft(int x, int y, int n){
    return (cell[y][x].left_bit & (1 << n - 1)) != 0;
  }

  private void checkError(int x, int y, int bit){
    if(isFix(x, y) && (bit & getBit(x, y)) != 0)
      error[y][x] = true;
  }

  public void check(){
    for(int idx = 0; idx < 9; idx++) {
      int h = Cell.NONE;
      int ho = Cell.NONE;
      int v = Cell.NONE;
      int vo = Cell.NONE;
      int b = Cell.NONE;
      int bo = Cell.NONE;
      for(int i = 0; i < 9; i++) {
        if (isFix(i, idx)) {
          int bit = getBit(i, idx);
          if ((ho & bit) != 0) {
            h |= bit;
          }
          ho |= bit;
        }
        if (isFix(idx, i)) {
          int bit = getBit(idx, i);
          if ((vo & bit) != 0) {
            v |= bit;
          }
          vo |= bit;
        }
        int x = idx % 3 * 3 + i % 3;
        int y = idx / 3 * 3 + i / 3;
        if (isFix(x, y)) {
          int bit = getBit(x, y);
          if ((bo & bit) != 0) {
            b |= bit;
          }
          bo |= bit;
        }
      }
      for(int i = 0; i < 9; i++) {
        checkError(i, idx, h);
        checkError(idx, i, v);
        checkError(idx % 3 * 3 + i % 3, idx / 3 * 3 + i / 3, b);
      }
    }
    // is all cell fixed
    boolean fix = true;
    for(int y = 0; y < 9; y++) {
      for(int x = 0; x < 9; x++) {
        fix &= isFix(x, y);
      }
    }
  }

  public void delete(int sx, int sy, int dx, int dy){
    cell[sy][sx].delete(cell[dy][dx].left_bit);
  }

  public void toggle(int x, int y, int n){
    cell[y][x].toggle(n);
  }

  public void fix(int x, int y, int n){
    cell[y][x].fix(n);
  }

  public void clear(int x, int y){
    cell[y][x].clear();
    error[y][x] = false;
  }

  public void clearAll(){
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        clear(x, y);
      }
    }
  }

}
