import java.util.ArrayList;
import java.util.List;

public class Field {
  private Cell[][] cell;
  private int [][] group;

  public Field(){
    cell = new Cell[9][9];
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        cell[y][x] = new Cell();
      }
    }

    group = new int[3][9];
  }

  public boolean isFix(int x, int y){
    return cell[y][x].isFix();
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

  public int[][] getGroup(int x, int y){
    for (int i = 0; i < 9; i++) {
      group[0][i] = (y << 4) + i;   // horizontal
      group[1][i] = (i << 4) + x;   // vertical
      group[2][i] = (y / 3 * 3 + i / 3 << 4) + x / 3 * 3 + i % 3; //box
    }
    return group;
  }

  public boolean isLeft(int x, int y, int n){
    return (cell[y][x].left_bit & (1 << n - 1)) != 0;
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
  }

  public void clearAll(){
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        clear(x, y);
      }
    }
  }

}
