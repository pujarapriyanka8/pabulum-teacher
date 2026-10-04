// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'my_student_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$MyStudentEvent {

 String get query; bool get debounce;
/// Create a copy of MyStudentEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyStudentEventCopyWith<MyStudentEvent> get copyWith => _$MyStudentEventCopyWithImpl<MyStudentEvent>(this as MyStudentEvent, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyStudentEvent&&(identical(other.query, query) || other.query == query)&&(identical(other.debounce, debounce) || other.debounce == debounce));
}


@override
int get hashCode => Object.hash(runtimeType,query,debounce);

@override
String toString() {
  return 'MyStudentEvent(query: $query, debounce: $debounce)';
}


}

/// @nodoc
abstract mixin class $MyStudentEventCopyWith<$Res>  {
  factory $MyStudentEventCopyWith(MyStudentEvent value, $Res Function(MyStudentEvent) _then) = _$MyStudentEventCopyWithImpl;
@useResult
$Res call({
 String query, bool debounce
});




}
/// @nodoc
class _$MyStudentEventCopyWithImpl<$Res>
    implements $MyStudentEventCopyWith<$Res> {
  _$MyStudentEventCopyWithImpl(this._self, this._then);

  final MyStudentEvent _self;
  final $Res Function(MyStudentEvent) _then;

/// Create a copy of MyStudentEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? query = null,Object? debounce = null,}) {
  return _then(_self.copyWith(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,debounce: null == debounce ? _self.debounce : debounce // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [MyStudentEvent].
extension MyStudentEventPatterns on MyStudentEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadMyStudents value)?  onLoadMyStudents,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadMyStudents() when onLoadMyStudents != null:
return onLoadMyStudents(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadMyStudents value)  onLoadMyStudents,}){
final _that = this;
switch (_that) {
case OnLoadMyStudents():
return onLoadMyStudents(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadMyStudents value)?  onLoadMyStudents,}){
final _that = this;
switch (_that) {
case OnLoadMyStudents() when onLoadMyStudents != null:
return onLoadMyStudents(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String query,  bool debounce)?  onLoadMyStudents,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadMyStudents() when onLoadMyStudents != null:
return onLoadMyStudents(_that.query,_that.debounce);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String query,  bool debounce)  onLoadMyStudents,}) {final _that = this;
switch (_that) {
case OnLoadMyStudents():
return onLoadMyStudents(_that.query,_that.debounce);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String query,  bool debounce)?  onLoadMyStudents,}) {final _that = this;
switch (_that) {
case OnLoadMyStudents() when onLoadMyStudents != null:
return onLoadMyStudents(_that.query,_that.debounce);case _:
  return null;

}
}

}

/// @nodoc


class OnLoadMyStudents implements MyStudentEvent {
  const OnLoadMyStudents({this.query = '', this.debounce = false});
  

@override@JsonKey() final  String query;
@override@JsonKey() final  bool debounce;

/// Create a copy of MyStudentEvent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadMyStudentsCopyWith<OnLoadMyStudents> get copyWith => _$OnLoadMyStudentsCopyWithImpl<OnLoadMyStudents>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadMyStudents&&(identical(other.query, query) || other.query == query)&&(identical(other.debounce, debounce) || other.debounce == debounce));
}


@override
int get hashCode => Object.hash(runtimeType,query,debounce);

@override
String toString() {
  return 'MyStudentEvent.onLoadMyStudents(query: $query, debounce: $debounce)';
}


}

/// @nodoc
abstract mixin class $OnLoadMyStudentsCopyWith<$Res> implements $MyStudentEventCopyWith<$Res> {
  factory $OnLoadMyStudentsCopyWith(OnLoadMyStudents value, $Res Function(OnLoadMyStudents) _then) = _$OnLoadMyStudentsCopyWithImpl;
@override @useResult
$Res call({
 String query, bool debounce
});




}
/// @nodoc
class _$OnLoadMyStudentsCopyWithImpl<$Res>
    implements $OnLoadMyStudentsCopyWith<$Res> {
  _$OnLoadMyStudentsCopyWithImpl(this._self, this._then);

  final OnLoadMyStudents _self;
  final $Res Function(OnLoadMyStudents) _then;

/// Create a copy of MyStudentEvent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? query = null,Object? debounce = null,}) {
  return _then(OnLoadMyStudents(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,debounce: null == debounce ? _self.debounce : debounce // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

/// @nodoc
mixin _$MyStudentState {

 bool get isLoading; List<MyStudent> get arrMyStudents; String get query; TextEditingController get studentNameController;
/// Create a copy of MyStudentState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MyStudentStateCopyWith<MyStudentState> get copyWith => _$MyStudentStateCopyWithImpl<MyStudentState>(this as MyStudentState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MyStudentState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.arrMyStudents, arrMyStudents)&&(identical(other.query, query) || other.query == query)&&(identical(other.studentNameController, studentNameController) || other.studentNameController == studentNameController));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(arrMyStudents),query,studentNameController);

@override
String toString() {
  return 'MyStudentState(isLoading: $isLoading, arrMyStudents: $arrMyStudents, query: $query, studentNameController: $studentNameController)';
}


}

/// @nodoc
abstract mixin class $MyStudentStateCopyWith<$Res>  {
  factory $MyStudentStateCopyWith(MyStudentState value, $Res Function(MyStudentState) _then) = _$MyStudentStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<MyStudent> arrMyStudents, String query, TextEditingController studentNameController
});




}
/// @nodoc
class _$MyStudentStateCopyWithImpl<$Res>
    implements $MyStudentStateCopyWith<$Res> {
  _$MyStudentStateCopyWithImpl(this._self, this._then);

  final MyStudentState _self;
  final $Res Function(MyStudentState) _then;

/// Create a copy of MyStudentState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? arrMyStudents = null,Object? query = null,Object? studentNameController = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,arrMyStudents: null == arrMyStudents ? _self.arrMyStudents : arrMyStudents // ignore: cast_nullable_to_non_nullable
as List<MyStudent>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,studentNameController: null == studentNameController ? _self.studentNameController : studentNameController // ignore: cast_nullable_to_non_nullable
as TextEditingController,
  ));
}

}


/// Adds pattern-matching-related methods to [MyStudentState].
extension MyStudentStatePatterns on MyStudentState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MyStudentState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MyStudentState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MyStudentState value)  $default,){
final _that = this;
switch (_that) {
case _MyStudentState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MyStudentState value)?  $default,){
final _that = this;
switch (_that) {
case _MyStudentState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<MyStudent> arrMyStudents,  String query,  TextEditingController studentNameController)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MyStudentState() when $default != null:
return $default(_that.isLoading,_that.arrMyStudents,_that.query,_that.studentNameController);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<MyStudent> arrMyStudents,  String query,  TextEditingController studentNameController)  $default,) {final _that = this;
switch (_that) {
case _MyStudentState():
return $default(_that.isLoading,_that.arrMyStudents,_that.query,_that.studentNameController);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<MyStudent> arrMyStudents,  String query,  TextEditingController studentNameController)?  $default,) {final _that = this;
switch (_that) {
case _MyStudentState() when $default != null:
return $default(_that.isLoading,_that.arrMyStudents,_that.query,_that.studentNameController);case _:
  return null;

}
}

}

/// @nodoc


class _MyStudentState implements MyStudentState {
  const _MyStudentState({required this.isLoading, required final  List<MyStudent> arrMyStudents, this.query = '', required this.studentNameController}): _arrMyStudents = arrMyStudents;
  

@override final  bool isLoading;
 final  List<MyStudent> _arrMyStudents;
@override List<MyStudent> get arrMyStudents {
  if (_arrMyStudents is EqualUnmodifiableListView) return _arrMyStudents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arrMyStudents);
}

@override@JsonKey() final  String query;
@override final  TextEditingController studentNameController;

/// Create a copy of MyStudentState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MyStudentStateCopyWith<_MyStudentState> get copyWith => __$MyStudentStateCopyWithImpl<_MyStudentState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MyStudentState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._arrMyStudents, _arrMyStudents)&&(identical(other.query, query) || other.query == query)&&(identical(other.studentNameController, studentNameController) || other.studentNameController == studentNameController));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_arrMyStudents),query,studentNameController);

@override
String toString() {
  return 'MyStudentState(isLoading: $isLoading, arrMyStudents: $arrMyStudents, query: $query, studentNameController: $studentNameController)';
}


}

/// @nodoc
abstract mixin class _$MyStudentStateCopyWith<$Res> implements $MyStudentStateCopyWith<$Res> {
  factory _$MyStudentStateCopyWith(_MyStudentState value, $Res Function(_MyStudentState) _then) = __$MyStudentStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<MyStudent> arrMyStudents, String query, TextEditingController studentNameController
});




}
/// @nodoc
class __$MyStudentStateCopyWithImpl<$Res>
    implements _$MyStudentStateCopyWith<$Res> {
  __$MyStudentStateCopyWithImpl(this._self, this._then);

  final _MyStudentState _self;
  final $Res Function(_MyStudentState) _then;

/// Create a copy of MyStudentState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? arrMyStudents = null,Object? query = null,Object? studentNameController = null,}) {
  return _then(_MyStudentState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,arrMyStudents: null == arrMyStudents ? _self._arrMyStudents : arrMyStudents // ignore: cast_nullable_to_non_nullable
as List<MyStudent>,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,studentNameController: null == studentNameController ? _self.studentNameController : studentNameController // ignore: cast_nullable_to_non_nullable
as TextEditingController,
  ));
}


}

// dart format on
