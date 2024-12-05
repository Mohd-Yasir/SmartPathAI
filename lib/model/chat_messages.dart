import 'dart:ffi';

class ChatMessages {
  late final String id;
  late final String messages;
  late final Bool isSentBuyUser;
  late final DateTime timeStamp;

  ChatMessages({
    required id,
    required messages,
    required isSentBuyUser,
    required timeStamp,
  });
}
