interface AtomicView {
    public void draw();
}

abstract class DataView implements AtomicView {
    abstract public void draw();
}