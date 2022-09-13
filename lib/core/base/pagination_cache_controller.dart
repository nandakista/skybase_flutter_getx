import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

abstract class PaginationCacheController<T> extends GetxController {
  late Box<T> box;
  List<T> dataList = [];
  int perPage = 20;
  int page = 1;
  final pagingController = PagingController<int, T>(firstPageKey: 0);

  getListData();

  openBox(String _cacheBoxName) {
    box = Hive.box<T>(_cacheBoxName);
  }

  Future<List<T>> loadData() async {
    if (box.isEmpty) {
      return getListData();
    } else {
      getListData();
      List<T> _users = [];
      for (var i = 0; i < box.length; i++) {
        _users.add(box.getAt(i)!);
      }
      return _users;
    }
  }

  saveCache({required List<T> data, required Iterable<String>? idList}){
    data.asMap().forEach((i, value) {
      box.put(idList?.toList()[i], data[i]);
    });
    if (data.isNotEmpty) {
      dataList.addAll(data);
    }
  }

  @override
  void onInit() {
    pagingController.addPageRequestListener((page) {
      loadData();
    });
    super.onInit();
  }

  refreshPage() {
    page = 1;
    pagingController.refresh();
  }

  loadNextData(List<T> data) {
    final isLastPage = data.length < perPage;
    if (isLastPage) {
      pagingController.appendLastPage(data);
    } else {
      final nextPage = page++;
      pagingController.appendPage(data, nextPage);
    }
  }
}
