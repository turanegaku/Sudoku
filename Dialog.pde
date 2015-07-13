public class Dialog {
  int t;
  String txt="";

  public void draw() {
    if (t-->0) {
      text(txt, width/2, height-10);
    }
  }

  public void show(String txt) {
    println(txt);
    this.txt=txt;
    t=120;
  }
}

