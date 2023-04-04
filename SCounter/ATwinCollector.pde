class ATwinCollector extends DataCollector {
    private int s1PulseWatchDog = 0;
    private int s2PulseWatchDog = 0;
    
    private boolean inSetting = false;

    public ATwinCollector(PApplet parent, String device) {
        super(parent, device);
    }

    public boolean isInSetting() {
        return inSetting;
    }

    protected void onS1Updated() {
        s1PulseWatchDog++;
        if (s1PulseWatchDog == 2) {
            s1PulseWatchDog = 0;
            betCount++;
            
            if (checkGameStarted(inBigBonus || inMiddleBonus)) {
                updateGameCountAndBets();
            }
        }
    }

    protected void onS2Updated() {
        s2PulseWatchDog++;

        if (s2PulseWatchDog == 2) {
            s2PulseWatchDog = 0;
            payCount++;
        }
    }

    protected void onS3Updated() {
        inMiddleBonus = !inMiddleBonus;
        
        if (inMiddleBonus) {
            middleBonusCount++;
        }
        else {
            resetCurrentGameCount();
        }
    }

    protected void onS4Updated() {
        inBigBonus = !inBigBonus;

        if (inBigBonus) {
            bigBonusCount++;
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

    private boolean checkGameStarted(boolean bonusFlag) {
        int bonusFlagAsInt = bonusFlag?1:0;
        
        if ((betCount + bonusFlagAsInt - betCountAtLastGameUpdate) >= 3) {
            return true;
        }
        return false;
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
