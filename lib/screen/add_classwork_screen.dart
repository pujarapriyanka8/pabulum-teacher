
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pabulum_teacher/bloc/addwork/add_work_bloc.dart';
import 'package:pabulum_teacher/model/workoption_model.dart';
import 'package:pabulum_teacher/screen/custom_appbar.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/app_images.dart';

class AddClassworkScreen extends StatelessWidget {
  const AddClassworkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddWorkBloc(isHomework: false)
        ..add(const AddWorkEvent.onLoadStandards()),
      child: BlocConsumer<AddWorkBloc, AddWorkState>(
        listenWhen: (previous, current) =>
        !previous.isSubmitted && current.isSubmitted,
        listener: (context, state) {
          Navigator.of(context).pop(true);
        },
        builder: (context, state) {
          final busy = state.isLoading ||
              state.isLoadingOptions ||
              state.isPickingAttachment ||
              state.isSubmitting ||
              state.isSubmitted;

          return PopScope(
            canPop: !state.isSubmitting,
            child: Scaffold(
              backgroundColor: AppColors.background,
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
                        constraints:
                        const BoxConstraints(maxWidth: 700),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              child: CustomAppBar(
                                title: 'Add Classwork',
                                subtitle:
                                'Create and share classwork\nwith your students.',
                                image: AppImages.icHomeworkHeader,
                              ),
                            ),
                            Expanded(
                              child: AbsorbPointer(
                                absorbing: state.isSubmitting ||
                                    state.isSubmitted,
                                child: ListView(
                                  keyboardDismissBehavior:
                                  ScrollViewKeyboardDismissBehavior
                                      .onDrag,
                                  padding: const EdgeInsets.fromLTRB(
                                    16, 0, 16, 22,
                                  ),
                                  children: [
                                    _details(context, state),
                                    const SizedBox(height: 13),
                                    _classAndSubject(context, state),
                                    const SizedBox(height: 13),
                                    _content(state),
                                    const SizedBox(height: 13),
                                    _attachments(context, state),
                                    const SizedBox(height: 18),
                                    _submitButton(
                                      context,
                                      state,
                                      busy,
                                    ),
                                  ],
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
            ),
          );
        },
      ),
    );
  }

  Widget _details(
      BuildContext context,
      AddWorkState state,
      ) {
    return _section(
      title: 'Classwork details',
      icon: Icons.edit_note_rounded,
      sectionColor: AppColors.purple,
      children: [
        _textField(
          controller: state.titleController,
          label: 'Classwork title *',
          hint: 'Enter classwork title',
          suffixIcon: Icons.menu_book_outlined,
        ),
        const SizedBox(height: 13),
        _dateField(
          label: 'Date *',
          value: state.workDate,
          hint: 'Select date',
          onTap: () => _pickDate(context, state),
        ),
      ],
    );
  }

  Widget _classAndSubject(
      BuildContext context,
      AddWorkState state,
      ) {
    final bloc = context.read<AddWorkBloc>();
    final enabled =
        !state.isLoading && !state.isLoadingOptions;

    return _section(
      title: 'Class & subject',
      icon: Icons.auto_stories_rounded,
      sectionColor: AppColors.colorPrimaryBlue,
      children: [
        if (state.isLoading || state.isLoadingOptions) ...[
          LinearProgressIndicator(
            minHeight: 3,
            color: AppColors.purple,
            backgroundColor:
            AppColors.purple.withValues(alpha: 0.10),
          ),
          const SizedBox(height: 13),
        ],
        _dropdown(
          label: 'Standard *',
          items: state.standards,
          value: state.standardId,
          hint: state.isLoading
              ? 'Loading standards…'
              : 'Select standard',
          enabled: enabled,
          onChanged: (id) => bloc.add(
            AddWorkEvent.onSelectStandard(
              standardId: id,
            ),
          ),
        ),
        if (!state.isLoading && state.standards.isEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: enabled
                  ? () => bloc.add(
                const AddWorkEvent.onLoadStandards(),
              )
                  : null,
              icon: const Icon(
                Icons.refresh_rounded,
                size: 18,
              ),
              label: const Text('Reload standards'),
            ),
          ),
        const SizedBox(height: 13),
        _dropdown(
          label: 'Division *',
          items: state.divisions,
          value: state.divisionId,
          hint: state.standardId == null
              ? 'Select standard first'
              : 'Select division',
          enabled: enabled && state.standardId != null,
          onChanged: (id) => bloc.add(
            AddWorkEvent.onSelectDivision(
              divisionId: id,
            ),
          ),
        ),
        const SizedBox(height: 13),
        _dropdown(
          label: 'Subject *',
          items: state.subjects,
          value: state.subjectId,
          hint: state.standardId == null
              ? 'Select standard first'
              : 'Select subject',
          enabled: enabled && state.standardId != null,
          onChanged: (id) => bloc.add(
            AddWorkEvent.onSelectSubject(
              subjectId: id,
            ),
          ),
        ),
        const SizedBox(height: 13),
        _dropdown(
          label: 'Lesson *',
          items: state.lessons,
          value: state.lessonId,
          hint: state.subjectId == null
              ? 'Select subject first'
              : 'Select lesson',
          enabled: enabled && state.subjectId != null,
          onChanged: (id) => bloc.add(
            AddWorkEvent.onSelectLesson(
              lessonId: id,
            ),
          ),
        ),
        const SizedBox(height: 13),
        _dropdown(
          label: 'Topic *',
          items: state.topics,
          value: state.topicId,
          hint: state.lessonId == null
              ? 'Select lesson first'
              : 'Select topic',
          enabled: enabled && state.lessonId != null,
          onChanged: (id) => bloc.add(
            AddWorkEvent.onSelectTopic(
              topicId: id,
            ),
          ),
        ),
      ],
    );
  }

  Widget _content(AddWorkState state) {
    return _section(
      title: 'Classwork content',
      icon: Icons.description_outlined,
      sectionColor: AppColors.colorPrimaryOrange,
      children: [
        _textField(
          controller: state.instructionsController,
          label: 'Instructions',
          hint: 'Write instructions, questions or notes...',
          minLines: 4,
          maxLines: 8,
        ),
        const SizedBox(height: 13),
        _textField(
          controller: state.youtubeController,
          label: 'YouTube URL',
          hint: 'Paste YouTube video link',
          keyboardType: TextInputType.url,
          prefixIcon: Icons.link_rounded,
        ),
      ],
    );
  }

  Widget _attachments(
      BuildContext context,
      AddWorkState state,
      ) {
    return _section(
      title: 'Attachments',
      icon: Icons.attach_file_rounded,
      sectionColor: AppColors.green,
      children: [
        _attachment(
          context,
          state,
          label: 'Image',
          subtitle: 'JPG, JPEG or PNG',
          icon: Icons.image_outlined,
          color: AppColors.purple,
          type: WorkAttachmentType.image,
          path: state.imagePath,
        ),
        const SizedBox(height: 9),
        _attachment(
          context,
          state,
          label: 'PDF document',
          subtitle: 'Select a PDF document',
          icon: Icons.picture_as_pdf_outlined,
          color: AppColors.red,
          type: WorkAttachmentType.pdf,
          path: state.pdfPath,
        ),
        const SizedBox(height: 9),
        _attachment(
          context,
          state,
          label: 'Audio',
          subtitle: 'MP3, M4A, WAV or AAC',
          icon: Icons.music_note_rounded,
          color: AppColors.green,
          type: WorkAttachmentType.audio,
          path: state.audioPath,
        ),
        if (state.isPickingAttachment) ...[
          const SizedBox(height: 12),
          LinearProgressIndicator(
            minHeight: 3,
            color: AppColors.purple,
          ),
        ],
      ],
    );
  }

  Widget _section({
    required String title,
    required IconData icon,
    required Color sectionColor,
    required List<Widget> children,
  }) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: sectionColor.withValues(alpha: 0.25),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 12,
            ),
            color: sectionColor.withValues(alpha: 0.12),
            child: Row(
              children: [
                Container(
                  width: 34,
                  height: 34,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: sectionColor.withValues(
                      alpha: 0.13,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: sectionColor,
                    size: 21,
                  ),
                ),
                const SizedBox(width: 9),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: AppColors.ink,
                      fontSize: 15,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: children,
            ),
          ),
        ],
      ),
    );
  }

  Widget _label(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        label,
        style: TextStyle(
          color: AppColors.ink,
          fontSize: 12,
          fontWeight: FontWeight.w700,
          height: 1.3,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String label,
    required String hint,
    int minLines = 1,
    int maxLines = 1,
    TextInputType? keyboardType,
    IconData? prefixIcon,
    IconData? suffixIcon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(label),
        TextField(
          controller: controller,
          minLines: minLines,
          maxLines: maxLines,
          keyboardType: keyboardType ??
              (maxLines > 1
                  ? TextInputType.multiline
                  : TextInputType.text),
          style: TextStyle(
            color: AppColors.ink,
            fontSize: 13,
            height: 1.4,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(
              color: AppColors.muted,
              fontSize: 13,
            ),
            filled: true,
            fillColor: AppColors.surface,
            isDense: true,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 13,
              vertical: 13,
            ),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(
              prefixIcon,
              color: AppColors.purple,
              size: 21,
            ),
            suffixIcon: suffixIcon == null
                ? null
                : Icon(
              suffixIcon,
              color: AppColors.purple,
              size: 20,
            ),
            enabledBorder: _inputBorder(),
            focusedBorder: _inputBorder(
              color: AppColors.purple,
              width: 1.4,
            ),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _inputBorder({
    Color? color,
    double width = 1,
  }) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: color ?? AppColors.colorGrey1,
        width: width,
      ),
    );
  }

  Widget _dropdown({
    required String label,
    required List<WorkOption> items,
    required int? value,
    required String hint,
    required bool enabled,
    required ValueChanged<int> onChanged,
  }) {
    final canSelect = enabled && items.isNotEmpty;

    final selectedValue =
    items.any((item) => item.id == value)
        ? value
        : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(label),
        Container(
          constraints: const BoxConstraints(minHeight: 49),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            color: canSelect
                ? AppColors.surface
                : AppColors.background,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.colorGrey1,
            ),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: selectedValue,
              isExpanded: true,
              itemHeight: null,
              dropdownColor: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 23,
                color: canSelect
                    ? AppColors.purple
                    : AppColors.muted,
              ),
              hint: Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 11,
                ),
                child: Text(
                  hint,
                  style: TextStyle(
                    color: AppColors.muted,
                    fontSize: 13,
                  ),
                ),
              ),
              selectedItemBuilder: (context) {
                return items.map((item) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 11,
                      ),
                      child: Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: AppColors.ink,
                          fontSize: 13,
                          height: 1.4,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }).toList();
              },
              items: items.map((item) {
                return DropdownMenuItem<int>(
                  value: item.id,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 11,
                    ),
                    child: Text(
                      item.name,
                      style: TextStyle(
                        color: AppColors.ink,
                        fontSize: 13,
                        height: 1.4,
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: canSelect
                  ? (id) {
                if (id != null && id != value) {
                  onChanged(id);
                }
              }
                  : null,
            ),
          ),
        ),
      ],
    );
  }

  Widget _dateField({
    required String label,
    required DateTime? value,
    required String hint,
    required VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(label),
        Material(
          color: onTap == null
              ? AppColors.background
              : AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(
              color: AppColors.colorGrey1,
            ),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 13,
                vertical: 13,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value == null
                          ? hint
                          : DateFormat('dd MMM yyyy').format(value),
                      style: TextStyle(
                        color: value == null
                            ? AppColors.muted
                            : AppColors.ink,
                        fontSize: 13,
                        fontWeight: value == null
                            ? FontWeight.w400
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.calendar_month_rounded,
                    size: 21,
                    color: onTap == null
                        ? AppColors.muted
                        : AppColors.purple,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _attachment(
      BuildContext context,
      AddWorkState state, {
        required String label,
        required String subtitle,
        required IconData icon,
        required Color color,
        required WorkAttachmentType type,
        required String? path,
      }) {
    final hasFile = path != null && path.isNotEmpty;

    final disabled = state.isPickingAttachment ||
        state.isLoading ||
        state.isLoadingOptions;

    final bloc = context.read<AddWorkBloc>();

    return Material(
      color: AppColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(13),
        side: BorderSide(
          color: AppColors.colorGrey1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: disabled
            ? null
            : () => bloc.add(
          AddWorkEvent.onPickAttachment(
            type: type,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 11,
            vertical: 10,
          ),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(11),
                ),
                child: hasFile &&
                    type == WorkAttachmentType.image
                    ? Image.file(
                  File(path!),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                )
                    : Icon(
                  icon,
                  color: color,
                  size: 24,
                ),
              ),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasFile
                          ? path!
                          .replaceAll('\\', '/')
                          .split('/')
                          .last
                          : 'Choose $label',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.ink,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hasFile ? 'Tap to replace' : subtitle,
                      style: TextStyle(
                        color: AppColors.muted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
              if (hasFile)
                IconButton(
                  tooltip: 'Remove $label',
                  onPressed: disabled
                      ? null
                      : () => bloc.add(
                    AddWorkEvent.onRemoveAttachment(
                      type: type,
                    ),
                  ),
                  icon: Icon(
                    Icons.close_rounded,
                    color: AppColors.muted,
                    size: 20,
                  ),
                )
              else ...[
                const SizedBox(width: 8),
                Icon(
                  Icons.add_circle_outline_rounded,
                  color: color,
                  size: 24,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _submitButton(
      BuildContext context,
      AddWorkState state,
      bool busy,
      ) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: busy
            ? null
            : () {
          FocusManager.instance.primaryFocus
              ?.unfocus();

          context.read<AddWorkBloc>().add(
            const AddWorkEvent.onSubmitClasswork(),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.purple,
          foregroundColor: AppColors.white,
          disabledBackgroundColor:
          AppColors.purple.withValues(alpha: 0.18),
          disabledForegroundColor: AppColors.muted,
          elevation: 0,
          minimumSize: const Size.fromHeight(52),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        child: state.isSubmitting
            ? SizedBox(
          height: 22,
          width: 22,
          child: CircularProgressIndicator(
            color: AppColors.purple,
            strokeWidth: 2,
          ),
        )
            : Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            const Text(
              'Add Classwork',
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w700,
              ),
            ),
            const Spacer(),
            Container(
              width: 30,
              height: 30,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppColors.white.withValues(
                  alpha: 0.13,
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_forward_rounded,
                color: AppColors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickDate(
      BuildContext context,
      AddWorkState state,
      ) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: state.workDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100, 12, 31),
      helpText: 'Select classwork date',
    );

    if (!context.mounted || selected == null) return;

    context.read<AddWorkBloc>().add(
      AddWorkEvent.onSelectWorkDate(
        date: selected,
      ),
    );
  }
}
