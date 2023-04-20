class DataCounter extends Item {
    private Point position;
    private float viewWidth, viewHeight;
    private String counterTitle;
    private int counterValue = 0;

    public DataCounter(Point pos, String title, float w, float h) {
        position = pos;
        counterTitle = title;
        viewWidth = w;
        viewHeight = h;
    }

    public void draw() {
        fill(0, 0, 0, 175);
        rect(position.x, position.y, position.x + width, position.y + viewHeight);
    }

    public void setValue(int value) {
        counterValue = value;
    }
}