// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'classwork_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ClassworkEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassworkEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ClassworkEvent()';
}


}

/// @nodoc
class $ClassworkEventCopyWith<$Res>  {
$ClassworkEventCopyWith(ClassworkEvent _, $Res Function(ClassworkEvent) __);
}


/// Adds pattern-matching-related methods to [ClassworkEvent].
extension ClassworkEventPatterns on ClassworkEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadClasswork value)?  onLoadClasswork,TResult Function( OnLoadClassworkDetail value)?  onLoadClassworkDetail,TResult Function( OnDeleteClasswork value)?  onDeleteClasswork,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadClasswork() when onLoadClasswork != null:
return onLoadClasswork(_that);case OnLoadClassworkDetail() when onLoadClassworkDetail != null:
return onLoadClassworkDetail(_that);case OnDeleteClasswork() when onDeleteClasswork != null:
return onDeleteClasswork(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadClasswork value)  onLoadClasswork,required TResult Function( OnLoadClassworkDetail value)  onLoadClassworkDetail,required TResult Function( OnDeleteClasswork value)  onDeleteClasswork,}){
final _that = this;
switch (_that) {
case OnLoadClasswork():
return onLoadClasswork(_that);case OnLoadClassworkDetail():
return onLoadClassworkDetail(_that);case OnDeleteClasswork():
return onDeleteClasswork(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadClasswork value)?  onLoadClasswork,TResult? Function( OnLoadClassworkDetail value)?  onLoadClassworkDetail,TResult? Function( OnDeleteClasswork value)?  onDeleteClasswork,}){
final _that = this;
switch (_that) {
case OnLoadClasswork() when onLoadClasswork != null:
return onLoadClasswork(_that);case OnLoadClassworkDetail() when onLoadClassworkDetail != null:
return onLoadClassworkDetail(_that);case OnDeleteClasswork() when onDeleteClasswork != null:
return onDeleteClasswork(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  String query)?  onLoadClasswork,TResult Function( String classworkId)?  onLoadClassworkDetail,TResult Function( int classworkId)?  onDeleteClasswork,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadClasswork() when onLoadClasswork != null:
return onLoadClasswork(_that.page,_that.query);case OnLoadClassworkDetail() when onLoadClassworkDetail != null:
return onLoadClassworkDetail(_that.classworkId);case OnDeleteClasswork() when onDeleteClasswork != null:
return onDeleteClasswork(_that.classworkId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  String query)  onLoadClasswork,required TResult Function( String classworkId)  onLoadClassworkDetail,required TResult Function( int classworkId)  onDeleteClasswork,}) {final _that = this;
switch (_that) {
case OnLoadClasswork():
return onLoadClasswork(_that.page,_that.query);case OnLoadClassworkDetail():
return onLoadClassworkDetail(_that.classworkId);case OnDeleteClasswork():
return onDeleteClasswork(_that.classworkId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  String query)?  onLoadClasswork,TResult? Function( String classworkId)?  onLoadClassworkDetail,TResult? Function( int classworkId)?  onDeleteClasswork,}) {final _that = this;
switch (_that) {
case OnLoadClasswork() when onLoadClasswork != null:
return onLoadClasswork(_that.page,_that.query);case OnLoadClassworkDetail() when onLoadClassworkDetail != null:
return onLoadClassworkDetail(_that.classworkId);case OnDeleteClasswork() when onDeleteClasswork != null:
return onDeleteClasswork(_that.classworkId);case _:
  return null;

}
}

}

/// @nodoc


class OnLoadClasswork implements ClassworkEvent {
  const OnLoadClasswork({this.page = 1, this.query = ''});
  

@JsonKey() final  int page;
@JsonKey() final  String query;

/// Create a copy of ClassworkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadClassworkCopyWith<OnLoadClasswork> get copyWith => _$OnLoadClassworkCopyWithImpl<OnLoadClasswork>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadClasswork&&(identical(other.page, page) || other.page == page)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,page,query);

@override
String toString() {
  return 'ClassworkEvent.onLoadClasswork(page: $page, query: $query)';
}


}

/// @nodoc
abstract mixin class $OnLoadClassworkCopyWith<$Res> implements $ClassworkEventCopyWith<$Res> {
  factory $OnLoadClassworkCopyWith(OnLoadClasswork value, $Res Function(OnLoadClasswork) _then) = _$OnLoadClassworkCopyWithImpl;
@useResult
$Res call({
 int page, String query
});




}
/// @nodoc
class _$OnLoadClassworkCopyWithImpl<$Res>
    implements $OnLoadClassworkCopyWith<$Res> {
  _$OnLoadClassworkCopyWithImpl(this._self, this._then);

  final OnLoadClasswork _self;
  final $Res Function(OnLoadClasswork) _then;

/// Create a copy of ClassworkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? query = null,}) {
  return _then(OnLoadClasswork(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OnLoadClassworkDetail implements ClassworkEvent {
  const OnLoadClassworkDetail({required this.classworkId});
  

 final  String classworkId;

/// Create a copy of ClassworkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadClassworkDetailCopyWith<OnLoadClassworkDetail> get copyWith => _$OnLoadClassworkDetailCopyWithImpl<OnLoadClassworkDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadClassworkDetail&&(identical(other.classworkId, classworkId) || other.classworkId == classworkId));
}


@override
int get hashCode => Object.hash(runtimeType,classworkId);

@override
String toString() {
  return 'ClassworkEvent.onLoadClassworkDetail(classworkId: $classworkId)';
}


}

/// @nodoc
abstract mixin class $OnLoadClassworkDetailCopyWith<$Res> implements $ClassworkEventCopyWith<$Res> {
  factory $OnLoadClassworkDetailCopyWith(OnLoadClassworkDetail value, $Res Function(OnLoadClassworkDetail) _then) = _$OnLoadClassworkDetailCopyWithImpl;
@useResult
$Res call({
 String classworkId
});




}
/// @nodoc
class _$OnLoadClassworkDetailCopyWithImpl<$Res>
    implements $OnLoadClassworkDetailCopyWith<$Res> {
  _$OnLoadClassworkDetailCopyWithImpl(this._self, this._then);

  final OnLoadClassworkDetail _self;
  final $Res Function(OnLoadClassworkDetail) _then;

/// Create a copy of ClassworkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? classworkId = null,}) {
  return _then(OnLoadClassworkDetail(
classworkId: null == classworkId ? _self.classworkId : classworkId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OnDeleteClasswork implements ClassworkEvent {
  const OnDeleteClasswork({required this.classworkId});
  

 final  int classworkId;

/// Create a copy of ClassworkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnDeleteClassworkCopyWith<OnDeleteClasswork> get copyWith => _$OnDeleteClassworkCopyWithImpl<OnDeleteClasswork>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnDeleteClasswork&&(identical(other.classworkId, classworkId) || other.classworkId == classworkId));
}


@override
int get hashCode => Object.hash(runtimeType,classworkId);

@override
String toString() {
  return 'ClassworkEvent.onDeleteClasswork(classworkId: $classworkId)';
}


}

/// @nodoc
abstract mixin class $OnDeleteClassworkCopyWith<$Res> implements $ClassworkEventCopyWith<$Res> {
  factory $OnDeleteClassworkCopyWith(OnDeleteClasswork value, $Res Function(OnDeleteClasswork) _then) = _$OnDeleteClassworkCopyWithImpl;
@useResult
$Res call({
 int classworkId
});




}
/// @nodoc
class _$OnDeleteClassworkCopyWithImpl<$Res>
    implements $OnDeleteClassworkCopyWith<$Res> {
  _$OnDeleteClassworkCopyWithImpl(this._self, this._then);

  final OnDeleteClasswork _self;
  final $Res Function(OnDeleteClasswork) _then;

/// Create a copy of ClassworkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? classworkId = null,}) {
  return _then(OnDeleteClasswork(
classworkId: null == classworkId ? _self.classworkId : classworkId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc
mixin _$ClassworkState {

 bool get isLoading; bool get isLoadingMore; List<ClassworkData> get arrClasswork; TextEditingController get searchController; int get currentPage; bool get hasMore; String get query; ClassworkDetailData? get classworkDetailData;
/// Create a copy of ClassworkState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ClassworkStateCopyWith<ClassworkState> get copyWith => _$ClassworkStateCopyWithImpl<ClassworkState>(this as ClassworkState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ClassworkState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.arrClasswork, arrClasswork)&&(identical(other.searchController, searchController) || other.searchController == searchController)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.query, query) || other.query == query)&&(identical(other.classworkDetailData, classworkDetailData) || other.classworkDetailData == classworkDetailData));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(arrClasswork),searchController,currentPage,hasMore,query,classworkDetailData);

@override
String toString() {
  return 'ClassworkState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, arrClasswork: $arrClasswork, searchController: $searchController, currentPage: $currentPage, hasMore: $hasMore, query: $query, classworkDetailData: $classworkDetailData)';
}


}

/// @nodoc
abstract mixin class $ClassworkStateCopyWith<$Res>  {
  factory $ClassworkStateCopyWith(ClassworkState value, $Res Function(ClassworkState) _then) = _$ClassworkStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<ClassworkData> arrClasswork, TextEditingController searchController, int currentPage, bool hasMore, String query, ClassworkDetailData? classworkDetailData
});




}
/// @nodoc
class _$ClassworkStateCopyWithImpl<$Res>
    implements $ClassworkStateCopyWith<$Res> {
  _$ClassworkStateCopyWithImpl(this._self, this._then);

  final ClassworkState _self;
  final $Res Function(ClassworkState) _then;

/// Create a copy of ClassworkState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? arrClasswork = null,Object? searchController = null,Object? currentPage = null,Object? hasMore = null,Object? query = null,Object? classworkDetailData = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,arrClasswork: null == arrClasswork ? _self.arrClasswork : arrClasswork // ignore: cast_nullable_to_non_nullable
as List<ClassworkData>,searchController: null == searchController ? _self.searchController : searchController // ignore: cast_nullable_to_non_nullable
as TextEditingController,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,classworkDetailData: freezed == classworkDetailData ? _self.classworkDetailData : classworkDetailData // ignore: cast_nullable_to_non_nullable
as ClassworkDetailData?,
  ));
}

}


/// Adds pattern-matching-related methods to [ClassworkState].
extension ClassworkStatePatterns on ClassworkState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ClassworkState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ClassworkState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ClassworkState value)  $default,){
final _that = this;
switch (_that) {
case _ClassworkState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ClassworkState value)?  $default,){
final _that = this;
switch (_that) {
case _ClassworkState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  List<ClassworkData> arrClasswork,  TextEditingController searchController,  int currentPage,  bool hasMore,  String query,  ClassworkDetailData? classworkDetailData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ClassworkState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.arrClasswork,_that.searchController,_that.currentPage,_that.hasMore,_that.query,_that.classworkDetailData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  List<ClassworkData> arrClasswork,  TextEditingController searchController,  int currentPage,  bool hasMore,  String query,  ClassworkDetailData? classworkDetailData)  $default,) {final _that = this;
switch (_that) {
case _ClassworkState():
return $default(_that.isLoading,_that.isLoadingMore,_that.arrClasswork,_that.searchController,_that.currentPage,_that.hasMore,_that.query,_that.classworkDetailData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isLoadingMore,  List<ClassworkData> arrClasswork,  TextEditingController searchController,  int currentPage,  bool hasMore,  String query,  ClassworkDetailData? classworkDetailData)?  $default,) {final _that = this;
switch (_that) {
case _ClassworkState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.arrClasswork,_that.searchController,_that.currentPage,_that.hasMore,_that.query,_that.classworkDetailData);case _:
  return null;

}
}

}

/// @nodoc


class _ClassworkState implements ClassworkState {
  const _ClassworkState({required this.isLoading, required this.isLoadingMore, required final  List<ClassworkData> arrClasswork, required this.searchController, required this.currentPage, required this.hasMore, this.query = '', required this.classworkDetailData}): _arrClasswork = arrClasswork;
  

@override final  bool isLoading;
@override final  bool isLoadingMore;
 final  List<ClassworkData> _arrClasswork;
@override List<ClassworkData> get arrClasswork {
  if (_arrClasswork is EqualUnmodifiableListView) return _arrClasswork;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arrClasswork);
}

@override final  TextEditingController searchController;
@override final  int currentPage;
@override final  bool hasMore;
@override@JsonKey() final  String query;
@override final  ClassworkDetailData? classworkDetailData;

/// Create a copy of ClassworkState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ClassworkStateCopyWith<_ClassworkState> get copyWith => __$ClassworkStateCopyWithImpl<_ClassworkState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ClassworkState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._arrClasswork, _arrClasswork)&&(identical(other.searchController, searchController) || other.searchController == searchController)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.query, query) || other.query == query)&&(identical(other.classworkDetailData, classworkDetailData) || other.classworkDetailData == classworkDetailData));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(_arrClasswork),searchController,currentPage,hasMore,query,classworkDetailData);

@override
String toString() {
  return 'ClassworkState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, arrClasswork: $arrClasswork, searchController: $searchController, currentPage: $currentPage, hasMore: $hasMore, query: $query, classworkDetailData: $classworkDetailData)';
}


}

/// @nodoc
abstract mixin class _$ClassworkStateCopyWith<$Res> implements $ClassworkStateCopyWith<$Res> {
  factory _$ClassworkStateCopyWith(_ClassworkState value, $Res Function(_ClassworkState) _then) = __$ClassworkStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<ClassworkData> arrClasswork, TextEditingController searchController, int currentPage, bool hasMore, String query, ClassworkDetailData? classworkDetailData
});




}
/// @nodoc
class __$ClassworkStateCopyWithImpl<$Res>
    implements _$ClassworkStateCopyWith<$Res> {
  __$ClassworkStateCopyWithImpl(this._self, this._then);

  final _ClassworkState _self;
  final $Res Function(_ClassworkState) _then;

/// Create a copy of ClassworkState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? arrClasswork = null,Object? searchController = null,Object? currentPage = null,Object? hasMore = null,Object? query = null,Object? classworkDetailData = freezed,}) {
  return _then(_ClassworkState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,arrClasswork: null == arrClasswork ? _self._arrClasswork : arrClasswork // ignore: cast_nullable_to_non_nullable
as List<ClassworkData>,searchController: null == searchController ? _self.searchController : searchController // ignore: cast_nullable_to_non_nullable
as TextEditingController,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,classworkDetailData: freezed == classworkDetailData ? _self.classworkDetailData : classworkDetailData // ignore: cast_nullable_to_non_nullable
as ClassworkDetailData?,
  ));
}


}

// dart format on
