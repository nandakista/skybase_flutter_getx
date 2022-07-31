import 'package:varcore_flutter_base/ui/views/order/filter/filter_order_type_model.dart';

class FilterOrderData {
  static final all = <FilterOrder>[
    FilterOrder(
      label: 'Butuh Konfirmasi',
      isSelected: false,
    ),
  ];

  static final process = <FilterOrder>[
    FilterOrder(
      label: 'Upload Draft',
      isSelected: false,
    ),
    FilterOrder(
      label: 'Upload Revisi',
      isSelected: false,
    ),
    FilterOrder(
      label: 'Menunggu Konfirmasi Draft',
      isSelected: false,
    ),
    FilterOrder(
      label: 'Upload Insight',
      isSelected: false,
    ),
    FilterOrder(
      label: 'Menunggu Konfirmasi Insight',
      isSelected: false,
    ),
  ];

  static final done = <FilterOrder>[
    FilterOrder(
      label: 'Selesai',
      isSelected: false,
    ),
    FilterOrder(
      label: 'Ditolak',
      isSelected: false,
    ),
  ];

  static final orderBy = <FilterOrder>[
    FilterOrder(
      label: 'Pesanan Paling Baru',
      isSelected: false,
    ),
    FilterOrder(
      label: 'Pesanan Paling Lama',
      isSelected: false,
    ),
  ];
}