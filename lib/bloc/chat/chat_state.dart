part of 'chat_bloc.dart';

@freezed
abstract class ChatState with _$ChatState {
  const factory ChatState({
    required bool isLoading,
    required List<ChatListData> students,
    required List<ChatDetailData> messages,
    required List<AllStudentData> arrAllStudentData,
    required TextEditingController searchController,
    required TextEditingController messageController,
    required ScrollController scrollController,
    @Default(false) bool isLoadingMore,
    @Default(false) bool isSending,
    @Default(false) bool hasError,
    @Default(false) bool hasMore,
    @Default(0) int currentPage,
    @Default('') String query,
    @Default(false) bool isLoadingMoreMessages,
    @Default(0) int messagePage,
    @Default(1) int messageLastPage,
    @Default('') String messageError,
    int? studentId,
  }) = _ChatState;

  factory ChatState.initial() {
    return ChatState(
      isLoading: false,
      students: [],
      messages: [],
      arrAllStudentData: [],
      searchController: TextEditingController(),
      messageController: TextEditingController(),
      scrollController: ScrollController(),
    );
  }
}