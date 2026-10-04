part of 'chat_bloc.dart';

@freezed
class ChatEvent with _$ChatEvent {
  const factory ChatEvent.onLoadChats() = OnLoadChats;

  const factory ChatEvent.onLoadMessages({
    required int studentId,
    @Default(1) int page,
  }) = OnLoadMessages;

  const factory ChatEvent.onLoadAllStudent() = OnLoadAllStudent;
  const factory ChatEvent.onSendMessage({
    required int studentId,
  }) = OnSendMessage;

  const factory ChatEvent.onSearchChats({
    required String query,
  }) = OnSearchChats;
}
