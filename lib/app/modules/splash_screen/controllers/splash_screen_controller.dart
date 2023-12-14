import 'package:foodie/app/data/services/user_service.dart';
import 'package:foodie/app/routes/app_pages.dart';
import 'package:foodie/app/utils/strings.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenController extends GetxController {
  static late SharedPreferences _prefs;

  @override
  void onInit() {
    getTokenAndNavigate();
    super.onInit();
  }

  //User service
  final UserService _userService = Get.put(UserService());

//get user token and navigate
  void getTokenAndNavigate() async {
    _prefs = await SharedPreferences.getInstance();
    var keepMeLoggedIn = _prefs.getBool(Strings.keepMeLoggedIn);
    var userId = _prefs.getString(Strings.loginToken);

    if (keepMeLoggedIn == true) {
      try {
        await getExistingData(userId ?? "");
        Get.offAllNamed(Routes.BOTTOM_BAR);
      } catch (e) {
        Get.offAllNamed(Routes.SIGN_IN);
      }
    } else {
      Get.offAllNamed(Routes.SIGN_IN);
    }
  }

  //Get existing user data
  Future<void> getExistingData(String userId) async {
    try {
      await _userService.fetchUserData(userId);
    } catch (e) {
      throw e.toString();
    }
  }
}
