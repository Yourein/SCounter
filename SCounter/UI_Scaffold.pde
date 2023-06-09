class Scaffold extends InteractiveItem {
    private Point position = new Point(0, 0);

    private BottomNavigation bottomNavigation;
    private ArrayList<Item> appBar;
    private ArrayList<View> content;

    private int contentIndex = 0;

    public Scaffold() {
        bottomNavigation = new BottomNavigation(
            DefaultBottomNavHeight,
            (it) -> { contentIndex = it; }
        );

        appBar = new ArrayList<Item>();
        content = new ArrayList<View>();
    }

    public void draw() {
        if (content.size() > 0) {
            content.get(contentIndex).draw();
            appBar.get(contentIndex).draw();
            bottomNavigation.draw();
        }
    }

    public void onEvent(Event kind) {
        bottomNavigation.onEvent(kind);
        
        content.stream()
            .filter((i) -> { return i instanceof Interactive; })
            .forEach((i) -> { ((Interactive) i).onEvent(kind); });
    }

    public void addContent(View view, String title, String label) {
        content.add(view);
        appBar.add(new AppBar(title));
        bottomNavigation.addTab(label);
    }
}

class AppBar extends Item {
    private Point position;
    private String title;
    private float txtWidth;
    

    public AppBar(String t) {
        title = t;

        textSize(NormalTextSize);
        txtWidth = textWidth(title);
    }

    public void draw() {
        fill(BlackValue);
        rect(0, 0, width, DefaultAppBarHeight);

        fill(WhiteValue);
        textFont(Bold);
        textSize(NormalTextSize);
        text(title, width/2.0, DefaultAppBarHeight/2.0 - TextHorizontalAdjustment);
        textFont(Regular);
    }
}

class BottomNavigation extends InteractiveItem {
    private class NavigationTab extends InteractiveActionableItem {
        private Point position = new Point(0, 0);
        private float viewHeight;
        private String tabLabel;
        private float txtWidth;

        private float textXBegin, textYBegin;
        private int tabID;

        private Callback<Integer> tabCallback;

        public NavigationTab(String label, int id, float vHeight, Callback<Integer> callback) {
            tabLabel = label;
            viewHeight = vHeight;
            
            textSize(NormalTextSize);
            txtWidth = textWidth(tabLabel);
            
            tabID = id;
            tabCallback = callback;
        }

        public void draw() {
            this.draw(width, true);
        }

        public void draw(float tabWidth, boolean isTabActive) {
            textXBegin = tabWidth/2.0 + tabID*tabWidth;
            textYBegin = height - viewHeight + viewHeight/2.0 - TextHorizontalAdjustment;

            fill(0);
            rect(tabID*tabWidth, height - viewHeight, tabID*tabWidth + tabWidth, height);
            fill(255);

            textFont(Light);
            textSize(SmallTextSize);
            fill(isTabActive?WhiteValue:GrayValue);
            text(tabLabel, textXBegin, textYBegin);
            textFont(Regular);
            textSize(NormalTextSize);

            fill(255);
        }

        public void onEvent(Event kind) {
            if (kind == Event.onClicked) {
                if (isMouseOverRect(textXBegin - 4, textYBegin - NormalTextSize - 2, textXBegin + txtWidth + 4, textYBegin + 2)) {
                    action(kind);
                }
            }
        }

        public int getTabID() {
            return tabID;
        }

        protected void action(Event kind) {
            if (kind == Event.onClicked) {
                tabCallback.invoke(tabID);
            }
        }
    }

    private Point position;
    private float viewHeight;
    private float tabWidth;
    
    private ArrayList<NavigationTab> childTab = new ArrayList<NavigationTab>();
    private int activeTab = 0;
    private Callback<Integer> onTabClickedCallback;

    public BottomNavigation(
        float vHeight,
        Callback<Integer> callback
    ) {
        viewHeight = vHeight;
        tabWidth = width; // Screen width for default
        onTabClickedCallback = callback;
    }

    public void draw() {
        if (childTab.size() > 0) {
            childTab.stream().forEach((i) -> { 
                i.draw(
                    tabWidth,
                    activeTab == i.getTabID()
                ); 
            });
        }
    }

    public void onEvent(Event kind) {
        childTab.stream().forEach((i) -> { i.onEvent(kind); });
    }

    public void addTab(String tabLabel) {
        childTab.add(
            new NavigationTab(
                tabLabel,
                childTab.size(),
                DefaultBottomNavHeight,
                (tabID) -> { 
                    if (tabID != activeTab) {
                        activeTab = tabID;
                        onTabClickedCallback.invoke(tabID);
                    }
                }
            )
        );

        tabWidth = width / ((float) childTab.size());
    }
}
