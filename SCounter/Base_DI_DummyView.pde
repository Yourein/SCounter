class DummyItem extends Item {
    private Point position = new Point(0, 0);
    private int fcolor = 0;
    
    public DummyItem(int f) {
        fcolor = f;
    }

    public void draw() {
        fill(fcolor);
        rect(0, 0, width, height);
    }
}