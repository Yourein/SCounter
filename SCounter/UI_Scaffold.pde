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
    private 

    public void draw() {

    }

    public void onEvent(Event kind) {

    }
}

class BottomNavigation extends InteractiveActionableItem {
    
}