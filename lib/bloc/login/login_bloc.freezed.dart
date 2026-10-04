// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'login_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$LoginEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent()';
}


}

/// @nodoc
class $LoginEventCopyWith<$Res>  {
$LoginEventCopyWith(LoginEvent _, $Res Function(LoginEvent) __);
}


/// Adds pattern-matching-related methods to [LoginEvent].
extension LoginEventPatterns on LoginEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoginClickEvent value)?  onLoginClickEvent,TResult Function( OnLoadProfileEvent value)?  onLoadProfileEvent,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoginClickEvent() when onLoginClickEvent != null:
return onLoginClickEvent(_that);case OnLoadProfileEvent() when onLoadProfileEvent != null:
return onLoadProfileEvent(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoginClickEvent value)  onLoginClickEvent,required TResult Function( OnLoadProfileEvent value)  onLoadProfileEvent,}){
final _that = this;
switch (_that) {
case OnLoginClickEvent():
return onLoginClickEvent(_that);case OnLoadProfileEvent():
return onLoadProfileEvent(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoginClickEvent value)?  onLoginClickEvent,TResult? Function( OnLoadProfileEvent value)?  onLoadProfileEvent,}){
final _that = this;
switch (_that) {
case OnLoginClickEvent() when onLoginClickEvent != null:
return onLoginClickEvent(_that);case OnLoadProfileEvent() when onLoadProfileEvent != null:
return onLoadProfileEvent(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onLoginClickEvent,TResult Function()?  onLoadProfileEvent,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoginClickEvent() when onLoginClickEvent != null:
return onLoginClickEvent();case OnLoadProfileEvent() when onLoadProfileEvent != null:
return onLoadProfileEvent();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onLoginClickEvent,required TResult Function()  onLoadProfileEvent,}) {final _that = this;
switch (_that) {
case OnLoginClickEvent():
return onLoginClickEvent();case OnLoadProfileEvent():
return onLoadProfileEvent();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onLoginClickEvent,TResult? Function()?  onLoadProfileEvent,}) {final _that = this;
switch (_that) {
case OnLoginClickEvent() when onLoginClickEvent != null:
return onLoginClickEvent();case OnLoadProfileEvent() when onLoadProfileEvent != null:
return onLoadProfileEvent();case _:
  return null;

}
}

}

/// @nodoc


class OnLoginClickEvent implements LoginEvent {
  const OnLoginClickEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoginClickEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.onLoginClickEvent()';
}


}




/// @nodoc


class OnLoadProfileEvent implements LoginEvent {
  const OnLoadProfileEvent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadProfileEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'LoginEvent.onLoadProfileEvent()';
}


}




/// @nodoc
mixin _$LoginState {

 bool get isLoading; TextEditingController get userName; TextEditingController get password; LoginResponse? get loginResponse; ProfileData? get profileData;
/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LoginStateCopyWith<LoginState> get copyWith => _$LoginStateCopyWithImpl<LoginState>(this as LoginState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LoginState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.password, password) || other.password == password)&&(identical(other.loginResponse, loginResponse) || other.loginResponse == loginResponse)&&(identical(other.profileData, profileData) || other.profileData == profileData));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,userName,password,loginResponse,profileData);

@override
String toString() {
  return 'LoginState(isLoading: $isLoading, userName: $userName, password: $password, loginResponse: $loginResponse, profileData: $profileData)';
}


}

/// @nodoc
abstract mixin class $LoginStateCopyWith<$Res>  {
  factory $LoginStateCopyWith(LoginState value, $Res Function(LoginState) _then) = _$LoginStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, TextEditingController userName, TextEditingController password, LoginResponse? loginResponse, ProfileData? profileData
});




}
/// @nodoc
class _$LoginStateCopyWithImpl<$Res>
    implements $LoginStateCopyWith<$Res> {
  _$LoginStateCopyWithImpl(this._self, this._then);

  final LoginState _self;
  final $Res Function(LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? userName = null,Object? password = null,Object? loginResponse = freezed,Object? profileData = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as TextEditingController,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as TextEditingController,loginResponse: freezed == loginResponse ? _self.loginResponse : loginResponse // ignore: cast_nullable_to_non_nullable
as LoginResponse?,profileData: freezed == profileData ? _self.profileData : profileData // ignore: cast_nullable_to_non_nullable
as ProfileData?,
  ));
}

}


/// Adds pattern-matching-related methods to [LoginState].
extension LoginStatePatterns on LoginState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LoginState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LoginState value)  $default,){
final _that = this;
switch (_that) {
case _LoginState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LoginState value)?  $default,){
final _that = this;
switch (_that) {
case _LoginState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  TextEditingController userName,  TextEditingController password,  LoginResponse? loginResponse,  ProfileData? profileData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.isLoading,_that.userName,_that.password,_that.loginResponse,_that.profileData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  TextEditingController userName,  TextEditingController password,  LoginResponse? loginResponse,  ProfileData? profileData)  $default,) {final _that = this;
switch (_that) {
case _LoginState():
return $default(_that.isLoading,_that.userName,_that.password,_that.loginResponse,_that.profileData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  TextEditingController userName,  TextEditingController password,  LoginResponse? loginResponse,  ProfileData? profileData)?  $default,) {final _that = this;
switch (_that) {
case _LoginState() when $default != null:
return $default(_that.isLoading,_that.userName,_that.password,_that.loginResponse,_that.profileData);case _:
  return null;

}
}

}

/// @nodoc


class _LoginState implements LoginState {
  const _LoginState({required this.isLoading, required this.userName, required this.password, required this.loginResponse, required this.profileData});
  

@override final  bool isLoading;
@override final  TextEditingController userName;
@override final  TextEditingController password;
@override final  LoginResponse? loginResponse;
@override final  ProfileData? profileData;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LoginStateCopyWith<_LoginState> get copyWith => __$LoginStateCopyWithImpl<_LoginState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LoginState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.password, password) || other.password == password)&&(identical(other.loginResponse, loginResponse) || other.loginResponse == loginResponse)&&(identical(other.profileData, profileData) || other.profileData == profileData));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,userName,password,loginResponse,profileData);

@override
String toString() {
  return 'LoginState(isLoading: $isLoading, userName: $userName, password: $password, loginResponse: $loginResponse, profileData: $profileData)';
}


}

/// @nodoc
abstract mixin class _$LoginStateCopyWith<$Res> implements $LoginStateCopyWith<$Res> {
  factory _$LoginStateCopyWith(_LoginState value, $Res Function(_LoginState) _then) = __$LoginStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, TextEditingController userName, TextEditingController password, LoginResponse? loginResponse, ProfileData? profileData
});




}
/// @nodoc
class __$LoginStateCopyWithImpl<$Res>
    implements _$LoginStateCopyWith<$Res> {
  __$LoginStateCopyWithImpl(this._self, this._then);

  final _LoginState _self;
  final $Res Function(_LoginState) _then;

/// Create a copy of LoginState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? userName = null,Object? password = null,Object? loginResponse = freezed,Object? profileData = freezed,}) {
  return _then(_LoginState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as TextEditingController,password: null == password ? _self.password : password // ignore: cast_nullable_to_non_nullable
as TextEditingController,loginResponse: freezed == loginResponse ? _self.loginResponse : loginResponse // ignore: cast_nullable_to_non_nullable
as LoginResponse?,profileData: freezed == profileData ? _self.profileData : profileData // ignore: cast_nullable_to_non_nullable
as ProfileData?,
  ));
}


}

// dart format on
