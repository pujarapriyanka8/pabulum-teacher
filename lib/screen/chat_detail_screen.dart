
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/chat/chat_bloc.dart';
import 'package:pabulum_teacher/model/chat_detail_model.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments = ModalRoute.of(context)?.settings.arguments;
    final studentId = int.tryParse('$arguments');

    return Scaffold(
      backgroundColor: AppColors.background,
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.icBackgroundAll,
              fit: BoxFit.cover,
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 700),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
                      child: CustomAppBar(
                        title: 'Chat',
                        subtitle:
                        'Connect and communicate\nwith your students.',
                        image: AppImages.icHomeworkHeader,
                      ),
                    ),
                    Expanded(
                      child: studentId == null
                          ? _buildMissingStudent()
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
                                Column(
                                  children: [
                                    _buildStudentHeader(
                                      context,
                                      state,
                                    ),
                                    Expanded(
                                      child: state.messages.isEmpty
                                          ? state.isLoading
                                          ? const SizedBox.shrink()
                                          : _buildEmptyState(
                                        context,
                                        state,
                                      )
                                          : _buildMessages(
                                        context,
                                        state,
                                      ),
                                    ),
                                    _buildMessageInput(
                                      context,
                                      state,
                                      studentId,
                                    ),
                                  ],
                                ),
                                if (state.isLoading)
                                  Utils.loaderBrier(),
                                if (state.isLoading)
                                  Utils.loaderWid(),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMissingStudent() {
    return Center(
      child: Text(
        'Student ID is missing.',
        style: TextStyle(
          color: AppColors.ink,
          fontSize: 14,
          fontWeight: FontWeight.w600,
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

    for (final message in state.messages) {
      if (state.studentId != null &&
          int.tryParse('${message.sender?.id}') == state.studentId) {
        if (studentName.isEmpty) {
          studentName = (message.sender?.name ?? '').trim();
        }

        if (profileImage.isEmpty) {
          profileImage =
              (message.sender?.profileImage ?? '').trim();
        }
      }

      if (state.studentId != null &&
          int.tryParse('${message.receiver?.id}') == state.studentId) {
        if (studentName.isEmpty) {
          studentName = (message.receiver?.name ?? '').trim();
        }

        if (profileImage.isEmpty) {
          profileImage =
              (message.receiver?.profileImage ?? '').trim();
        }
      }

      if (studentName.isNotEmpty && profileImage.isNotEmpty) {
        break;
      }
    }

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.22),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildAvatar(
            name: studentName,
            imageUrl: profileImage,
          ),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  studentName.isNotEmpty
                      ? studentName
                      : state.isLoading
                      ? 'Loading...'
                      : 'Student',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Icon(
                      Icons.chat_bubble_outline_rounded,
                      size: 13,
                      color: AppColors.purple,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      'Student conversation',
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Material(
            color: AppColors.purple.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(11),
            child: InkWell(
              borderRadius: BorderRadius.circular(11),
              onTap: state.isLoading ||
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
              child: Padding(
                padding: const EdgeInsets.all(9),
                child: Icon(
                  Icons.refresh_rounded,
                  color: AppColors.purple,
                  size: 21,
                ),
              ),
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
      color: AppColors.purple.withValues(alpha: 0.12),
      child: Text(
        name.isEmpty ? 'S' : name.characters.first.toUpperCase(),
        style: TextStyle(
          color: AppColors.purple,
          fontSize: 18,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    return Container(
      width: 46,
      height: 46,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.35),
          width: 1.5,
        ),
      ),
      child: ClipOval(
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
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 14),
      itemCount:
      state.messages.length + (showPageControl ? 1 : 0),
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

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Align(
            alignment: isMine
                ? Alignment.centerRight
                : Alignment.centerLeft,
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
                      horizontal: 13,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: isMine
                          ? AppColors.purple
                          : AppColors.surface,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(16),
                        topRight: const Radius.circular(16),
                        bottomLeft:
                        Radius.circular(isMine ? 16 : 5),
                        bottomRight:
                        Radius.circular(isMine ? 5 : 16),
                      ),
                      border: isMine
                          ? null
                          : Border.all(
                        color: AppColors.purple.withValues(
                          alpha: 0.18,
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.purple.withValues(
                            alpha: 0.05,
                          ),
                          blurRadius: 7,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Text(
                      message.message ?? '',
                      style: TextStyle(
                        color: isMine
                            ? AppColors.white
                            : AppColors.ink,
                        fontSize: 13,
                        height: 1.45,
                      ),
                    ),
                  ),
                  if ((message.createdAt ?? '').isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 4,
                      ),
                      child: Text(
                        message.createdAt ?? '',
                        style: TextStyle(
                          color: AppColors.muted,
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
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              color: AppColors.purple,
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
              padding: const EdgeInsets.only(bottom: 5),
              child: Text(
                state.messageError,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.muted,
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
              size: 18,
            ),
            label: Text(
              state.messageError.isNotEmpty
                  ? 'Try again'
                  : 'Load more messages',
            ),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.purple,
              textStyle: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
              ),
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
              width: 86,
              height: 86,
              decoration: BoxDecoration(
                color: AppColors.purple.withValues(alpha: 0.09),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: AppColors.purple.withValues(
                    alpha: 0.18,
                  ),
                ),
              ),
              child: Icon(
                hasError
                    ? Icons.wifi_off_rounded
                    : Icons.mark_chat_unread_rounded,
                color: AppColors.purple,
                size: 38,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              hasError
                  ? 'Unable to load chat'
                  : 'No messages yet!',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 7),
            Text(
              hasError
                  ? state.messageError
                  : 'Start a conversation with your student.\nYour messages will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColors.muted,
                fontSize: 12,
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
                  foregroundColor: AppColors.purple,
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
      ChatState state,
      int studentId,
      ) {
    final isBusy = state.isSending ||
        state.isLoading ||
        state.isLoadingMoreMessages;

    return Container(
      margin: const EdgeInsets.fromLTRB(12, 4, 12, 10),
      padding: const EdgeInsets.all(9),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: AppColors.purple.withValues(alpha: 0.23),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
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
              textCapitalization:
              TextCapitalization.sentences,
              cursorColor: AppColors.purple,
              style: TextStyle(
                color: AppColors.ink,
                fontSize: 13,
                height: 1.4,
              ),
              decoration: InputDecoration(
                hintText: 'Write a message...',
                hintStyle: TextStyle(
                  color: AppColors.muted,
                  fontSize: 13,
                ),
                filled: true,
                fillColor: AppColors.background,
                isDense: true,
                contentPadding:
                const EdgeInsets.symmetric(
                  horizontal: 13,
                  vertical: 12,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    color: AppColors.colorGrey1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide(
                    color: AppColors.purple,
                    width: 1.3,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: state.messageController,
            builder: (context, value, child) {
              final canSend =
                  value.text.trim().isNotEmpty && !isBusy;

              return SizedBox(
                width: 45,
                height: 45,
                child: IconButton(
                  tooltip: 'Send message',
                  onPressed: canSend
                      ? () {
                    context.read<ChatBloc>().add(
                      ChatEvent.onSendMessage(
                        studentId: studentId,
                      ),
                    );
                  }
                      : null,
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: AppColors.white,
                    disabledBackgroundColor:
                    AppColors.purple.withValues(
                      alpha: 0.14,
                    ),
                    disabledForegroundColor:
                    AppColors.muted,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(13),
                    ),
                  ),
                  icon: state.isSending
                      ? SizedBox(
                    width: 19,
                    height: 19,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                      : const Icon(
                    Icons.send_rounded,
                    size: 20,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
