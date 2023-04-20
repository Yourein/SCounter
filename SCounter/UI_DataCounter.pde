class DataCounter extends Item {
    private Point position;
    private float viewWidth, viewHeight;
    private String counterTitle;
    private int counterValue = 0;

    private float viewTextHorizontalAdjustment;
    private float viewTextVerticalAdjustment;

    public DataCounter(Point pos, String title, float w, float h) {
        position = pos;
        counterTitle = title;
        viewWidth = w;
        viewHeight = h;

        viewTextHorizontalAdjustment = 3*(viewWidth/100.0);
        viewTextVerticalAdjustment = NormalTextSize/2.0 + TextHorizontalAdjustment;
    }

    public void draw() {
        fill(255);
        textAlign(LEFT, CENTER);
        stroke(255, 0, 0);
        strokeWeight(10);
        text(
            counterTitle,
            position.x + viewTextHorizontalAdjustment,
            position.y + viewTextVerticalAdjustment
        );
        textAlign(CENTER, CENTER);
        strokeWeight(0);
        stroke(255);
    }

    public void setValue(int value) {
        counterValue = value;
    }
}