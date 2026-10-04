import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:pabulum_teacher/bloc/addwork/add_work_bloc.dart';
import 'package:pabulum_teacher/model/workoption_model.dart';
import 'package:pabulum_teacher/utils/utils.dart';

class AddHomeworkScreen extends StatelessWidget {
  const AddHomeworkScreen({super.key});

  static const _primary = Color(0xFF7655E8);
  static const _text = Color(0xFF192841);
  static const _muted = Color(0xFF788198);
  static const _border = Color(0xFFE2E5EF);
  static const _background = Color(0xFFF6F5FC);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddWorkBloc(isHomework: true)
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
              backgroundColor: _background,
              appBar: Utils.customAppBar('Add Homework', context, isBack: true, onBackPress: (){
                Navigator.pop(context);
              }),
              body: SafeArea(
                top: false,
                child: AbsorbPointer(
                  absorbing: state.isSubmitting || state.isSubmitted,
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
                    keyboardDismissBehavior:
                    ScrollViewKeyboardDismissBehavior.onDrag,
                    children: [
                      _details(context, state),
                      const SizedBox(height: 16),
                      _classAndSubject(context, state),
                      const SizedBox(height: 16),
                      _content(state),
                      const SizedBox(height: 16),
                      _attachments(context, state),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: busy
                            ? null
                            : () {
                          FocusManager.instance.primaryFocus
                              ?.unfocus();

                          context.read<AddWorkBloc>().add(
                            const AddWorkEvent.onSubmitHomework(),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _primary,
                          foregroundColor: Colors.white,
                          disabledBackgroundColor:
                          const Color(0xFFE5DDF9),
                          disabledForegroundColor: _muted,
                          elevation: 0,
                          minimumSize: const Size.fromHeight(52),
                          padding: const EdgeInsets.all(15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: state.isSubmitting
                            ? const SizedBox(
                          height: 22,
                          width: 22,
                          child: CircularProgressIndicator(
                            color: _primary,
                            strokeWidth: 2,
                          ),
                        )
                            : const Text(
                          'Add Homework',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _details(BuildContext context, AddWorkState state) {
    return _section(
      title: 'Homework details',
      icon: Icons.edit_note_rounded,
      headerColor: const Color(0xFFECE5FF),
      iconColor: _primary,
      children: [
        _textField(
          controller: state.titleController,
          label: 'Homework title *',
          hint: 'Enter homework title',
        ),
        const SizedBox(height: 16),
        _dateField(
          label: 'Start date *',
          value: state.workDate,
          onTap: () => _pickStartDate(context, state),
        ),
        const SizedBox(height: 16),
        _dateField(
          label: 'Due date *',
          value: state.dueDate,
          onTap: state.workDate == null
              ? null
              : () => _pickDueDate(context, state),
        ),
        if (state.workDate == null) ...[
          const SizedBox(height: 8),
          const Text(
            'Select the start date before the due date.',
            style: TextStyle(
              color: _muted,
              fontSize: 12,
              height: 1.4,
            ),
          ),
        ],
      ],
    );
  }

  Widget _classAndSubject(BuildContext context, AddWorkState state) {
    final bloc = context.read<AddWorkBloc>();
    final enabled = !state.isLoading && !state.isLoadingOptions;

    return _section(
      title: 'Class & subject',
      icon: Icons.menu_book_rounded,
      headerColor: const Color(0xFFE5EFFF),
      iconColor: const Color(0xFF4672B5),
      children: [
        if (state.isLoading || state.isLoadingOptions) ...[
          const LinearProgressIndicator(
            minHeight: 3,
            color: _primary,
            backgroundColor: Color(0xFFEDE7FB),
          ),
          const SizedBox(height: 16),
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
            AddWorkEvent.onSelectStandard(standardId: id),
          ),
        ),
        if (!state.isLoading && state.standards.isEmpty)
          Align(
            alignment: Alignment.centerRight,
            child: TextButton.icon(
              onPressed: enabled
                  ? () => bloc.add(const AddWorkEvent.onLoadStandards())
                  : null,
              icon: const Icon(Icons.refresh_rounded, size: 18),
              label: const Text('Reload standards'),
            ),
          ),
        const SizedBox(height: 16),
        _dropdown(
          label: 'Division *',
          items: state.divisions,
          value: state.divisionId,
          hint: state.standardId == null
              ? 'Select standard first'
              : 'Select division',
          enabled: enabled && state.standardId != null,
          onChanged: (id) => bloc.add(
            AddWorkEvent.onSelectDivision(divisionId: id),
          ),
        ),
        const SizedBox(height: 16),
        _dropdown(
          label: 'Subject *',
          items: state.subjects,
          value: state.subjectId,
          hint: state.standardId == null
              ? 'Select standard first'
              : 'Select subject',
          enabled: enabled && state.standardId != null,
          onChanged: (id) => bloc.add(
            AddWorkEvent.onSelectSubject(subjectId: id),
          ),
        ),
        const SizedBox(height: 16),
        _dropdown(
          label: 'Lesson *',
          items: state.lessons,
          value: state.lessonId,
          hint: state.subjectId == null
              ? 'Select subject first'
              : 'Select lesson',
          enabled: enabled && state.subjectId != null,
          onChanged: (id) => bloc.add(
            AddWorkEvent.onSelectLesson(lessonId: id),
          ),
        ),
        const SizedBox(height: 16),
        _dropdown(
          label: 'Topic *',
          items: state.topics,
          value: state.topicId,
          hint: state.lessonId == null
              ? 'Select lesson first'
              : 'Select topic',
          enabled: enabled && state.lessonId != null,
          onChanged: (id) => bloc.add(
            AddWorkEvent.onSelectTopic(topicId: id),
          ),
        ),
      ],
    );
  }

  Widget _content(AddWorkState state) {
    return _section(
      title: 'Homework content',
      icon: Icons.description_outlined,
      headerColor: const Color(0xFFFFEBDD),
      iconColor: const Color(0xFFA96A3E),
      children: [
        _textField(
          controller: state.instructionsController,
          label: 'Instructions',
          hint: 'Write homework instructions…',
          minLines: 4,
          maxLines: 8,
        ),
        const SizedBox(height: 16),
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

  Widget _attachments(BuildContext context, AddWorkState state) {
    return _section(
      title: 'Attachments',
      icon: Icons.attach_file_rounded,
      headerColor: const Color(0xFFDFF3E9),
      iconColor: const Color(0xFF178564),
      children: [
        _attachment(
          context,
          state,
          label: 'Image',
          subtitle: 'JPG, JPEG or PNG',
          icon: Icons.image_outlined,
          color: _primary,
          type: WorkAttachmentType.image,
          path: state.imagePath,
        ),
        const SizedBox(height: 12),
        _attachment(
          context,
          state,
          label: 'PDF document',
          subtitle: 'Select a PDF document',
          icon: Icons.picture_as_pdf_outlined,
          color: const Color(0xFFC94E70),
          type: WorkAttachmentType.pdf,
          path: state.pdfPath,
        ),
        const SizedBox(height: 12),
        _attachment(
          context,
          state,
          label: 'Audio',
          subtitle: 'MP3, M4A, WAV or AAC',
          icon: Icons.music_note_outlined,
          color: const Color(0xFF178564),
          type: WorkAttachmentType.audio,
          path: state.audioPath,
        ),
        if (state.isPickingAttachment) ...[
          const SizedBox(height: 12),
          const LinearProgressIndicator(
            minHeight: 3,
            color: _primary,
          ),
        ],
      ],
    );
  }

  Widget _section({
    required String title,
    required IconData icon,
    required Color headerColor,
    required Color iconColor,
    required List<Widget> children,
  }) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x08493978),
            blurRadius: 12,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 12,
            ),
            color: headerColor,
            child: Row(
              children: [
                Icon(icon, color: iconColor, size: 21),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: _text,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(14),
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
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        label,
        style: const TextStyle(
          color: _text,
          fontSize: 13,
          fontWeight: FontWeight.w600,
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
          style: const TextStyle(
            color: _text,
            fontSize: 14,
            height: 1.5,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: const TextStyle(
              color: _muted,
              fontSize: 13,
            ),
            filled: true,
            fillColor: const Color(0xFFFCFCFF),
            isDense: true,
            contentPadding: const EdgeInsets.all(13),
            prefixIcon: prefixIcon == null
                ? null
                : Icon(prefixIcon, color: _muted, size: 21),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: _border),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(
                color: _primary,
                width: 1.4,
              ),
            ),
          ),
        ),
      ],
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
    items.any((item) => item.id == value) ? value : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(label),
        Container(
          constraints: const BoxConstraints(minHeight: 52),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: canSelect
                ? const Color(0xFFFCFCFF)
                : const Color(0xFFF4F5F8),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: _border),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
              value: selectedValue,
              isExpanded: true,
              isDense: false,
              itemHeight: null,
              dropdownColor: Colors.white,
              borderRadius: BorderRadius.circular(12),
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 22,
                color: canSelect ? _primary : _muted,
              ),
              hint: Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  hint,
                  style: const TextStyle(
                    color: _muted,
                    fontSize: 13,
                  ),
                ),
              ),
              selectedItemBuilder: (context) {
                return items.map((item) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      child: Text(
                        item.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: _text,
                          fontSize: 14,
                          height: 1.4,
                          fontWeight: FontWeight.w500,
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
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    child: Text(
                      item.name,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 14,
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
    required VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _label(label),
        Material(
          color: onTap == null
              ? const Color(0xFFF4F5F8)
              : const Color(0xFFFCFCFF),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: const BorderSide(color: _border),
          ),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      value == null
                          ? 'Select date'
                          : DateFormat('dd MMM yyyy').format(value),
                      style: TextStyle(
                        color: value == null ? _muted : _text,
                        fontSize: 14,
                        height: 1.4,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    Icons.calendar_month_outlined,
                    size: 21,
                    color: onTap == null ? _muted : _primary,
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
      color: const Color(0xFFFCFCFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: _border),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: disabled
            ? null
            : () => bloc.add(
          AddWorkEvent.onPickAttachment(type: type),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Container(
                width: 42,
                height: 42,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.09),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: hasFile && type == WorkAttachmentType.image
                    ? Image.file(
                  File(path!),
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) =>
                      Icon(icon, color: color, size: 23),
                )
                    : Icon(icon, color: color, size: 23),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      hasFile
                          ? path!.replaceAll('\\', '/').split('/').last
                          : 'Choose $label',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: _text,
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      hasFile ? 'Tap to replace' : subtitle,
                      style: const TextStyle(
                        color: _muted,
                        fontSize: 11,
                        height: 1.4,
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
                    AddWorkEvent.onRemoveAttachment(type: type),
                  ),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: _muted,
                    size: 20,
                  ),
                )
              else ...[
                const SizedBox(width: 8),
                Icon(Icons.add_circle_outline, color: color, size: 22),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickStartDate(
      BuildContext context,
      AddWorkState state,
      ) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: state.workDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100, 12, 31),
      helpText: 'Select start date',
    );

    if (!context.mounted || selected == null) return;

    context.read<AddWorkBloc>().add(
      AddWorkEvent.onSelectWorkDate(date: selected),
    );
  }

  Future<void> _pickDueDate(
      BuildContext context,
      AddWorkState state,
      ) async {
    final startDate = state.workDate;
    if (startDate == null) return;

    final dueDate = state.dueDate;
    final initialDate =
    dueDate == null || dueDate.isBefore(startDate)
        ? startDate
        : dueDate;

    final selected = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: startDate,
      lastDate: DateTime(2100, 12, 31),
      helpText: 'Select due date',
    );

    if (!context.mounted || selected == null) return;

    context.read<AddWorkBloc>().add(
      AddWorkEvent.onSelectDueDate(date: selected),
    );
  }
}