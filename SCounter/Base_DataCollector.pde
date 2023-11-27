abstract class DataCollector {
    private Receiver receiver;
    protected int betCount = 0;
    protected int payCount = 0;
    protected int bigBonusCount = 0;
    protected int middleBonusCount = 0;

    protected int betCountAtLastGameUpdate = 0;
    protected int totalGameCount = 0;
    protected int gameBetweenBonusCount = 0;

    protected boolean inBigBonus = false;
    protected boolean inMiddleBonus = false;
    protected boolean inError = false;

    public DataCollector(PApplet parent, String device) {
        receiver = new DataReceiver(parent, device);
        // receiver = new DummyReceiver();
    }

    abstract protected void onS1Updated();
    abstract protected void onS2Updated();
    abstract protected void onS3Updated();
    abstract protected void onS4Updated();
    abstract protected void onS5Updated();
    abstract protected void onS6Updated();
    abstract protected void onS7Updated();

    public int getBetCount() {
        return betCount;
    }

    public int getPayCount() {
        return payCount;
    }

    public int getBigBonusCount() {
        return bigBonusCount;
    }

    public int getMiddleBonusCount() {
        return middleBonusCount;
    }

    public int getTotalGameCount() {
        return totalGameCount;
    }

    public int getGameBetweenBonusCount() {
        return gameBetweenBonusCount;
    }

    public boolean isInBigBonus() {
        return inBigBonus;
    }

    public boolean isInMiddleBonus() {
        return inMiddleBonus;
    }

    public boolean isInError() {
        return inError;
    }

    public void fetchUpdate() {
        int data = -1;
        if (receiver.newDataAvailable()) data = receiver.fetchUpdate();

        switch (data) {
            case 1<<0:
                onS1Updated();
                break;
            case 1<<1:
                onS2Updated();
                break;
            case 1<<2:
                onS3Updated();
                break;
            case 1<<3:
                onS4Updated();
                break;
            case 1<<4:
                onS5Updated();
                break;
            case 1<<5:
                onS6Updated();
                break;
            case 1<<6:
                onS7Updated();
                break;
            default:
                break;
        }

        return;
    }
}
