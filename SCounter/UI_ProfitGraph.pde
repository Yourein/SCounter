class ProfitGraph extends Item {
    private Point position;
    private float viewWidth, viewHeight;
    private float lineYBegin;
    private float plotHorizontalPadding, plotVerticalPadding;
    private ArrayList<Integer> data = new ArrayList<Integer>();
    private final int n = 12000;
    private final int maxValue = 6000;

    public ProfitGraph(Point pos, float _width, float _height) {
        position = pos;
        lineYBegin = position.y + (_height/2.0);
        viewWidth = _width;
        viewHeight = _height;
        plotHorizontalPadding = viewWidth/float(n);
        plotVerticalPadding = _height/float(2*maxValue);
    }

    public void push_back(int newData){
        data.add(newData);
    }

    public void draw() {
        this.verticalAxis();
        this.horizontalAxis();
        this.plot();
    }

    private void verticalAxis() {
        stroke(255);
        strokeWeight(4);
        line(position.x, position.y, position.x, position.y+viewHeight);
        strokeWeight(0);
    }

    private void horizontalAxis() {
        stroke(255);
        strokeWeight(4);
        line(position.x, lineYBegin, position.x + viewWidth, lineYBegin);
        strokeWeight(0);

        stroke(255, 255, 255, 60);
        strokeWeight(1);
        textAlign(LEFT, CENTER);
        textFont(Light);
        textSize(TinyTextSize);
        for (int i = -5; i <= 5; i++) {
            if (i == 0) continue;

            float lineY = lineYBegin - i*1000*plotVerticalPadding;
            line(position.x, lineY, position.x+viewWidth, lineY);

            if (i%2 == 0) {
                text(i*1000, position.x + 5, lineY - 7);
            }
        }
        textSize(NormalTextSize);
        textFont(Regular);
        textAlign(CENTER, CENTER);
        stroke(255);
        strokeWeight(0);
    }

    private void plot() {
        float lastx = position.x, lasty = lineYBegin;
        stroke(255, 230, 50);
        strokeWeight(2);
        for (int i = 0; i < data.size(); i++) {
            float currentX = min(position.x + i*plotHorizontalPadding, position.x + viewWidth);
            float currentY = lineYBegin - min(data.get(i)*plotVerticalPadding, maxValue*plotVerticalPadding);
            line(lastx, lasty, currentX, currentY);
            lastx = currentX;
            lasty = currentY;
        }
        strokeWeight(0);
    }
}