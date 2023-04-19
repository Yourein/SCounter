class ATwinContent extends InteractiveItem {
    private Point position;
    private ATwinCollectorUseCase useCase;

    public ATwinContent(Point pos, String device) {
        position = pos;
        useCase = new ATwinCollectorUseCase(this, device);
    }

    public void draw() {
        if (useCase.inSetting()) {
            
        }
        else if (useCase.inError()) {

        }
        else {

        }
    }

    private void settingScreen() {
        
    }

    private void errorScreen() {

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