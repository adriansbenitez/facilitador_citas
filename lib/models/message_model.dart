import '../blocs/message/message_cubit.dart';

class MessageModel {
  String message;
  MessageStatusType messageStatusType;

  MessageModel({required this.message, required this.messageStatusType});
}
