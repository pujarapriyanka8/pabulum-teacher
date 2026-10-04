// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_work_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AddWorkEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddWorkEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent()';
}


}

/// @nodoc
class $AddWorkEventCopyWith<$Res>  {
$AddWorkEventCopyWith(AddWorkEvent _, $Res Function(AddWorkEvent) __);
}


/// Adds pattern-matching-related methods to [AddWorkEvent].
extension AddWorkEventPatterns on AddWorkEvent {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadStandards value)?  onLoadStandards,TResult Function( OnSelectStandard value)?  onSelectStandard,TResult Function( OnSelectDivision value)?  onSelectDivision,TResult Function( OnSelectSubject value)?  onSelectSubject,TResult Function( OnSelectLesson value)?  onSelectLesson,TResult Function( OnSelectTopic value)?  onSelectTopic,TResult Function( OnSelectWorkDate value)?  onSelectWorkDate,TResult Function( OnSelectDueDate value)?  onSelectDueDate,TResult Function( OnPickAttachment value)?  onPickAttachment,TResult Function( OnRemoveAttachment value)?  onRemoveAttachment,TResult Function( OnSubmitHomework value)?  onSubmitHomework,TResult Function( OnSubmitClasswork value)?  onSubmitClasswork,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadStandards() when onLoadStandards != null:
return onLoadStandards(_that);case OnSelectStandard() when onSelectStandard != null:
return onSelectStandard(_that);case OnSelectDivision() when onSelectDivision != null:
return onSelectDivision(_that);case OnSelectSubject() when onSelectSubject != null:
return onSelectSubject(_that);case OnSelectLesson() when onSelectLesson != null:
return onSelectLesson(_that);case OnSelectTopic() when onSelectTopic != null:
return onSelectTopic(_that);case OnSelectWorkDate() when onSelectWorkDate != null:
return onSelectWorkDate(_that);case OnSelectDueDate() when onSelectDueDate != null:
return onSelectDueDate(_that);case OnPickAttachment() when onPickAttachment != null:
return onPickAttachment(_that);case OnRemoveAttachment() when onRemoveAttachment != null:
return onRemoveAttachment(_that);case OnSubmitHomework() when onSubmitHomework != null:
return onSubmitHomework(_that);case OnSubmitClasswork() when onSubmitClasswork != null:
return onSubmitClasswork(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadStandards value)  onLoadStandards,required TResult Function( OnSelectStandard value)  onSelectStandard,required TResult Function( OnSelectDivision value)  onSelectDivision,required TResult Function( OnSelectSubject value)  onSelectSubject,required TResult Function( OnSelectLesson value)  onSelectLesson,required TResult Function( OnSelectTopic value)  onSelectTopic,required TResult Function( OnSelectWorkDate value)  onSelectWorkDate,required TResult Function( OnSelectDueDate value)  onSelectDueDate,required TResult Function( OnPickAttachment value)  onPickAttachment,required TResult Function( OnRemoveAttachment value)  onRemoveAttachment,required TResult Function( OnSubmitHomework value)  onSubmitHomework,required TResult Function( OnSubmitClasswork value)  onSubmitClasswork,}){
final _that = this;
switch (_that) {
case OnLoadStandards():
return onLoadStandards(_that);case OnSelectStandard():
return onSelectStandard(_that);case OnSelectDivision():
return onSelectDivision(_that);case OnSelectSubject():
return onSelectSubject(_that);case OnSelectLesson():
return onSelectLesson(_that);case OnSelectTopic():
return onSelectTopic(_that);case OnSelectWorkDate():
return onSelectWorkDate(_that);case OnSelectDueDate():
return onSelectDueDate(_that);case OnPickAttachment():
return onPickAttachment(_that);case OnRemoveAttachment():
return onRemoveAttachment(_that);case OnSubmitHomework():
return onSubmitHomework(_that);case OnSubmitClasswork():
return onSubmitClasswork(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadStandards value)?  onLoadStandards,TResult? Function( OnSelectStandard value)?  onSelectStandard,TResult? Function( OnSelectDivision value)?  onSelectDivision,TResult? Function( OnSelectSubject value)?  onSelectSubject,TResult? Function( OnSelectLesson value)?  onSelectLesson,TResult? Function( OnSelectTopic value)?  onSelectTopic,TResult? Function( OnSelectWorkDate value)?  onSelectWorkDate,TResult? Function( OnSelectDueDate value)?  onSelectDueDate,TResult? Function( OnPickAttachment value)?  onPickAttachment,TResult? Function( OnRemoveAttachment value)?  onRemoveAttachment,TResult? Function( OnSubmitHomework value)?  onSubmitHomework,TResult? Function( OnSubmitClasswork value)?  onSubmitClasswork,}){
final _that = this;
switch (_that) {
case OnLoadStandards() when onLoadStandards != null:
return onLoadStandards(_that);case OnSelectStandard() when onSelectStandard != null:
return onSelectStandard(_that);case OnSelectDivision() when onSelectDivision != null:
return onSelectDivision(_that);case OnSelectSubject() when onSelectSubject != null:
return onSelectSubject(_that);case OnSelectLesson() when onSelectLesson != null:
return onSelectLesson(_that);case OnSelectTopic() when onSelectTopic != null:
return onSelectTopic(_that);case OnSelectWorkDate() when onSelectWorkDate != null:
return onSelectWorkDate(_that);case OnSelectDueDate() when onSelectDueDate != null:
return onSelectDueDate(_that);case OnPickAttachment() when onPickAttachment != null:
return onPickAttachment(_that);case OnRemoveAttachment() when onRemoveAttachment != null:
return onRemoveAttachment(_that);case OnSubmitHomework() when onSubmitHomework != null:
return onSubmitHomework(_that);case OnSubmitClasswork() when onSubmitClasswork != null:
return onSubmitClasswork(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onLoadStandards,TResult Function( int standardId)?  onSelectStandard,TResult Function( int divisionId)?  onSelectDivision,TResult Function( int subjectId)?  onSelectSubject,TResult Function( int lessonId)?  onSelectLesson,TResult Function( int topicId)?  onSelectTopic,TResult Function( DateTime date)?  onSelectWorkDate,TResult Function( DateTime date)?  onSelectDueDate,TResult Function( WorkAttachmentType type)?  onPickAttachment,TResult Function( WorkAttachmentType type)?  onRemoveAttachment,TResult Function()?  onSubmitHomework,TResult Function()?  onSubmitClasswork,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadStandards() when onLoadStandards != null:
return onLoadStandards();case OnSelectStandard() when onSelectStandard != null:
return onSelectStandard(_that.standardId);case OnSelectDivision() when onSelectDivision != null:
return onSelectDivision(_that.divisionId);case OnSelectSubject() when onSelectSubject != null:
return onSelectSubject(_that.subjectId);case OnSelectLesson() when onSelectLesson != null:
return onSelectLesson(_that.lessonId);case OnSelectTopic() when onSelectTopic != null:
return onSelectTopic(_that.topicId);case OnSelectWorkDate() when onSelectWorkDate != null:
return onSelectWorkDate(_that.date);case OnSelectDueDate() when onSelectDueDate != null:
return onSelectDueDate(_that.date);case OnPickAttachment() when onPickAttachment != null:
return onPickAttachment(_that.type);case OnRemoveAttachment() when onRemoveAttachment != null:
return onRemoveAttachment(_that.type);case OnSubmitHomework() when onSubmitHomework != null:
return onSubmitHomework();case OnSubmitClasswork() when onSubmitClasswork != null:
return onSubmitClasswork();case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onLoadStandards,required TResult Function( int standardId)  onSelectStandard,required TResult Function( int divisionId)  onSelectDivision,required TResult Function( int subjectId)  onSelectSubject,required TResult Function( int lessonId)  onSelectLesson,required TResult Function( int topicId)  onSelectTopic,required TResult Function( DateTime date)  onSelectWorkDate,required TResult Function( DateTime date)  onSelectDueDate,required TResult Function( WorkAttachmentType type)  onPickAttachment,required TResult Function( WorkAttachmentType type)  onRemoveAttachment,required TResult Function()  onSubmitHomework,required TResult Function()  onSubmitClasswork,}) {final _that = this;
switch (_that) {
case OnLoadStandards():
return onLoadStandards();case OnSelectStandard():
return onSelectStandard(_that.standardId);case OnSelectDivision():
return onSelectDivision(_that.divisionId);case OnSelectSubject():
return onSelectSubject(_that.subjectId);case OnSelectLesson():
return onSelectLesson(_that.lessonId);case OnSelectTopic():
return onSelectTopic(_that.topicId);case OnSelectWorkDate():
return onSelectWorkDate(_that.date);case OnSelectDueDate():
return onSelectDueDate(_that.date);case OnPickAttachment():
return onPickAttachment(_that.type);case OnRemoveAttachment():
return onRemoveAttachment(_that.type);case OnSubmitHomework():
return onSubmitHomework();case OnSubmitClasswork():
return onSubmitClasswork();case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onLoadStandards,TResult? Function( int standardId)?  onSelectStandard,TResult? Function( int divisionId)?  onSelectDivision,TResult? Function( int subjectId)?  onSelectSubject,TResult? Function( int lessonId)?  onSelectLesson,TResult? Function( int topicId)?  onSelectTopic,TResult? Function( DateTime date)?  onSelectWorkDate,TResult? Function( DateTime date)?  onSelectDueDate,TResult? Function( WorkAttachmentType type)?  onPickAttachment,TResult? Function( WorkAttachmentType type)?  onRemoveAttachment,TResult? Function()?  onSubmitHomework,TResult? Function()?  onSubmitClasswork,}) {final _that = this;
switch (_that) {
case OnLoadStandards() when onLoadStandards != null:
return onLoadStandards();case OnSelectStandard() when onSelectStandard != null:
return onSelectStandard(_that.standardId);case OnSelectDivision() when onSelectDivision != null:
return onSelectDivision(_that.divisionId);case OnSelectSubject() when onSelectSubject != null:
return onSelectSubject(_that.subjectId);case OnSelectLesson() when onSelectLesson != null:
return onSelectLesson(_that.lessonId);case OnSelectTopic() when onSelectTopic != null:
return onSelectTopic(_that.topicId);case OnSelectWorkDate() when onSelectWorkDate != null:
return onSelectWorkDate(_that.date);case OnSelectDueDate() when onSelectDueDate != null:
return onSelectDueDate(_that.date);case OnPickAttachment() when onPickAttachment != null:
return onPickAttachment(_that.type);case OnRemoveAttachment() when onRemoveAttachment != null:
return onRemoveAttachment(_that.type);case OnSubmitHomework() when onSubmitHomework != null:
return onSubmitHomework();case OnSubmitClasswork() when onSubmitClasswork != null:
return onSubmitClasswork();case _:
  return null;

}
}

}

/// @nodoc


class OnLoadStandards with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnLoadStandards();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onLoadStandards'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadStandards);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onLoadStandards()';
}


}




/// @nodoc


class OnSelectStandard with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnSelectStandard({required this.standardId});
  

 final  int standardId;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSelectStandardCopyWith<OnSelectStandard> get copyWith => _$OnSelectStandardCopyWithImpl<OnSelectStandard>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onSelectStandard'))
    ..add(DiagnosticsProperty('standardId', standardId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSelectStandard&&(identical(other.standardId, standardId) || other.standardId == standardId));
}


@override
int get hashCode => Object.hash(runtimeType,standardId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onSelectStandard(standardId: $standardId)';
}


}

/// @nodoc
abstract mixin class $OnSelectStandardCopyWith<$Res> implements $AddWorkEventCopyWith<$Res> {
  factory $OnSelectStandardCopyWith(OnSelectStandard value, $Res Function(OnSelectStandard) _then) = _$OnSelectStandardCopyWithImpl;
@useResult
$Res call({
 int standardId
});




}
/// @nodoc
class _$OnSelectStandardCopyWithImpl<$Res>
    implements $OnSelectStandardCopyWith<$Res> {
  _$OnSelectStandardCopyWithImpl(this._self, this._then);

  final OnSelectStandard _self;
  final $Res Function(OnSelectStandard) _then;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? standardId = null,}) {
  return _then(OnSelectStandard(
standardId: null == standardId ? _self.standardId : standardId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnSelectDivision with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnSelectDivision({required this.divisionId});
  

 final  int divisionId;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSelectDivisionCopyWith<OnSelectDivision> get copyWith => _$OnSelectDivisionCopyWithImpl<OnSelectDivision>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onSelectDivision'))
    ..add(DiagnosticsProperty('divisionId', divisionId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSelectDivision&&(identical(other.divisionId, divisionId) || other.divisionId == divisionId));
}


@override
int get hashCode => Object.hash(runtimeType,divisionId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onSelectDivision(divisionId: $divisionId)';
}


}

/// @nodoc
abstract mixin class $OnSelectDivisionCopyWith<$Res> implements $AddWorkEventCopyWith<$Res> {
  factory $OnSelectDivisionCopyWith(OnSelectDivision value, $Res Function(OnSelectDivision) _then) = _$OnSelectDivisionCopyWithImpl;
@useResult
$Res call({
 int divisionId
});




}
/// @nodoc
class _$OnSelectDivisionCopyWithImpl<$Res>
    implements $OnSelectDivisionCopyWith<$Res> {
  _$OnSelectDivisionCopyWithImpl(this._self, this._then);

  final OnSelectDivision _self;
  final $Res Function(OnSelectDivision) _then;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? divisionId = null,}) {
  return _then(OnSelectDivision(
divisionId: null == divisionId ? _self.divisionId : divisionId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnSelectSubject with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnSelectSubject({required this.subjectId});
  

 final  int subjectId;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSelectSubjectCopyWith<OnSelectSubject> get copyWith => _$OnSelectSubjectCopyWithImpl<OnSelectSubject>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onSelectSubject'))
    ..add(DiagnosticsProperty('subjectId', subjectId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSelectSubject&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId));
}


@override
int get hashCode => Object.hash(runtimeType,subjectId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onSelectSubject(subjectId: $subjectId)';
}


}

/// @nodoc
abstract mixin class $OnSelectSubjectCopyWith<$Res> implements $AddWorkEventCopyWith<$Res> {
  factory $OnSelectSubjectCopyWith(OnSelectSubject value, $Res Function(OnSelectSubject) _then) = _$OnSelectSubjectCopyWithImpl;
@useResult
$Res call({
 int subjectId
});




}
/// @nodoc
class _$OnSelectSubjectCopyWithImpl<$Res>
    implements $OnSelectSubjectCopyWith<$Res> {
  _$OnSelectSubjectCopyWithImpl(this._self, this._then);

  final OnSelectSubject _self;
  final $Res Function(OnSelectSubject) _then;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? subjectId = null,}) {
  return _then(OnSelectSubject(
subjectId: null == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnSelectLesson with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnSelectLesson({required this.lessonId});
  

 final  int lessonId;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSelectLessonCopyWith<OnSelectLesson> get copyWith => _$OnSelectLessonCopyWithImpl<OnSelectLesson>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onSelectLesson'))
    ..add(DiagnosticsProperty('lessonId', lessonId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSelectLesson&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId));
}


@override
int get hashCode => Object.hash(runtimeType,lessonId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onSelectLesson(lessonId: $lessonId)';
}


}

/// @nodoc
abstract mixin class $OnSelectLessonCopyWith<$Res> implements $AddWorkEventCopyWith<$Res> {
  factory $OnSelectLessonCopyWith(OnSelectLesson value, $Res Function(OnSelectLesson) _then) = _$OnSelectLessonCopyWithImpl;
@useResult
$Res call({
 int lessonId
});




}
/// @nodoc
class _$OnSelectLessonCopyWithImpl<$Res>
    implements $OnSelectLessonCopyWith<$Res> {
  _$OnSelectLessonCopyWithImpl(this._self, this._then);

  final OnSelectLesson _self;
  final $Res Function(OnSelectLesson) _then;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? lessonId = null,}) {
  return _then(OnSelectLesson(
lessonId: null == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnSelectTopic with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnSelectTopic({required this.topicId});
  

 final  int topicId;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSelectTopicCopyWith<OnSelectTopic> get copyWith => _$OnSelectTopicCopyWithImpl<OnSelectTopic>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onSelectTopic'))
    ..add(DiagnosticsProperty('topicId', topicId));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSelectTopic&&(identical(other.topicId, topicId) || other.topicId == topicId));
}


@override
int get hashCode => Object.hash(runtimeType,topicId);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onSelectTopic(topicId: $topicId)';
}


}

/// @nodoc
abstract mixin class $OnSelectTopicCopyWith<$Res> implements $AddWorkEventCopyWith<$Res> {
  factory $OnSelectTopicCopyWith(OnSelectTopic value, $Res Function(OnSelectTopic) _then) = _$OnSelectTopicCopyWithImpl;
@useResult
$Res call({
 int topicId
});




}
/// @nodoc
class _$OnSelectTopicCopyWithImpl<$Res>
    implements $OnSelectTopicCopyWith<$Res> {
  _$OnSelectTopicCopyWithImpl(this._self, this._then);

  final OnSelectTopic _self;
  final $Res Function(OnSelectTopic) _then;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? topicId = null,}) {
  return _then(OnSelectTopic(
topicId: null == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnSelectWorkDate with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnSelectWorkDate({required this.date});
  

 final  DateTime date;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSelectWorkDateCopyWith<OnSelectWorkDate> get copyWith => _$OnSelectWorkDateCopyWithImpl<OnSelectWorkDate>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onSelectWorkDate'))
    ..add(DiagnosticsProperty('date', date));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSelectWorkDate&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onSelectWorkDate(date: $date)';
}


}

/// @nodoc
abstract mixin class $OnSelectWorkDateCopyWith<$Res> implements $AddWorkEventCopyWith<$Res> {
  factory $OnSelectWorkDateCopyWith(OnSelectWorkDate value, $Res Function(OnSelectWorkDate) _then) = _$OnSelectWorkDateCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class _$OnSelectWorkDateCopyWithImpl<$Res>
    implements $OnSelectWorkDateCopyWith<$Res> {
  _$OnSelectWorkDateCopyWithImpl(this._self, this._then);

  final OnSelectWorkDate _self;
  final $Res Function(OnSelectWorkDate) _then;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(OnSelectWorkDate(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class OnSelectDueDate with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnSelectDueDate({required this.date});
  

 final  DateTime date;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSelectDueDateCopyWith<OnSelectDueDate> get copyWith => _$OnSelectDueDateCopyWithImpl<OnSelectDueDate>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onSelectDueDate'))
    ..add(DiagnosticsProperty('date', date));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSelectDueDate&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onSelectDueDate(date: $date)';
}


}

/// @nodoc
abstract mixin class $OnSelectDueDateCopyWith<$Res> implements $AddWorkEventCopyWith<$Res> {
  factory $OnSelectDueDateCopyWith(OnSelectDueDate value, $Res Function(OnSelectDueDate) _then) = _$OnSelectDueDateCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class _$OnSelectDueDateCopyWithImpl<$Res>
    implements $OnSelectDueDateCopyWith<$Res> {
  _$OnSelectDueDateCopyWithImpl(this._self, this._then);

  final OnSelectDueDate _self;
  final $Res Function(OnSelectDueDate) _then;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(OnSelectDueDate(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class OnPickAttachment with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnPickAttachment({required this.type});
  

 final  WorkAttachmentType type;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnPickAttachmentCopyWith<OnPickAttachment> get copyWith => _$OnPickAttachmentCopyWithImpl<OnPickAttachment>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onPickAttachment'))
    ..add(DiagnosticsProperty('type', type));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnPickAttachment&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onPickAttachment(type: $type)';
}


}

/// @nodoc
abstract mixin class $OnPickAttachmentCopyWith<$Res> implements $AddWorkEventCopyWith<$Res> {
  factory $OnPickAttachmentCopyWith(OnPickAttachment value, $Res Function(OnPickAttachment) _then) = _$OnPickAttachmentCopyWithImpl;
@useResult
$Res call({
 WorkAttachmentType type
});




}
/// @nodoc
class _$OnPickAttachmentCopyWithImpl<$Res>
    implements $OnPickAttachmentCopyWith<$Res> {
  _$OnPickAttachmentCopyWithImpl(this._self, this._then);

  final OnPickAttachment _self;
  final $Res Function(OnPickAttachment) _then;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(OnPickAttachment(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as WorkAttachmentType,
  ));
}


}

/// @nodoc


class OnRemoveAttachment with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnRemoveAttachment({required this.type});
  

 final  WorkAttachmentType type;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnRemoveAttachmentCopyWith<OnRemoveAttachment> get copyWith => _$OnRemoveAttachmentCopyWithImpl<OnRemoveAttachment>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onRemoveAttachment'))
    ..add(DiagnosticsProperty('type', type));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnRemoveAttachment&&(identical(other.type, type) || other.type == type));
}


@override
int get hashCode => Object.hash(runtimeType,type);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onRemoveAttachment(type: $type)';
}


}

/// @nodoc
abstract mixin class $OnRemoveAttachmentCopyWith<$Res> implements $AddWorkEventCopyWith<$Res> {
  factory $OnRemoveAttachmentCopyWith(OnRemoveAttachment value, $Res Function(OnRemoveAttachment) _then) = _$OnRemoveAttachmentCopyWithImpl;
@useResult
$Res call({
 WorkAttachmentType type
});




}
/// @nodoc
class _$OnRemoveAttachmentCopyWithImpl<$Res>
    implements $OnRemoveAttachmentCopyWith<$Res> {
  _$OnRemoveAttachmentCopyWithImpl(this._self, this._then);

  final OnRemoveAttachment _self;
  final $Res Function(OnRemoveAttachment) _then;

/// Create a copy of AddWorkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? type = null,}) {
  return _then(OnRemoveAttachment(
type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as WorkAttachmentType,
  ));
}


}

/// @nodoc


class OnSubmitHomework with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnSubmitHomework();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onSubmitHomework'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSubmitHomework);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onSubmitHomework()';
}


}




/// @nodoc


class OnSubmitClasswork with DiagnosticableTreeMixin implements AddWorkEvent {
  const OnSubmitClasswork();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkEvent.onSubmitClasswork'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSubmitClasswork);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkEvent.onSubmitClasswork()';
}


}




/// @nodoc
mixin _$AddWorkState implements DiagnosticableTreeMixin {

 bool get isHomework; bool get isLoading; bool get isLoadingOptions; bool get isPickingAttachment; List<WorkOption> get standards; List<WorkOption> get divisions; List<WorkOption> get subjects; List<WorkOption> get lessons; List<WorkOption> get topics; TextEditingController get titleController; TextEditingController get instructionsController; TextEditingController get youtubeController; bool get isSubmitting; bool get isSubmitted; String? get errorMessage; String? get successMessage; int? get standardId; int? get divisionId; int? get subjectId; int? get lessonId; int? get topicId; DateTime? get workDate; DateTime? get dueDate; String? get imagePath; String? get pdfPath; String? get audioPath; String? get videoPath;
/// Create a copy of AddWorkState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AddWorkStateCopyWith<AddWorkState> get copyWith => _$AddWorkStateCopyWithImpl<AddWorkState>(this as AddWorkState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkState'))
    ..add(DiagnosticsProperty('isHomework', isHomework))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isLoadingOptions', isLoadingOptions))..add(DiagnosticsProperty('isPickingAttachment', isPickingAttachment))..add(DiagnosticsProperty('standards', standards))..add(DiagnosticsProperty('divisions', divisions))..add(DiagnosticsProperty('subjects', subjects))..add(DiagnosticsProperty('lessons', lessons))..add(DiagnosticsProperty('topics', topics))..add(DiagnosticsProperty('titleController', titleController))..add(DiagnosticsProperty('instructionsController', instructionsController))..add(DiagnosticsProperty('youtubeController', youtubeController))..add(DiagnosticsProperty('isSubmitting', isSubmitting))..add(DiagnosticsProperty('isSubmitted', isSubmitted))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('successMessage', successMessage))..add(DiagnosticsProperty('standardId', standardId))..add(DiagnosticsProperty('divisionId', divisionId))..add(DiagnosticsProperty('subjectId', subjectId))..add(DiagnosticsProperty('lessonId', lessonId))..add(DiagnosticsProperty('topicId', topicId))..add(DiagnosticsProperty('workDate', workDate))..add(DiagnosticsProperty('dueDate', dueDate))..add(DiagnosticsProperty('imagePath', imagePath))..add(DiagnosticsProperty('pdfPath', pdfPath))..add(DiagnosticsProperty('audioPath', audioPath))..add(DiagnosticsProperty('videoPath', videoPath));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AddWorkState&&(identical(other.isHomework, isHomework) || other.isHomework == isHomework)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingOptions, isLoadingOptions) || other.isLoadingOptions == isLoadingOptions)&&(identical(other.isPickingAttachment, isPickingAttachment) || other.isPickingAttachment == isPickingAttachment)&&const DeepCollectionEquality().equals(other.standards, standards)&&const DeepCollectionEquality().equals(other.divisions, divisions)&&const DeepCollectionEquality().equals(other.subjects, subjects)&&const DeepCollectionEquality().equals(other.lessons, lessons)&&const DeepCollectionEquality().equals(other.topics, topics)&&(identical(other.titleController, titleController) || other.titleController == titleController)&&(identical(other.instructionsController, instructionsController) || other.instructionsController == instructionsController)&&(identical(other.youtubeController, youtubeController) || other.youtubeController == youtubeController)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.standardId, standardId) || other.standardId == standardId)&&(identical(other.divisionId, divisionId) || other.divisionId == divisionId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.topicId, topicId) || other.topicId == topicId)&&(identical(other.workDate, workDate) || other.workDate == workDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath)&&(identical(other.audioPath, audioPath) || other.audioPath == audioPath)&&(identical(other.videoPath, videoPath) || other.videoPath == videoPath));
}


@override
int get hashCode => Object.hashAll([runtimeType,isHomework,isLoading,isLoadingOptions,isPickingAttachment,const DeepCollectionEquality().hash(standards),const DeepCollectionEquality().hash(divisions),const DeepCollectionEquality().hash(subjects),const DeepCollectionEquality().hash(lessons),const DeepCollectionEquality().hash(topics),titleController,instructionsController,youtubeController,isSubmitting,isSubmitted,errorMessage,successMessage,standardId,divisionId,subjectId,lessonId,topicId,workDate,dueDate,imagePath,pdfPath,audioPath,videoPath]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkState(isHomework: $isHomework, isLoading: $isLoading, isLoadingOptions: $isLoadingOptions, isPickingAttachment: $isPickingAttachment, standards: $standards, divisions: $divisions, subjects: $subjects, lessons: $lessons, topics: $topics, titleController: $titleController, instructionsController: $instructionsController, youtubeController: $youtubeController, isSubmitting: $isSubmitting, isSubmitted: $isSubmitted, errorMessage: $errorMessage, successMessage: $successMessage, standardId: $standardId, divisionId: $divisionId, subjectId: $subjectId, lessonId: $lessonId, topicId: $topicId, workDate: $workDate, dueDate: $dueDate, imagePath: $imagePath, pdfPath: $pdfPath, audioPath: $audioPath, videoPath: $videoPath)';
}


}

/// @nodoc
abstract mixin class $AddWorkStateCopyWith<$Res>  {
  factory $AddWorkStateCopyWith(AddWorkState value, $Res Function(AddWorkState) _then) = _$AddWorkStateCopyWithImpl;
@useResult
$Res call({
 bool isHomework, bool isLoading, bool isLoadingOptions, bool isPickingAttachment, List<WorkOption> standards, List<WorkOption> divisions, List<WorkOption> subjects, List<WorkOption> lessons, List<WorkOption> topics, TextEditingController titleController, TextEditingController instructionsController, TextEditingController youtubeController, bool isSubmitting, bool isSubmitted, String? errorMessage, String? successMessage, int? standardId, int? divisionId, int? subjectId, int? lessonId, int? topicId, DateTime? workDate, DateTime? dueDate, String? imagePath, String? pdfPath, String? audioPath, String? videoPath
});




}
/// @nodoc
class _$AddWorkStateCopyWithImpl<$Res>
    implements $AddWorkStateCopyWith<$Res> {
  _$AddWorkStateCopyWithImpl(this._self, this._then);

  final AddWorkState _self;
  final $Res Function(AddWorkState) _then;

/// Create a copy of AddWorkState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isHomework = null,Object? isLoading = null,Object? isLoadingOptions = null,Object? isPickingAttachment = null,Object? standards = null,Object? divisions = null,Object? subjects = null,Object? lessons = null,Object? topics = null,Object? titleController = null,Object? instructionsController = null,Object? youtubeController = null,Object? isSubmitting = null,Object? isSubmitted = null,Object? errorMessage = freezed,Object? successMessage = freezed,Object? standardId = freezed,Object? divisionId = freezed,Object? subjectId = freezed,Object? lessonId = freezed,Object? topicId = freezed,Object? workDate = freezed,Object? dueDate = freezed,Object? imagePath = freezed,Object? pdfPath = freezed,Object? audioPath = freezed,Object? videoPath = freezed,}) {
  return _then(_self.copyWith(
isHomework: null == isHomework ? _self.isHomework : isHomework // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingOptions: null == isLoadingOptions ? _self.isLoadingOptions : isLoadingOptions // ignore: cast_nullable_to_non_nullable
as bool,isPickingAttachment: null == isPickingAttachment ? _self.isPickingAttachment : isPickingAttachment // ignore: cast_nullable_to_non_nullable
as bool,standards: null == standards ? _self.standards : standards // ignore: cast_nullable_to_non_nullable
as List<WorkOption>,divisions: null == divisions ? _self.divisions : divisions // ignore: cast_nullable_to_non_nullable
as List<WorkOption>,subjects: null == subjects ? _self.subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<WorkOption>,lessons: null == lessons ? _self.lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<WorkOption>,topics: null == topics ? _self.topics : topics // ignore: cast_nullable_to_non_nullable
as List<WorkOption>,titleController: null == titleController ? _self.titleController : titleController // ignore: cast_nullable_to_non_nullable
as TextEditingController,instructionsController: null == instructionsController ? _self.instructionsController : instructionsController // ignore: cast_nullable_to_non_nullable
as TextEditingController,youtubeController: null == youtubeController ? _self.youtubeController : youtubeController // ignore: cast_nullable_to_non_nullable
as TextEditingController,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,standardId: freezed == standardId ? _self.standardId : standardId // ignore: cast_nullable_to_non_nullable
as int?,divisionId: freezed == divisionId ? _self.divisionId : divisionId // ignore: cast_nullable_to_non_nullable
as int?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as int?,lessonId: freezed == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as int?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as int?,workDate: freezed == workDate ? _self.workDate : workDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,pdfPath: freezed == pdfPath ? _self.pdfPath : pdfPath // ignore: cast_nullable_to_non_nullable
as String?,audioPath: freezed == audioPath ? _self.audioPath : audioPath // ignore: cast_nullable_to_non_nullable
as String?,videoPath: freezed == videoPath ? _self.videoPath : videoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AddWorkState].
extension AddWorkStatePatterns on AddWorkState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AddWorkState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AddWorkState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AddWorkState value)  $default,){
final _that = this;
switch (_that) {
case _AddWorkState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AddWorkState value)?  $default,){
final _that = this;
switch (_that) {
case _AddWorkState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isHomework,  bool isLoading,  bool isLoadingOptions,  bool isPickingAttachment,  List<WorkOption> standards,  List<WorkOption> divisions,  List<WorkOption> subjects,  List<WorkOption> lessons,  List<WorkOption> topics,  TextEditingController titleController,  TextEditingController instructionsController,  TextEditingController youtubeController,  bool isSubmitting,  bool isSubmitted,  String? errorMessage,  String? successMessage,  int? standardId,  int? divisionId,  int? subjectId,  int? lessonId,  int? topicId,  DateTime? workDate,  DateTime? dueDate,  String? imagePath,  String? pdfPath,  String? audioPath,  String? videoPath)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AddWorkState() when $default != null:
return $default(_that.isHomework,_that.isLoading,_that.isLoadingOptions,_that.isPickingAttachment,_that.standards,_that.divisions,_that.subjects,_that.lessons,_that.topics,_that.titleController,_that.instructionsController,_that.youtubeController,_that.isSubmitting,_that.isSubmitted,_that.errorMessage,_that.successMessage,_that.standardId,_that.divisionId,_that.subjectId,_that.lessonId,_that.topicId,_that.workDate,_that.dueDate,_that.imagePath,_that.pdfPath,_that.audioPath,_that.videoPath);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isHomework,  bool isLoading,  bool isLoadingOptions,  bool isPickingAttachment,  List<WorkOption> standards,  List<WorkOption> divisions,  List<WorkOption> subjects,  List<WorkOption> lessons,  List<WorkOption> topics,  TextEditingController titleController,  TextEditingController instructionsController,  TextEditingController youtubeController,  bool isSubmitting,  bool isSubmitted,  String? errorMessage,  String? successMessage,  int? standardId,  int? divisionId,  int? subjectId,  int? lessonId,  int? topicId,  DateTime? workDate,  DateTime? dueDate,  String? imagePath,  String? pdfPath,  String? audioPath,  String? videoPath)  $default,) {final _that = this;
switch (_that) {
case _AddWorkState():
return $default(_that.isHomework,_that.isLoading,_that.isLoadingOptions,_that.isPickingAttachment,_that.standards,_that.divisions,_that.subjects,_that.lessons,_that.topics,_that.titleController,_that.instructionsController,_that.youtubeController,_that.isSubmitting,_that.isSubmitted,_that.errorMessage,_that.successMessage,_that.standardId,_that.divisionId,_that.subjectId,_that.lessonId,_that.topicId,_that.workDate,_that.dueDate,_that.imagePath,_that.pdfPath,_that.audioPath,_that.videoPath);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isHomework,  bool isLoading,  bool isLoadingOptions,  bool isPickingAttachment,  List<WorkOption> standards,  List<WorkOption> divisions,  List<WorkOption> subjects,  List<WorkOption> lessons,  List<WorkOption> topics,  TextEditingController titleController,  TextEditingController instructionsController,  TextEditingController youtubeController,  bool isSubmitting,  bool isSubmitted,  String? errorMessage,  String? successMessage,  int? standardId,  int? divisionId,  int? subjectId,  int? lessonId,  int? topicId,  DateTime? workDate,  DateTime? dueDate,  String? imagePath,  String? pdfPath,  String? audioPath,  String? videoPath)?  $default,) {final _that = this;
switch (_that) {
case _AddWorkState() when $default != null:
return $default(_that.isHomework,_that.isLoading,_that.isLoadingOptions,_that.isPickingAttachment,_that.standards,_that.divisions,_that.subjects,_that.lessons,_that.topics,_that.titleController,_that.instructionsController,_that.youtubeController,_that.isSubmitting,_that.isSubmitted,_that.errorMessage,_that.successMessage,_that.standardId,_that.divisionId,_that.subjectId,_that.lessonId,_that.topicId,_that.workDate,_that.dueDate,_that.imagePath,_that.pdfPath,_that.audioPath,_that.videoPath);case _:
  return null;

}
}

}

/// @nodoc


class _AddWorkState with DiagnosticableTreeMixin implements AddWorkState {
  const _AddWorkState({required this.isHomework, required this.isLoading, required this.isLoadingOptions, required this.isPickingAttachment, required final  List<WorkOption> standards, required final  List<WorkOption> divisions, required final  List<WorkOption> subjects, required final  List<WorkOption> lessons, required final  List<WorkOption> topics, required this.titleController, required this.instructionsController, required this.youtubeController, this.isSubmitting = false, this.isSubmitted = false, this.errorMessage, this.successMessage, this.standardId, this.divisionId, this.subjectId, this.lessonId, this.topicId, this.workDate, this.dueDate, this.imagePath, this.pdfPath, this.audioPath, this.videoPath}): _standards = standards,_divisions = divisions,_subjects = subjects,_lessons = lessons,_topics = topics;
  

@override final  bool isHomework;
@override final  bool isLoading;
@override final  bool isLoadingOptions;
@override final  bool isPickingAttachment;
 final  List<WorkOption> _standards;
@override List<WorkOption> get standards {
  if (_standards is EqualUnmodifiableListView) return _standards;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_standards);
}

 final  List<WorkOption> _divisions;
@override List<WorkOption> get divisions {
  if (_divisions is EqualUnmodifiableListView) return _divisions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_divisions);
}

 final  List<WorkOption> _subjects;
@override List<WorkOption> get subjects {
  if (_subjects is EqualUnmodifiableListView) return _subjects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_subjects);
}

 final  List<WorkOption> _lessons;
@override List<WorkOption> get lessons {
  if (_lessons is EqualUnmodifiableListView) return _lessons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lessons);
}

 final  List<WorkOption> _topics;
@override List<WorkOption> get topics {
  if (_topics is EqualUnmodifiableListView) return _topics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topics);
}

@override final  TextEditingController titleController;
@override final  TextEditingController instructionsController;
@override final  TextEditingController youtubeController;
@override@JsonKey() final  bool isSubmitting;
@override@JsonKey() final  bool isSubmitted;
@override final  String? errorMessage;
@override final  String? successMessage;
@override final  int? standardId;
@override final  int? divisionId;
@override final  int? subjectId;
@override final  int? lessonId;
@override final  int? topicId;
@override final  DateTime? workDate;
@override final  DateTime? dueDate;
@override final  String? imagePath;
@override final  String? pdfPath;
@override final  String? audioPath;
@override final  String? videoPath;

/// Create a copy of AddWorkState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AddWorkStateCopyWith<_AddWorkState> get copyWith => __$AddWorkStateCopyWithImpl<_AddWorkState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'AddWorkState'))
    ..add(DiagnosticsProperty('isHomework', isHomework))..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('isLoadingOptions', isLoadingOptions))..add(DiagnosticsProperty('isPickingAttachment', isPickingAttachment))..add(DiagnosticsProperty('standards', standards))..add(DiagnosticsProperty('divisions', divisions))..add(DiagnosticsProperty('subjects', subjects))..add(DiagnosticsProperty('lessons', lessons))..add(DiagnosticsProperty('topics', topics))..add(DiagnosticsProperty('titleController', titleController))..add(DiagnosticsProperty('instructionsController', instructionsController))..add(DiagnosticsProperty('youtubeController', youtubeController))..add(DiagnosticsProperty('isSubmitting', isSubmitting))..add(DiagnosticsProperty('isSubmitted', isSubmitted))..add(DiagnosticsProperty('errorMessage', errorMessage))..add(DiagnosticsProperty('successMessage', successMessage))..add(DiagnosticsProperty('standardId', standardId))..add(DiagnosticsProperty('divisionId', divisionId))..add(DiagnosticsProperty('subjectId', subjectId))..add(DiagnosticsProperty('lessonId', lessonId))..add(DiagnosticsProperty('topicId', topicId))..add(DiagnosticsProperty('workDate', workDate))..add(DiagnosticsProperty('dueDate', dueDate))..add(DiagnosticsProperty('imagePath', imagePath))..add(DiagnosticsProperty('pdfPath', pdfPath))..add(DiagnosticsProperty('audioPath', audioPath))..add(DiagnosticsProperty('videoPath', videoPath));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AddWorkState&&(identical(other.isHomework, isHomework) || other.isHomework == isHomework)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingOptions, isLoadingOptions) || other.isLoadingOptions == isLoadingOptions)&&(identical(other.isPickingAttachment, isPickingAttachment) || other.isPickingAttachment == isPickingAttachment)&&const DeepCollectionEquality().equals(other._standards, _standards)&&const DeepCollectionEquality().equals(other._divisions, _divisions)&&const DeepCollectionEquality().equals(other._subjects, _subjects)&&const DeepCollectionEquality().equals(other._lessons, _lessons)&&const DeepCollectionEquality().equals(other._topics, _topics)&&(identical(other.titleController, titleController) || other.titleController == titleController)&&(identical(other.instructionsController, instructionsController) || other.instructionsController == instructionsController)&&(identical(other.youtubeController, youtubeController) || other.youtubeController == youtubeController)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage)&&(identical(other.standardId, standardId) || other.standardId == standardId)&&(identical(other.divisionId, divisionId) || other.divisionId == divisionId)&&(identical(other.subjectId, subjectId) || other.subjectId == subjectId)&&(identical(other.lessonId, lessonId) || other.lessonId == lessonId)&&(identical(other.topicId, topicId) || other.topicId == topicId)&&(identical(other.workDate, workDate) || other.workDate == workDate)&&(identical(other.dueDate, dueDate) || other.dueDate == dueDate)&&(identical(other.imagePath, imagePath) || other.imagePath == imagePath)&&(identical(other.pdfPath, pdfPath) || other.pdfPath == pdfPath)&&(identical(other.audioPath, audioPath) || other.audioPath == audioPath)&&(identical(other.videoPath, videoPath) || other.videoPath == videoPath));
}


@override
int get hashCode => Object.hashAll([runtimeType,isHomework,isLoading,isLoadingOptions,isPickingAttachment,const DeepCollectionEquality().hash(_standards),const DeepCollectionEquality().hash(_divisions),const DeepCollectionEquality().hash(_subjects),const DeepCollectionEquality().hash(_lessons),const DeepCollectionEquality().hash(_topics),titleController,instructionsController,youtubeController,isSubmitting,isSubmitted,errorMessage,successMessage,standardId,divisionId,subjectId,lessonId,topicId,workDate,dueDate,imagePath,pdfPath,audioPath,videoPath]);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'AddWorkState(isHomework: $isHomework, isLoading: $isLoading, isLoadingOptions: $isLoadingOptions, isPickingAttachment: $isPickingAttachment, standards: $standards, divisions: $divisions, subjects: $subjects, lessons: $lessons, topics: $topics, titleController: $titleController, instructionsController: $instructionsController, youtubeController: $youtubeController, isSubmitting: $isSubmitting, isSubmitted: $isSubmitted, errorMessage: $errorMessage, successMessage: $successMessage, standardId: $standardId, divisionId: $divisionId, subjectId: $subjectId, lessonId: $lessonId, topicId: $topicId, workDate: $workDate, dueDate: $dueDate, imagePath: $imagePath, pdfPath: $pdfPath, audioPath: $audioPath, videoPath: $videoPath)';
}


}

/// @nodoc
abstract mixin class _$AddWorkStateCopyWith<$Res> implements $AddWorkStateCopyWith<$Res> {
  factory _$AddWorkStateCopyWith(_AddWorkState value, $Res Function(_AddWorkState) _then) = __$AddWorkStateCopyWithImpl;
@override @useResult
$Res call({
 bool isHomework, bool isLoading, bool isLoadingOptions, bool isPickingAttachment, List<WorkOption> standards, List<WorkOption> divisions, List<WorkOption> subjects, List<WorkOption> lessons, List<WorkOption> topics, TextEditingController titleController, TextEditingController instructionsController, TextEditingController youtubeController, bool isSubmitting, bool isSubmitted, String? errorMessage, String? successMessage, int? standardId, int? divisionId, int? subjectId, int? lessonId, int? topicId, DateTime? workDate, DateTime? dueDate, String? imagePath, String? pdfPath, String? audioPath, String? videoPath
});




}
/// @nodoc
class __$AddWorkStateCopyWithImpl<$Res>
    implements _$AddWorkStateCopyWith<$Res> {
  __$AddWorkStateCopyWithImpl(this._self, this._then);

  final _AddWorkState _self;
  final $Res Function(_AddWorkState) _then;

/// Create a copy of AddWorkState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isHomework = null,Object? isLoading = null,Object? isLoadingOptions = null,Object? isPickingAttachment = null,Object? standards = null,Object? divisions = null,Object? subjects = null,Object? lessons = null,Object? topics = null,Object? titleController = null,Object? instructionsController = null,Object? youtubeController = null,Object? isSubmitting = null,Object? isSubmitted = null,Object? errorMessage = freezed,Object? successMessage = freezed,Object? standardId = freezed,Object? divisionId = freezed,Object? subjectId = freezed,Object? lessonId = freezed,Object? topicId = freezed,Object? workDate = freezed,Object? dueDate = freezed,Object? imagePath = freezed,Object? pdfPath = freezed,Object? audioPath = freezed,Object? videoPath = freezed,}) {
  return _then(_AddWorkState(
isHomework: null == isHomework ? _self.isHomework : isHomework // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingOptions: null == isLoadingOptions ? _self.isLoadingOptions : isLoadingOptions // ignore: cast_nullable_to_non_nullable
as bool,isPickingAttachment: null == isPickingAttachment ? _self.isPickingAttachment : isPickingAttachment // ignore: cast_nullable_to_non_nullable
as bool,standards: null == standards ? _self._standards : standards // ignore: cast_nullable_to_non_nullable
as List<WorkOption>,divisions: null == divisions ? _self._divisions : divisions // ignore: cast_nullable_to_non_nullable
as List<WorkOption>,subjects: null == subjects ? _self._subjects : subjects // ignore: cast_nullable_to_non_nullable
as List<WorkOption>,lessons: null == lessons ? _self._lessons : lessons // ignore: cast_nullable_to_non_nullable
as List<WorkOption>,topics: null == topics ? _self._topics : topics // ignore: cast_nullable_to_non_nullable
as List<WorkOption>,titleController: null == titleController ? _self.titleController : titleController // ignore: cast_nullable_to_non_nullable
as TextEditingController,instructionsController: null == instructionsController ? _self.instructionsController : instructionsController // ignore: cast_nullable_to_non_nullable
as TextEditingController,youtubeController: null == youtubeController ? _self.youtubeController : youtubeController // ignore: cast_nullable_to_non_nullable
as TextEditingController,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,standardId: freezed == standardId ? _self.standardId : standardId // ignore: cast_nullable_to_non_nullable
as int?,divisionId: freezed == divisionId ? _self.divisionId : divisionId // ignore: cast_nullable_to_non_nullable
as int?,subjectId: freezed == subjectId ? _self.subjectId : subjectId // ignore: cast_nullable_to_non_nullable
as int?,lessonId: freezed == lessonId ? _self.lessonId : lessonId // ignore: cast_nullable_to_non_nullable
as int?,topicId: freezed == topicId ? _self.topicId : topicId // ignore: cast_nullable_to_non_nullable
as int?,workDate: freezed == workDate ? _self.workDate : workDate // ignore: cast_nullable_to_non_nullable
as DateTime?,dueDate: freezed == dueDate ? _self.dueDate : dueDate // ignore: cast_nullable_to_non_nullable
as DateTime?,imagePath: freezed == imagePath ? _self.imagePath : imagePath // ignore: cast_nullable_to_non_nullable
as String?,pdfPath: freezed == pdfPath ? _self.pdfPath : pdfPath // ignore: cast_nullable_to_non_nullable
as String?,audioPath: freezed == audioPath ? _self.audioPath : audioPath // ignore: cast_nullable_to_non_nullable
as String?,videoPath: freezed == videoPath ? _self.videoPath : videoPath // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
