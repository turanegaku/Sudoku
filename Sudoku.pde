Solve solve;
SolveAll solveAll;
Dialog dialog;
Cell cell[][];
PFont f1, f2;
String name;
int sx, sy;

void setup() {
  size(CELL_SIZE*9, CELL_SIZE*9+50);

  sx=sy=0;
  solve=new Solve();
  solveAll=new SolveAll();
  dialog=new Dialog();
  cell=new Cell[9][9];
  for (int i=0;i<9*9;i++)cell[i/9][i%9]=new Cell();
  f1=createFont("ComicSansMS", 25);
  f2=createFont("ComicSansMS", 10);

  textAlign(CENTER);
}

public void saverequest(String nam) {
  this.name=nam;
}

void draw() {
  background(#cccccc);
  strokeWeight(1);
  for (int x=0;x<9;x++)
    for (int y=0;y<9;y++) {
      fill(sx==x&&sy==y?#ccccff:#ffffff);
      rect(CELL_SIZE*x, CELL_SIZE*y, CELL_SIZE, CELL_SIZE);
      fill(0);
      Integer[] l=cell[x][y].getNumbers();
      if (l.length==1) {
        textFont(f1);
        if (l[0]!=null)
          text(l[0], CELL_SIZE*x+CELL_SIZE/2, CELL_SIZE*y+CELL_SIZE*3/4);
      }
      else {
        textFont(f2);
        for (int i=0;i<l.length;i++)
          if (l[i]!=null)
            text(l[i], CELL_SIZE*x+CELL_SIZE/3*(i%3)+CELL_SIZE/5, CELL_SIZE*y+CELL_SIZE/3*(i/3)+CELL_SIZE/4);
      }
    }
  noFill();
  strokeWeight(5);
  for (int x=0;x<9;x+=3)
    for (int y=0;y<9;y+=3)
      rect(CELL_SIZE*x, CELL_SIZE*y, CELL_SIZE*3, CELL_SIZE*3);

  fill(0);
  textFont(f1);
  if (solve.running)
    text("solving :"+nf(solve.getSize(), 2, 0), width/2, height-10);
  dialog.draw();
}

public void mousePressed(java.awt.event.MouseEvent e) {
  int nx=mouseX/CELL_SIZE;
  int ny=mouseY/CELL_SIZE;
  if (ny>=9) {
    sx=sy=-1;
    solve.start();
    return;
  }
  if (sx==nx&&sy==ny)
    sx=sy=-1;
  else {
    sx=nx;
    sy=ny;
  }
}

public void keyPressed(java.awt.event.KeyEvent e) {
  int code=e.getKeyCode();
  if (code==ESC) {
    sx=sy=sx+sy<0?0:-1;
    return;
  }
  if (code==ENTER) {
    if ((e.getModifiers()&java.awt.event.ActionEvent.CTRL_MASK)==java.awt.event.ActionEvent.CTRL_MASK) {
      solveAll.start();
    }
    else
      solve.start();
    return;
  }
  if (code==DELETE) {
    solve.stop();
    for (int i=0;i<9*9;i++)cell[i/9][i%9]=new Cell();
    return;
  }
  if (code==BACKSPACE) {
    cell[sx][sy]=new Cell();
    return;
  }
  if (code=='C'&&!solve.running) {
    solve.check();
    return;
  }
  if (code=='S') {
    for (int y=0;y<9;y++)
      for (int x=0;x<9;x++)
        if (cell[x][y].isDef())
          println("cell["+x+"]["+y+"].def("+cell[x][y].getNumber()+");");
  }
  if (code=='Q') {
    for (int i=0;i<9*9;i++)cell[i/9][i%9]=new Cell();
    cell[1][0].def(3);
    cell[6][0].def(8);
    cell[0][1].def(9);
    cell[7][1].def(3);
    cell[2][2].def(8);
    cell[8][2].def(7);
    cell[2][3].def(7);
    cell[0][4].def(1);
    cell[4][4].def(8);
    cell[7][4].def(2);
    cell[4][5].def(4);
    cell[5][5].def(3);
    cell[6][5].def(6);
    cell[8][5].def(9);
    cell[0][6].def(7);
    cell[2][6].def(1);
    cell[3][6].def(9);
    cell[3][7].def(7);
    cell[4][7].def(5);
    cell[7][7].def(4);
    cell[1][8].def(4);
    cell[4][8].def(1);
    cell[7][8].def(9);
    cell[8][8].def(2);
    return;
  }
  if (code=='W') {
    for (int i=0;i<9*9;i++)cell[i/9][i%9]=new Cell();
    cell[1][0].def(9);
    cell[2][0].def(1);
    cell[4][0].def(2);
    cell[6][1].def(7);
    cell[8][1].def(6);
    cell[7][3].def(9);
    cell[0][4].def(6);
    cell[0][5].def(7);
    cell[2][5].def(5);
    cell[3][5].def(6);
    cell[0][6].def(8);
    cell[8][6].def(3);
    cell[4][7].def(9);
    cell[5][7].def(4);
    cell[7][7].def(2);
    cell[2][8].def(7);
    cell[4][8].def(1);
    return;
  }
  if (code=='E') {
    for (int i=0;i<9*9;i++)cell[i/9][i%9]=new Cell();
    cell[0][0].def(9);
    cell[6][0].def(5);
    cell[8][0].def(4);
    cell[1][1].def(5);
    cell[4][2].def(8);
    cell[5][2].def(1);
    cell[0][4].def(2);
    cell[3][4].def(4);
    cell[4][4].def(5);
    cell[2][5].def(7);
    cell[7][5].def(8);
    cell[0][6].def(7);
    cell[4][6].def(9);
    cell[1][7].def(8);
    cell[7][7].def(1);
    cell[3][8].def(2);
    cell[6][8].def(3);  
    return;
  }
  if (code=='R') {
    for (int i=0;i<9*9;i++)cell[i/9][i%9]=new Cell();
    cell[0][0].def(1);
    cell[1][0].def(9);
    cell[8][0].def(4);
    cell[4][1].def(7);
    cell[5][1].def(1);
    cell[7][1].def(2);
    cell[8][1].def(8);
    cell[1][2].def(8);
    cell[2][2].def(2);
    cell[5][2].def(3);
    cell[6][2].def(5);
    cell[2][3].def(9);
    cell[3][3].def(6);
    cell[4][3].def(4);
    cell[6][3].def(1);
    cell[7][3].def(8);
    cell[0][4].def(5);
    cell[2][4].def(7);
    cell[3][4].def(1);
    cell[4][4].def(3);
    cell[8][4].def(9);
    cell[0][5].def(6);
    cell[2][5].def(8);
    cell[3][5].def(2);
    cell[7][5].def(5);
    cell[0][6].def(9);
    cell[1][6].def(3);
    cell[2][6].def(6);
    cell[4][6].def(8);
    cell[5][6].def(4);
    cell[6][6].def(7);
    cell[0][7].def(2);
    cell[1][7].def(5);
    cell[2][7].def(4);
    cell[4][7].def(1);
    cell[5][7].def(9);
    cell[6][7].def(8);
    cell[7][7].def(3);
    cell[1][8].def(7);
    cell[3][8].def(3);
    cell[4][8].def(2);
    cell[5][8].def(6);
    cell[7][8].def(4);
    cell[8][8].def(5);  
    return;
  }
  if ('0'<=code&&code<='9') {
    cell[sx][sy].def(code-'0');
    //    solve.start();
    return;
  }
  if (LEFT<=code&&code<=DOWN&&sx+sy>=0) {
    code-=LEFT;
    sx=constrain(sx+(code-1)%2, 0, 8);
    sy=constrain(sy+(code-2)%2, 0, 8);
    return;
  }
}

