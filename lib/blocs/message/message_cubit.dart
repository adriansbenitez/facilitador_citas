import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:facilitador_citas/models/models.dart';

enum MessageStatusType { success, warning, error }

class MessageCubit extends Cubit<MessageModel?> {
  Timer? timer;
  MessageStatusType messageStatusType = MessageStatusType.success;

  MessageCubit(super.initialState);

  void onShow(String message, MessageStatusType messageStatusType) {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {
      emit(
          MessageModel(message: message, messageStatusType: messageStatusType));
    });
  }
}
