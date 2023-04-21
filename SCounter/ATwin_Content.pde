class ATwinContent extends InteractiveItem {
    private Point position;
    private ATwinCollectorUseCase useCase;
    
    private NullableImage bgImage;
    private ProfitGraph graph;
    private DataCounter currentGameCounter;
    private DataCounter totalGameCounter;
    private DataCounter bigBonusCounter;
    private DataCounter regBonusCounter;

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

        currentGameCounter = new DataCounter(
            new Point(0, DefaultAppBarHeight),
            "現在",
            "G",
            width/2.0,
            (height - DefaultAppBarHeight - DefaultBottomNavHeight)/4.0
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
            currentGameCounter.draw();
            graph.draw();
        }
    }

    private void settingScreen() {
        
    }

    private void errorScreen() {

    }

    private void bgImg() {
        fill(0, 0, 0, 200);
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