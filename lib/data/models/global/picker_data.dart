class PickerData<T> {
  bool isSelected;
  int? index;
  T? data;

  PickerData({
    this.isSelected = false,
    this.index,
    this.data,
  });

  PickerData<T> copy({
    bool? isSelected,
    int? index,
    T? data,
  }) =>
      PickerData(
        isSelected: isSelected ?? this.isSelected,
        index: index ?? this.index,
        data: data ?? this.data,
      );
}
