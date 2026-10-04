import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:pabulum_teacher/bloc/chat/chat_bloc.dart';
import 'package:pabulum_teacher/model/chat_list_model.dart';
import 'package:pabulum_teacher/routes/routes_name.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

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
        'Messages',
        context,
        isBack: false,
        onBackPress: () => Navigator.of(context).pop(),
      ),
      body: BlocProvider(
        create: (_) => ChatBloc()..add(const ChatEvent.onLoadChats()),
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
                            padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                _buildSearch(context, state),
                                if (state.students.isNotEmpty) ...[
                                  const SizedBox(height: 16),
                                  _buildHeading(context, state),
                                  const SizedBox(height: 12),
                                ],
                              ],
                            ),
                          ),
                          Expanded(
                            child: state.students.isEmpty
                                ? state.isLoading
                                      ? const SizedBox.shrink()
                                      : _buildEmptyState(context, state)
                                : ListView.separated(
                                    keyboardDismissBehavior:
                                        ScrollViewKeyboardDismissBehavior
                                            .onDrag,
                                    padding: const EdgeInsets.fromLTRB(
                                      16,
                                      0,
                                      16,
                                      16,
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
      bottomNavigationBar: Utils.navigationBar(),
    );
  }

  Widget _buildSearch(BuildContext context, ChatState state) {
    return TextField(
      controller: state.searchController,
      onChanged: (value) {
        context.read<ChatBloc>().add(ChatEvent.onSearchChats(query: value));
      },
      textInputAction: TextInputAction.search,
      onSubmitted: (_) {
        FocusScope.of(context).unfocus();
      },
      cursorColor: _green,
      style: const TextStyle(color: _green, fontSize: 14),
      decoration: InputDecoration(
        hintText: 'Search students...',
        hintStyle: const TextStyle(color: _muted, fontSize: 14),
        prefixIcon: const Icon(Icons.search_rounded, color: _muted, size: 23),
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
              icon: const Icon(Icons.close_rounded, color: _muted, size: 20),
            );
          },
        ),
        filled: true,
        fillColor: const Color(0xFFF0EFE7),
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

  OutlineInputBorder _searchBorder({Color color = const Color(0xFFE3E3D9)}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(15),
      borderSide: BorderSide(color: color),
    );
  }

  Widget _buildHeading(BuildContext context, ChatState state) {
    return Row(
      children: [
        Expanded(
          child: ValueListenableBuilder<TextEditingValue>(
            valueListenable: state.searchController,
            builder: (context, value, child) {
              return Text(
                value.text.trim().isEmpty ? 'Student chats' : 'Search results',
                style: const TextStyle(
                  color: _muted,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 12),
        _buildNewChatButton(context, compact: true),
      ],
    );
  }

  Widget _buildNewChatButton(BuildContext context, {bool compact = false}) {
    return ElevatedButton.icon(
      onPressed: () {
        FocusScope.of(context).unfocus();

        Navigator.pushNamed(context, RouteName.newChatScreen);
      },
      icon: Icon(Icons.add_rounded, size: compact ? 20 : 23),
      label: Text(
        'New Chat',
        style: TextStyle(
          fontSize: compact ? 13 : 15,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: _green,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: Size(0, compact ? 44 : 48),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 13 : 24,
          vertical: compact ? 10 : 14,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(compact ? 11 : 15),
        ),
      ),
    );
  }

  Widget _buildStudentCard(BuildContext context, ChatListData student) {
    final colors = _paletteFor(student);
    final background = colors[0];
    final border = colors[1];
    final iconBackground = colors[2];
    final accent = colors[3];

    final name = (student.name ?? '').trim();

    return GestureDetector(
      onTap: () {
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
              color: accent.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
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
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 13, 14, 13),
                child: Row(
                  children: [
                    _buildAvatar(
                      student,
                      accent: accent,
                      background: iconBackground,
                    ),
                    const SizedBox(width: 13),
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
                          const SizedBox(height: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 4,
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
                                color: Color.lerp(accent, _green, 0.35),
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
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: iconBackground,
                        borderRadius: BorderRadius.circular(11),
                      ),
                      child: Icon(
                        Icons.chat_bubble_outline_rounded,
                        color: accent,
                        size: 21,
                      ),
                    ),
                  ],
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
    final imageUrl = (student.profileImage ?? '').trim();

    final fallback = Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color.lerp(accent, Colors.white, 0.08)!, accent],
        ),
      ),
      child: Text(
        name.isEmpty ? 'S' : name.characters.first.toUpperCase(),
        style: const TextStyle(
          color: Colors.white,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
      ),
    );

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(color: background, shape: BoxShape.circle),
      child: ClipOval(
        child: imageUrl.isEmpty
            ? fallback
            : Image.network(
                imageUrl,
                width: 52,
                height: 52,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => fallback,
                loadingBuilder: (_, child, progress) {
                  return progress == null ? child : fallback;
                },
              ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ChatState state) {
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
                if (isSearching)
                  Container(
                    width: 90,
                    height: 90,
                    decoration: const BoxDecoration(
                      color: Color(0xFFDDE2D0),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.search_off_rounded,
                      size: 42,
                      color: _green,
                    ),
                  )
                else
                  _buildChatIllustration(),
                const SizedBox(height: 24),
                Text(
                  isSearching ? 'No matching students' : 'No conversations yet',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _green,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  isSearching
                      ? 'Try another name, GR or roll number.'
                      : 'Start a new chat with a student.',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 24),
                if (isSearching)
                  TextButton.icon(
                    onPressed: () {
                      state.searchController.clear();

                      context.read<ChatBloc>().add(
                        const ChatEvent.onSearchChats(query: ''),
                      );
                    },
                    icon: const Icon(Icons.close_rounded, size: 19),
                    label: const Text('Clear search'),
                    style: TextButton.styleFrom(foregroundColor: _green),
                  )
                else ...[
                  _buildNewChatButton(context),
                  const SizedBox(height: 8),
                  TextButton.icon(
                    onPressed: () {
                      context.read<ChatBloc>().add(
                        const ChatEvent.onLoadChats(),
                      );
                    },
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('Refresh'),
                    style: TextButton.styleFrom(foregroundColor: _muted),
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
        width: 160,
        height: 115,
        child: Stack(
          children: [
            const Positioned(
              left: 0,
              top: 0,
              child: Icon(
                Icons.mode_comment_rounded,
                size: 112,
                color: Color(0xFFD9E1D0),
              ),
            ),
            Positioned(
              left: 28,
              top: 43,
              child: Row(
                children: List.generate(
                  3,
                  (index) => Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 9),
                    decoration: const BoxDecoration(
                      color: Color(0xFFADBEA7),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
            ),
            const Positioned(
              right: 0,
              bottom: 0,
              child: Icon(
                Icons.mode_comment_rounded,
                size: 76,
                color: Color(0xFF678D79),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Color> _paletteFor(ChatListData student) {
    final key = student.id?.toString() ?? student.name ?? '';

    final index =
        key.codeUnits.fold<int>(0, (sum, value) => sum + value) %
        _palettes.length;

    return _palettes[index];
  }
}
