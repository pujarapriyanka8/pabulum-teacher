import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/chat/chat_bloc.dart';
import 'package:pabulum_teacher/model/chat_list_model.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class NewChatScreen extends StatelessWidget {
  const NewChatScreen({super.key});

  static const Color _background = Color(0xFFF5F1E9);
  static const Color _green = Color(0xFF174C43);
  static const Color _muted = Color(0xFF788781);

  // Background, border, badge background, accent.
  static const _palettes = [
    [
      Color(0xFFF0FAF7),
      Color(0xFFB8E4DA),
      Color(0xFFDDF3ED),
      Color(0xFF008C7D),
    ],
    [
      Color(0xFFF7F3FF),
      Color(0xFFD4C5FC),
      Color(0xFFECE4FF),
      Color(0xFF7550E8),
    ],
    [
      Color(0xFFF0F6FF),
      Color(0xFFBDD5F5),
      Color(0xFFDFECFC),
      Color(0xFF4389CA),
    ],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _background,
      appBar: Utils.customAppBar(
        'New Chat',
        context,
        isBack: true,
        onBackPress: () => Navigator.of(context).pop(),
      ),
      body: BlocProvider(
        create: (_) => ChatBloc()
          ..add(const ChatEvent.onLoadAllStudent()),
        child: BlocBuilder<ChatBloc, ChatState>(
          builder: (context, state) {
            return Stack(
              children: [
                SafeArea(
                  top: false,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 700),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                              16,
                              16,
                              16,
                              0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildSearch(context, state),
                                const SizedBox(height: 22),
                                _buildHeading(),
                                const SizedBox(height: 16),
                              ],
                            ),
                          ),
                          Expanded(
                            child: state.students.isEmpty
                                ? state.isLoading
                                ? const SizedBox.shrink()
                                : _buildEmptyState(context, state)
                                : Scrollbar(
                              child: ListView.separated(
                                keyboardDismissBehavior:
                                ScrollViewKeyboardDismissBehavior
                                    .onDrag,
                                padding: const EdgeInsets.fromLTRB(
                                  16,
                                  0,
                                  16,
                                  20,
                                ),
                                itemCount: state.students.length,
                                separatorBuilder: (_, __) =>
                                const SizedBox(height: 10),
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
    );
  }

  Widget _buildSearch(
      BuildContext context,
      ChatState state,
      ) {
    return TextField(
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
      cursorColor: _green,
      style: const TextStyle(
        color: _green,
        fontSize: 14,
      ),
      decoration: InputDecoration(
        hintText: 'Search name or roll number...',
        hintStyle: const TextStyle(
          color: _muted,
          fontSize: 13,
        ),
        prefixIcon: const Icon(
          Icons.search_rounded,
          color: _muted,
          size: 23,
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
              icon: const Icon(
                Icons.close_rounded,
                color: _muted,
                size: 20,
              ),
            );
          },
        ),
        filled: true,
        fillColor: const Color(0xFFFFFCF7),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 15,
        ),
        border: _searchBorder(),
        enabledBorder: _searchBorder(),
        focusedBorder: _searchBorder(color: _green),
      ),
    );
  }

  OutlineInputBorder _searchBorder({
    Color color = const Color(0xFFE3E3D9),
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildHeading() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select a student',
          style: TextStyle(
            color: _green,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 6),
        Text(
          'Tap a student to start chatting',
          style: TextStyle(
            color: _muted,
            fontSize: 13,
            height: 1.4,
          ),
        ),
      ],
    );
  }

  Widget _buildStudentCard(
      BuildContext context,
      ChatListData student,
      ) {
    final colors = _paletteFor(student);

    final background = colors[0];
    final border = colors[1];
    final iconBackground = colors[2];
    final accent = colors[3];

    final name = (student.name ?? '').trim();

    return GestureDetector(
      onTap: (){
        Navigator.pushNamed(
          context,
          RouteName.chatDetailScreen,
          arguments: student.id,
        );
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: accent.withValues(alpha: 0.05),
              blurRadius: 7,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Material(
          color: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(color: border),
          ),
          clipBehavior: Clip.antiAlias,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              15,
              11,
              13,
              11,
            ),
            child: Row(
              children: [
                _buildAvatar(
                  student,
                  accent: accent,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name.isEmpty ? 'Student' : name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _green,
                          fontSize: 15,
                          height: 1.25,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 9,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: iconBackground,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Roll No. ${student.rollNumber ?? '-'}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.lerp(
                              accent,
                              _green,
                              0.35,
                            ),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: iconBackground,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: accent,
                    size: 20,
                  ),
                ),
              ],
            ),
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
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.lerp(accent, Colors.white, 0.08)!,
            accent,
          ],
        ),
      ),
      child: Text(
        name.isEmpty ? 'S' : name.characters.first.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    return ClipOval(
      child: SizedBox(
        width: 48,
        height: 48,
        child: imageUrl.isEmpty
            ? fallback
            : Image.network(
          imageUrl,
          width: 48,
          height: 48,
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
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: const Color(0xFFDDE2D0),
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Icon(
                    isSearching
                        ? Icons.search_off_rounded
                        : Icons.people_outline_rounded,
                    color: _green,
                    size: 40,
                  ),
                ),
                const SizedBox(height: 18),
                Text(
                  isSearching
                      ? 'No matching students'
                      : 'No students available',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _green,
                    fontSize: 19,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  isSearching
                      ? 'Try another name or roll number.'
                      : 'Tap refresh to check for students.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 18),
                TextButton.icon(
                  onPressed: () {
                    if (isSearching) {
                      state.searchController.clear();

                      context.read<ChatBloc>().add(
                        const ChatEvent.onSearchChats(query: ''),
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
                    size: 20,
                  ),
                  label: Text(
                    isSearching ? 'Clear search' : 'Refresh',
                  ),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: _green,
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
        _palettes.length;

    return _palettes[index];
  }

  void _selectStudent(
      BuildContext context,
      ChatListData student,
      ) {
    final studentId = int.tryParse('${student.id}');

    if (studentId == null) {
      Utils.showToast('Student ID is missing.', false);
      return;
    }

    FocusScope.of(context).unfocus();

    Navigator.of(context).pop<ChatListData>(student);
  }
}