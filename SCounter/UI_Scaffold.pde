// class Scaffold {
//     private int screenWidth;
//     private int screenHeight;
//     private int currentTab = 0;
//     private ViewBundle tab1, tab2, tab3;

//     public Scaffold(int screenWidth, int screenHeight, ViewBundle _tab1) {
//         construction(screenWidth, screenHeight, _tab1, null, null);
//     }

//     public Scaffold(int screenWidth, int screenHeight, ViewBundle _tab1, ViewBundle _tab2) {
//         construction(screenWidth, screenHeight, _tab1, _tab2, null);
//     }

//     public Scaffold(int screenWidth, int screenHeight, ViewBundle _tab1, ViewBundle _tab2, ViewBundle _tab3) {
//         construction(screenWidth, screenHeight, _tab1, _tab2, _tab3);
//     }

//     private void construction(
//         int _screenWidth, 
//         int _screenHeight,
//         ViewBundle _tab1,
//         ViewBundle _tab2,
//         ViewBundle _tab3
//     ){
//         screenWidth = _screenWidth;
//         screenHeight = _screenHeight;
//         tab1 = _tab1;
//         tab2 = _tab2;
//         tab3 = _tab3;
//     }

//     void draw() {
        
//     }

//     void onClick() {

//     }
// }

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
