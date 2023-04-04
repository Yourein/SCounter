ATwinCollectorUseCase aTwin;

void setup() {
  aTwin = new ATwinCollectorUseCase(this, "/dev/ttyACM0");
  size(1280, 720);
  textSize(32);
}

void draw() {
  aTwin.fetchUpdate();
  background(0);
  
  text(String.format("Start : %d      Total: %d", aTwin.getCurrentGameCount(), aTwin.getTotalGameCount()), 10, 50);
  text(String.format("Profit: %d", aTwin.getProfit()), 10, 100);
  text(String.format("Bonus : %d   Big+: %d   Middle: %d", aTwin.getAllBonusCount(), aTwin.getBigBonusCount(), aTwin.getMiddleBonusCount()), 10, 150);
  text("inBB: " + (aTwin.inBigBonus()?"true":"false") + "   inMB: " + (aTwin.inMiddleBonus()?"true":"false"), 10, 200);
  text("inError: " + (aTwin.inError()?"true":"false"), 10, 250);
}  
