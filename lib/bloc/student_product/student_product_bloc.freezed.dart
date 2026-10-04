// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'student_product_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$StudentProductsEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentProductsEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'StudentProductsEvent()';
}


}

/// @nodoc
class $StudentProductsEventCopyWith<$Res>  {
$StudentProductsEventCopyWith(StudentProductsEvent _, $Res Function(StudentProductsEvent) __);
}


/// Adds pattern-matching-related methods to [StudentProductsEvent].
extension StudentProductsEventPatterns on StudentProductsEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadStudentProducts value)?  onLoadStudentProducts,TResult Function( OnUpdateProductStatus value)?  onUpdateProductStatus,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadStudentProducts() when onLoadStudentProducts != null:
return onLoadStudentProducts(_that);case OnUpdateProductStatus() when onUpdateProductStatus != null:
return onUpdateProductStatus(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadStudentProducts value)  onLoadStudentProducts,required TResult Function( OnUpdateProductStatus value)  onUpdateProductStatus,}){
final _that = this;
switch (_that) {
case OnLoadStudentProducts():
return onLoadStudentProducts(_that);case OnUpdateProductStatus():
return onUpdateProductStatus(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadStudentProducts value)?  onLoadStudentProducts,TResult? Function( OnUpdateProductStatus value)?  onUpdateProductStatus,}){
final _that = this;
switch (_that) {
case OnLoadStudentProducts() when onLoadStudentProducts != null:
return onLoadStudentProducts(_that);case OnUpdateProductStatus() when onUpdateProductStatus != null:
return onUpdateProductStatus(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page)?  onLoadStudentProducts,TResult Function( num requestId,  String status)?  onUpdateProductStatus,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadStudentProducts() when onLoadStudentProducts != null:
return onLoadStudentProducts(_that.page);case OnUpdateProductStatus() when onUpdateProductStatus != null:
return onUpdateProductStatus(_that.requestId,_that.status);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page)  onLoadStudentProducts,required TResult Function( num requestId,  String status)  onUpdateProductStatus,}) {final _that = this;
switch (_that) {
case OnLoadStudentProducts():
return onLoadStudentProducts(_that.page);case OnUpdateProductStatus():
return onUpdateProductStatus(_that.requestId,_that.status);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page)?  onLoadStudentProducts,TResult? Function( num requestId,  String status)?  onUpdateProductStatus,}) {final _that = this;
switch (_that) {
case OnLoadStudentProducts() when onLoadStudentProducts != null:
return onLoadStudentProducts(_that.page);case OnUpdateProductStatus() when onUpdateProductStatus != null:
return onUpdateProductStatus(_that.requestId,_that.status);case _:
  return null;

}
}

}

/// @nodoc


class OnLoadStudentProducts implements StudentProductsEvent {
  const OnLoadStudentProducts({this.page = 1});
  

@JsonKey() final  int page;

/// Create a copy of StudentProductsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadStudentProductsCopyWith<OnLoadStudentProducts> get copyWith => _$OnLoadStudentProductsCopyWithImpl<OnLoadStudentProducts>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadStudentProducts&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,page);

@override
String toString() {
  return 'StudentProductsEvent.onLoadStudentProducts(page: $page)';
}


}

/// @nodoc
abstract mixin class $OnLoadStudentProductsCopyWith<$Res> implements $StudentProductsEventCopyWith<$Res> {
  factory $OnLoadStudentProductsCopyWith(OnLoadStudentProducts value, $Res Function(OnLoadStudentProducts) _then) = _$OnLoadStudentProductsCopyWithImpl;
@useResult
$Res call({
 int page
});




}
/// @nodoc
class _$OnLoadStudentProductsCopyWithImpl<$Res>
    implements $OnLoadStudentProductsCopyWith<$Res> {
  _$OnLoadStudentProductsCopyWithImpl(this._self, this._then);

  final OnLoadStudentProducts _self;
  final $Res Function(OnLoadStudentProducts) _then;

/// Create a copy of StudentProductsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,}) {
  return _then(OnLoadStudentProducts(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnUpdateProductStatus implements StudentProductsEvent {
  const OnUpdateProductStatus({required this.requestId, required this.status});
  

 final  num requestId;
 final  String status;

/// Create a copy of StudentProductsEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnUpdateProductStatusCopyWith<OnUpdateProductStatus> get copyWith => _$OnUpdateProductStatusCopyWithImpl<OnUpdateProductStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnUpdateProductStatus&&(identical(other.requestId, requestId) || other.requestId == requestId)&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,requestId,status);

@override
String toString() {
  return 'StudentProductsEvent.onUpdateProductStatus(requestId: $requestId, status: $status)';
}


}

/// @nodoc
abstract mixin class $OnUpdateProductStatusCopyWith<$Res> implements $StudentProductsEventCopyWith<$Res> {
  factory $OnUpdateProductStatusCopyWith(OnUpdateProductStatus value, $Res Function(OnUpdateProductStatus) _then) = _$OnUpdateProductStatusCopyWithImpl;
@useResult
$Res call({
 num requestId, String status
});




}
/// @nodoc
class _$OnUpdateProductStatusCopyWithImpl<$Res>
    implements $OnUpdateProductStatusCopyWith<$Res> {
  _$OnUpdateProductStatusCopyWithImpl(this._self, this._then);

  final OnUpdateProductStatus _self;
  final $Res Function(OnUpdateProductStatus) _then;

/// Create a copy of StudentProductsEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? requestId = null,Object? status = null,}) {
  return _then(OnUpdateProductStatus(
requestId: null == requestId ? _self.requestId : requestId // ignore: cast_nullable_to_non_nullable
as num,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$StudentProductsState {

 bool get isLoading; bool get isLoadingMore; List<StudentProductData> get arrStudentProducts; int get currentPage; bool get hasMore;
/// Create a copy of StudentProductsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$StudentProductsStateCopyWith<StudentProductsState> get copyWith => _$StudentProductsStateCopyWithImpl<StudentProductsState>(this as StudentProductsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is StudentProductsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.arrStudentProducts, arrStudentProducts)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(arrStudentProducts),currentPage,hasMore);

@override
String toString() {
  return 'StudentProductsState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, arrStudentProducts: $arrStudentProducts, currentPage: $currentPage, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class $StudentProductsStateCopyWith<$Res>  {
  factory $StudentProductsStateCopyWith(StudentProductsState value, $Res Function(StudentProductsState) _then) = _$StudentProductsStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<StudentProductData> arrStudentProducts, int currentPage, bool hasMore
});




}
/// @nodoc
class _$StudentProductsStateCopyWithImpl<$Res>
    implements $StudentProductsStateCopyWith<$Res> {
  _$StudentProductsStateCopyWithImpl(this._self, this._then);

  final StudentProductsState _self;
  final $Res Function(StudentProductsState) _then;

/// Create a copy of StudentProductsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? arrStudentProducts = null,Object? currentPage = null,Object? hasMore = null,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,arrStudentProducts: null == arrStudentProducts ? _self.arrStudentProducts : arrStudentProducts // ignore: cast_nullable_to_non_nullable
as List<StudentProductData>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [StudentProductsState].
extension StudentProductsStatePatterns on StudentProductsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _StudentProductsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _StudentProductsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _StudentProductsState value)  $default,){
final _that = this;
switch (_that) {
case _StudentProductsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _StudentProductsState value)?  $default,){
final _that = this;
switch (_that) {
case _StudentProductsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  List<StudentProductData> arrStudentProducts,  int currentPage,  bool hasMore)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _StudentProductsState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.arrStudentProducts,_that.currentPage,_that.hasMore);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  List<StudentProductData> arrStudentProducts,  int currentPage,  bool hasMore)  $default,) {final _that = this;
switch (_that) {
case _StudentProductsState():
return $default(_that.isLoading,_that.isLoadingMore,_that.arrStudentProducts,_that.currentPage,_that.hasMore);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isLoadingMore,  List<StudentProductData> arrStudentProducts,  int currentPage,  bool hasMore)?  $default,) {final _that = this;
switch (_that) {
case _StudentProductsState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.arrStudentProducts,_that.currentPage,_that.hasMore);case _:
  return null;

}
}

}

/// @nodoc


class _StudentProductsState implements StudentProductsState {
  const _StudentProductsState({required this.isLoading, required this.isLoadingMore, required final  List<StudentProductData> arrStudentProducts, required this.currentPage, required this.hasMore}): _arrStudentProducts = arrStudentProducts;
  

@override final  bool isLoading;
@override final  bool isLoadingMore;
 final  List<StudentProductData> _arrStudentProducts;
@override List<StudentProductData> get arrStudentProducts {
  if (_arrStudentProducts is EqualUnmodifiableListView) return _arrStudentProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arrStudentProducts);
}

@override final  int currentPage;
@override final  bool hasMore;

/// Create a copy of StudentProductsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$StudentProductsStateCopyWith<_StudentProductsState> get copyWith => __$StudentProductsStateCopyWithImpl<_StudentProductsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _StudentProductsState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._arrStudentProducts, _arrStudentProducts)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(_arrStudentProducts),currentPage,hasMore);

@override
String toString() {
  return 'StudentProductsState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, arrStudentProducts: $arrStudentProducts, currentPage: $currentPage, hasMore: $hasMore)';
}


}

/// @nodoc
abstract mixin class _$StudentProductsStateCopyWith<$Res> implements $StudentProductsStateCopyWith<$Res> {
  factory _$StudentProductsStateCopyWith(_StudentProductsState value, $Res Function(_StudentProductsState) _then) = __$StudentProductsStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<StudentProductData> arrStudentProducts, int currentPage, bool hasMore
});




}
/// @nodoc
class __$StudentProductsStateCopyWithImpl<$Res>
    implements _$StudentProductsStateCopyWith<$Res> {
  __$StudentProductsStateCopyWithImpl(this._self, this._then);

  final _StudentProductsState _self;
  final $Res Function(_StudentProductsState) _then;

/// Create a copy of StudentProductsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? arrStudentProducts = null,Object? currentPage = null,Object? hasMore = null,}) {
  return _then(_StudentProductsState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,arrStudentProducts: null == arrStudentProducts ? _self._arrStudentProducts : arrStudentProducts // ignore: cast_nullable_to_non_nullable
as List<StudentProductData>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
