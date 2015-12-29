import java.util.HashSet;
import java.util.Set;

public class SolveDelete extends Solve {
  public void run(){
    Set<Integer> delete = new HashSet<>();
    Set<Integer> check = new HashSet<>();
    boolean[][] used = new boolean[9][9];

    for (int y = 0; y < 9; y++) {
      for (int x = 0; x < 9; x++) {
        if (field.isFix(x, y)) {
          delete.add((y << 4) + x);
        }
      }
    }

    while(delete.size() + check.size() > 0) {
      for(int p : delete) {
        int x = p & 0xf, y = p >> 4;
        used[y][x] = true;
        int[][] groups = field.getGroup(x, y);
        for(int[] group : groups) {
          for(int q : group) {
            if (p == q) continue;
            int sx = q & 0xf, sy = q >> 4;
            field.delete(sx, sy, x, y);
            check.add(q);
          }
        }
      }
      delete.clear();
      for(int p : check) {
        int x = p & 0xf, y = p >> 4;
        // field.delete(x, y);
        int[][] groups = field.getGroup(x, y);
        for(int[] group : groups) {
          int bit = ~0;
          for(int q : group) {
            int sx = q & 0xf, sy = q >> 4;
            int b = field.getBit(sx, sy);
            bit &= p == q ? b : ~b;
          }
          if(bit != 0) {
            field.setBit(x, y, bit);
            delete.add(p);
          }
        }
      }
      check.clear();
    }
  }
}
