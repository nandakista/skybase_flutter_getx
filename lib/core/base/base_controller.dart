import 'package:get/get.dart';

/* Created by
   Varcant
   nanda.kista@gmail.com
*/
abstract class BaseController extends GetxController {
  RxBool isLoading = false.obs;
  RxString errorMessage = ''.obs;
  RxBool isError = false.obs;

  void onRefresh();

  void showLoading() {
    isLoading.toggle();
    isError.value = false;
    errorMessage.value = '';
  }

  void hideLoading() => isLoading.toggle();

  void showError(String message) {
    errorMessage.value = message;
    isError.value = true;
  }
}
