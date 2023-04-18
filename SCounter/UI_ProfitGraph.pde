class ProfitGraph extends Item {
    private Point position;
    private int viewWidth, viewHeight;
    private float lineYBegin;
    private float plotHorizontalPadding, plotVerticalPadding;
    private ArrayList<Integer> data = new ArrayList<Integer>();
    private final int n = 12000;
    private final int maxValue = 6000;

    public ProfitGraph(Point pos, int _width, int _height) {
        position = pos;
        lineYBegin = position.x + (_height/2.0);
        viewWidth = _width;
        viewHeight = _height;
        plotHorizontalPadding = viewWidth/float(n);
        plotVerticalPadding = _height/float(2*maxValue);
    }

    public void push_back(int newData){
        data.add(newData);
    }

    void draw() {
        float xBegin = position.x;
        stroke(255);
        strokeWeight(4);
        line(xBegin, lineYBegin, xBegin + viewWidth, lineYBegin);

        float lastx = xBegin, lasty = lineYBegin;
        stroke(255, 230, 50);
        strokeWeight(2);
        for (int i = 0; i < data.size(); i++) {
            float currentX = min(xBegin + i*plotHorizontalPadding, xBegin + viewWidth);
            float currentY = lineYBegin - min(data.get(i)*plotVerticalPadding, maxValue*plotVerticalPadding);
            line(lastx, lasty, currentX, currentY);
            lastx = currentX;
            lasty = currentY;
        }
    }
}