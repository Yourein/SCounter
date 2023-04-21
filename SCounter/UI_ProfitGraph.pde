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
        this.baseLine();
        this.plot();
    }

    private void baseLine() {
        stroke(255);
        strokeWeight(4);
        line(position.x, lineYBegin, position.x + viewWidth, lineYBegin);
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