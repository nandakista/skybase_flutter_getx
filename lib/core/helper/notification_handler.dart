import 'package:get/get.dart';
import 'package:skybase/ui/views/main_navigation/main_nav_view.dart';

class NotificationHandler {
    String? title;
    String? body;
    Map<String, dynamic>? data;
    
    NotificationHandler({
        this.title,
        this.body,
        required this.data,
    });

    String pageDirection() {
      return pageDirectionFromNotification(
        subject, 
        subjectId
      );
    }

    String get subject => data!['subject'];
    String get bodyHtml => data!['body_html'];
    int? get isDiscussion => data!['is_discussion'] != null ? int.parse(data!['is_discussion']) : null;
    int? get subjectId => data!['subject_id'] != null ? int.parse(data!['subject_id']) : null;

    void redirectNotifToPage() {
      Get.toNamed(pageDirection());
    }

}

String pageDirectionFromNotification(String type, int? id) {
  switch (type) {
    case "*":
        return MainNavView.route;
    default:
        return MainNavView.route;
  }
}