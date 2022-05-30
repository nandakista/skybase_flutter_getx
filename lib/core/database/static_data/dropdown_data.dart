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

  static List<DropdownData> getStatusHukum(){
    return <DropdownData>[
      DropdownData(value: 'umum', title: 'Perseorangan'),
      DropdownData(value: 'perusahaan', title: 'Perusahaan'),
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


  static List<DropdownData> dummyTipeHak(){
    return <DropdownData>[
      DropdownData(title: 'Hak Guna Bangunan', value: 'hgb'),
    ];
  }

  static List<DropdownData> dummyRegion(){
    return <DropdownData>[
      DropdownData(title: 'DKI Jakarta', value: 'value'),
      DropdownData(title: 'Bandung', value: 'value'),
      DropdownData(title: 'Semarang', value: 'value'),
      DropdownData(title: 'Jakarta Selatan', value: 'value'),
      DropdownData(title: 'Jakarta Barat', value: 'value'),
      DropdownData(title: 'Jakarta Timur', value: 'value'),
      DropdownData(title: 'Jakarta Utara', value: 'value'),
    ];
  }

}