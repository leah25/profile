class NotificationData {
  String id;
  String title;
  String action;
  String message;
  String email;
  String time;

  NotificationData({
    this.id,
    this.title,
    this.action,
    this.message,
    this.email,
    this.time
  });

  NotificationData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    action = json['action'];
    message = json['message'];
    email = json['email'];
    time = json['timestamp'];
  }
}
