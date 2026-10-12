
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/chat/chat_bloc.dart';
import 'package:pabulum_teacher/model/chat_list_model.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              AppImages.icBackgroundAll,
              fit: BoxFit.cover,
            ),
          ),
          BlocProvider(
            create: (_) => ChatBloc()
              ..add(const ChatEvent.onLoadAllStudent()),
            child: BlocBuilder<ChatBloc, ChatState>(
              builder: (context, state) {
                return Stack(
                  children: [
                    SafeArea(
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: ConstrainedBox(
                          constraints: const BoxConstraints(
                            maxWidth: 700,
                          ),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                child: CustomAppBar(
                                  title: 'New Chat',
                                  subtitle:
                                  'Choose a student and\nstart a conversation.',
                                  image: AppImages.icNotificationHeader,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  12,
                                ),
                                child: _buildSearch(context, state),
                              ),
                              Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  12,
                                ),
                                child: _buildHeading(state),
                              ),
                              Expanded(
                                child: state.students.isEmpty
                                    ? state.isLoading
                                    ? const SizedBox.shrink()
                                    : _buildEmptyState(
                                  context,
                                  state,
                                )
                                    : Scrollbar(
                                  child: ListView.separated(
                                    keyboardDismissBehavior:
                                    ScrollViewKeyboardDismissBehavior
                                        .onDrag,
                                    padding:
                                    const EdgeInsets.fromLTRB(
                                      16,
                                      0,
                                      16,
                                      20,
                                    ),
                                    itemCount: state.students.length,
                                    separatorBuilder: (_, __) =>
                                    const SizedBox(height: 9),
                                    itemBuilder: (context, index) {
                                      return _buildStudentCard(
                                        context,
                                        state.students[index],
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
                    if (state.isLoading) Utils.loaderBrier(),
                    if (state.isLoading) Utils.loaderWid(),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearch(
      BuildContext context,
      ChatState state,
      ) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.05),
            blurRadius: 9,
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
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
        decoration: InputDecoration(
          hintText: 'Search name or roll number...',
          hintStyle: TextStyle(
            color: AppColors.muted,
            fontSize: 12,
          ),
          prefixIcon: Icon(
            Icons.search_rounded,
            color: AppColors.purple,
            size: 22,
          ),
          suffixIcon: ValueListenableBuilder<TextEditingValue>(
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
                    const ChatEvent.onSearchChats(query: ''),
                  );
                },
                icon: Icon(
                  Icons.close_rounded,
                  color: AppColors.muted,
                  size: 19,
                ),
              );
            },
          ),
          filled: true,
          fillColor: AppColors.surface,
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 13,
            vertical: 14,
          ),
          enabledBorder: _searchBorder(),
          focusedBorder: _searchBorder(
            color: AppColors.purple,
            width: 1.4,
          ),
        ),
      ),
    );
  }

  OutlineInputBorder _searchBorder({
    Color? color,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(
        color: color ??
            AppColors.purple.withValues(alpha: 0.20),
        width: width,
      ),
    );
  }

  Widget _buildHeading(ChatState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          Icon(
            Icons.groups_2_rounded,
            color: AppColors.colorPrimaryBlue,
            size: 24,
          ),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Select a Student',
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  'Tap a student to start chatting',
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStudentCard(
      BuildContext context,
      ChatListData student,
      ) {
    final palette = _paletteFor(student);

    final background = palette[0];
    final borderColor = palette[1];
    final accentColor = palette[2];

    final name = (student.name ?? '').trim();

    return Material(
      color: background,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: borderColor,
          width: 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          final studentId = int.tryParse('${student.id}');

          if (studentId == null) {
            Utils.showToast('Student ID is missing.', false);
            return;
          }

          FocusScope.of(context).unfocus();

          Navigator.pushNamed(
            context,
            RouteName.chatDetailScreen,
            arguments: studentId,
          );
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 11,
          ),
          child: Row(
            children: [
              _buildAvatar(
                student,
                accent: accentColor,
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name.isEmpty ? 'Student' : name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.ink,
                        fontSize: 14,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(
                          Icons.badge_outlined,
                          size: 14,
                          color: accentColor,
                        ),
                        const SizedBox(width: 5),
                        Expanded(
                          child: Text(
                            'Roll No. ${student.rollNumber ?? '-'}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: AppColors.muted,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: accentColor.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: Icon(
                  Icons.chat_bubble_outline_rounded,
                  color: accentColor,
                  size: 19,
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
      }) {
    final name = (student.name ?? '').trim();
    final imageUrl = (student.profileImage ?? '').trim();

    final fallback = Container(
      alignment: Alignment.center,
      color: accent.withValues(alpha: 0.12),
      child: Text(
        name.isEmpty ? 'S' : name.characters.first.toUpperCase(),
        style: TextStyle(
          color: accent,
          fontSize: 20,
          fontWeight: FontWeight.w800,
        ),
      ),
    );

    return Container(
      width: 47,
      height: 47,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: accent.withValues(alpha: 0.35),
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
            final isSearching = value.text.trim().isNotEmpty;

            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 86,
                  height: 86,
                  decoration: BoxDecoration(
                    color:
                    AppColors.purple.withValues(alpha: 0.09),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: AppColors.purple.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Icon(
                    isSearching
                        ? Icons.search_off_rounded
                        : Icons.people_outline_rounded,
                    color: AppColors.purple,
                    size: 38,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  isSearching
                      ? 'No matching students'
                      : 'No students available',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.ink,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 7),
                Text(
                  isSearching
                      ? 'Try another name or roll number.'
                      : 'Tap refresh to check for students.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 12,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 17),
                ElevatedButton.icon(
                  onPressed: () {
                    if (isSearching) {
                      state.searchController.clear();

                      context.read<ChatBloc>().add(
                        const ChatEvent.onSearchChats(
                          query: '',
                        ),
                      );
                    } else {
                      context.read<ChatBloc>().add(
                        const ChatEvent.onLoadAllStudent(),
                      );
                    }
                  },
                  icon: Icon(
                    isSearching
                        ? Icons.close_rounded
                        : Icons.refresh_rounded,
                    size: 19,
                  ),
                  label: Text(
                    isSearching ? 'Clear search' : 'Refresh',
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.purple,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  List<Color> _paletteFor(ChatListData student) {
    final key = student.id?.toString() ?? student.name ?? '';

    final index = key.codeUnits.fold<int>(
      0,
          (sum, value) => sum + value,
    ) %
        4;

    switch (index) {
      case 0:
        return [
          AppColors.surface,
          AppColors.purple.withValues(alpha: 0.28),
          AppColors.purple,
        ];
      case 1:
        return [
          AppColors.surface,
          AppColors.colorPrimaryBlue.withValues(alpha: 0.28),
          AppColors.colorPrimaryBlue,
        ];
      case 2:
        return [
          AppColors.surface,
          AppColors.green.withValues(alpha: 0.28),
          AppColors.green,
        ];
      default:
        return [
          AppColors.surface,
          AppColors.colorPrimaryOrange.withValues(alpha: 0.28),
          AppColors.colorPrimaryOrange,
        ];
    }
  }
}
