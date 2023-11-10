class MessageModel{
  late String title;
  late String body;
  late int email_addressee;

  MessageModel({
    required this.email_addressee,
    required this.title,
    required this.body,
  });
}