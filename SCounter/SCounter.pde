Scaffold scaffold;

void setup() {
  size(1280, 720);
  scaffold = new Scaffold();
  scaffold.addContent(new DummyItem(WhiteValue), "DummyTitle1", "DummyItem1");
  scaffold.addContent(new DummyItem(GrayValue), "DummyTitle2", "DummyItem2");
}

void draw() {
  aTwin.fetchUpdate();
  background(WhiteValue);
  
  fill(WhiteValue);
  scaffold.draw();
}  

void mouseClicked() { scaffold.onEvent(Event.onClicked); }