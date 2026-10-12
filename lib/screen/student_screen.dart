
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/my_student/my_student_bloc.dart';
import 'package:pabulum_teacher/model/my_students.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/screen/student_detail_dialog.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocProvider(
        create: (context) =>
        MyStudentBloc()..add(OnLoadMyStudents()),
        child: BlocBuilder<MyStudentBloc, MyStudentState>(
          builder: (context, state) {
            return Stack(
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
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            child: CustomAppBar(
                              title: 'Students',
                              subtitle:
                              'Find and manage your students\nwith ease.',
                              image: AppImages.icStudent,
                            ),
                          ),
                          Expanded(
                            child: CustomScrollView(
                              keyboardDismissBehavior:
                              ScrollViewKeyboardDismissBehavior
                                  .onDrag,
                              slivers: [
                                SliverPadding(
                                  padding:
                                  const EdgeInsets.fromLTRB(
                                    16,
                                    0,
                                    16,
                                    0,
                                  ),
                                  sliver: SliverToBoxAdapter(
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        TextField(
                                          controller:
                                          state.studentNameController,
                                          onChanged: (value) {
                                            context
                                                .read<MyStudentBloc>()
                                                .add(
                                              MyStudentEvent
                                                  .onLoadMyStudents(
                                                query: value,
                                                debounce: true,
                                              ),
                                            );
                                          },
                                          textInputAction:
                                          TextInputAction.search,
                                          onSubmitted: (value) {
                                            FocusScope.of(context)
                                                .unfocus();
                                            context
                                                .read<MyStudentBloc>()
                                                .add(
                                              MyStudentEvent
                                                  .onLoadMyStudents(
                                                query: value,
                                              ),
                                            );
                                          },
                                          style: TextStyle(
                                            color: AppColors.ink,
                                            fontSize: 14,
                                          ),
                                          decoration: InputDecoration(
                                            hintText:
                                            'Search student name',
                                            hintStyle: TextStyle(
                                              color: AppColors.muted,
                                              fontSize: 13,
                                            ),
                                            prefixIcon: Icon(
                                              Icons.search_rounded,
                                              color: AppColors.purple,
                                              size: 25,
                                            ),
                                            suffixIcon:
                                            state.query.isNotEmpty
                                                ? IconButton(
                                              tooltip:
                                              'Clear search',
                                              onPressed: () {
                                                state
                                                    .studentNameController
                                                    .clear();

                                                context
                                                    .read<
                                                    MyStudentBloc>()
                                                    .add(
                                                  const MyStudentEvent
                                                      .onLoadMyStudents(
                                                    query: '',
                                                  ),
                                                );
                                              },
                                              icon: Icon(
                                                Icons.close_rounded,
                                                color:
                                                AppColors.muted,
                                              ),
                                            )
                                                : null,
                                            filled: true,
                                            fillColor:
                                            AppColors.surface,
                                            contentPadding:
                                            const EdgeInsets.symmetric(
                                              horizontal: 14,
                                              vertical: 16,
                                            ),
                                            border: _searchBorder(),
                                            enabledBorder:
                                            _searchBorder(),
                                            focusedBorder:
                                            _searchBorder(
                                              color: AppColors.purple,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 22),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                state.isLoading
                                                    ? 'Search results'
                                                    : 'All students',
                                                style: TextStyle(
                                                  color: AppColors.ink,
                                                  fontSize: 20,
                                                  fontWeight:
                                                  FontWeight.w800,
                                                ),
                                              ),
                                            ),
                                            Text(
                                              '${state.arrMyStudents.length} '
                                                  '${state.arrMyStudents.length == 1 ? 'student' : 'students'}',
                                              style: TextStyle(
                                                color: AppColors.muted,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 12),
                                      ],
                                    ),
                                  ),
                                ),
                                if (state.arrMyStudents.isEmpty)
                                  SliverToBoxAdapter(
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.symmetric(
                                        vertical: 45,
                                      ),
                                      child: Column(
                                        children: [
                                          Icon(
                                            Icons.person_search_rounded,
                                            color: AppColors.purple,
                                            size: 48,
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            state.isLoading
                                                ? 'No students found'
                                                : 'No students yet',
                                            style: TextStyle(
                                              color: AppColors.ink,
                                              fontSize: 15,
                                              fontWeight:
                                              FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                else
                                  SliverPadding(
                                    padding:
                                    const EdgeInsets.fromLTRB(
                                      16,
                                      0,
                                      16,
                                      16,
                                    ),
                                    sliver: SliverList(
                                      delegate:
                                      SliverChildBuilderDelegate(
                                            (context, index) {
                                          final student =
                                          state.arrMyStudents[index];

                                          return Padding(
                                            padding:
                                            const EdgeInsets.only(
                                              bottom: 10,
                                            ),
                                            child: _StudentCard(
                                              key: ValueKey(student.id),
                                              student: student,
                                              index: index,
                                              onTap: () {
                                                StudentDetailsDialog.show(
                                                  context,
                                                  student,
                                                );
                                              },
                                            ),
                                          );
                                        },
                                        childCount:
                                        state.arrMyStudents.length,
                                      ),
                                    ),
                                  ),
                              ],
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

  OutlineInputBorder _searchBorder({
    Color? color,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: BorderSide(
        color: color ?? AppColors.colorGrey1,
      ),
    );
  }
}

class _StudentCard extends StatelessWidget {
  const _StudentCard({
    super.key,
    required this.student,
    required this.index,
    this.onTap,
  });

  final MyStudent student;
  final int index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final borderColor = Utils.getCardBorderColor(index);

    return Container(
      height: 94,
      decoration: Utils.cardDecoration(
        index: index,
        radius: 20,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
            ),
            child: Row(
              children: [
                _StudentAvatar(student: student),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.ink,
                          fontSize: 16,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Roll number: ${student.rollNumber ?? '—'}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.muted,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null)
                  Icon(
                    Icons.chevron_right_rounded,
                    color: borderColor,
                    size: 27,
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StudentAvatar extends StatelessWidget {
  const _StudentAvatar({
    required this.student,
  });

  final MyStudent student;

  Widget _fallback() {
    return Image.asset(
      AppImages.icProfile,
      fit: BoxFit.cover,
    );
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = student.profileImage?.trim();

    return ExcludeSemantics(
      child: ClipOval(
        child: SizedBox(
          width: 56,
          height: 56,
          child: imageUrl != null && imageUrl.isNotEmpty
              ? Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder:
                (context, error, stackTrace) {
              return _fallback();
            },
            loadingBuilder:
                (context, child, progress) {
              return progress == null
                  ? child
                  : _fallback();
            },
          )
              : _fallback(),
        ),
      ),
    );
  }
}
