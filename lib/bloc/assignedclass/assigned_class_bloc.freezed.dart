// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'assigned_class_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AssignedClassesEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssignedClassesEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssignedClassesEvent()';
}


}

/// @nodoc
class $AssignedClassesEventCopyWith<$Res>  {
$AssignedClassesEventCopyWith(AssignedClassesEvent _, $Res Function(AssignedClassesEvent) __);
}


/// Adds pattern-matching-related methods to [AssignedClassesEvent].
extension AssignedClassesEventPatterns on AssignedClassesEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadAssignedClasses value)?  onLoadAssignedClasses,TResult Function( OnSearchAssignedClasses value)?  onSearchAssignedClasses,TResult Function( OnClearAssignedClassesSearch value)?  onClearSearch,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadAssignedClasses() when onLoadAssignedClasses != null:
return onLoadAssignedClasses(_that);case OnSearchAssignedClasses() when onSearchAssignedClasses != null:
return onSearchAssignedClasses(_that);case OnClearAssignedClassesSearch() when onClearSearch != null:
return onClearSearch(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadAssignedClasses value)  onLoadAssignedClasses,required TResult Function( OnSearchAssignedClasses value)  onSearchAssignedClasses,required TResult Function( OnClearAssignedClassesSearch value)  onClearSearch,}){
final _that = this;
switch (_that) {
case OnLoadAssignedClasses():
return onLoadAssignedClasses(_that);case OnSearchAssignedClasses():
return onSearchAssignedClasses(_that);case OnClearAssignedClassesSearch():
return onClearSearch(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadAssignedClasses value)?  onLoadAssignedClasses,TResult? Function( OnSearchAssignedClasses value)?  onSearchAssignedClasses,TResult? Function( OnClearAssignedClassesSearch value)?  onClearSearch,}){
final _that = this;
switch (_that) {
case OnLoadAssignedClasses() when onLoadAssignedClasses != null:
return onLoadAssignedClasses(_that);case OnSearchAssignedClasses() when onSearchAssignedClasses != null:
return onSearchAssignedClasses(_that);case OnClearAssignedClassesSearch() when onClearSearch != null:
return onClearSearch(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onLoadAssignedClasses,TResult Function( String query)?  onSearchAssignedClasses,TResult Function()?  onClearSearch,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadAssignedClasses() when onLoadAssignedClasses != null:
return onLoadAssignedClasses();case OnSearchAssignedClasses() when onSearchAssignedClasses != null:
return onSearchAssignedClasses(_that.query);case OnClearAssignedClassesSearch() when onClearSearch != null:
return onClearSearch();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onLoadAssignedClasses,required TResult Function( String query)  onSearchAssignedClasses,required TResult Function()  onClearSearch,}) {final _that = this;
switch (_that) {
case OnLoadAssignedClasses():
return onLoadAssignedClasses();case OnSearchAssignedClasses():
return onSearchAssignedClasses(_that.query);case OnClearAssignedClassesSearch():
return onClearSearch();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onLoadAssignedClasses,TResult? Function( String query)?  onSearchAssignedClasses,TResult? Function()?  onClearSearch,}) {final _that = this;
switch (_that) {
case OnLoadAssignedClasses() when onLoadAssignedClasses != null:
return onLoadAssignedClasses();case OnSearchAssignedClasses() when onSearchAssignedClasses != null:
return onSearchAssignedClasses(_that.query);case OnClearAssignedClassesSearch() when onClearSearch != null:
return onClearSearch();case _:
  return null;

}
}

}

/// @nodoc


class OnLoadAssignedClasses implements AssignedClassesEvent {
  const OnLoadAssignedClasses();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadAssignedClasses);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssignedClassesEvent.onLoadAssignedClasses()';
}


}




/// @nodoc


class OnSearchAssignedClasses implements AssignedClassesEvent {
  const OnSearchAssignedClasses({this.query = ''});
  

@JsonKey() final  String query;

/// Create a copy of AssignedClassesEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSearchAssignedClassesCopyWith<OnSearchAssignedClasses> get copyWith => _$OnSearchAssignedClassesCopyWithImpl<OnSearchAssignedClasses>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSearchAssignedClasses&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'AssignedClassesEvent.onSearchAssignedClasses(query: $query)';
}


}

/// @nodoc
abstract mixin class $OnSearchAssignedClassesCopyWith<$Res> implements $AssignedClassesEventCopyWith<$Res> {
  factory $OnSearchAssignedClassesCopyWith(OnSearchAssignedClasses value, $Res Function(OnSearchAssignedClasses) _then) = _$OnSearchAssignedClassesCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$OnSearchAssignedClassesCopyWithImpl<$Res>
    implements $OnSearchAssignedClassesCopyWith<$Res> {
  _$OnSearchAssignedClassesCopyWithImpl(this._self, this._then);

  final OnSearchAssignedClasses _self;
  final $Res Function(OnSearchAssignedClasses) _then;

/// Create a copy of AssignedClassesEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(OnSearchAssignedClasses(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OnClearAssignedClassesSearch implements AssignedClassesEvent {
  const OnClearAssignedClassesSearch();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnClearAssignedClassesSearch);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AssignedClassesEvent.onClearSearch()';
}


}




/// @nodoc
mixin _$AssignedClassesState {

 bool get isLoading; List<AssignedClassData> get arrAssignedClasses; TextEditingController get searchController; String get query; String? get errorMessage;
/// Create a copy of AssignedClassesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AssignedClassesStateCopyWith<AssignedClassesState> get copyWith => _$AssignedClassesStateCopyWithImpl<AssignedClassesState>(this as AssignedClassesState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AssignedClassesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.arrAssignedClasses, arrAssignedClasses)&&(identical(other.searchController, searchController) || other.searchController == searchController)&&(identical(other.query, query) || other.query == query)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(arrAssignedClasses),searchController,query,errorMessage);

@override
String toString() {
  return 'AssignedClassesState(isLoading: $isLoading, arrAssignedClasses: $arrAssignedClasses, searchController: $searchController, query: $query, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AssignedClassesStateCopyWith<$Res>  {
  factory $AssignedClassesStateCopyWith(AssignedClassesState value, $Res Function(AssignedClassesState) _then) = _$AssignedClassesStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<AssignedClassData> arrAssignedClasses, TextEditingController searchController, String query, String? errorMessage
});




}
/// @nodoc
class _$AssignedClassesStateCopyWithImpl<$Res>
    implements $AssignedClassesStateCopyWith<$Res> {
  _$AssignedClassesStateCopyWithImpl(this._self, this._then);

  final AssignedClassesState _self;
  final $Res Function(AssignedClassesState) _then;

/// Create a copy of AssignedClassesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? arrAssignedClasses = null,Object? searchController = null,Object? query = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,arrAssignedClasses: null == arrAssignedClasses ? _self.arrAssignedClasses : arrAssignedClasses // ignore: cast_nullable_to_non_nullable
as List<AssignedClassData>,searchController: null == searchController ? _self.searchController : searchController // ignore: cast_nullable_to_non_nullable
as TextEditingController,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AssignedClassesState].
extension AssignedClassesStatePatterns on AssignedClassesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AssignedClassesState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AssignedClassesState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AssignedClassesState value)  $default,){
final _that = this;
switch (_that) {
case _AssignedClassesState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AssignedClassesState value)?  $default,){
final _that = this;
switch (_that) {
case _AssignedClassesState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<AssignedClassData> arrAssignedClasses,  TextEditingController searchController,  String query,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AssignedClassesState() when $default != null:
return $default(_that.isLoading,_that.arrAssignedClasses,_that.searchController,_that.query,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<AssignedClassData> arrAssignedClasses,  TextEditingController searchController,  String query,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AssignedClassesState():
return $default(_that.isLoading,_that.arrAssignedClasses,_that.searchController,_that.query,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<AssignedClassData> arrAssignedClasses,  TextEditingController searchController,  String query,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AssignedClassesState() when $default != null:
return $default(_that.isLoading,_that.arrAssignedClasses,_that.searchController,_that.query,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AssignedClassesState implements AssignedClassesState {
  const _AssignedClassesState({required this.isLoading, required final  List<AssignedClassData> arrAssignedClasses, required this.searchController, this.query = '', this.errorMessage}): _arrAssignedClasses = arrAssignedClasses;
  

@override final  bool isLoading;
 final  List<AssignedClassData> _arrAssignedClasses;
@override List<AssignedClassData> get arrAssignedClasses {
  if (_arrAssignedClasses is EqualUnmodifiableListView) return _arrAssignedClasses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arrAssignedClasses);
}

@override final  TextEditingController searchController;
@override@JsonKey() final  String query;
@override final  String? errorMessage;

/// Create a copy of AssignedClassesState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AssignedClassesStateCopyWith<_AssignedClassesState> get copyWith => __$AssignedClassesStateCopyWithImpl<_AssignedClassesState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AssignedClassesState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._arrAssignedClasses, _arrAssignedClasses)&&(identical(other.searchController, searchController) || other.searchController == searchController)&&(identical(other.query, query) || other.query == query)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_arrAssignedClasses),searchController,query,errorMessage);

@override
String toString() {
  return 'AssignedClassesState(isLoading: $isLoading, arrAssignedClasses: $arrAssignedClasses, searchController: $searchController, query: $query, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AssignedClassesStateCopyWith<$Res> implements $AssignedClassesStateCopyWith<$Res> {
  factory _$AssignedClassesStateCopyWith(_AssignedClassesState value, $Res Function(_AssignedClassesState) _then) = __$AssignedClassesStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<AssignedClassData> arrAssignedClasses, TextEditingController searchController, String query, String? errorMessage
});




}
/// @nodoc
class __$AssignedClassesStateCopyWithImpl<$Res>
    implements _$AssignedClassesStateCopyWith<$Res> {
  __$AssignedClassesStateCopyWithImpl(this._self, this._then);

  final _AssignedClassesState _self;
  final $Res Function(_AssignedClassesState) _then;

/// Create a copy of AssignedClassesState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? arrAssignedClasses = null,Object? searchController = null,Object? query = null,Object? errorMessage = freezed,}) {
  return _then(_AssignedClassesState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,arrAssignedClasses: null == arrAssignedClasses ? _self._arrAssignedClasses : arrAssignedClasses // ignore: cast_nullable_to_non_nullable
as List<AssignedClassData>,searchController: null == searchController ? _self.searchController : searchController // ignore: cast_nullable_to_non_nullable
as TextEditingController,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
