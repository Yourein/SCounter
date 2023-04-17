class Scaffold extends InteractiveItem {
    private Point position;

    private BottomNavigation bottomNavigation;
    private Item topBar;
    private ArrayList<View> content

    public void draw() {

    }

    public void onEvent(Event kind) {
        bottomNavigation.onEvent(kind);
    }
}

class BottomNavigation extends InteractiveActionableItem {
    private class NavigationTab extends InteractiveActionableItem {
        
    }

    private Point position;
    
    private int deviceCount = 0;

    public BottomNavigation(Point pos) {
        position = pos;
    }

    public void draw() {
        if (deviceCount > 0) {

        }
    }

    public void onEvent(Event kind) {

    }

    protected void action(Event kind) {

    }

    public void addTab(String tabName) {

    }
}
