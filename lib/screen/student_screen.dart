import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pabulum_teacher/bloc/my_student/my_student_bloc.dart';
import 'package:pabulum_teacher/model/my_students.dart';
import 'package:pabulum_teacher/screen/student_detail_dialog.dart';
import 'package:pabulum_teacher/utils/app_images.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class StudentsScreen extends StatelessWidget {
  const StudentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FC),
      appBar: Utils.customAppBar(
        'Students',
        context,
        isBack: true,
        onBackPress: () {
          Navigator.of(context).pop();

        },
      ),
      body: BlocProvider(
        create: (context) =>
        MyStudentBloc()
          ..add(OnLoadMyStudents()),
        child: BlocBuilder<MyStudentBloc, MyStudentState>(
          builder: (context, state) {
            return Stack(
              children:[ SafeArea(
                top: false,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 700),
                    child: CustomScrollView(
                      keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                      slivers: [
                        SliverPadding(
                          padding: const EdgeInsets.fromLTRB(20, 24, 20, 0),
                          sliver: SliverToBoxAdapter(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Find a student by name',
                                  style: TextStyle(
                                    color: Color(0xFF737B90),
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 12),
                                TextField(
                                  controller:state.studentNameController,
                                  onChanged: (value) {
                                    context.read<MyStudentBloc>().add(
                                      MyStudentEvent.onLoadMyStudents(
                                        query: value,
                                        debounce: true,
                                      ),
                                    );
                                  },
                                  textInputAction: TextInputAction.search,
                                  onSubmitted: (value) {
                                    FocusScope.of(context).unfocus();
                                    context.read<MyStudentBloc>().add(
                                      MyStudentEvent.onLoadMyStudents(
                                        query: value,
                                      ),
                                    );
                                  },
                                  style: const TextStyle(
                                    color: Color(0xFF202329),
                                    fontSize: 15,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Search student name',
                                    hintStyle: const TextStyle(
                                      color: Color(0xFF9399AA),
                                      fontSize: 15,
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.search_rounded,
                                      color: Color(0xFF737B90),
                                      size: 25,
                                    ),
                                    suffixIcon: state.query.isNotEmpty
                                        ? IconButton(
                                      tooltip: 'Clear search',
                                      onPressed: (){
                                        state.studentNameController.clear();
                                        context.read<MyStudentBloc>().add(
                                          const MyStudentEvent.onLoadMyStudents(query: ''),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.close_rounded,
                                        color: Color(0xFF737B90),
                                      ),
                                    )
                                        : null,
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 16,
                                    ),
                                    border: _searchBorder(),
                                    enabledBorder: _searchBorder(),
                                    focusedBorder: _searchBorder(
                                      color: const Color(0xFF5746FF),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 28),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        state.isLoading
                                            ? 'Search results'
                                            : 'All students',
                                        style: const TextStyle(
                                          color: Color(0xFF202329),
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    Text(
                                      '${state.arrMyStudents.length} '
                                          '${state.arrMyStudents.length == 1
                                          ? 'student'
                                          : 'students'}',
                                      style: const TextStyle(
                                        color: Color(0xFF737B90),
                                        fontSize: 13,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 18),
                              ],
                            ),
                          ),
                        ),
                        if (state.arrMyStudents.isEmpty)
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(24, 40, 24, 24),
                              child: Column(
                                children: [
                                  const Icon(
                                    Icons.person_search_outlined,
                                    size: 48,
                                    color: Color(0xFF9399AA),
                                  ),
                                  const SizedBox(height: 14),
                                  Text(
                                    state.isLoading
                                        ? 'No students found'
                                        : 'No students yet',
                                    style: const TextStyle(
                                      color: Color(0xFF202329),
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          )
                        else
                          SliverPadding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                            sliver: SliverList(
                              delegate: SliverChildBuilderDelegate((context,
                                  index,) {
                                final student = state.arrMyStudents[index];

                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 14),
                                  child: _StudentCard(
                                    key: ValueKey(student.id),
                                    student: student,
                                    onTap: () {
                                      StudentDetailsDialog.show(context, student);

                                    },
                                  ),
                                );
                              }, childCount: state.arrMyStudents.length),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
                if(state.isLoading)Utils.loaderBrier(),
                if(state.isLoading)Utils.loaderWid()
              ]
            );
          },
        ),
      ),
    );
  }

  OutlineInputBorder _searchBorder({Color color = const Color(0xFFE4E7EF)}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(14),
      borderSide: BorderSide(color: color),
    );
  }
}

class _StudentCard extends StatelessWidget {
  const _StudentCard({super.key, required this.student, this.onTap});

  final MyStudent student;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    const radius = BorderRadius.all(Radius.circular(18));

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: radius,
        boxShadow: [
          BoxShadow(
            color: Color(0x06000000),
            blurRadius: 16,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        borderRadius: radius,
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          splashColor: const Color(0x145746FF),
          highlightColor: const Color(0x085746FF),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                _StudentAvatar(student: student),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        student.name ?? '',
                        style: const TextStyle(
                          color: Color(0xFF202329),
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Roll number: ${student.rollNumber}',
                        style: const TextStyle(
                          color: Color(0xFF737B90),
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                if (onTap != null) ...[
                  const SizedBox(width: 8),
                  const Icon(
                    Icons.chevron_right_rounded,
                    color: Color(0xFF9CA3B4),
                    size: 26,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _StudentAvatar extends StatelessWidget {
  const _StudentAvatar({required this.student});

  final MyStudent student;

  @override
  Widget build(BuildContext context) {
    final imageUrl = student.profileImage?.trim();

    return ExcludeSemantics(
      child: ClipOval(
        child: SizedBox(
          width: 52,
          height: 52,
          child: imageUrl != null && imageUrl.isNotEmpty
              ? Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Image.asset(
                AppImages.icProfile,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              );
            },
            loadingBuilder: (context, child, progress) {
              return progress == null ? child : Image.asset(
                AppImages.icProfile,
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              );
            },
          )
              :Image.asset(
            AppImages.icProfile,
            height: 70,
            width: 70,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

}
