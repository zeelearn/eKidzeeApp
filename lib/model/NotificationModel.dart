class NotificationModel{
  int notificationId;
  String subject;
  String notificationtype;
  String message;
  String image_url;
  String time;
  int isSeen;
  double indicatorValue;

  NotificationModel({
    required this.notificationId,
    required this.subject,
    required this.notificationtype,
    required this.message,
    required this.image_url,
    required this.time,
    required this.isSeen,
    required this.indicatorValue
  });
}
