enum RequestState { initial, empty, loading, success, error, shimmering }

extension RequestStateExt on RequestState {
  bool get isInitial => this == RequestState.initial;

  bool get isEmpty => this == RequestState.empty;

  bool get isLoading => this == RequestState.loading;

  bool get isSuccess => this == RequestState.success;

  bool get isError => this == RequestState.error;

  bool get isShimmering => this == RequestState.shimmering;
}