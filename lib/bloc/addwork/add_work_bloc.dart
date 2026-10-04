import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:pabulum_teacher/model/workoption_model.dart';
import 'package:pabulum_teacher/network/api_service.dart';
import 'package:pabulum_teacher/utils/app_endpoints.dart';
import 'package:pabulum_teacher/utils/utils.dart';

part 'add_work_event.dart';
part 'add_work_state.dart';
part 'add_work_bloc.freezed.dart';

class AddWorkBloc extends Bloc<AddWorkEvent, AddWorkState> {
  final ApiService apiService = ApiService();

  AddWorkBloc({
    required bool isHomework,
  }) : super(AddWorkState.initial(isHomework: isHomework)) {
    on<OnLoadStandards>(onLoadStandards);
    on<OnSelectStandard>(onSelectStandard);
    on<OnSelectDivision>(onSelectDivision);
    on<OnSelectSubject>(onSelectSubject);
    on<OnSelectLesson>(onSelectLesson);
    on<OnSelectTopic>(onSelectTopic);
    on<OnSelectWorkDate>(onSelectWorkDate);
    on<OnSelectDueDate>(onSelectDueDate);
    on<OnPickAttachment>(onPickAttachment);
    on<OnRemoveAttachment>(onRemoveAttachment);
    on<OnSubmitHomework>(onSubmitHomework);
    on<OnSubmitClasswork>(onSubmitClasswork);
  }

  Future<List<WorkOption>> _loadOptions(
      String endpoint, {
        Map<String, String> parameters = const {},
        bool allowMissingSuccess = false,
      }) async {
    try {
      final uri = Uri.parse(endpoint);

      final url = uri.replace(
        queryParameters: {
          ...uri.queryParameters,
          ...parameters,
        },
      ).toString();

      final response = await apiService.getRequest(url);

      if (isClosed) return [];

      if (response.statusCode == 200) {
        final body = Map<String, dynamic>.from(
          response.data as Map,
        );

        final result = WorkOptionModel.fromJson(body);

        final isSuccess = result.success == true ||
            (allowMissingSuccess &&
                !body.containsKey('success') &&
                body['data'] is List);

        if (isSuccess) {
          return result.data;
        }

        Utils.showToast(result.message, false);
      } else {
        Utils.showToast(response.statusMessage, false);
      }
    } catch (e) {
      if (!isClosed) {
        Utils.showToast(e, false);
        debugPrint(e.toString());
      }
    }

    return [];
  }

  Future<void> onLoadStandards(
      OnLoadStandards event,
      Emitter<AddWorkState> emit,
      ) async {
    if (state.isLoading) return;

    emit(state.copyWith(isLoading: true));

    final standards = await _loadOptions(
      AppEndPoints.standards,
    );

    if (emit.isDone) return;

    emit(
      state.copyWith(
        isLoading: false,
        standards: standards,
      ),
    );
  }

  Future<void> onSelectStandard(
      OnSelectStandard event,
      Emitter<AddWorkState> emit,
      ) async {
    if (state.isLoading || state.isLoadingOptions) return;

    emit(
      state.copyWith(
        standardId: event.standardId,
        divisionId: null,
        subjectId: null,
        lessonId: null,
        topicId: null,
        divisions: [],
        subjects: [],
        lessons: [],
        topics: [],
        isLoadingOptions: true,
      ),
    );

    final parameters = {
      'standard_id': event.standardId.toString(),
    };

    final results = await Future.wait<List<WorkOption>>([
      _loadOptions(
        AppEndPoints.divisions,
        parameters: parameters,
      ),
      _loadOptions(
        AppEndPoints.subjects,
        parameters: parameters,
      ),
    ]);

    if (emit.isDone) return;

    emit(
      state.copyWith(
        divisions: results[0],
        subjects: results[1],
        isLoadingOptions: false,
      ),
    );
  }

  void onSelectDivision(
      OnSelectDivision event,
      Emitter<AddWorkState> emit,
      ) {
    if (state.isLoadingOptions) return;

    emit(
      state.copyWith(
        divisionId: event.divisionId,
      ),
    );
  }

  Future<void> onSelectSubject(
      OnSelectSubject event,
      Emitter<AddWorkState> emit,
      ) async {
    if (state.isLoadingOptions) return;

    emit(
      state.copyWith(
        subjectId: event.subjectId,
        lessonId: null,
        topicId: null,
        lessons: [],
        topics: [],
        isLoadingOptions: true,
      ),
    );

    final lessons = await _loadOptions(
      AppEndPoints.lessons,
      parameters: {
        'subject_id': event.subjectId.toString(),
      },
    );

    if (emit.isDone) return;

    emit(
      state.copyWith(
        lessons: lessons,
        isLoadingOptions: false,
      ),
    );
  }

  Future<void> onSelectLesson(
      OnSelectLesson event,
      Emitter<AddWorkState> emit,
      ) async {
    if (state.isLoadingOptions) return;

    emit(
      state.copyWith(
        lessonId: event.lessonId,
        topicId: null,
        topics: [],
        isLoadingOptions: true,
      ),
    );

    final topics = await _loadOptions(
      AppEndPoints.topics,
      parameters: {
        'lesson_id': event.lessonId.toString(),
      },
      allowMissingSuccess: true,
    );

    if (emit.isDone) return;

    emit(
      state.copyWith(
        topics: topics,
        isLoadingOptions: false,
      ),
    );
  }

  void onSelectTopic(
      OnSelectTopic event,
      Emitter<AddWorkState> emit,
      ) {
    if (state.isLoadingOptions) return;

    emit(
      state.copyWith(
        topicId: event.topicId,
      ),
    );
  }

  void onSelectWorkDate(
      OnSelectWorkDate event,
      Emitter<AddWorkState> emit,
      ) {
    final date = DateUtils.dateOnly(event.date);
    final dueDate = state.dueDate;

    emit(
      state.copyWith(
        workDate: date,
        dueDate: dueDate != null && dueDate.isBefore(date)
            ? null
            : dueDate,
      ),
    );
  }

  void onSelectDueDate(
      OnSelectDueDate event,
      Emitter<AddWorkState> emit,
      ) {
    final date = DateUtils.dateOnly(event.date);
    final startDate = state.workDate;

    if (startDate == null) {
      Utils.showToast('Select a start date first.', false);
      return;
    }

    if (date.isBefore(startDate)) {
      Utils.showToast(
        'Due date cannot be before the start date.',
        false,
      );
      return;
    }

    emit(
      state.copyWith(
        dueDate: date,
      ),
    );
  }

  Future<void> onPickAttachment(
      OnPickAttachment event,
      Emitter<AddWorkState> emit,
      ) async {
    if (state.isPickingAttachment) return;

    emit(state.copyWith(isPickingAttachment: true));

    try {
      final extensions = switch (event.type) {
        WorkAttachmentType.image => ['jpg', 'jpeg', 'png'],
        WorkAttachmentType.pdf => ['pdf'],
        WorkAttachmentType.audio => ['mp3', 'm4a', 'wav', 'aac'],
        // TODO: Handle this case.
      };

      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: extensions,
        allowMultiple: false,
        withData: false,
      );

      if (emit.isDone) return;

      if (result == null || result.files.isEmpty) return;

      final file = result.files.single;
      final path = file.path;

      if (path == null || path.isEmpty) {
        Utils.showToast('Could not access this file.', false);
        return;
      }

      final extension = file.extension?.toLowerCase();

      if (!extensions.contains(extension)) {
        Utils.showToast(
          'Please select a supported file type.',
          false,
        );
        return;
      }

      switch (event.type) {
        case WorkAttachmentType.image:
          emit(state.copyWith(imagePath: path));
          break;

        case WorkAttachmentType.pdf:
          emit(state.copyWith(pdfPath: path));
          break;

        case WorkAttachmentType.audio:
          emit(state.copyWith(audioPath: path));
          break;
      }
    } catch (e) {
      if (!emit.isDone) {
        Utils.showToast(e, false);
        debugPrint(e.toString());
      }
    } finally {
      if (!emit.isDone) {
        emit(state.copyWith(isPickingAttachment: false));
      }
    }
  }

  void onRemoveAttachment(
      OnRemoveAttachment event,
      Emitter<AddWorkState> emit,
      ) {
    switch (event.type) {
      case WorkAttachmentType.image:
        emit(state.copyWith(imagePath: null));
        break;

      case WorkAttachmentType.pdf:
        emit(state.copyWith(pdfPath: null));
        break;

      case WorkAttachmentType.audio:
        emit(state.copyWith(audioPath: null));
        break;
    }
  }


  Future<void> onSubmitHomework(
      OnSubmitHomework event,
      Emitter<AddWorkState> emit,
      ) async {
    if ( state.isSubmitted) return;
    if (!state.isHomework) return;

    final formState = state;

    emit(state.copyWith(
      isSubmitting: true,
      isSubmitted: false,
      errorMessage: null,
      successMessage: null,
    ));

    try {

      // Read controller values before any await.
      final values = _commonValues(formState)
        ..addAll({
          'start_date': _formatDate(formState.workDate),
          'due_date': _formatDate(formState.dueDate),
        });

      final formData = await _buildFormData(
        values: values,
        files: {
          'image': formState.imagePath,
          'pdf': formState.pdfPath,
          'audio': formState.audioPath,
        },
      );

      if (emit.isDone) return;

      if (kDebugMode) {
        debugPrint('POST: ${AppEndPoints.addHomework}');

        debugPrint('--- Form fields ---');
        for (final field in formData.fields) {
          debugPrint('${field.key}: ${field.value}');
        }

        debugPrint('--- Files ---');
        for (final file in formData.files) {
          debugPrint(
            '${file.key}: '
                'filename=${file.value.filename}, '
                'size=${file.value.length} bytes, '
                'contentType=${file.value.contentType}',
          );
        }
      }

      final response = await apiService.multiPartPostRequest(AppEndPoints.addHomework,formData);

      if (emit.isDone) return;

      if(response.statusCode == 200){
        emit(state.copyWith(
          isSubmitting: false,
          isSubmitted: true,
          successMessage: response.statusMessage,
        ));
        Utils.showToast(response.statusMessage, true);
      }
      else{
        emit(state.copyWith(
          isSubmitting: false,
          isSubmitted: false,
          successMessage: response.statusMessage,
        ));
        Utils.showToast(response.statusMessage, true);
      }
    } catch (e) {
      emit(state.copyWith(
        isSubmitting: false,
        isSubmitted: false,
        successMessage: e.toString(),
      ));
      Utils.showToast(e.toString(), true);
    }
  }

  Future<void> onSubmitClasswork(
      OnSubmitClasswork event,
      Emitter<AddWorkState> emit,
      ) async {
    if ( state.isSubmitted) return;
    if (state.isHomework) return;

    final formState = state;

    emit(state.copyWith(
      isSubmitting: true,
      isSubmitted: false,
      errorMessage: null,
      successMessage: null,
    ));

    try {

      final values = _commonValues(formState)
        ..addAll({
          'date': _formatDate(formState.workDate!),
        });

      final formData = await _buildFormData(
        values: values,
        files: {
          'image': formState.imagePath,
          'pdf': formState.pdfPath,
          'audio': formState.audioPath,
          'video': formState.videoPath,
        },
      );

      if (emit.isDone) return;

      final response = await apiService.multiPartPostRequest(AppEndPoints.addClasswork,formData);

      if (emit.isDone) return;

      final message = _readSuccessMessage(
        response,
        'Classwork added successfully.',
      );

      emit(state.copyWith(
        isSubmitting: false,
        isSubmitted: true,
        successMessage: message,
      ));

      Utils.showToast(message, true);
    } catch (e) {
      _handleSubmissionError(e, emit);
    }
  }

  Map<String, dynamic> _commonValues(AddWorkState formState) {
    final youtubeUrl = formState.youtubeController.text.trim();

    return {
      'title': formState.titleController.text.trim(),
      'standard_id': formState.standardId,
      'division_id': formState.divisionId,
      'subject_id': formState.subjectId,
      'lesson_id': formState.lessonId,
      'topic_id': formState.topicId,
      'text': formState.instructionsController.text.trim(),
      if (youtubeUrl.isNotEmpty) 'youtube_url': youtubeUrl,
    };
  }

  Future<FormData> _buildFormData({
    required Map<String, dynamic> values,
    required Map<String, String?> files,
  }) async {
    final data = <String, dynamic>{...values};

    for (final entry in files.entries) {
      final path = entry.value;

      if (path == null || path.isEmpty) continue;

      // Reads the file and uploads it as a multipart file part.
      data[entry.key] = await MultipartFile.fromFile(path);
    }

    // A new FormData is created for every submission attempt.
    return FormData.fromMap(data);
  }

  String _formatDate(DateTime? date) {
    final year = (date?.year).toString().padLeft(4, '0');
    final month = (date?.month).toString().padLeft(2, '0');
    final day = (date?.day).toString().padLeft(2, '0');

    return '$year-$month-$day';
  }

  String _readSuccessMessage(
      Response<dynamic> response,
      String fallback,
      ) {
    final statusCode = response.statusCode ?? 0;
    final body = response.data;

    if (body is! Map) {
      throw Exception(
        'Unexpected server response ($statusCode).',
      );
    }

    if (statusCode < 200 ||
        statusCode >= 300 ||
        body['success'] == false) {
      throw Exception(
        _serverMessage(body) ?? 'Unable to submit work.',
      );
    }

    return body['message']?.toString() ?? fallback;
  }

  String? _serverMessage(dynamic body) {
    if (body is! Map) return null;

    final errors = body['errors'];
    final messages = <String>[];

    if (errors is Map) {
      for (final value in errors.values) {
        if (value is List) {
          messages.addAll(value.map((item) => item.toString()));
        } else if (value != null) {
          messages.add(value.toString());
        }
      }
    }

    if (messages.isNotEmpty) return messages.join('\n');

    return body['message']?.toString();
  }

  void _handleSubmissionError(
      Object error,
      Emitter<AddWorkState> emit,
      ) {
    if (emit.isDone) return;

    String message;

    if (error is DioException) {
      final serverMessage = _serverMessage(error.response?.data);

      if (serverMessage != null) {
        message = serverMessage;
      } else if (
      error.type == DioExceptionType.connectionTimeout ||
          error.type == DioExceptionType.sendTimeout ||
          error.type == DioExceptionType.receiveTimeout) {
        message = 'The request timed out. '
            'Check the work list before retrying.';
      } else if (error.type == DioExceptionType.connectionError) {
        message = 'Unable to connect. '
            'Please check your internet connection.';
      } else {
        message = 'Unable to submit work. Please try again.';
      }
    } else {
      message = error.toString().replaceFirst('Exception: ', '');
    }

    emit(state.copyWith(
      isSubmitting: false,
      isSubmitted: false,
      errorMessage: message,
      successMessage: null,
    ));

    Utils.showToast(message, false);
  }

  @override
  Future<void> close() async {
    final titleController = state.titleController;
    final instructionsController = state.instructionsController;
    final youtubeController = state.youtubeController;

    await super.close();

    titleController.dispose();
    instructionsController.dispose();
    youtubeController.dispose();
  }
}