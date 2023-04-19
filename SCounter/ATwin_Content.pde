class ATwinContent extends InteractiveItem {
    private Point position;
    private ATwinCollectorUseCase useCase;
    
    private NullableImage bgImage;
    private ProfitGraph graph;

    public ATwinContent(
        Point pos,
        PApplet parent,
        String bgImgPath,
        String device
    ) {
        position = pos;
        
        bgImage = new NullableImage(loadImage(bgImgPath));
        graph = new ProfitGraph(
            new Point(width/2.0, DefaultAppBarHeight),
            width/2.0,
            height - DefaultBottomNavHeight - DefaultAppBarHeight
        );
        
        useCase = new ATwinCollectorUseCase(parent, device);
    }

    public void draw() {
        if (useCase.inSetting()) {
            settingScreen();   
        }
        else if (useCase.inError()) {
            errorScreen();
        }
        else {
            bgImg();
            graph.draw();
        }
    }

    private void settingScreen() {
        
    }

    private void errorScreen() {

    }

    private void bgImg() {
        fill(0, 0, 0, 150);
        bgImage.draw();
        rect(0, 0, width, height);
    }

    public void onEvent(Event kind) {
        if (kind == Event.newFrame) {
            if (useCase == null) {
                println("E: UseCase is null. Expected an instance of concrete subclass of the interface UseCase.");
            }
            else {
                useCase.fetchUpdate();
            }
        }
    }
}