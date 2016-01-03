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
    delete.solve(field, dialog);
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

  if ('0' <= code && code <= '9') {
    field.clearError(sx, sy);
    if (e.isShiftDown()) {
      field.toggle(sx, sy, code - '0');
    }else{
      field.fix(sx, sy, code - '0');
    }
  } else if (LEFT <= code && code <= DOWN && sx + sy >= 0) {
    code -= LEFT;
    sx = constrain(sx + (code - 1) % 2, 0, 8);
    sy = constrain(sy + (code - 2) % 2, 0, 8);
  }else
    switch(code) {
    case 'K':
      sy = constrain(sy - 1, 0, 8);
      break;
    case 'L':
      sx = constrain(sx + 1, 0, 8);
      break;
    case 'H':
      sx = constrain(sx - 1, 0, 8);
      break;
    case 'J':
      sy = constrain(sy + 1, 0, 8);
      break;
    case ESC:
      sx = sy = sx + sy < 0 ? 0 : -1;
      break;
    case ENTER:
      for(int j = 0; j < 9; j++) {
        for(int i = 0; i < 9; i++) {
          field.clearError(j, i);
        }
      }
      if (e.isControlDown())
        delete.solve(field, dialog);
      else
        all.solve(field, dialog);
      break;
    case DELETE:
      field.clearAll();
      break;
    case BACKSPACE:
      field.clear(sx, sy);
      break;
    case 'Q':
      field.clearAll();
      field.setCellString(SolveTest.dataEasy);
      break;
    case 'W':
      field.clearAll();
      field.setCellString(SolveTest.dataNrml);
      break;
    case 'E':
      field.clearAll();
      field.setCellString(SolveTest.dataHard);
      break;
    case 'R':
      field.clearAll();
      field.setCellString(SolveTest.dataPrfs);
      break;
    case 'T':
      field.clearAll();
      field.setCellString(SolveTest.dataLuna);
      break;
    }
}
