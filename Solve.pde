import java.util.Set;
import java.util.HashSet;
import java.util.Map;

public class P {
  int x, y, n;
  public P(int x, int y, int n) {
    this(x, y);
    this.n=n;
  }
  public P(int x, int y) {
    this.x=x;
    this.y=y;
  }

  public String toString() {
    return x+", "+y+"  "+n;
  }
} 

public class Solve implements Runnable {
  private boolean running;
  private List<P> list;
  private int cnt;

  public Solve() {
    list=new ArrayList<P>();
  }
  public int getSize() {
    return list.size();
  }

  public void run() {
    running=true;
    for (int i=0;i<9*9;i++)
      if (cell[i/9][i%9].isDef())
        list.add(new P(i/9, i%9, cell[i/9][i%9].getNumber()));
    while (list.size ()>0) {
      while (list.size ()>0) {
        cnt++;
        P p=list.remove(0);
        for (int i=0;i<9;i++) {//Delete Define Number
          if (cell[p.x][i].delete(p.n))
            list.add(new P(p.x, i, cell[p.x][i].getNumber()));
          if (cell[i][p.y].delete(p.n))
            list.add(new P(i, p.y, cell[i][p.y].getNumber()));
          if (cell[p.x/3*3+i/3][p.y/3*3+i%3].delete(p.n))
            list.add(new P(p.x/3*3+i/3, p.y/3*3+i%3, cell[p.x/3*3+i/3][p.y/3*3+i%3].getNumber()));
          wait_(1);
        }
      }
      if (cnt<81) {//Define Only Number
        for (int n=1;n<=9;n++)
          for (int i=0;i<9;i++) {
            List<List<P>>l=new ArrayList<List<P>>();
            for (int k=0;k<3;k++)l.add(new ArrayList<P>());
            for (int j=0;j<9;j++) {
              if (cell[i][j].contains(n))
                l.get(0).add(new P(i, j, n));
              if (cell[j][i].contains(n))
                l.get(1).add(new P(j, i, n));
              if (cell[i%3*3+j%3][i/3*3+j/3].contains(n))
                l.get(2).add(new P(i%3*3+j%3, i/3*3+j/3, n));
            }
            for (int k=0;k<3;k++)
              if (l.get(k).size()==1) {
                P pp=l.get(k).get(0);
                if (cell[pp.x][pp.y].isDef())continue;
                cell[pp.x][pp.y].def(pp.n);
                list.add(pp);
                wait_(1);
              }
          }
      }
    }
    int n=check();
    switch(n) {
    case 0:
      dialog.show("Correct");
      break;
    case -1:
      dialog.show("Not Finish");
      break;
    default:
      if (0<n&&n<10)
        dialog.show("Incorrect :"+n);
      break;
    }
    running=false;
  }

  public int check() {
    int t=0;
    for (int i=0;i<9;i++) {
      List<Set<Integer>>l=new ArrayList<Set<Integer>>();
      for (int k=0;k<3;k++)l.add(new HashSet<Integer>());
      for (int j=0;j<9;j++) {
        if (cell[i][j].isDef()) {
          if (!l.get(0).contains(cell[i][j].getNumber()))
            l.get(0).add(cell[i][j].getNumber());
          else
            return cell[i][j].getNumber();
        }
        else return -1;
        if (cell[j][i].isDef()) {
          if (!l.get(1).contains(cell[j][i].getNumber()))
            l.get(1).add(cell[j][i].getNumber());
          else
            return cell[j][i].getNumber();
        }
        else return -1;
        if (cell[i/3*3+j/3][i%3*3+j%3].isDef()) {
          if (!l.get(2).contains(cell[i/3*3+j/3][i%3*3+j%3].getNumber()))
            l.get(2).add(cell[i/3*3+j/3][i%3*3+j%3].getNumber());
          else
            return cell[i/3*3+j/3][i%3*3+j%3].getNumber();
        }
        else
          t=-1;
      }
    }
    return t;
  }

  public void start() {
    cnt=0;
    if (running)
      running=false;
    else
      new Thread(this).start();
  }

  public  void stop() {
    running=false;
  }

  public void wait_(int t) {
    try {
      Thread.sleep(t);
    }
    catch(Exception e) {
    }
  }
}

public class SolveAll implements Runnable {
  private boolean running;
  private int cnt;

  public boolean allPlayAll(int loc) {
    int x=loc%9;
    int y=loc/9;
    if (loc==9*9)
      return check()==0;
    if (!cell[x][y].isDef()) {
      Integer[] num=cell[x][y].getNumbers();
      for (int n:num) {
        cell[x][y].def(n);
        if (allPlayAll(loc+1))
          return true;
      }
      cell[x][y].clear();
      cell[x][y].addAll(num);
    }
    else
      return allPlayAll(loc+1);
    return false;
  }

  public void run() {
    running=true;
    allPlayAll(0);
    println("fin");
    running=false;
  }

  public int check() {
    return solve.check();
  }

  public void start() {
    if (running)
      running=false;
    else {
      cnt=0;
      for (int i=0;i<9*9;i++)
        if (cell[i/9][i%9].isDef())
          cnt++;
      new Thread(this).start();
    }
  }

  public  void stop() {
    running=false;
  }

  public void wait_(int t) {
    try {
      Thread.sleep(t);
    }
    catch(Exception e) {
    }
  }
}

