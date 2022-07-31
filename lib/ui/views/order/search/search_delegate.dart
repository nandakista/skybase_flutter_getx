import 'package:flutter/material.dart';
import 'package:varcore_flutter_base/ui/views/order/dummy_order_data.dart';
import 'package:varcore_flutter_base/ui/views/order/search/empty_search_order_view.dart';
import 'package:varcore_flutter_base/ui/views/order/widgets/list_order_view.dart';

class SearchOrderDelegate extends SearchDelegate {
  List allData = dummyOrder();

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).backgroundColor,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            headline6: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
            subtitle1: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w500,
                color: Colors.black),
          ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Theme.of(context).scaffoldBackgroundColor,
        filled: true,
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1.5, color: Colors.grey),
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          borderSide: BorderSide(width: 1.5, color: Colors.grey),
        ),
      ),
    );
  }

  @override
  String? get searchFieldLabel => 'Cari nama campaign disini...';

  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 12);

  @override
  Widget? buildLeading(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.only(left: 30),
      child: Icon(Icons.search),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Center(
          child: InkWell(
            onTap: () => close(context, null),
            child: const Text(
              'Batal',
              style: TextStyle(color: Colors.black, fontSize: 18),
            ),
          ),
        ),
      )
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return _buildBody(emptyView: const EmptySearchOrderView());
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return _buildBody(
        emptyView: ListTile(
      title: Text(
        'Cari untuk $query..',
        textAlign: TextAlign.center,
      ),
    ));
  }

  Widget _buildBody({required Widget emptyView}) {
    List matchQuery = [];
    for (var item in allData) {
      if (item['title'].toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(item);
      }
    }
    if (matchQuery.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: ListOrderView(data: matchQuery),
      );
    } else {
      return emptyView;
    }
  }
}
