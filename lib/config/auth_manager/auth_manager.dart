import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import 'package:skybase/config/auth_manager/auth_state.dart';
import 'package:skybase/core/database/storage/cache_data.dart';
import 'package:skybase/core/database/storage/storage_key.dart';
import 'package:skybase/core/database/storage/storage_manager.dart';
import 'package:skybase/core/database/secure_storage/secure_storage_manager.dart';
import 'package:skybase/config/themes/theme_manager.dart';
import 'package:skybase/data/models/user/user.dart';
import 'package:skybase/ui/views/intro/intro_view.dart';
import 'package:skybase/ui/views/login/login_view.dart';
import 'package:skybase/ui/views/splash/splash_view.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

/// This class will called first time before app go to pages.
///
/// This class help you to manage authentication process.
/// Contains auth general function such as [login], [logout], and first install/[setup]
class AuthManager extends GetxService {
  static AuthManager get find => Get.find<AuthManager>();

  Rxn<AuthState> authState = Rxn<AuthState>();
  Stream<AuthState?> get stream => authState.stream;
  AuthState? get state => authState.value;

  StorageManager storage = StorageManager.find;
  SecureStorageManager secureStorage = SecureStorageManager.find;
  ThemeManager themeManager = ThemeManager.find;

  bool get isAuthenticated => state?.appStatus == AppType.AUTHENTICATED;
  bool get isUnauthenticated => state?.appStatus == AppType.UNAUTHENTICATED;

  @override
  void onInit() {
    authState.value = const AuthState(appStatus: AppType.INITIAL);
    super.onInit();
  }

  @override
  void onReady() async {
    ever(authState, authChanged);
    authChanged(state);
    super.onReady();
  }

  void authChanged(AuthState? state) async {
    switch (state?.appStatus) {
      case AppType.INITIAL:
        await setup();
        break;
      case AppType.FIRST_INSTALL:
        Timer(
          const Duration(seconds: 2),
          () => Get.offAllNamed(IntroView.route),
        );
        break;
      case AppType.UNAUTHENTICATED:
        Timer(
          const Duration(seconds: 2),
          () => Get.offAllNamed(LoginView.route),
        );
        break;
      case AppType.AUTHENTICATED:
        Get.offAllNamed(MainNavView.route);
        break;
      default:
        Get.toNamed(SplashView.route);
    }
  }

  Future<void> setup() async {
    checkFirstInstall();
    await checkAppTheme();
    await clearExpiredCache();
  }

  Future<void> clearExpiredCache() async {
    await Future.wait(
      (storage.box.getKeys() as Iterable).map((key) async {
        List<String> permanentKeys = [
          StorageKey.STORAGE_NAME,
          StorageKey.FIRST_INSTALL,
          StorageKey.CURRENT_LOCALE,
          StorageKey.IS_DARK_THEME,
          StorageKey.USERS,
        ];
        if (!permanentKeys.contains(key)) {
          final now = DateTime.now();
          dynamic storageItem = await storage.get(key);
          CacheData cacheData = CacheData.fromJson(jsonDecode(storageItem));
          if (cacheData.expiredDate.isBefore(now)) await storage.delete(key);
        }
      }),
    );
  }

  /// Check if app is first time installed. It will navigate to Introduction Page
  void checkFirstInstall() async {
    final bool isFirstInstall =
        await storage.getAwait(StorageKey.FIRST_INSTALL) ?? true;
    if (isFirstInstall) {
      await secureStorage.setToken(value: '');
      authState.value = const AuthState(appStatus: AppType.FIRST_INSTALL);
    } else {
      checkUser();
    }
  }

  /// Checking App Theme set it before app display
  Future<void> checkAppTheme() async {
    final bool isDarkTheme =
        await storage.getAwait(StorageKey.IS_DARK_THEME) ?? false;
    if (isDarkTheme) {
      themeManager.toDarkMode();
    } else {
      themeManager.toLightMode();
    }
  }

  /// This function to used for checking is valid token to API Server use GET User Endpoint (token required).
  /// If response is Error it will passed to [logout] process.
  Future<void> checkUser() async {
    // TODO : Add your logic check user here
    final String? token = await secureStorage.getToken();
    if (token != null && token != '') {
      setAuth();
    } else {
      logout();
    }
  }

  /// Set auth state to AppType.AUTHENTICATED
  void setAuth() async {
    if (await secureStorage.isLoggedIn()) {
      authState.value = const AuthState(appStatus: AppType.AUTHENTICATED);
    }
  }

  /// Just call this function to managed logout process.
  /// It will stream state and auto redirect your apps to page based on their state
  /// with [authChanged] function
  /// * No need to navigate manually (Get.to or Get.off)
  Future<void> logout() async {
    await clearData();
    authState.value = const AuthState(appStatus: AppType.UNAUTHENTICATED);
  }

  Future<void> clearData() async {
    await secureStorage.logout();
    await storage.logout();
  }

  /// Just call this function to managed login process.
  /// It will stream state and auto redirect your apps to page based on their state
  /// with [authChanged] function
  /// * No need to navigate manually (Get.to or Get.off).
  Future<void> login({
    required User user,
    required String token,
    required String refreshToken,
  }) async {
    await saveAuthData(user: user, token: token, refreshToken: refreshToken);
    setAuth();
  }

  Future<void> saveAuthData({
    required User user,
    required String token,
    required String refreshToken,
  }) async {
    await saveUserData(user: user);
    await secureStorage.setToken(value: token);
    await secureStorage.setRefreshToken(value: refreshToken);

    /// TODO : Sync locale from API user locale
    /// LocaleManager.find.updateLocale(
    ///   Locale(
    ///     user.locale ?? LocaleManager.find.fallbackLocale.languageCode,
    ///   ),
    /// );
  }

  Future<void> saveUserData({required User user}) async {
    await storage.save(StorageKey.USERS, user.toJson());
  }

  /// Get User data from GetStorage
  /// * No need to decode or call fromJson again when you used this helper
  User? get user {
    if (storage.has(StorageKey.USERS)) {
      return User.fromJson(storage.get(StorageKey.USERS));
    } else {
      return null;
    }
  }
}
