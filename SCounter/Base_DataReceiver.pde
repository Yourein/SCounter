import processing.serial.*;

abstract class Receiver {
    abstract public boolean newDataAvailable();
    abstract protected int readData();
    abstract public int fetchUpdate();
}

class DataReceiver extends Receiver {
    private Serial rx;
    private int oldByte = 127, currentByte = 127;

    public DataReceiver(PApplet parent, String device) {
        rx = new Serial(parent, device, 9600);
    }

    public boolean newDataAvailable() {
        return rx.available() > 0;
    }

    protected int readData() {
        String res = "";
        while(true) {
            char buf = char(rx.read());
            if ('0' <= buf && buf <= '9') res += buf;
            else if (buf == '\n') break;
        }

        return Integer.parseInt(res);
    }

    // 1bitの変更毎にUpdateがemitされるので、
    // XORで立つbitは高々1bitで、返り値の値は2^nになる
    public int fetchUpdate() {
        currentByte = readData();
        int diff = oldByte^currentByte;
        oldByte = currentByte;
        return diff;
    }
}