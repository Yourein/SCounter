abstract class ViewBundle {
    private DataView view;
    private UseCase usecase;
    private String fullName = null, abbreviated = null;

    public ViewBundle(DataView _view, UseCase _usecase) {
        construction(_view, _usecase, "", "");
    }

    public ViewBundle(DataView _view, UseCase _usecase, String _fullName, String _abbreviated) {
        construction(_view, _usecase, _fullName, _abbreviated);
    }

    private void construction(
        DataView _view,
        UseCase _usecase,
        String _fullName,
        String _abbreviated
    ) {
        view = _view;
        usecase = _usecase;
        fullName = _fullName;
        abbreviated = _abbreviated;
    }

    public String getFullName() {
        return fullName;
    }

    public String getAbbreviated() {
        return abbreviated;
    }
}