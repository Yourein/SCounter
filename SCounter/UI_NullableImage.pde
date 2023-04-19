class NullableImage extends Item {
    private Point position = new Point(0, 0);
    private PImage img;

    public NullableImage(PImage image) {
        img = image;
    }

    public void draw() {
        if (img == null) {
            emitNullPointerLog();
            return;
        }
        
        image(img, 0, 0, img.width, img.height);
    }

    public void draw(float x, float y) {
        if (img == null) {
            emitNullPointerLog();
            return;
        }
        
        image(img, x, y, img.width, img.height);
    }

    public void draw(float x1, float y1, float x2, float y2) {
        if (img == null) {
            emitNullPointerLog();
            return;
        }

        image(img, x1, y1, x2, y2);
    }

    private void emitNullPointerLog() {
        println("E: Found Null pointer while drawing image");
    }
}