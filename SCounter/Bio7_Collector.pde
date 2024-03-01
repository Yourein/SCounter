class Bio7Collector extends DataCollector {
    private int s1PulseWatchDog = 0;
    private int s2PulseWatchDog = 0;

    private boolean inSetting = false;

    public Bio7Collector(PApplet parent, String device) {
        super(parent, device);
    }

    public boolean isInSetting() {
        return inSetting;
    }

    protected void onS1Updated() {
        s1PulseWatchDog++;
        
        // 立ち上がりと立ち下がり両方見てるので2回
        if (s1PulseWatchDog == 2) {
            s1PulseWatchDog = 0;
            betCount++;
            
            if (checkGameStarted()) {
                updateGameCountAndBets();
            }
        }
    }

    protected void onS2Updated() {
        s2PulseWatchDog++;

        // 立ち上がりと立ち下がり両方見てるので2回
        if (s2PulseWatchDog == 2) {
            s2PulseWatchDog = 0;
            payCount++;
        }
    }

    protected void onS3Updated() {
        //バイオ7の3番はBBカウントではないが、内部的にBBとして代用
        inBigBonus = !inBigBonus;
        
        if (inBigBonus) {
            bigBonusCount++;
        }
        else {
            resetCurrentGameCount();
        }
    }

    protected void onS4Updated() {
        //バイオ7の4番はMBカウントではないが、内部的にMBとして代用
        inMiddleBonus = !inMiddleBonus;

        if (inMiddleBonus) {
            middleBonusCount++;
        }
        else {
            resetCurrentGameCount();
        }
    }

    protected void onS5Updated() {
        return;
    }

    protected void onS6Updated() {
        inSetting = !inSetting;
    }

    protected void onS7Updated() {
        inError = !inError;
    }

    private boolean checkGameStarted() {
        return betCount - betCountAtLastGameUpdate >= 3;
    }

    private void updateGameCountAndBets() {
        betCountAtLastGameUpdate = betCount;
        totalGameCount++;
        gameBetweenBonusCount++;
    }

    private void resetCurrentGameCount() {
        gameBetweenBonusCount = 0;
    }
}