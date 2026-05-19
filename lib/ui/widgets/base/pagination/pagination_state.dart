enum PaginationState {
  initial,
  loading,
  loadingMore,
  empty,
  success,
  error,
  errorMore,
}

extension PaginationStateExt on PaginationState {
  bool get isInitial => this == PaginationState.initial;

  bool get isLoading => this == PaginationState.loading;

  bool get isLoadingMore => this == PaginationState.loadingMore;

  bool get isEmpty => this == PaginationState.empty;

  bool get isSuccess => this == PaginationState.success;

  bool get isError => this == PaginationState.error;

  bool get isErrorMore => this == PaginationState.errorMore;
}
