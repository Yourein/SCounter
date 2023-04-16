interface View {
    abstract public void draw();
}

interface Interactive {
    abstract public void onEvent(Event kind);
}

abstract class Actionable {
    abstract protected void action(Event kind);
}
