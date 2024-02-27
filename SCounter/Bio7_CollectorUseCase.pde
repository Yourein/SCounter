class Bio7CollectorUseCase implements UseCase {
    private Bio7Collector collector;

    public Bio7CollectorUseCase(PApplet parent, String device){
        collector = new Bio7Collector(parent, device);
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

    public int getHazardRushCount() {
        return collector.getBigBonusCount();
    }

    public int getClimaxBattleCount() {
        return collector.getMiddleBonusCount();
    }

    public boolean inHazardRush() {
        return collector.isInBigBonus();
    }

    public boolean inClimaxBattle() {
        return collector.isInMiddleBonus();
    }

    public boolean inSetting() {
        return collector.isInSetting();
    }

    public boolean inError() {
        return collector.isInError();
    }
}