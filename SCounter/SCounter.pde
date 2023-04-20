PFont Regular, Medium, Bold, Light;

Scaffold scaffold;

void setup() {
  size(1280, 720);
  scaffold = new Scaffold();
  scaffold.addContent(
    new ATwinContent(
      new Point(DefaultAppBarHeight, 0),
      this,
      "./Assets/atwin.png",
      "/dev/ttyACM0"
    ), 
    "A-SLOTツインエンジェルBREAK",
    "Device1"
  );

  /*
   * SET textAlign to (CENTER, CENTER) BY DEFAULT.
   * if you change textAlign, please reset textAlign to (CENTER, CETNER).
   */
  textAlign(CENTER, CENTER);

  Bold = createFont("./font/NotoSansJP/NotoSansJP-Bold.ttf", 240, true);
  Light = createFont("./font/NotoSansJP/NotoSansJP-Light.ttf", 240, true);
  Medium = createFont("./font/NotoSansJP/NotoSansJP-Medium.ttf", 240, true);
  Regular = createFont("./font/NotoSansJP/NotoSansJP-Regular.ttf", 240, true);
  textFont(Regular);
}

void draw() {
  background(WhiteValue);
  fill(WhiteValue);
  
  scaffold.draw();
}  

void mouseClicked() { scaffold.onEvent(Event.onClicked); }