// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'dashboard_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DashboardEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent()';
}


}

/// @nodoc
class $DashboardEventCopyWith<$Res>  {
$DashboardEventCopyWith(DashboardEvent _, $Res Function(DashboardEvent) __);
}


/// Adds pattern-matching-related methods to [DashboardEvent].
extension DashboardEventPatterns on DashboardEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadDashboardData value)?  onLoadDashboardData,TResult Function( OnExpandClick value)?  onExpandClick,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadDashboardData() when onLoadDashboardData != null:
return onLoadDashboardData(_that);case OnExpandClick() when onExpandClick != null:
return onExpandClick(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadDashboardData value)  onLoadDashboardData,required TResult Function( OnExpandClick value)  onExpandClick,}){
final _that = this;
switch (_that) {
case OnLoadDashboardData():
return onLoadDashboardData(_that);case OnExpandClick():
return onExpandClick(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadDashboardData value)?  onLoadDashboardData,TResult? Function( OnExpandClick value)?  onExpandClick,}){
final _that = this;
switch (_that) {
case OnLoadDashboardData() when onLoadDashboardData != null:
return onLoadDashboardData(_that);case OnExpandClick() when onExpandClick != null:
return onExpandClick(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onLoadDashboardData,TResult Function()?  onExpandClick,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadDashboardData() when onLoadDashboardData != null:
return onLoadDashboardData();case OnExpandClick() when onExpandClick != null:
return onExpandClick();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onLoadDashboardData,required TResult Function()  onExpandClick,}) {final _that = this;
switch (_that) {
case OnLoadDashboardData():
return onLoadDashboardData();case OnExpandClick():
return onExpandClick();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onLoadDashboardData,TResult? Function()?  onExpandClick,}) {final _that = this;
switch (_that) {
case OnLoadDashboardData() when onLoadDashboardData != null:
return onLoadDashboardData();case OnExpandClick() when onExpandClick != null:
return onExpandClick();case _:
  return null;

}
}

}

/// @nodoc


class OnLoadDashboardData implements DashboardEvent {
  const OnLoadDashboardData();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadDashboardData);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.onLoadDashboardData()';
}


}




/// @nodoc


class OnExpandClick implements DashboardEvent {
  const OnExpandClick();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnExpandClick);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'DashboardEvent.onExpandClick()';
}


}




/// @nodoc
mixin _$DashboardState {

 bool get isLoading; DashboardData? get dashboardData; bool get isExpanded;
/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardStateCopyWith<DashboardState> get copyWith => _$DashboardStateCopyWithImpl<DashboardState>(this as DashboardState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.dashboardData, dashboardData) || other.dashboardData == dashboardData)&&(identical(other.isExpanded, isExpanded) || other.isExpanded == isExpanded));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,dashboardData,isExpanded);

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, dashboardData: $dashboardData, isExpanded: $isExpanded)';
}


}

/// @nodoc
abstract mixin class $DashboardStateCopyWith<$Res>  {
  factory $DashboardStateCopyWith(DashboardState value, $Res Function(DashboardState) _then) = _$DashboardStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, DashboardData? dashboardData, bool isExpanded
});




}
/// @nodoc
class _$DashboardStateCopyWithImpl<$Res>
    implements $DashboardStateCopyWith<$Res> {
  _$DashboardStateCopyWithImpl(this._self, this._then);

  final DashboardState _self;
  final $Res Function(DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? dashboardData = freezed,Object? isExpanded = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,dashboardData: freezed == dashboardData ? _self.dashboardData : dashboardData // ignore: cast_nullable_to_non_nullable
as DashboardData?,isExpanded: null == isExpanded ? _self.isExpanded : isExpanded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [DashboardState].
extension DashboardStatePatterns on DashboardState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DashboardState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DashboardState value)  $default,){
final _that = this;
switch (_that) {
case _DashboardState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DashboardState value)?  $default,){
final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  DashboardData? dashboardData,  bool isExpanded)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.isLoading,_that.dashboardData,_that.isExpanded);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  DashboardData? dashboardData,  bool isExpanded)  $default,) {final _that = this;
switch (_that) {
case _DashboardState():
return $default(_that.isLoading,_that.dashboardData,_that.isExpanded);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  DashboardData? dashboardData,  bool isExpanded)?  $default,) {final _that = this;
switch (_that) {
case _DashboardState() when $default != null:
return $default(_that.isLoading,_that.dashboardData,_that.isExpanded);case _:
  return null;

}
}

}

/// @nodoc


class _DashboardState implements DashboardState {
  const _DashboardState({required this.isLoading, required this.dashboardData, required this.isExpanded});
  

@override final  bool isLoading;
@override final  DashboardData? dashboardData;
@override final  bool isExpanded;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardStateCopyWith<_DashboardState> get copyWith => __$DashboardStateCopyWithImpl<_DashboardState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.dashboardData, dashboardData) || other.dashboardData == dashboardData)&&(identical(other.isExpanded, isExpanded) || other.isExpanded == isExpanded));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,dashboardData,isExpanded);

@override
String toString() {
  return 'DashboardState(isLoading: $isLoading, dashboardData: $dashboardData, isExpanded: $isExpanded)';
}


}

/// @nodoc
abstract mixin class _$DashboardStateCopyWith<$Res> implements $DashboardStateCopyWith<$Res> {
  factory _$DashboardStateCopyWith(_DashboardState value, $Res Function(_DashboardState) _then) = __$DashboardStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, DashboardData? dashboardData, bool isExpanded
});




}
/// @nodoc
class __$DashboardStateCopyWithImpl<$Res>
    implements _$DashboardStateCopyWith<$Res> {
  __$DashboardStateCopyWithImpl(this._self, this._then);

  final _DashboardState _self;
  final $Res Function(_DashboardState) _then;

/// Create a copy of DashboardState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? dashboardData = freezed,Object? isExpanded = null,}) {
  return _then(_DashboardState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,dashboardData: freezed == dashboardData ? _self.dashboardData : dashboardData // ignore: cast_nullable_to_non_nullable
as DashboardData?,isExpanded: null == isExpanded ? _self.isExpanded : isExpanded // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
