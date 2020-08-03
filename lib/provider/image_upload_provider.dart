part of 'providers.dart';

enum ViewState { LOADING, IDLE }

class ImageUploadProvider with ChangeNotifier {
  ViewState _viewState = ViewState.IDLE;

  ViewState get getViewState => _viewState;

  void setToLoading() {
    _viewState = ViewState.LOADING;
    notifyListeners();
  }

  void setToIdle() {
    _viewState = ViewState.IDLE;
    notifyListeners();
  }
}
