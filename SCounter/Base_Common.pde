/*
 * Common Class and business logic
 */

class Point {
    float x, y;

    public Point(float _x, float _y) {
        x = _x;
        y = _y;
    }
}

boolean isMouseOverRect(float x1, float y1, float x2, float y2) {
    if (x1 > x2) {
        float tmp = x2;
        x2 = x1;
        x1 = tmp;
    }

    if (y1 > y2) {
        float tmp = y2;
        y2 = y1;
        y1 = tmp;
    }

    return x1 <= mouseX && mouseX <= x2 && y1 <= mouseY && mouseY <= y2;
}

@FunctionalInterface
interface Callback<T> {
    public void invoke(T x);
}