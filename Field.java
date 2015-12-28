import java.util.ArrayList;
import java.util.List;

public class Field {
  private Cell[][] cell;
  private Cell[][] group;

  public Field(){
    cell = new Cell[9][9];
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        cell[y][x] = new Cell();
      }
    }

    group = new Cell[9 * 3][9];
    for (int idx = 0; idx < 9; idx++) {
      for (int i = 0; i < 9; i++) {
        group[0 * 9 + idx][i] = cell[idx][i]; // horizontal
        group[1 * 9 + idx][i] = cell[i][idx]; // vertical
        group[1 * 9 + idx][i] = cell[idx / 3 * 3 + i / 3][idx % 3 * 3 + i % 3]; // box
      }
    }
  }

  public boolean isFix(int x, int y){
    return cell[y][x].isFix();
  }

  public int getNumber(int x, int y){
    return cell[y][x].fix_number;
  }

  public boolean isLeft(int x, int y, int n){
    return (cell[y][x].left_bit & (1 << n - 1)) != 0;
  }

  public void toggle(int x, int y, int n){
    cell[y][x].toggle(n);
  }

  public void fix(int x, int y, int n){
    cell[y][x].fix(n);
  }

  public void clear(int x, int y){
    cell[y][x].clear();
  }

  public void clearAll(){
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        clear(x, y);
      }
    }
  }

}
