import java.util.List;

final int CELL_SIZE=50;

public class Cell {
  private List<Integer>l;
  boolean isdef;

  public Cell() {
    l=new ArrayList<Integer>();
    for (int i=1;i<10;i++)
      l.add(i);
    isdef=false;
  }

  public void def(int n) {
    if (n<=0||10<=n)return;
    l.clear();
    l.add(n);
    isdef=true;
  }
  public boolean isDef() {
    return isdef;
  }
  private void setDef() {
    isdef=l.size()==1;
  }

  public void clear() {
    isdef=false;
    l.clear();
  }

  public void addAll(Integer[] n) {
    for (int m:n)
      l.add(m);
    setDef();
  }

  public boolean delete(int n) {
    if (this.isDef())return false;
    if (contains(n)) {
      l.remove(l.indexOf(n));
      setDef();
      return isDef();
    }
    return false;
  }

  public boolean contains(int n) {
    return l.contains(n);
  }
  public Integer getNumber() {
    if (!isDef())return null;
    return l.get(0);
  }
  public Integer[] getNumbers() {
    return l.toArray(new Integer[0]);
  }
}

