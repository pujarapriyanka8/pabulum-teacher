import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/chat/chat_bloc.dart';
import 'package:pabulum_teacher/model/chat_detail_model.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  static const Color _background = Color(0xFFF5F1E9);
  static const Color _green = Color(0xFF174C43);
  static const Color _muted = Color(0xFF788781);

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final studentId = int.tryParse('$arguments');

    return Scaffold(
      backgroundColor: _background,
      appBar: Utils.customAppBar(
        'Chat',
        context,
        isBack: true,
        onBackPress: () => Navigator.of(context).pop(),
      ),
      body: studentId == null
          ? const Center(
        child: Text(
          'Student ID is missing.',
          style: TextStyle(
            color: _green,
            fontSize: 15,
          ),
        ),
      )
          : BlocProvider(
        create: (_) => ChatBloc()
          ..add(
            ChatEvent.onLoadMessages(
              studentId: studentId,
              page: 1,
            ),
          ),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return Stack(
              children: [
                SafeArea(
                  top: false,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxWidth: 700,
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          _buildStudentHeader(context, state),
                          Expanded(
                            child: state.messages.isEmpty
                                ? state.isLoading
                                ? const SizedBox.shrink()
                                : _buildEmptyState(
                              context,
                              state,
                            )
                                : _buildMessages(context, state),
                          ),
                          _buildMessageInput(context, state,studentId),
                        ],
                      ),
                    ),
                  ),
                ),
                if (state.isLoading) Utils.loaderBrier(),
                if (state.isLoading) Utils.loaderWid(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildStudentHeader(
      BuildContext context,
      ChatState state,
      ) {
    String studentName = '';
    String profileImage = '';

    // Find the selected student in the API response.
    // The student can be either the sender or receiver.
    for (final message in state.messages) {
      if (state.studentId != null &&
          int.tryParse('${message.sender?.id}') == state.studentId) {
        if (studentName.isEmpty) {
          studentName = (message.sender?.name ?? '').trim();
        }

        if (profileImage.isEmpty) {
          profileImage = (message.sender?.profileImage ?? '').trim();
        }
      }

      if (state.studentId != null &&
          int.tryParse('${message.receiver?.id}') == state.studentId) {
        if (studentName.isEmpty) {
          studentName = (message.receiver?.name ?? '').trim();
        }

        if (profileImage.isEmpty) {
          profileImage = (message.receiver?.profileImage ?? '').trim();
        }
      }

      if (studentName.isNotEmpty && profileImage.isNotEmpty) {
        break;
      }
    }

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 12, 12, 14),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFCF7),
        border: Border(
          bottom: BorderSide(
            color: Color(0xFFE6E4DA),
          ),
        ),
      ),
      child: Row(
        children: [
          _buildAvatar(
            name: studentName,
            imageUrl: profileImage,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              studentName.isNotEmpty
                  ? studentName
                  : state.isLoading
                  ? 'Loading...'
                  : 'Student',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: _green,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            tooltip: 'Refresh messages',
            onPressed: state.isLoading ||
                state.isLoadingMoreMessages ||
                state.studentId == null
                ? null
                : () {
              context.read<ChatBloc>().add(
                ChatEvent.onLoadMessages(
                  studentId: state.studentId!,
                  page: 1,
                ),
              );
            },
            icon: const Icon(
              Icons.refresh_rounded,
              color: _green,
              size: 23,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar({
    required String name,
    required String imageUrl,
  }) {
    final fallback = Container(
      alignment: Alignment.center,
      color: const Color(0xFFDDE9DF),
      child: Text(
        name.isEmpty ? 'S' : name.characters.first.toUpperCase(),
        style: const TextStyle(
          color: _green,
          fontSize: 21,
          fontWeight: FontWeight.w700,
        ),
      ),
    );

    return ClipOval(
      child: SizedBox(
        width: 46,
        height: 46,
        child: imageUrl.isEmpty
            ? fallback
            : Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => fallback,
          loadingBuilder: (_, child, progress) {
            return progress == null ? child : fallback;
          },
        ),
      ),
    );
  }

  Widget _buildMessages(
      BuildContext context,
      ChatState state,
      ) {
    final showPageControl =
        state.messagePage < state.messageLastPage ||
            state.isLoadingMoreMessages ||
            state.messageError.isNotEmpty;

    return ListView.builder(
      controller: state.scrollController,
      reverse: true,
      keyboardDismissBehavior:
      ScrollViewKeyboardDismissBehavior.onDrag,
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      itemCount: state.messages.length + (showPageControl ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == state.messages.length) {
          return _buildPageControl(context, state);
        }

        return _buildMessageBubble(
          state.messages[index],
          state,
        );
      },
    );
  }

  Widget _buildMessageBubble(
      ChatDetailData message,
      ChatState state,
      ) {
    final isMine = state.studentId != null &&
        int.tryParse('${message.receiverId}') == state.studentId;

    final bubbleColor =
    isMine ? _green : const Color(0xFFFFFCF7);

    final textColor =
    isMine ? Colors.white : const Color(0xFF283C34);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment:
            isMine ? Alignment.centerRight : Alignment.centerLeft,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: constraints.maxWidth * 0.82,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: isMine
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 11,
                    ),
                    decoration: BoxDecoration(
                      color: bubbleColor,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft: Radius.circular(isMine ? 16 : 4),
                        bottomRight: Radius.circular(isMine ? 4 : 16),
                      ),
                      border: isMine
                          ? null
                          : Border.all(
                        color: const Color(0xFFE1E5DA),
                      ),
                    ),
                    child: Text(
                      message.message ?? '',
                      style: TextStyle(
                        color: textColor,
                        fontSize: 14,
                        height: 1.45,
                      ),
                    ),
                  ),
                  if ((message.createdAt ?? '').isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 3,
                      ),
                      child: Text(
                        message.createdAt ?? '',
                        style: const TextStyle(
                          color: _muted,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageControl(
      BuildContext context,
      ChatState state,
      ) {
    if (state.isLoadingMoreMessages) {
      return const Padding(
        padding: EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: _green,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (state.messageError.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Text(
                state.messageError,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: _muted,
                  fontSize: 12,
                ),
              ),
            ),
          TextButton.icon(
            onPressed: state.studentId == null
                ? null
                : () {
              context.read<ChatBloc>().add(
                ChatEvent.onLoadMessages(
                  studentId: state.studentId!,
                  page: state.messagePage + 1,
                ),
              );
            },
            icon: Icon(
              state.messageError.isNotEmpty
                  ? Icons.refresh_rounded
                  : Icons.expand_less_rounded,
              size: 20,
            ),
            label: Text(
              state.messageError.isNotEmpty
                  ? 'Try again'
                  : 'Load more messages',
            ),
            style: TextButton.styleFrom(
              foregroundColor: _green,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(
      BuildContext context,
      ChatState state,
      ) {
    final hasError = state.messageError.isNotEmpty;

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: const Color(0xFFDDE2D0),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Icon(
                hasError
                    ? Icons.wifi_off_rounded
                    : Icons.forum_outlined,
                color: _green,
                size: 36,
              ),
            ),
            const SizedBox(height: 18),
            Text(
              hasError ? 'Unable to load chat' : 'No messages yet',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _green,
                fontSize: 19,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              hasError
                  ? state.messageError
                  : 'Your conversation will appear here.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: _muted,
                fontSize: 13,
                height: 1.5,
              ),
            ),
            if (hasError) ...[
              const SizedBox(height: 14),
              TextButton.icon(
                onPressed: state.studentId == null
                    ? null
                    : () {
                  context.read<ChatBloc>().add(
                    ChatEvent.onLoadMessages(
                      studentId: state.studentId!,
                      page: 1,
                    ),
                  );
                },
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try again'),
                style: TextButton.styleFrom(
                  foregroundColor: _green,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMessageInput(
      BuildContext context,
      ChatState state, int studentId,
      ) {
    final isBusy = state.isSending ||
        state.isLoading ||
        state.isLoadingMoreMessages;

    return Container(
      padding: const EdgeInsets.fromLTRB(14, 10, 14, 12),
      decoration: const BoxDecoration(
        color: Color(0xFFFFFCF7),
        border: Border(
          top: BorderSide(
            color: Color(0xFFE6E4DA),
          ),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: state.messageController,
              readOnly: state.isSending,
              minLines: 1,
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              textCapitalization: TextCapitalization.sentences,
              cursorColor: _green,
              style: const TextStyle(
                color: _green,
                fontSize: 14,
                height: 1.4,
              ),
              decoration: InputDecoration(
                hintText: 'Write a message...',
                hintStyle: const TextStyle(
                  color: _muted,
                  fontSize: 13,
                ),
                filled: true,
                fillColor: const Color(0xFFF0EFE7),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 13,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: Color(0xFFE3E3D9),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(
                    color: _green,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: state.messageController,
            builder: (context, value, child) {
              final canSend =
                  value.text.trim().isNotEmpty && !isBusy;

              return SizedBox(
                width: 46,
                height: 46,
                child: IconButton(
                  tooltip: 'Send message',
                  onPressed: state.isSending ||
                      state.messageController.text.trim().isEmpty
                      ? null
                      : () {
                    context.read<ChatBloc>().add(
                      ChatEvent.onSendMessage(
                        studentId: studentId,
                      ),
                    );
                  },
                  style: IconButton.styleFrom(
                    backgroundColor: _green,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor:
                    const Color(0xFFDDE2D0),
                    disabledForegroundColor:
                    const Color(0xFF8A9D8E),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  icon: state.isSending
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: _green,
                    ),
                  )
                      : const Icon(
                    Icons.send_rounded,
                    size: 21,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }}