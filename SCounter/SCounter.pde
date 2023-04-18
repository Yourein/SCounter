ATwinCollectorUseCase aTwin;

Scaffold scaffold;

void setup() {
  aTwin = new ATwinCollectorUseCase(this, "/dev/ttyACM0");
  size(1280, 720);
  scaffold = new Scaffold();
  scaffold.addContent(new DummyItem(WhiteValue), "DummyTitle1", "DummyItem1");
  scaffold.addContent(new DummyItem(GrayValue), "DummyTitle2", "DummyItem2");
}

void draw() {
  aTwin.fetchUpdate();
  background(WhiteValue);
  
  fill(WhiteValue);
  // text(String.format("Start : %d      Total: %d", aTwin.getCurrentGameCount(), aTwin.getTotalGameCount()), 10, 50);
  // text(String.format("Profit: %d", aTwin.getProfit()), 10, 100);
  // text(String.format("Bonus : %d   Big+: %d   Middle: %d", aTwin.getAllBonusCount(), aTwin.getBigBonusCount(), aTwin.getMiddleBonusCount()), 10, 150);
  // text("inBB: " + (aTwin.inBigBonus()?"true":"false") + "   inMB: " + (aTwin.inMiddleBonus()?"true":"false"), 10, 200);
  // text("inError: " + (aTwin.inError()?"true":"false"), 10, 250);
  scaffold.draw();
}  

void mouseClicked() { scaffold.onEvent(Event.onClicked); }