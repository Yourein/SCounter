abstract class Item implements View {
    private Point position;

    abstract public void draw();
}

abstract class InteractiveItem implements View, Interactive {
    private Point position;

    abstract public void draw();
    abstract public void onEvent(Event kind);
}

abstract class InteractiveActionableItem extends Actionable implements View, Interactive {
    private Point position;

    abstract public void draw();
    abstract public void onEvent(Event kind);
    abstract protected void action(Event kind);
}
