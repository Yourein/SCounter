abstract class ViewBundle {
    private DataView view;
    private String fullName = null, abbreviated = null;
    private PImage backImage = null;

    public ViewBundle(DataView _view) {
        construction(_view, "", "", null);
    }

    public ViewBundle(DataView _view, String _fullName, String _abbreviated) {
        construction(_view, _fullName, _abbreviated, null);
    }

    public ViewBundle(DataView _view, PImage img) {
        construction(_view, "", "", img);
    }

    public ViewBundle(DataView _view, String _fullName, String _abbreviated, PImage img) {
        construction(_view, _fullName, _abbreviated, img);
    }

    private void construction(
        DataView _view,
        String _fullName,
        String _abbreviated,
        PImage img
    ) {
        view = _view;
        fullName = _fullName;
        abbreviated = _abbreviated;
        backImage = img;
    }

    private void drawBackGround() {
        if (backImage != null) {
            background(backImage);
            fill(0, 0, 0, 100);
        }
    }

    public String getFullName() {
        return fullName;
    }

    public String getAbbreviated() {
        return abbreviated;
    }

    public void draw() {
        view.draw();
    }
}