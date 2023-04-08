class DummyReceiver extends Receiver {
    public boolean newDataAvailable() {
        return false;
    }

    protected int readData() {
        return 127;
    }

    public int fetchUpdate() {
        return 0;
    }
}