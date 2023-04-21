class DataCounter extends Item {
    private Point position;
    private float viewWidth, viewHeight;
    private String counterTitle, counterUnit;
    private int counterValue = 0;

    private float viewTextHorizontalAdjustment;
    private float viewTextVerticalAdjustment;

    public DataCounter(Point pos, String title, String unit, float w, float h) {
        position = pos;
        counterTitle = title;
        counterUnit = unit;
        viewWidth = w;
        viewHeight = h;

        viewTextHorizontalAdjustment = 3*(viewWidth/100.0);
        viewTextVerticalAdjustment = NormalTextSize/2.0 + TextHorizontalAdjustment;
    }

    public void draw() {
        this.title();
        this.value();
    }

    private void title() {
        fill(255);
        textAlign(LEFT, CENTER);
        textFont(Bold);
        textSize(NormalTextSize);
        stroke(255, 0, 0);
        strokeWeight(10);

        text(
            counterTitle,
            position.x + viewTextHorizontalAdjustment,
            position.y + viewTextVerticalAdjustment
        );
        
        textFont(Regular);
        textSize(NormalTextSize);
        textAlign(CENTER, CENTER);
        strokeWeight(0);
        stroke(255);
    }

    private void value() {
        fill(255);
        textAlign(RIGHT, CENTER);
        textFont(Bold);
        textSize(BigTextSize);

        text(
            String.format("%05d", counterValue) + " " + counterUnit,
            position.x + viewWidth - viewTextHorizontalAdjustment,
            position.y + viewHeight/2.0 - TextVerticalAdjustment
        );

        textFont(Regular);
        textSize(NormalTextSize);
        textAlign(CENTER, CENTER);
    }

    public void setValue(int value) {
        counterValue = value;
    }
}