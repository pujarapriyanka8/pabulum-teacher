// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'attendance_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AttendanceEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AttendanceEvent()';
}


}

/// @nodoc
class $AttendanceEventCopyWith<$Res>  {
$AttendanceEventCopyWith(AttendanceEvent _, $Res Function(AttendanceEvent) __);
}


/// Adds pattern-matching-related methods to [AttendanceEvent].
extension AttendanceEventPatterns on AttendanceEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadAttendanceHistory value)?  onLoadAttendanceHistory,TResult Function( OnLoadAttendanceDetails value)?  onLoadAttendanceDetails,TResult Function( OnChangeAttendanceDate value)?  onChangeAttendanceDate,TResult Function( OnChangeStudentAttendance value)?  onChangeStudentAttendance,TResult Function( OnMarkAllAttendance value)?  onMarkAllAttendance,TResult Function( OnSubmitAttendance value)?  onSubmitAttendance,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadAttendanceHistory() when onLoadAttendanceHistory != null:
return onLoadAttendanceHistory(_that);case OnLoadAttendanceDetails() when onLoadAttendanceDetails != null:
return onLoadAttendanceDetails(_that);case OnChangeAttendanceDate() when onChangeAttendanceDate != null:
return onChangeAttendanceDate(_that);case OnChangeStudentAttendance() when onChangeStudentAttendance != null:
return onChangeStudentAttendance(_that);case OnMarkAllAttendance() when onMarkAllAttendance != null:
return onMarkAllAttendance(_that);case OnSubmitAttendance() when onSubmitAttendance != null:
return onSubmitAttendance(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadAttendanceHistory value)  onLoadAttendanceHistory,required TResult Function( OnLoadAttendanceDetails value)  onLoadAttendanceDetails,required TResult Function( OnChangeAttendanceDate value)  onChangeAttendanceDate,required TResult Function( OnChangeStudentAttendance value)  onChangeStudentAttendance,required TResult Function( OnMarkAllAttendance value)  onMarkAllAttendance,required TResult Function( OnSubmitAttendance value)  onSubmitAttendance,}){
final _that = this;
switch (_that) {
case OnLoadAttendanceHistory():
return onLoadAttendanceHistory(_that);case OnLoadAttendanceDetails():
return onLoadAttendanceDetails(_that);case OnChangeAttendanceDate():
return onChangeAttendanceDate(_that);case OnChangeStudentAttendance():
return onChangeStudentAttendance(_that);case OnMarkAllAttendance():
return onMarkAllAttendance(_that);case OnSubmitAttendance():
return onSubmitAttendance(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadAttendanceHistory value)?  onLoadAttendanceHistory,TResult? Function( OnLoadAttendanceDetails value)?  onLoadAttendanceDetails,TResult? Function( OnChangeAttendanceDate value)?  onChangeAttendanceDate,TResult? Function( OnChangeStudentAttendance value)?  onChangeStudentAttendance,TResult? Function( OnMarkAllAttendance value)?  onMarkAllAttendance,TResult? Function( OnSubmitAttendance value)?  onSubmitAttendance,}){
final _that = this;
switch (_that) {
case OnLoadAttendanceHistory() when onLoadAttendanceHistory != null:
return onLoadAttendanceHistory(_that);case OnLoadAttendanceDetails() when onLoadAttendanceDetails != null:
return onLoadAttendanceDetails(_that);case OnChangeAttendanceDate() when onChangeAttendanceDate != null:
return onChangeAttendanceDate(_that);case OnChangeStudentAttendance() when onChangeStudentAttendance != null:
return onChangeStudentAttendance(_that);case OnMarkAllAttendance() when onMarkAllAttendance != null:
return onMarkAllAttendance(_that);case OnSubmitAttendance() when onSubmitAttendance != null:
return onSubmitAttendance(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  DateTime? date)?  onLoadAttendanceHistory,TResult Function( String attendanceId)?  onLoadAttendanceDetails,TResult Function( DateTime date)?  onChangeAttendanceDate,TResult Function( String studentId,  bool isPresent)?  onChangeStudentAttendance,TResult Function( bool isPresent,  List<MyStudent> students)?  onMarkAllAttendance,TResult Function( List<MyStudent> students)?  onSubmitAttendance,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadAttendanceHistory() when onLoadAttendanceHistory != null:
return onLoadAttendanceHistory(_that.page,_that.date);case OnLoadAttendanceDetails() when onLoadAttendanceDetails != null:
return onLoadAttendanceDetails(_that.attendanceId);case OnChangeAttendanceDate() when onChangeAttendanceDate != null:
return onChangeAttendanceDate(_that.date);case OnChangeStudentAttendance() when onChangeStudentAttendance != null:
return onChangeStudentAttendance(_that.studentId,_that.isPresent);case OnMarkAllAttendance() when onMarkAllAttendance != null:
return onMarkAllAttendance(_that.isPresent,_that.students);case OnSubmitAttendance() when onSubmitAttendance != null:
return onSubmitAttendance(_that.students);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  DateTime? date)  onLoadAttendanceHistory,required TResult Function( String attendanceId)  onLoadAttendanceDetails,required TResult Function( DateTime date)  onChangeAttendanceDate,required TResult Function( String studentId,  bool isPresent)  onChangeStudentAttendance,required TResult Function( bool isPresent,  List<MyStudent> students)  onMarkAllAttendance,required TResult Function( List<MyStudent> students)  onSubmitAttendance,}) {final _that = this;
switch (_that) {
case OnLoadAttendanceHistory():
return onLoadAttendanceHistory(_that.page,_that.date);case OnLoadAttendanceDetails():
return onLoadAttendanceDetails(_that.attendanceId);case OnChangeAttendanceDate():
return onChangeAttendanceDate(_that.date);case OnChangeStudentAttendance():
return onChangeStudentAttendance(_that.studentId,_that.isPresent);case OnMarkAllAttendance():
return onMarkAllAttendance(_that.isPresent,_that.students);case OnSubmitAttendance():
return onSubmitAttendance(_that.students);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  DateTime? date)?  onLoadAttendanceHistory,TResult? Function( String attendanceId)?  onLoadAttendanceDetails,TResult? Function( DateTime date)?  onChangeAttendanceDate,TResult? Function( String studentId,  bool isPresent)?  onChangeStudentAttendance,TResult? Function( bool isPresent,  List<MyStudent> students)?  onMarkAllAttendance,TResult? Function( List<MyStudent> students)?  onSubmitAttendance,}) {final _that = this;
switch (_that) {
case OnLoadAttendanceHistory() when onLoadAttendanceHistory != null:
return onLoadAttendanceHistory(_that.page,_that.date);case OnLoadAttendanceDetails() when onLoadAttendanceDetails != null:
return onLoadAttendanceDetails(_that.attendanceId);case OnChangeAttendanceDate() when onChangeAttendanceDate != null:
return onChangeAttendanceDate(_that.date);case OnChangeStudentAttendance() when onChangeStudentAttendance != null:
return onChangeStudentAttendance(_that.studentId,_that.isPresent);case OnMarkAllAttendance() when onMarkAllAttendance != null:
return onMarkAllAttendance(_that.isPresent,_that.students);case OnSubmitAttendance() when onSubmitAttendance != null:
return onSubmitAttendance(_that.students);case _:
  return null;

}
}

}

/// @nodoc


class OnLoadAttendanceHistory implements AttendanceEvent {
  const OnLoadAttendanceHistory({this.page = 1, this.date});
  

@JsonKey() final  int page;
 final  DateTime? date;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadAttendanceHistoryCopyWith<OnLoadAttendanceHistory> get copyWith => _$OnLoadAttendanceHistoryCopyWithImpl<OnLoadAttendanceHistory>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadAttendanceHistory&&(identical(other.page, page) || other.page == page)&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,page,date);

@override
String toString() {
  return 'AttendanceEvent.onLoadAttendanceHistory(page: $page, date: $date)';
}


}

/// @nodoc
abstract mixin class $OnLoadAttendanceHistoryCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $OnLoadAttendanceHistoryCopyWith(OnLoadAttendanceHistory value, $Res Function(OnLoadAttendanceHistory) _then) = _$OnLoadAttendanceHistoryCopyWithImpl;
@useResult
$Res call({
 int page, DateTime? date
});




}
/// @nodoc
class _$OnLoadAttendanceHistoryCopyWithImpl<$Res>
    implements $OnLoadAttendanceHistoryCopyWith<$Res> {
  _$OnLoadAttendanceHistoryCopyWithImpl(this._self, this._then);

  final OnLoadAttendanceHistory _self;
  final $Res Function(OnLoadAttendanceHistory) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? date = freezed,}) {
  return _then(OnLoadAttendanceHistory(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,date: freezed == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

/// @nodoc


class OnLoadAttendanceDetails implements AttendanceEvent {
  const OnLoadAttendanceDetails({required this.attendanceId});
  

 final  String attendanceId;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadAttendanceDetailsCopyWith<OnLoadAttendanceDetails> get copyWith => _$OnLoadAttendanceDetailsCopyWithImpl<OnLoadAttendanceDetails>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadAttendanceDetails&&(identical(other.attendanceId, attendanceId) || other.attendanceId == attendanceId));
}


@override
int get hashCode => Object.hash(runtimeType,attendanceId);

@override
String toString() {
  return 'AttendanceEvent.onLoadAttendanceDetails(attendanceId: $attendanceId)';
}


}

/// @nodoc
abstract mixin class $OnLoadAttendanceDetailsCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $OnLoadAttendanceDetailsCopyWith(OnLoadAttendanceDetails value, $Res Function(OnLoadAttendanceDetails) _then) = _$OnLoadAttendanceDetailsCopyWithImpl;
@useResult
$Res call({
 String attendanceId
});




}
/// @nodoc
class _$OnLoadAttendanceDetailsCopyWithImpl<$Res>
    implements $OnLoadAttendanceDetailsCopyWith<$Res> {
  _$OnLoadAttendanceDetailsCopyWithImpl(this._self, this._then);

  final OnLoadAttendanceDetails _self;
  final $Res Function(OnLoadAttendanceDetails) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? attendanceId = null,}) {
  return _then(OnLoadAttendanceDetails(
attendanceId: null == attendanceId ? _self.attendanceId : attendanceId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OnChangeAttendanceDate implements AttendanceEvent {
  const OnChangeAttendanceDate({required this.date});
  

 final  DateTime date;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnChangeAttendanceDateCopyWith<OnChangeAttendanceDate> get copyWith => _$OnChangeAttendanceDateCopyWithImpl<OnChangeAttendanceDate>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnChangeAttendanceDate&&(identical(other.date, date) || other.date == date));
}


@override
int get hashCode => Object.hash(runtimeType,date);

@override
String toString() {
  return 'AttendanceEvent.onChangeAttendanceDate(date: $date)';
}


}

/// @nodoc
abstract mixin class $OnChangeAttendanceDateCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $OnChangeAttendanceDateCopyWith(OnChangeAttendanceDate value, $Res Function(OnChangeAttendanceDate) _then) = _$OnChangeAttendanceDateCopyWithImpl;
@useResult
$Res call({
 DateTime date
});




}
/// @nodoc
class _$OnChangeAttendanceDateCopyWithImpl<$Res>
    implements $OnChangeAttendanceDateCopyWith<$Res> {
  _$OnChangeAttendanceDateCopyWithImpl(this._self, this._then);

  final OnChangeAttendanceDate _self;
  final $Res Function(OnChangeAttendanceDate) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? date = null,}) {
  return _then(OnChangeAttendanceDate(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

/// @nodoc


class OnChangeStudentAttendance implements AttendanceEvent {
  const OnChangeStudentAttendance({required this.studentId, required this.isPresent});
  

 final  String studentId;
 final  bool isPresent;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnChangeStudentAttendanceCopyWith<OnChangeStudentAttendance> get copyWith => _$OnChangeStudentAttendanceCopyWithImpl<OnChangeStudentAttendance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnChangeStudentAttendance&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.isPresent, isPresent) || other.isPresent == isPresent));
}


@override
int get hashCode => Object.hash(runtimeType,studentId,isPresent);

@override
String toString() {
  return 'AttendanceEvent.onChangeStudentAttendance(studentId: $studentId, isPresent: $isPresent)';
}


}

/// @nodoc
abstract mixin class $OnChangeStudentAttendanceCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $OnChangeStudentAttendanceCopyWith(OnChangeStudentAttendance value, $Res Function(OnChangeStudentAttendance) _then) = _$OnChangeStudentAttendanceCopyWithImpl;
@useResult
$Res call({
 String studentId, bool isPresent
});




}
/// @nodoc
class _$OnChangeStudentAttendanceCopyWithImpl<$Res>
    implements $OnChangeStudentAttendanceCopyWith<$Res> {
  _$OnChangeStudentAttendanceCopyWithImpl(this._self, this._then);

  final OnChangeStudentAttendance _self;
  final $Res Function(OnChangeStudentAttendance) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? studentId = null,Object? isPresent = null,}) {
  return _then(OnChangeStudentAttendance(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as String,isPresent: null == isPresent ? _self.isPresent : isPresent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc


class OnMarkAllAttendance implements AttendanceEvent {
  const OnMarkAllAttendance({required this.isPresent, required final  List<MyStudent> students}): _students = students;
  

 final  bool isPresent;
 final  List<MyStudent> _students;
 List<MyStudent> get students {
  if (_students is EqualUnmodifiableListView) return _students;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_students);
}


/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnMarkAllAttendanceCopyWith<OnMarkAllAttendance> get copyWith => _$OnMarkAllAttendanceCopyWithImpl<OnMarkAllAttendance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnMarkAllAttendance&&(identical(other.isPresent, isPresent) || other.isPresent == isPresent)&&const DeepCollectionEquality().equals(other._students, _students));
}


@override
int get hashCode => Object.hash(runtimeType,isPresent,const DeepCollectionEquality().hash(_students));

@override
String toString() {
  return 'AttendanceEvent.onMarkAllAttendance(isPresent: $isPresent, students: $students)';
}


}

/// @nodoc
abstract mixin class $OnMarkAllAttendanceCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $OnMarkAllAttendanceCopyWith(OnMarkAllAttendance value, $Res Function(OnMarkAllAttendance) _then) = _$OnMarkAllAttendanceCopyWithImpl;
@useResult
$Res call({
 bool isPresent, List<MyStudent> students
});




}
/// @nodoc
class _$OnMarkAllAttendanceCopyWithImpl<$Res>
    implements $OnMarkAllAttendanceCopyWith<$Res> {
  _$OnMarkAllAttendanceCopyWithImpl(this._self, this._then);

  final OnMarkAllAttendance _self;
  final $Res Function(OnMarkAllAttendance) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? isPresent = null,Object? students = null,}) {
  return _then(OnMarkAllAttendance(
isPresent: null == isPresent ? _self.isPresent : isPresent // ignore: cast_nullable_to_non_nullable
as bool,students: null == students ? _self._students : students // ignore: cast_nullable_to_non_nullable
as List<MyStudent>,
  ));
}


}

/// @nodoc


class OnSubmitAttendance implements AttendanceEvent {
  const OnSubmitAttendance({required final  List<MyStudent> students}): _students = students;
  

 final  List<MyStudent> _students;
 List<MyStudent> get students {
  if (_students is EqualUnmodifiableListView) return _students;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_students);
}


/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSubmitAttendanceCopyWith<OnSubmitAttendance> get copyWith => _$OnSubmitAttendanceCopyWithImpl<OnSubmitAttendance>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSubmitAttendance&&const DeepCollectionEquality().equals(other._students, _students));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_students));

@override
String toString() {
  return 'AttendanceEvent.onSubmitAttendance(students: $students)';
}


}

/// @nodoc
abstract mixin class $OnSubmitAttendanceCopyWith<$Res> implements $AttendanceEventCopyWith<$Res> {
  factory $OnSubmitAttendanceCopyWith(OnSubmitAttendance value, $Res Function(OnSubmitAttendance) _then) = _$OnSubmitAttendanceCopyWithImpl;
@useResult
$Res call({
 List<MyStudent> students
});




}
/// @nodoc
class _$OnSubmitAttendanceCopyWithImpl<$Res>
    implements $OnSubmitAttendanceCopyWith<$Res> {
  _$OnSubmitAttendanceCopyWithImpl(this._self, this._then);

  final OnSubmitAttendance _self;
  final $Res Function(OnSubmitAttendance) _then;

/// Create a copy of AttendanceEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? students = null,}) {
  return _then(OnSubmitAttendance(
students: null == students ? _self._students : students // ignore: cast_nullable_to_non_nullable
as List<MyStudent>,
  ));
}


}

/// @nodoc
mixin _$AttendanceState {

 bool get isLoading; bool get isLoadingMore; bool get isSubmitting; bool get isSubmitted; List<AttendanceHistory> get arrAttendanceHistory; AttendanceDetailData? get attendanceDetailData; Map<String, bool> get attendanceStatus; DateTime get attendanceDate; int get currentPage; bool get hasMore; DateTime? get filterDate;
/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AttendanceStateCopyWith<AttendanceState> get copyWith => _$AttendanceStateCopyWithImpl<AttendanceState>(this as AttendanceState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AttendanceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&const DeepCollectionEquality().equals(other.arrAttendanceHistory, arrAttendanceHistory)&&(identical(other.attendanceDetailData, attendanceDetailData) || other.attendanceDetailData == attendanceDetailData)&&const DeepCollectionEquality().equals(other.attendanceStatus, attendanceStatus)&&(identical(other.attendanceDate, attendanceDate) || other.attendanceDate == attendanceDate)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.filterDate, filterDate) || other.filterDate == filterDate));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,isSubmitting,isSubmitted,const DeepCollectionEquality().hash(arrAttendanceHistory),attendanceDetailData,const DeepCollectionEquality().hash(attendanceStatus),attendanceDate,currentPage,hasMore,filterDate);

@override
String toString() {
  return 'AttendanceState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, isSubmitting: $isSubmitting, isSubmitted: $isSubmitted, arrAttendanceHistory: $arrAttendanceHistory, attendanceDetailData: $attendanceDetailData, attendanceStatus: $attendanceStatus, attendanceDate: $attendanceDate, currentPage: $currentPage, hasMore: $hasMore, filterDate: $filterDate)';
}


}

/// @nodoc
abstract mixin class $AttendanceStateCopyWith<$Res>  {
  factory $AttendanceStateCopyWith(AttendanceState value, $Res Function(AttendanceState) _then) = _$AttendanceStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool isSubmitting, bool isSubmitted, List<AttendanceHistory> arrAttendanceHistory, AttendanceDetailData? attendanceDetailData, Map<String, bool> attendanceStatus, DateTime attendanceDate, int currentPage, bool hasMore, DateTime? filterDate
});




}
/// @nodoc
class _$AttendanceStateCopyWithImpl<$Res>
    implements $AttendanceStateCopyWith<$Res> {
  _$AttendanceStateCopyWithImpl(this._self, this._then);

  final AttendanceState _self;
  final $Res Function(AttendanceState) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? isSubmitting = null,Object? isSubmitted = null,Object? arrAttendanceHistory = null,Object? attendanceDetailData = freezed,Object? attendanceStatus = null,Object? attendanceDate = null,Object? currentPage = null,Object? hasMore = null,Object? filterDate = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,arrAttendanceHistory: null == arrAttendanceHistory ? _self.arrAttendanceHistory : arrAttendanceHistory // ignore: cast_nullable_to_non_nullable
as List<AttendanceHistory>,attendanceDetailData: freezed == attendanceDetailData ? _self.attendanceDetailData : attendanceDetailData // ignore: cast_nullable_to_non_nullable
as AttendanceDetailData?,attendanceStatus: null == attendanceStatus ? _self.attendanceStatus : attendanceStatus // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,attendanceDate: null == attendanceDate ? _self.attendanceDate : attendanceDate // ignore: cast_nullable_to_non_nullable
as DateTime,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,filterDate: freezed == filterDate ? _self.filterDate : filterDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [AttendanceState].
extension AttendanceStatePatterns on AttendanceState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AttendanceState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AttendanceState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AttendanceState value)  $default,){
final _that = this;
switch (_that) {
case _AttendanceState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AttendanceState value)?  $default,){
final _that = this;
switch (_that) {
case _AttendanceState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  bool isSubmitting,  bool isSubmitted,  List<AttendanceHistory> arrAttendanceHistory,  AttendanceDetailData? attendanceDetailData,  Map<String, bool> attendanceStatus,  DateTime attendanceDate,  int currentPage,  bool hasMore,  DateTime? filterDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AttendanceState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.isSubmitting,_that.isSubmitted,_that.arrAttendanceHistory,_that.attendanceDetailData,_that.attendanceStatus,_that.attendanceDate,_that.currentPage,_that.hasMore,_that.filterDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  bool isSubmitting,  bool isSubmitted,  List<AttendanceHistory> arrAttendanceHistory,  AttendanceDetailData? attendanceDetailData,  Map<String, bool> attendanceStatus,  DateTime attendanceDate,  int currentPage,  bool hasMore,  DateTime? filterDate)  $default,) {final _that = this;
switch (_that) {
case _AttendanceState():
return $default(_that.isLoading,_that.isLoadingMore,_that.isSubmitting,_that.isSubmitted,_that.arrAttendanceHistory,_that.attendanceDetailData,_that.attendanceStatus,_that.attendanceDate,_that.currentPage,_that.hasMore,_that.filterDate);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isLoadingMore,  bool isSubmitting,  bool isSubmitted,  List<AttendanceHistory> arrAttendanceHistory,  AttendanceDetailData? attendanceDetailData,  Map<String, bool> attendanceStatus,  DateTime attendanceDate,  int currentPage,  bool hasMore,  DateTime? filterDate)?  $default,) {final _that = this;
switch (_that) {
case _AttendanceState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.isSubmitting,_that.isSubmitted,_that.arrAttendanceHistory,_that.attendanceDetailData,_that.attendanceStatus,_that.attendanceDate,_that.currentPage,_that.hasMore,_that.filterDate);case _:
  return null;

}
}

}

/// @nodoc


class _AttendanceState implements AttendanceState {
  const _AttendanceState({required this.isLoading, required this.isLoadingMore, required this.isSubmitting, required this.isSubmitted, required final  List<AttendanceHistory> arrAttendanceHistory, required this.attendanceDetailData, required final  Map<String, bool> attendanceStatus, required this.attendanceDate, required this.currentPage, required this.hasMore, this.filterDate}): _arrAttendanceHistory = arrAttendanceHistory,_attendanceStatus = attendanceStatus;
  

@override final  bool isLoading;
@override final  bool isLoadingMore;
@override final  bool isSubmitting;
@override final  bool isSubmitted;
 final  List<AttendanceHistory> _arrAttendanceHistory;
@override List<AttendanceHistory> get arrAttendanceHistory {
  if (_arrAttendanceHistory is EqualUnmodifiableListView) return _arrAttendanceHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arrAttendanceHistory);
}

@override final  AttendanceDetailData? attendanceDetailData;
 final  Map<String, bool> _attendanceStatus;
@override Map<String, bool> get attendanceStatus {
  if (_attendanceStatus is EqualUnmodifiableMapView) return _attendanceStatus;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_attendanceStatus);
}

@override final  DateTime attendanceDate;
@override final  int currentPage;
@override final  bool hasMore;
@override final  DateTime? filterDate;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AttendanceStateCopyWith<_AttendanceState> get copyWith => __$AttendanceStateCopyWithImpl<_AttendanceState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AttendanceState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&const DeepCollectionEquality().equals(other._arrAttendanceHistory, _arrAttendanceHistory)&&(identical(other.attendanceDetailData, attendanceDetailData) || other.attendanceDetailData == attendanceDetailData)&&const DeepCollectionEquality().equals(other._attendanceStatus, _attendanceStatus)&&(identical(other.attendanceDate, attendanceDate) || other.attendanceDate == attendanceDate)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.filterDate, filterDate) || other.filterDate == filterDate));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,isSubmitting,isSubmitted,const DeepCollectionEquality().hash(_arrAttendanceHistory),attendanceDetailData,const DeepCollectionEquality().hash(_attendanceStatus),attendanceDate,currentPage,hasMore,filterDate);

@override
String toString() {
  return 'AttendanceState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, isSubmitting: $isSubmitting, isSubmitted: $isSubmitted, arrAttendanceHistory: $arrAttendanceHistory, attendanceDetailData: $attendanceDetailData, attendanceStatus: $attendanceStatus, attendanceDate: $attendanceDate, currentPage: $currentPage, hasMore: $hasMore, filterDate: $filterDate)';
}


}

/// @nodoc
abstract mixin class _$AttendanceStateCopyWith<$Res> implements $AttendanceStateCopyWith<$Res> {
  factory _$AttendanceStateCopyWith(_AttendanceState value, $Res Function(_AttendanceState) _then) = __$AttendanceStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool isSubmitting, bool isSubmitted, List<AttendanceHistory> arrAttendanceHistory, AttendanceDetailData? attendanceDetailData, Map<String, bool> attendanceStatus, DateTime attendanceDate, int currentPage, bool hasMore, DateTime? filterDate
});




}
/// @nodoc
class __$AttendanceStateCopyWithImpl<$Res>
    implements _$AttendanceStateCopyWith<$Res> {
  __$AttendanceStateCopyWithImpl(this._self, this._then);

  final _AttendanceState _self;
  final $Res Function(_AttendanceState) _then;

/// Create a copy of AttendanceState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? isSubmitting = null,Object? isSubmitted = null,Object? arrAttendanceHistory = null,Object? attendanceDetailData = freezed,Object? attendanceStatus = null,Object? attendanceDate = null,Object? currentPage = null,Object? hasMore = null,Object? filterDate = freezed,}) {
  return _then(_AttendanceState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,arrAttendanceHistory: null == arrAttendanceHistory ? _self._arrAttendanceHistory : arrAttendanceHistory // ignore: cast_nullable_to_non_nullable
as List<AttendanceHistory>,attendanceDetailData: freezed == attendanceDetailData ? _self.attendanceDetailData : attendanceDetailData // ignore: cast_nullable_to_non_nullable
as AttendanceDetailData?,attendanceStatus: null == attendanceStatus ? _self._attendanceStatus : attendanceStatus // ignore: cast_nullable_to_non_nullable
as Map<String, bool>,attendanceDate: null == attendanceDate ? _self.attendanceDate : attendanceDate // ignore: cast_nullable_to_non_nullable
as DateTime,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,filterDate: freezed == filterDate ? _self.filterDate : filterDate // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
