public class Dialog {
  int x, y, t;
  String txt = "";

  public Dialog(int x, int y){
    this.x = x;
    this.y = y;
  }

  public void draw() {
    if (t-- > 0) {
      text(txt, x, y);
    }
  }

  public void show(String txt) {
    println(txt);
    this.txt = txt;
    t = 120;
  }
}
