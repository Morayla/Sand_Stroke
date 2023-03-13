class Brush {
  //original position
  float originalx, originaly;
  //current position
  float x, y;
  //speed
  float vx;
  //amplitude of brush
  float originalbrushWidth;
  float brushWidth;
  //brush color
  color strokeColor;
  //theta variable that controls the changeing width of brush
  float theta;
  float maxtheta;

  Brush(float x_, float y_, float bw_) {
    originalx = x = x_;
    originaly = y = y_;
    originalbrushWidth = brushWidth = bw_;
    init();
  }

  void init() {
    strokeColor = palette[int(random(palNum))];
    theta = random(0.01, 0.1);
    maxtheta = 0.3;
    x = originalx;
    y = originaly;
    brushWidth = originalbrushWidth;
    vx = 1.0;
  }

  void update()
  {
    x+=vx;
    if (x>width) init();
  }

  void render() {
    theta+=random(-0.042, 0.042);
    theta=constrain(theta, -maxtheta, maxtheta);
    if (abs(theta)<0.01) {
      if (random(10000)>9900) strokeColor = palette[int(random(palNum))];
    }

    // 涂抹在当前点
    stroke(strokeColor, 22);
    point(x, y);

    // 涂抹在当前点的上下
    // number of brushing points below and above brush position
    float scatterNum = 200;
    for (int i=0; i<scatterNum; i++) {
      // 离笔刷中心越近，浓度越高，反之越低，线形衰减
      float alpha = 255*0.1*(1-i/scatterNum);
      stroke(strokeColor, alpha);
      // 确保上下对称
      point(x, y + brushWidth*sin(i*theta*0.005));
      point(x, y - brushWidth*sin(i*theta*0.005));
    }
  }
}
