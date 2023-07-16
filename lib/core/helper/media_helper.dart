import 'package:path/path.dart' as p;

class MediaHelper {
  String tag = 'MediaHelper :';
  static const imageExtensions = ["png", "jpg", "jpeg", "gif", "webp"];
  static const videoExtensions = ["mp4", "mov", "mkv", "avi"];
  static const fileExtensions = [
    "pdf",
    "doc",
    "docx",
    "odt",
    "xls",
    "xlsx",
    "csv",
    "psd",
    "txt",
    "zip",
    "rar"
  ];

  static MediaInfo getMediaType(String path) {
    final extension = path.startsWith('http')
        ? p.extension(path).replaceFirst(".", "").split("?").first
        : p.extension(path).replaceFirst(".", "");

    if (imageExtensions.contains(extension.toLowerCase())) {
      return MediaInfo(path, MediaType.IMAGE);
    } else if (videoExtensions.contains(extension.toLowerCase())) {
      return MediaInfo(path, MediaType.VIDEO);
    } else if (fileExtensions.contains(extension.toLowerCase())) {
      return MediaInfo(path, MediaType.FILE);
    } else {
      return MediaInfo(path, MediaType.UNKNOWN);
    }
  }
}

class MediaInfo {
  String path;
  MediaType type;
  MediaInfo(this.path, this.type);
}

enum MediaType {
  FILE,
  IMAGE,
  VIDEO,
  UNKNOWN,
}
