public abstract class Solve implements Runnable {
  protected Field field;
  protected Sudoku sudoku;
  private int [][] group = new int[3][9];
  public void solve(Field field, Sudoku sudoku){
    this.field = field;
    this.sudoku = sudoku;
    new Thread(this).start();
  }

  protected int[][] getGroup(int x, int y){
    for (int i = 0; i < 9; i++) {
      group[0][i] = (y << 4) + i;   // horizontal
      group[1][i] = (i << 4) + x;   // vertical
      group[2][i] = (y / 3 * 3 + i / 3 << 4) + x / 3 * 3 + i % 3; //box
    }
    return group;
  }

  public abstract void run();
}
