class ATwinDataView extends DataView {
    private ATwinCollectorUseCase useCase;
    private int lastGameCount = -1;

    public void draw() {
        if (lastGameCount != useCase.getTotalGameCount()) {
            
        }
    }
}