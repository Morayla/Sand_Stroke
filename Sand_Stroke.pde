// A simplification of Sand Stroke by Jared Tarbell, 2004
// Ao Lei, 2023

int brushNum = 22;

int palMax = 256;
int palNum = 0;
color[] palette = new color[palMax];

Brush[] brushes;

void setup() {
  size(500,500);
  colorMode(RGB,255);
  fillPalette("longcolor.gif");
  brushes = new Brush[brushNum];
  for (int i=0;i<brushNum;i++) {
    brushes[i] = new Brush(0,random(height),200);
  }
  background(255);
}

void draw() {
  for (Brush brush:brushes) {
    brush.update();
    brush.render();
  }
}

// 在palette中填充各不相同的颜色
void fillPalette(String fn) {
  PImage b;
  b = loadImage(fn);
  image(b,0,0,width,height);
  for (int x=0;x<width;x++){
    for (int y=0;y<height;y++) {
      color c = get(x,y);
      boolean exists = false;
      for (int n=0;n<palNum;n++) {
        if (c==palette[n]) {
          exists = true;
          break;
        }
      }
      if (!exists) {
        // add color to pal
        if (palNum<palMax) {
          palette[palNum] = c;
          palNum++;
        } else {
          break;
        }
      }
    }
  }
  
  // 调色板加入黑白的颜色来控制的颜色的饱和度
  // add white and black to palette to control saturation
  int saturationControl=6;
  if (palNum<palMax-saturationControl) {
    for (int i=0; i<saturationControl; i++) {
      palette[palNum]=#000000;
      palNum++;
      palette[palNum]=#FFFFFF;
      palNum++;
    }
  }
  println(palNum);
}
