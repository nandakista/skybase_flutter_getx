class DropdownData {
  String? value;
  String? title;

  DropdownData({ this.value,  this.title});

  static List<DropdownData> getBank(){
    return <DropdownData>[
      DropdownData(value: '1000201', title: 'BCA'),
      DropdownData(value: '1000202', title: 'Mandiri'),
      DropdownData(value: '1000203', title: 'BRI'),
      DropdownData(value: '1000204', title: 'BNI'),
    ];
  }

  static List<DropdownData> marriageStatus(){
    return <DropdownData>[
      DropdownData(value: 'menikah', title: 'Menikah'),
      DropdownData(value: 'belum_menikah', title: 'Belum Menikah'),
      DropdownData(value: 'cerai', title: 'Cerai'),
      DropdownData(value: 'cerai_mati', title: 'Cerai Mati'),
    ];
  }
}