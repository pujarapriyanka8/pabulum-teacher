// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'timetable_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$TimetableEvent implements DiagnosticableTreeMixin {




@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TimetableEvent'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TimetableEvent()';
}


}

/// @nodoc
class $TimetableEventCopyWith<$Res>  {
$TimetableEventCopyWith(TimetableEvent _, $Res Function(TimetableEvent) __);
}


/// Adds pattern-matching-related methods to [TimetableEvent].
extension TimetableEventPatterns on TimetableEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadTimetable value)?  onLoadTimetable,TResult Function( OnToggleDay value)?  onToggleDay,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadTimetable() when onLoadTimetable != null:
return onLoadTimetable(_that);case OnToggleDay() when onToggleDay != null:
return onToggleDay(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadTimetable value)  onLoadTimetable,required TResult Function( OnToggleDay value)  onToggleDay,}){
final _that = this;
switch (_that) {
case OnLoadTimetable():
return onLoadTimetable(_that);case OnToggleDay():
return onToggleDay(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadTimetable value)?  onLoadTimetable,TResult? Function( OnToggleDay value)?  onToggleDay,}){
final _that = this;
switch (_that) {
case OnLoadTimetable() when onLoadTimetable != null:
return onLoadTimetable(_that);case OnToggleDay() when onToggleDay != null:
return onToggleDay(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onLoadTimetable,TResult Function( String day)?  onToggleDay,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadTimetable() when onLoadTimetable != null:
return onLoadTimetable();case OnToggleDay() when onToggleDay != null:
return onToggleDay(_that.day);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onLoadTimetable,required TResult Function( String day)  onToggleDay,}) {final _that = this;
switch (_that) {
case OnLoadTimetable():
return onLoadTimetable();case OnToggleDay():
return onToggleDay(_that.day);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onLoadTimetable,TResult? Function( String day)?  onToggleDay,}) {final _that = this;
switch (_that) {
case OnLoadTimetable() when onLoadTimetable != null:
return onLoadTimetable();case OnToggleDay() when onToggleDay != null:
return onToggleDay(_that.day);case _:
  return null;

}
}

}

/// @nodoc


class OnLoadTimetable with DiagnosticableTreeMixin implements TimetableEvent {
  const OnLoadTimetable();
  





@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TimetableEvent.onLoadTimetable'))
    ;
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadTimetable);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TimetableEvent.onLoadTimetable()';
}


}




/// @nodoc


class OnToggleDay with DiagnosticableTreeMixin implements TimetableEvent {
  const OnToggleDay({required this.day});
  

 final  String day;

/// Create a copy of TimetableEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnToggleDayCopyWith<OnToggleDay> get copyWith => _$OnToggleDayCopyWithImpl<OnToggleDay>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TimetableEvent.onToggleDay'))
    ..add(DiagnosticsProperty('day', day));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnToggleDay&&(identical(other.day, day) || other.day == day));
}


@override
int get hashCode => Object.hash(runtimeType,day);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TimetableEvent.onToggleDay(day: $day)';
}


}

/// @nodoc
abstract mixin class $OnToggleDayCopyWith<$Res> implements $TimetableEventCopyWith<$Res> {
  factory $OnToggleDayCopyWith(OnToggleDay value, $Res Function(OnToggleDay) _then) = _$OnToggleDayCopyWithImpl;
@useResult
$Res call({
 String day
});




}
/// @nodoc
class _$OnToggleDayCopyWithImpl<$Res>
    implements $OnToggleDayCopyWith<$Res> {
  _$OnToggleDayCopyWithImpl(this._self, this._then);

  final OnToggleDay _self;
  final $Res Function(OnToggleDay) _then;

/// Create a copy of TimetableEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? day = null,}) {
  return _then(OnToggleDay(
day: null == day ? _self.day : day // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$TimetableState implements DiagnosticableTreeMixin {

 bool get isLoading; List<TimeTableData> get arrTimetable; Set<String> get expandedDays; String? get errorMessage;
/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimetableStateCopyWith<TimetableState> get copyWith => _$TimetableStateCopyWithImpl<TimetableState>(this as TimetableState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TimetableState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('arrTimetable', arrTimetable))..add(DiagnosticsProperty('expandedDays', expandedDays))..add(DiagnosticsProperty('errorMessage', errorMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimetableState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.arrTimetable, arrTimetable)&&const DeepCollectionEquality().equals(other.expandedDays, expandedDays)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(arrTimetable),const DeepCollectionEquality().hash(expandedDays),errorMessage);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TimetableState(isLoading: $isLoading, arrTimetable: $arrTimetable, expandedDays: $expandedDays, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $TimetableStateCopyWith<$Res>  {
  factory $TimetableStateCopyWith(TimetableState value, $Res Function(TimetableState) _then) = _$TimetableStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<TimeTableData> arrTimetable, Set<String> expandedDays, String? errorMessage
});




}
/// @nodoc
class _$TimetableStateCopyWithImpl<$Res>
    implements $TimetableStateCopyWith<$Res> {
  _$TimetableStateCopyWithImpl(this._self, this._then);

  final TimetableState _self;
  final $Res Function(TimetableState) _then;

/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? arrTimetable = null,Object? expandedDays = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,arrTimetable: null == arrTimetable ? _self.arrTimetable : arrTimetable // ignore: cast_nullable_to_non_nullable
as List<TimeTableData>,expandedDays: null == expandedDays ? _self.expandedDays : expandedDays // ignore: cast_nullable_to_non_nullable
as Set<String>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TimetableState].
extension TimetableStatePatterns on TimetableState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TimetableState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TimetableState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TimetableState value)  $default,){
final _that = this;
switch (_that) {
case _TimetableState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TimetableState value)?  $default,){
final _that = this;
switch (_that) {
case _TimetableState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<TimeTableData> arrTimetable,  Set<String> expandedDays,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TimetableState() when $default != null:
return $default(_that.isLoading,_that.arrTimetable,_that.expandedDays,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<TimeTableData> arrTimetable,  Set<String> expandedDays,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _TimetableState():
return $default(_that.isLoading,_that.arrTimetable,_that.expandedDays,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<TimeTableData> arrTimetable,  Set<String> expandedDays,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _TimetableState() when $default != null:
return $default(_that.isLoading,_that.arrTimetable,_that.expandedDays,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _TimetableState with DiagnosticableTreeMixin implements TimetableState {
  const _TimetableState({required this.isLoading, required final  List<TimeTableData> arrTimetable, required final  Set<String> expandedDays, this.errorMessage}): _arrTimetable = arrTimetable,_expandedDays = expandedDays;
  

@override final  bool isLoading;
 final  List<TimeTableData> _arrTimetable;
@override List<TimeTableData> get arrTimetable {
  if (_arrTimetable is EqualUnmodifiableListView) return _arrTimetable;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arrTimetable);
}

 final  Set<String> _expandedDays;
@override Set<String> get expandedDays {
  if (_expandedDays is EqualUnmodifiableSetView) return _expandedDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_expandedDays);
}

@override final  String? errorMessage;

/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimetableStateCopyWith<_TimetableState> get copyWith => __$TimetableStateCopyWithImpl<_TimetableState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'TimetableState'))
    ..add(DiagnosticsProperty('isLoading', isLoading))..add(DiagnosticsProperty('arrTimetable', arrTimetable))..add(DiagnosticsProperty('expandedDays', expandedDays))..add(DiagnosticsProperty('errorMessage', errorMessage));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimetableState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._arrTimetable, _arrTimetable)&&const DeepCollectionEquality().equals(other._expandedDays, _expandedDays)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_arrTimetable),const DeepCollectionEquality().hash(_expandedDays),errorMessage);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'TimetableState(isLoading: $isLoading, arrTimetable: $arrTimetable, expandedDays: $expandedDays, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$TimetableStateCopyWith<$Res> implements $TimetableStateCopyWith<$Res> {
  factory _$TimetableStateCopyWith(_TimetableState value, $Res Function(_TimetableState) _then) = __$TimetableStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<TimeTableData> arrTimetable, Set<String> expandedDays, String? errorMessage
});




}
/// @nodoc
class __$TimetableStateCopyWithImpl<$Res>
    implements _$TimetableStateCopyWith<$Res> {
  __$TimetableStateCopyWithImpl(this._self, this._then);

  final _TimetableState _self;
  final $Res Function(_TimetableState) _then;

/// Create a copy of TimetableState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? arrTimetable = null,Object? expandedDays = null,Object? errorMessage = freezed,}) {
  return _then(_TimetableState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,arrTimetable: null == arrTimetable ? _self._arrTimetable : arrTimetable // ignore: cast_nullable_to_non_nullable
as List<TimeTableData>,expandedDays: null == expandedDays ? _self._expandedDays : expandedDays // ignore: cast_nullable_to_non_nullable
as Set<String>,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
