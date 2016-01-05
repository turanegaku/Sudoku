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

  public Field(String cellstr){
    this();
    setCellString(cellstr);
  }

  public void setCellString(String cellstr){
    if (cellstr.length() != 81) return;
    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        cell[y][x] = new Cell();
        cell[y][x].fix(cellstr.charAt(y * 9 + x) - '0');
      }
    }
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

  public void clearError(int x, int y){
    error[y][x] = false;
  }

  public int getBit(int x, int y){
    return cell[y][x].getBit();
  }

  public void setBit(int x, int y, int bit){
    cell[y][x].setBit(bit);
  }

  public int getNumber(int x, int y){
    return cell[y][x].getNumber();
  }

  public boolean isLeft(int x, int y, int n){
    return (cell[y][x].getBit() & (1 << n - 1)) != 0;
  }

  public boolean checkwithreturn(){
    for(int idx = 0; idx < 9; idx++) {
      for(int i = 0; i < 9 - 1; i++) {
        for(int j = i + 1; j < 9; j++) {
          if(isFix(i, idx) && isFix(j, idx))
            if((getBit(i, idx) & getBit(j, idx)) != 0) {
              return false;
            }
          if(isFix(idx, i) && isFix(idx, j))
            if((getBit(idx, i) & getBit(idx, j)) != 0) {
              return false;
            }
          int xi = idx % 3 * 3 + i % 3;
          int yi = idx / 3 * 3 + i / 3;
          int xj = idx % 3 * 3 + j % 3;
          int yj = idx / 3 * 3 + j / 3;
          if(isFix(xi, yi) && isFix(xj, yj))
            if((getBit(xi, yi) & getBit(xj, yj)) != 0) {
              return false;
            }
        }
      }
    }
    return true;
  }

  public boolean check(){
    boolean result = true;
    for(int idx = 0; idx < 9; idx++) {
      for(int i = 0; i < 9 - 1; i++) {
        for(int j = i + 1; j < 9; j++) {
          if((getBit(i, idx) & getBit(j, idx)) != 0) {
            toError(i, idx);
            toError(j, idx);
            result = false;
          }
          if((getBit(idx, i) & getBit(idx, j)) != 0) {
            toError(idx, i);
            toError(idx, j);
            result = false;
          }
          int xi = idx % 3 * 3 + i % 3;
          int yi = idx / 3 * 3 + i / 3;
          int xj = idx % 3 * 3 + j % 3;
          int yj = idx / 3 * 3 + j / 3;
          if((getBit(xi, yi) & getBit(xj, yj)) != 0) {
            toError(xi, yi);
            toError(xj, yj);
            result = false;
          }
        }
      }
    }
    return result;
  }

  public void delete(int sx, int sy, int dx, int dy){
    cell[sy][sx].delete(cell[dy][dx].getBit());
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
