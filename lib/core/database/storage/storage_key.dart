class StorageKey {
  static const STORAGE_NAME = 'AppGetStorage';

  static const FIRST_INSTALL = 'first_install';
  static const USERS = 'users';
  static const CURRENT_LOCALE = 'current_locale';
  static const IS_DARK_THEME = 'is_dark_theme';

  static List<String> permanentKeys = [
    StorageKey.STORAGE_NAME,
    StorageKey.FIRST_INSTALL,
    StorageKey.CURRENT_LOCALE,
    StorageKey.IS_DARK_THEME,
  ];
}
