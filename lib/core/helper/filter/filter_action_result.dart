enum FilterAction {
  submit,
  cancel,
}

class FilterResult<T> {
  FilterAction action;
  List<T> value;

  FilterResult({required this.action, required this.value});
}