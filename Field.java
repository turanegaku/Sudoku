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

  public void toError(int x, int y){
    error[y][x] = true;
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

  public void check(){
    for(int idx = 0; idx < 9; idx++) {
      int ha = Cell.ALL;
      int va = Cell.ALL;
      int ba = Cell.ALL;
      int ho = Cell.NONE;
      int vo = Cell.NONE;
      int bo = Cell.NONE;
      int hp = Cell.NONE;
      int vp = Cell.NONE;
      int bp = Cell.NONE;
      for(int i = 0; i < 9; i++) {
        ho |= getBit(i, idx);
        hp += getBit(i, idx);
        ha &= getBit(i, idx);
        vo |= getBit(idx, i);
        vp += getBit(idx, i);
        va &= getBit(idx, i);
        int x = idx % 3 * 3 + i % 3;
        int y = idx / 3 * 3 + i / 3;
        bo |= getBit(x, y);
        bp += getBit(x, y);
        ba &= getBit(x, y);
      }
      if ( ho != Cell.ALL || hp != Cell.ALL || ha != Cell.NONE) {
        int bit = Cell.NONE;
        for(int i = 0; i < 9; i++) {
          toError(i, idx);
        }
      }
      if ( vo != Cell.ALL || vp != Cell.ALL || va != Cell.NONE) {
        for(int i = 0; i < 9; i++) {
          toError(idx, i);
        }
      }
      if ( bo != Cell.ALL || bp != Cell.ALL || ba != Cell.NONE) {
        for(int i = 0; i < 9; i++) {
          int x = idx % 3 * 3 + i % 3;
          int y = idx / 3 * 3 + i / 3;
          toError(x, y);
        }
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
