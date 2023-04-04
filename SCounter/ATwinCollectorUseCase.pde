class ATwinCollectorUseCase {
    private ATwinCollector collector;

    public ATwinCollectorUseCase(PApplet parent, String device){
        collector = new ATwinCollector(parent, device);
    }

    public void fetchUpdate() {
        collector.fetchUpdate();
    }

    public int getProfit() {
        return collector.getPayCount() - collector.getBetCount();
    }

    public int getTotalGameCount() {
        return collector.getTotalGameCount();
    }

    public int getCurrentGameCount() {
        return collector.getGameBetweenBonusCount();
    }

    public int getAllBonusCount() {
        return collector.getMiddleBonusCount() + collector.getBigBonusCount();
    }

    public int getBigBonusCount() {
        return collector.getBigBonusCount();
    }

    public int getMiddleBonusCount() {
        return collector.getMiddleBonusCount();
    }

    public boolean inBigBonus() {
        return collector.isInBigBonus();
    }

    public boolean inMiddleBonus() {
        return collector.isInMiddleBonus();
    }

    public boolean inSetting() {
        return collector.isInSetting();
    }

    public boolean inError() {
        return collector.isInError();
    }
}