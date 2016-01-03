final int CELL_SIZE = 50;

Solve delete;
SolveAll all;
Dialog dialog;
Field field;
PFont f1, f2;
String name;
int sx, sy;

void settings(){
  size(CELL_SIZE * 9, CELL_SIZE * 9 + 50);
}

void setup() {
  sx = sy = 0;
  delete = new SolveDelete();
  all = new SolveAll();
  dialog = new Dialog(width / 2, height - 10);
  field = new Field();
  f1 = createFont("ComicSansMS", 25);
  f2 = createFont("ComicSansMS", 10);

  textAlign(CENTER);
  frameRate(10);
}

public void saverequest(String nam) {
  this.name = nam;
}

void draw() {
  background(#cccccc);
  strokeWeight(1);
  for (int y = 0; y < 9; y++) {
    for (int x = 0; x < 9; x++) {
      fill(sx == x && sy == y ? #ccccff : #ffffff);
      rect(CELL_SIZE * x, CELL_SIZE * y, CELL_SIZE, CELL_SIZE);
      if (field.isError(x, y)) {
        fill(#ffaaaa, 100);
        rect(CELL_SIZE * x, CELL_SIZE * y, CELL_SIZE, CELL_SIZE);
      }
      fill(0);
      if (field.isFix(x, y)) {
        textFont(f1);
        text(field.getNumber(x, y), CELL_SIZE * x + CELL_SIZE / 2, CELL_SIZE * y + CELL_SIZE * 3 / 4);
      }
      else {
        textFont(f2);
        for (int i = 0; i < 9; i++) {
          fill(field.isLeft(x, y, i + 1) ? 0 : #bbbbff);
          text(i + 1, CELL_SIZE * x + CELL_SIZE / 3 * (i % 3) + CELL_SIZE / 5, CELL_SIZE * y + CELL_SIZE / 3 * (2 - i / 3) + CELL_SIZE / 4);
        }
      }
    }
  }
  noFill();
  strokeWeight(5);
  for (int x = 0; x < 9; x += 3)
    for (int y = 0; y < 9; y += 3)
      rect(CELL_SIZE * x, CELL_SIZE * y, CELL_SIZE * 3, CELL_SIZE * 3);

  fill(0);
  textFont(f1);
  dialog.draw();
}

public void mousePressed(MouseEvent e) {
  int nx = mouseX / CELL_SIZE;
  int ny = mouseY / CELL_SIZE;
  if (ny >= 9) {
    sx = sy = -1;
    delete.solve(field, this);
    return;
  }
  if (sx == nx && sy == ny)
    sx = sy = -1;
  else {
    sx = nx;
    sy = ny;
  }
}

public void keyPressed(KeyEvent e) {
  int code = e.getKeyCode();
  if (code == ESC) {
    sx = sy = sx + sy < 0 ? 0 : -1;
    return;
  }
  if (code == ENTER) {
    for(int j = 0; j < 9; j++) {
      for(int i = 0; i < 9; i++) {
        field.clearError(j, i);
      }
    }
    if (e.isControlDown())
      all.solve(field, this);
    else
      delete.solve(field, this);
    return;
  }
  if (code == DELETE) {
    field.clearAll();
    return;
  }
  if (code == BACKSPACE) {
    field.clear(sx, sy);
    return;
  }
  if (code == 'Q') {
    field.clearAll();
    field.fix(1, 0, 3);
    field.fix(6, 0, 8);
    field.fix(0, 1, 9);
    field.fix(7, 1, 3);
    field.fix(2, 2, 8);
    field.fix(8, 2, 7);
    field.fix(2, 3, 7);
    field.fix(0, 4, 1);
    field.fix(4, 4, 8);
    field.fix(7, 4, 2);
    field.fix(4, 5, 4);
    field.fix(5, 5, 3);
    field.fix(6, 5, 6);
    field.fix(8, 5, 9);
    field.fix(0, 6, 7);
    field.fix(2, 6, 1);
    field.fix(3, 6, 9);
    field.fix(3, 7, 7);
    field.fix(4, 7, 5);
    field.fix(7, 7, 4);
    field.fix(1, 8, 4);
    field.fix(4, 8, 1);
    field.fix(7, 8, 9);
    field.fix(8, 8, 2);
    return;
  }
  if (code == 'W') {
    field.clearAll();
    field.fix(1, 0, 9);
    field.fix(2, 0, 1);
    field.fix(4, 0, 2);
    field.fix(6, 1, 7);
    field.fix(8, 1, 6);
    field.fix(7, 3, 9);
    field.fix(0, 4, 6);
    field.fix(0, 5, 7);
    field.fix(2, 5, 5);
    field.fix(3, 5, 6);
    field.fix(0, 6, 8);
    field.fix(8, 6, 3);
    field.fix(4, 7, 9);
    field.fix(5, 7, 4);
    field.fix(7, 7, 2);
    field.fix(2, 8, 7);
    field.fix(4, 8, 1);
    return;
  }
  if (code == 'E') {
    field.clearAll();
    field.fix(0, 0, 9);
    field.fix(6, 0, 5);
    field.fix(8, 0, 4);
    field.fix(1, 1, 5);
    field.fix(4, 2, 8);
    field.fix(5, 2, 1);
    field.fix(0, 4, 2);
    field.fix(3, 4, 4);
    field.fix(4, 4, 5);
    field.fix(2, 5, 7);
    field.fix(7, 5, 8);
    field.fix(0, 6, 7);
    field.fix(4, 6, 9);
    field.fix(1, 7, 8);
    field.fix(7, 7, 1);
    field.fix(3, 8, 2);
    field.fix(6, 8, 3);
    return;
  }
  if (code == 'R') {
    field.clearAll();
    field.fix(0, 0, 1);
    field.fix(1, 0, 9);
    field.fix(8, 0, 4);
    field.fix(4, 1, 7);
    field.fix(5, 1, 1);
    field.fix(7, 1, 2);
    field.fix(8, 1, 8);
    field.fix(1, 2, 8);
    field.fix(2, 2, 2);
    field.fix(5, 2, 3);
    field.fix(6, 2, 5);
    field.fix(2, 3, 9);
    field.fix(3, 3, 6);
    field.fix(4, 3, 4);
    field.fix(6, 3, 1);
    field.fix(7, 3, 8);
    field.fix(0, 4, 5);
    field.fix(2, 4, 7);
    field.fix(3, 4, 1);
    field.fix(4, 4, 3);
    field.fix(8, 4, 9);
    field.fix(0, 5, 6);
    field.fix(2, 5, 8);
    field.fix(3, 5, 2);
    field.fix(7, 5, 5);
    field.fix(0, 6, 9);
    field.fix(1, 6, 3);
    field.fix(2, 6, 6);
    field.fix(4, 6, 8);
    field.fix(5, 6, 4);
    field.fix(6, 6, 7);
    field.fix(0, 7, 2);
    field.fix(1, 7, 5);
    field.fix(2, 7, 4);
    field.fix(4, 7, 1);
    field.fix(5, 7, 9);
    field.fix(6, 7, 8);
    field.fix(7, 7, 3);
    field.fix(1, 8, 7);
    field.fix(3, 8, 3);
    field.fix(4, 8, 2);
    field.fix(5, 8, 6);
    field.fix(7, 8, 4);
    field.fix(8, 8, 5);
    return;
  }
  if ('0' <= code && code <= '9') {
    field.clearError(sx, sy);
    if (e.isShiftDown()) {
      field.toggle(sx, sy, code - '0');
    }else{
      field.fix(sx, sy, code - '0');
    }
    return;
  }
  if (LEFT <= code && code <= DOWN && sx + sy >= 0) {
    code -= LEFT;
    sx = constrain(sx + (code - 1) % 2, 0, 8);
    sy = constrain(sy + (code - 2) % 2, 0, 8);
    return;
  }
}
