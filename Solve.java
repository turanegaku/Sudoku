public abstract class Solve implements Runnable {
  Field field;
  public void solve(Field field){
    this.field = field;
    new Thread(this).start();
  }

  public abstract void run();
}
