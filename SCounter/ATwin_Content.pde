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
        float counterHeight = (height - DefaultAppBarHeight - DefaultBottomNavHeight)/4.0;

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
            counterHeight
        );

        totalGameCounter = new DataCounter(
            new Point(0, DefaultAppBarHeight + counterHeight),
            "累計",
            "G",
            width/2.0,
            counterHeight
        );

        bigBonusCounter = new DataCounter(
            new Point(0, DefaultAppBarHeight + counterHeight*2),
            "Big Bonus",
            "回",
            width/2.0,
            counterHeight
        );

        regBonusCounter = new DataCounter(
            new Point(0, DefaultAppBarHeight + counterHeight*3),
            "Middle Bonus",
            "回",
            width/2.0,
            counterHeight
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
            totalGameCounter.draw();
            bigBonusCounter.draw();
            regBonusCounter.draw();
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