
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/chat/chat_bloc.dart';
import 'package:pabulum_teacher/model/chat_list_model.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      bottomNavigationBar: Utils.navigationBar(),
      body: BlocProvider(
        create: (_) =>
        ChatBloc()..add(const ChatEvent.onLoadChats()),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
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
                      constraints:
                      const BoxConstraints(maxWidth: 700),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: CustomAppBar(
                              title: 'Messages',
                              subtitle:
                              'Chat with your students and\nstay connected.',
                              image: AppImages.icNotificationHeader,
                              showBackButton: false,
                            ),
                          ),
                          Padding(
                            padding:
                            const EdgeInsets.fromLTRB(
                              16,
                              0,
                              16,
                              0,
                            ),
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.stretch,
                              children: [
                                _buildSearch(context, state),
                                const SizedBox(height: 15),
                                Align(
                                  alignment:
                                  Alignment.centerRight,
                                  child: _buildNewChatButton(
                                    context,
                                    compact: true,
                                  ),
                                ),
                                const SizedBox(height: 17),
                                if (state.students.isNotEmpty)
                                  _buildHeading(
                                    context,
                                    state,
                                  ),
                                if (state.students.isNotEmpty)
                                  const SizedBox(height: 13),
                              ],
                            ),
                          ),
                          Expanded(
                            child: state.students.isEmpty
                                ? state.isLoading
                                ? const SizedBox.shrink()
                                : _buildEmptyState(
                              context,
                              state,
                            )
                                : ListView.separated(
                              keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior
                                  .onDrag,
                              padding:
                              const EdgeInsets.fromLTRB(
                                16,
                                0,
                                16,
                                16,
                              ),
                              itemCount:
                              state.students.length,
                              separatorBuilder:
                                  (_, __) =>
                              const SizedBox(
                                height: 11,
                              ),
                              itemBuilder:
                                  (context, index) {
                                return _buildStudentCard(
                                  context,
                                  state.students[index],
                                );
                              },
                            ),
                          ),
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

  Widget _buildSearch(
      BuildContext context,
      ChatState state,
      ) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextField(
        controller: state.searchController,
        onChanged: (value) {
          context.read<ChatBloc>().add(
            ChatEvent.onSearchChats(query: value),
          );
        },
        textInputAction: TextInputAction.search,
        onSubmitted: (_) {
          FocusScope.of(context).unfocus();
        },
        cursorColor: AppColors.purple,
        style: TextStyle(
          color: AppColors.ink,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          hintText: 'Search students...',
          hintStyle: TextStyle(
            color: AppColors.muted,
            fontSize: 14,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.ink,
            size: 24,
          ),
          suffixIcon:
          ValueListenableBuilder<TextEditingValue>(
            valueListenable: state.searchController,
            builder: (context, value, child) {
              if (value.text.isEmpty) {
                return const SizedBox.shrink();
              }

              return IconButton(
                tooltip: 'Clear search',
                onPressed: () {
                  state.searchController.clear();

                  context.read<ChatBloc>().add(
                    const ChatEvent.onSearchChats(
                      query: '',
                    ),
                  );
                },
                icon: Icon(
                  Icons.close_rounded,
                  color: AppColors.muted,
                  size: 20,
                ),
              );
            },
          ),
          filled: true,
          fillColor: AppColors.white,
          contentPadding:
          const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 15,
          ),
          border: _searchBorder(),
          enabledBorder: _searchBorder(),
          focusedBorder: _searchBorder(
            color: AppColors.purple,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _searchBorder({
    Color? color,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: BorderSide(
        color: color ??
            AppColors.purple.withValues(alpha: 0.18),
        width: 1.2,
      ),
    );
  }

  Widget _buildHeading(
      BuildContext context,
      ChatState state,
      ) {
    return ValueListenableBuilder<TextEditingValue>(
      valueListenable: state.searchController,
      builder: (context, value, child) {
        return Text(
          value.text.trim().isEmpty
              ? 'Student chats'
              : 'Search results',
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 19,
            fontWeight: FontWeight.w800,
          ),
        );
      },
    );
  }

  Widget _buildNewChatButton(
      BuildContext context, {
        bool compact = false,
      }) {
    return ElevatedButton.icon(
      onPressed: () {
        FocusScope.of(context).unfocus();

        Navigator.pushNamed(
          context,
          RouteName.newChatScreen,
        );
      },
      icon: Icon(
        Icons.add_rounded,
        size: compact ? 20 : 23,
      ),
      label: Text(
        'New Chat',
        style: TextStyle(
          fontSize: compact ? 13 : 15,
          fontWeight: FontWeight.w700,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.purple,
        foregroundColor: AppColors.white,
        elevation: 2,
        shadowColor:
        AppColors.purple.withValues(alpha: 0.25),
        minimumSize: Size(0, compact ? 44 : 48),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 17 : 24,
          vertical: compact ? 10 : 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius:
          BorderRadius.circular(compact ? 13 : 15),
        ),
      ),
    );
  }

  Widget _buildStudentCard(
      BuildContext context,
      ChatListData student,
      ) {
    final index = _colorIndex(student);
    final accent = Utils.getCardBorderColor(index);
    final background = Utils.getCardBackgroundColor(index);
    final name = (student.name ?? '').trim();

    return Material(
      color: background.withValues(alpha: 0.45),
      elevation: 1,
      shadowColor: accent.withValues(alpha: 0.10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: BorderSide(
          color: accent.withValues(alpha: 0.55),
          width: 1.3,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            RouteName.chatDetailScreen,
            arguments: student.id,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 12,
          ),
          child: Row(
            children: [
              _buildAvatar(
                student,
                accent: accent,
                background: background,
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isEmpty ? 'Student' : name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.ink,
                        fontSize: 15,
                        height: 1.25,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 7),
                    Container(
                      padding:
                      const EdgeInsets.symmetric(
                        horizontal: 11,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: accent.withValues(
                          alpha: 0.12,
                        ),
                        borderRadius:
                        BorderRadius.circular(18),
                      ),
                      child: Text(
                        'Roll No. ${student.rollNumber ?? '-'}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: accent,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 11),
              Container(
                width: 44,
                height: 44,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.11),
                  borderRadius:
                  BorderRadius.circular(13),
                ),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: accent,
                  size: 23,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAvatar(
      ChatListData student, {
        required Color accent,
        required Color background,
      }) {
    final name = (student.name ?? '').trim();
    final imageUrl =
    (student.profileImage ?? '').trim();

    final fallback = Container(
      alignment: Alignment.center,
      color: background,
      child: Text(
        name.isEmpty
            ? 'S'
            : name.characters.first.toUpperCase(),
        style: TextStyle(
          color: accent,
          fontSize: 23,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    return Container(
      width: 57,
      height: 57,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(
          color: accent.withValues(alpha: 0.40),
          width: 1.3,
        ),
      ),
      child: ClipOval(
        child: imageUrl.isEmpty
            ? fallback
            : Image.network(
          imageUrl,
          width: 53,
          height: 53,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => fallback,
          loadingBuilder: (_, child, progress) {
            return progress == null
                ? child
                : fallback;
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState(
      BuildContext context,
      ChatState state,
      ) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: ValueListenableBuilder<TextEditingValue>(
          valueListenable: state.searchController,
          builder: (context, value, child) {
            final isSearching =
                value.text.trim().isNotEmpty;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSearching)
                  Container(
                    width: 90,
                    height: 90,
                    decoration: BoxDecoration(
                      color:
                      Utils.getCardBackgroundColor(0),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.search_off_rounded,
                      size: 42,
                      color: AppColors.purple,
                    ),
                  )
                else
                  _buildChatIllustration(),
                const SizedBox(height: 19),
                Text(
                  isSearching
                      ? 'No matching students'
                      : 'No conversations yet',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 19,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 9),
                Text(
                  isSearching
                      ? 'Try another name, GR or roll number.'
                      : 'Start a new chat with a student.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 20),
                if (isSearching)
                  TextButton.icon(
                    onPressed: () {
                      state.searchController.clear();

                      context.read<ChatBloc>().add(
                        const ChatEvent.onSearchChats(
                          query: '',
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.close_rounded,
                      size: 19,
                    ),
                    label: const Text('Clear search'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.purple,
                    ),
                  )
                else ...[
                  TextButton.icon(
                    onPressed: () {
                      context.read<ChatBloc>().add(
                        const ChatEvent.onLoadChats(),
                      );
                    },
                    icon: const Icon(
                      Icons.refresh_rounded,
                      size: 18,
                    ),
                    label: const Text('Refresh'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.muted,
                    ),
                  ),
                ],
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatIllustration() {
    return ExcludeSemantics(
      child: SizedBox(
        width: 150,
        height: 115,
        child: Image.asset(
          AppImages.icNotificationHeader,
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  int _colorIndex(ChatListData student) {
    final key =
        student.id?.toString() ?? student.name ?? '';

    return key.codeUnits.fold<int>(
      0,
          (sum, value) => sum + value,
    ) %
        6;
  }
}
