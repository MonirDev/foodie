import 'package:foodie/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      const Duration(seconds: 2),
      () {
        Get.offNamed(Routes.SIGN_IN);
      },
    );
  }
}
