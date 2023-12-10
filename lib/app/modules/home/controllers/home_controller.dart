import 'package:foodie/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  //go to product details
  void goToProductDetails() {
    Get.toNamed(Routes.PRODUCT_DETAILS);
  }
}
