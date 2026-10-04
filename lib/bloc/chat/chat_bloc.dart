import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pabulum_teacher/model/all_student_model.dart';
import 'package:pabulum_teacher/model/chat_detail_model.dart';
import 'package:pabulum_teacher/model/chat_list_model.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'chat_event.dart';
part 'chat_state.dart';
part 'chat_bloc.freezed.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ApiService apiService = ApiService();

  List<ChatListData> _allStudents = [];
  String _searchQuery = '';

  ChatBloc() : super(ChatState.initial()) {
    on<OnLoadChats>(onLoadChats);
    on<OnLoadAllStudent>(onLoadAllStudents);
    on<OnSearchChats>(onSearchChats);
    on<OnLoadMessages>(onLoadMessages);
    on<OnSendMessage>(onSendMessage);

  }

  Future<void> onLoadChats(
      OnLoadChats event,
      Emitter<ChatState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await apiService.getRequest(
        AppEndPoints.chatList,
      );

      if (emit.isDone) return;

      if (response.statusCode == 200 &&
          response.data['success'] == true) {
        final List<ChatListData> responseData =
        (response.data['data'] as List<dynamic>)
            .map((jsonItem) => ChatListData.fromJson(jsonItem))
            .toList();

        _allStudents = responseData;

        emit(state.copyWith(
          isLoading: false,
          students: _filterStudents(_searchQuery),
        ));
      } else {
        emit(state.copyWith(isLoading: false));

        Utils.showToast(
          response.statusMessage ?? 'Unable to load chats',
          false,
        );
      }
    } catch (e) {
      if (emit.isDone) return;

      emit(state.copyWith(isLoading: false));
      debugPrint(e.toString());

      Utils.showToast(
        'Unable to load chats. Please try again.',
        false,
      );
    }
  }

  Future<void> onLoadAllStudents(
      OnLoadAllStudent event,
      Emitter<ChatState> emit,
      ) async {
    try {
      emit(state.copyWith(isLoading: true));

      final response = await apiService.getRequest(
        AppEndPoints.allStudents,
      );

      if (emit.isDone) return;

      if (response.statusCode == 200 &&
          response.data['success'] == true) {
        final List<ChatListData> responseData =
        (response.data['data'] as List<dynamic>)
            .map((jsonItem) => ChatListData.fromJson(jsonItem))
            .toList();

        _allStudents = responseData;

        emit(state.copyWith(
          isLoading: false,
          students: _filterStudents(_searchQuery),
        ));
      } else {
        emit(state.copyWith(isLoading: false));

        Utils.showToast(
          response.statusMessage ?? 'Unable to load students',
          false,
        );
      }
    } catch (e) {
      if (emit.isDone) return;

      emit(state.copyWith(isLoading: false));
      debugPrint(e.toString());

      Utils.showToast(
        'Unable to load students. Please try again.',
        false,
      );
    }
  }

  void onSearchChats(
      OnSearchChats event,
      Emitter<ChatState> emit,
      ) {
    _searchQuery = event.query;

    emit(state.copyWith(
      students: _filterStudents(event.query),
    ));
  }

  List<ChatListData> _filterStudents(String value) {
    final query = value.trim().toLowerCase();

    if (query.isEmpty) {
      return List<ChatListData>.of(_allStudents);
    }

    return _allStudents.where((student) {
      final name = (student.name ?? '').toLowerCase();
      final grNumber = (student.grNumber ?? '').toLowerCase();
      final rollNumber = (student.rollNumber ?? '').toLowerCase();

      return name.contains(query) ||
          grNumber.contains(query) ||
          rollNumber.contains(query);
    }).toList();
  }


  Future<void> onLoadMessages(
      OnLoadMessages event,
      Emitter<ChatState> emit,
      ) async {
    if (state.isLoading || state.isLoadingMoreMessages) return;

    final isFirstPage = event.page == 1;

    if (!isFirstPage) {
      if (state.studentId != event.studentId ||
          event.page != state.messagePage + 1 ||
          event.page > state.messageLastPage) {
        return;
      }
    }

    try {
      emit(state.copyWith(
        isLoading: isFirstPage,
        isLoadingMoreMessages: !isFirstPage,
        studentId: event.studentId,
        messageError: '',
        messages: isFirstPage ? [] : state.messages,
        messagePage: isFirstPage ? 0 : state.messagePage,
        messageLastPage: isFirstPage ? 1 : state.messageLastPage,
      ));

      final response = await apiService.getRequest(
        '${AppEndPoints.chatDetail}/${event.studentId}?page=${event.page}',
      );

      if (emit.isDone) return;

      if (response.statusCode == 200 &&
          response.data['success'] == true) {
        final List<ChatDetailData> responseData =
        (response.data['data'] as List<dynamic>)
            .map((jsonItem) => ChatDetailData.fromJson(jsonItem))
            .toList();

        final messages = <ChatDetailData>[
          if (!isFirstPage) ...state.messages,
        ];

        // Avoid duplicate messages across pages.
        for (final message in responseData) {
          final index = message.id == null
              ? -1
              : messages.indexWhere(
                (item) => item.id == message.id,
          );

          if (index == -1) {
            messages.add(message);
          } else {
            messages[index] = message;
          }
        }

        // Newest first because the chat ListView uses reverse: true.
        messages.sort((a, b) {
          final dateComparison = _messageDate(b.createdAt ?? '')
              .compareTo(_messageDate(a.createdAt ?? ''));

          if (dateComparison != 0) return dateComparison;

          final firstId = int.tryParse('${a.id}') ?? 0;
          final secondId = int.tryParse('${b.id}') ?? 0;

          return secondId.compareTo(firstId);
        });

        final lastPage =
            int.tryParse('${response.data['last_page']}') ?? event.page;

        emit(state.copyWith(
          isLoading: false,
          isLoadingMoreMessages: false,
          messages: messages,
          messagePage: event.page,
          messageLastPage:
          lastPage < event.page ? event.page : lastPage,
          messageError: '',
        ));
      } else {
        final apiMessage =
            response.data['message']?.toString().trim() ?? '';

        final errorMessage = apiMessage.isNotEmpty
            ? apiMessage
            : 'Unable to load messages. Please try again.';

        emit(state.copyWith(
          isLoading: false,
          isLoadingMoreMessages: false,
          messageError: errorMessage,
        ));

        Utils.showToast(errorMessage, false);
      }
    } catch (e) {
      if (emit.isDone) return;

      debugPrint(e.toString());

      emit(state.copyWith(
        isLoading: false,
        isLoadingMoreMessages: false,
        messageError: 'Unable to load messages. Please try again.',
      ));

      Utils.showToast(
        'Unable to load messages. Please try again.',
        false,
      );
    }
  }

  DateTime _messageDate(String value) {
    // API format: dd-MM-yyyy HH:mm
    final match = RegExp(
      r'^(\d{2})-(\d{2})-(\d{4})\s+(\d{2}):(\d{2})',
    ).firstMatch(value.trim());

    if (match == null) {
      return DateTime.tryParse(value) ??
          DateTime.fromMillisecondsSinceEpoch(0);
    }

    return DateTime(
      int.parse(match.group(3)!),
      int.parse(match.group(2)!),
      int.parse(match.group(1)!),
      int.parse(match.group(4)!),
      int.parse(match.group(5)!),
    );
  }

  Future<void> onSendMessage(
      OnSendMessage event,
      Emitter<ChatState> emit,
      ) async {
    if (state.isSending) return;

    final messageText = state.messageController.text.trim();

    if (messageText.isEmpty) return;

    try {
      emit(state.copyWith(isSending: true));

      final response = await apiService.postRequest(
        '${AppEndPoints.sendMessage}/${event.studentId}',
        {
          'message': messageText,
        },
      );

      if (emit.isDone) return;

      if ((response.statusCode == 200 ||
          response.statusCode == 201) &&
          response.data['success'] == true) {
        final newMessage = ChatDetailData.fromJson(
          response.data['data'],
        );

        if (state.messageController.text.trim() == messageText) {
          state.messageController.clear();
        }

        emit(
          state.copyWith(
            isSending: false,
            messages: [
              newMessage,
              ...state.messages.where(
                    (item) =>
                newMessage.id == null ||
                    item.id != newMessage.id,
              ),
            ],
          ),
        );

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (isClosed) return;

          final controller = state.scrollController;

          if (controller.hasClients) {
            controller.animateTo(
              controller.position.minScrollExtent,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
            );
          }
        });
      } else {
        final errorMessage =
            response.data['message']?.toString().trim() ?? '';

        emit(state.copyWith(isSending: false));

        Utils.showToast(
          errorMessage.isNotEmpty
              ? errorMessage
              : 'Unable to send message. Please try again.',
          false,
        );
      }
    } catch (e) {
      if (emit.isDone) return;

      emit(state.copyWith(isSending: false));

      Utils.showToast(
        'Unable to send message. Please try again.',
        false,
      );
    }
  }
  @override
  Future<void> close() async {
    await super.close();

    state.searchController.dispose();
    state.messageController.dispose();
    state.scrollController.dispose();
  }
}