ATwinCollectorUseCase aTwin;
PImage img;

void setup() {
  aTwin = new ATwinCollectorUseCase(this, "/dev/ttyACM0");
  size(1280, 720);
  textSize(32);
  img = loadImage("./Assets/atwin.png");
}

void draw() {
  aTwin.fetchUpdate();
  if (img == null) background(255);
  else image(img, 0, 0, width, height);
  fill(0, 0, 0, 175);
  rect(-1, -1, width, height);
  fill(255);
  
  text(String.format("Start : %d      Total: %d", aTwin.getCurrentGameCount(), aTwin.getTotalGameCount()), 10, 50);
  text(String.format("Profit: %d", aTwin.getProfit()), 10, 100);
  text(String.format("Bonus : %d   Big+: %d   Middle: %d", aTwin.getAllBonusCount(), aTwin.getBigBonusCount(), aTwin.getMiddleBonusCount()), 10, 150);
  text("inBB: " + (aTwin.inBigBonus()?"true":"false") + "   inMB: " + (aTwin.inMiddleBonus()?"true":"false"), 10, 200);
  text("inError: " + (aTwin.inError()?"true":"false"), 10, 250);
}  
