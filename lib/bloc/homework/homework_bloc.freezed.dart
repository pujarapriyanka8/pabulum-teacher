// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'homework_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HomeworkEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeworkEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'HomeworkEvent()';
}


}

/// @nodoc
class $HomeworkEventCopyWith<$Res>  {
$HomeworkEventCopyWith(HomeworkEvent _, $Res Function(HomeworkEvent) __);
}


/// Adds pattern-matching-related methods to [HomeworkEvent].
extension HomeworkEventPatterns on HomeworkEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadHomeworkData value)?  onLoadHomeworkData,TResult Function( OnLoadHomeworkDetail value)?  onLoadHomeworkDetail,TResult Function( OnDeleteHomework value)?  onDeleteHomework,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadHomeworkData() when onLoadHomeworkData != null:
return onLoadHomeworkData(_that);case OnLoadHomeworkDetail() when onLoadHomeworkDetail != null:
return onLoadHomeworkDetail(_that);case OnDeleteHomework() when onDeleteHomework != null:
return onDeleteHomework(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadHomeworkData value)  onLoadHomeworkData,required TResult Function( OnLoadHomeworkDetail value)  onLoadHomeworkDetail,required TResult Function( OnDeleteHomework value)  onDeleteHomework,}){
final _that = this;
switch (_that) {
case OnLoadHomeworkData():
return onLoadHomeworkData(_that);case OnLoadHomeworkDetail():
return onLoadHomeworkDetail(_that);case OnDeleteHomework():
return onDeleteHomework(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadHomeworkData value)?  onLoadHomeworkData,TResult? Function( OnLoadHomeworkDetail value)?  onLoadHomeworkDetail,TResult? Function( OnDeleteHomework value)?  onDeleteHomework,}){
final _that = this;
switch (_that) {
case OnLoadHomeworkData() when onLoadHomeworkData != null:
return onLoadHomeworkData(_that);case OnLoadHomeworkDetail() when onLoadHomeworkDetail != null:
return onLoadHomeworkDetail(_that);case OnDeleteHomework() when onDeleteHomework != null:
return onDeleteHomework(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  String search)?  onLoadHomeworkData,TResult Function( String homeworkId)?  onLoadHomeworkDetail,TResult Function( String homeworkId)?  onDeleteHomework,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadHomeworkData() when onLoadHomeworkData != null:
return onLoadHomeworkData(_that.page,_that.search);case OnLoadHomeworkDetail() when onLoadHomeworkDetail != null:
return onLoadHomeworkDetail(_that.homeworkId);case OnDeleteHomework() when onDeleteHomework != null:
return onDeleteHomework(_that.homeworkId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  String search)  onLoadHomeworkData,required TResult Function( String homeworkId)  onLoadHomeworkDetail,required TResult Function( String homeworkId)  onDeleteHomework,}) {final _that = this;
switch (_that) {
case OnLoadHomeworkData():
return onLoadHomeworkData(_that.page,_that.search);case OnLoadHomeworkDetail():
return onLoadHomeworkDetail(_that.homeworkId);case OnDeleteHomework():
return onDeleteHomework(_that.homeworkId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  String search)?  onLoadHomeworkData,TResult? Function( String homeworkId)?  onLoadHomeworkDetail,TResult? Function( String homeworkId)?  onDeleteHomework,}) {final _that = this;
switch (_that) {
case OnLoadHomeworkData() when onLoadHomeworkData != null:
return onLoadHomeworkData(_that.page,_that.search);case OnLoadHomeworkDetail() when onLoadHomeworkDetail != null:
return onLoadHomeworkDetail(_that.homeworkId);case OnDeleteHomework() when onDeleteHomework != null:
return onDeleteHomework(_that.homeworkId);case _:
  return null;

}
}

}

/// @nodoc


class OnLoadHomeworkData implements HomeworkEvent {
  const OnLoadHomeworkData({this.page = 1, this.search = ''});
  

@JsonKey() final  int page;
@JsonKey() final  String search;

/// Create a copy of HomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadHomeworkDataCopyWith<OnLoadHomeworkData> get copyWith => _$OnLoadHomeworkDataCopyWithImpl<OnLoadHomeworkData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadHomeworkData&&(identical(other.page, page) || other.page == page)&&(identical(other.search, search) || other.search == search));
}


@override
int get hashCode => Object.hash(runtimeType,page,search);

@override
String toString() {
  return 'HomeworkEvent.onLoadHomeworkData(page: $page, search: $search)';
}


}

/// @nodoc
abstract mixin class $OnLoadHomeworkDataCopyWith<$Res> implements $HomeworkEventCopyWith<$Res> {
  factory $OnLoadHomeworkDataCopyWith(OnLoadHomeworkData value, $Res Function(OnLoadHomeworkData) _then) = _$OnLoadHomeworkDataCopyWithImpl;
@useResult
$Res call({
 int page, String search
});




}
/// @nodoc
class _$OnLoadHomeworkDataCopyWithImpl<$Res>
    implements $OnLoadHomeworkDataCopyWith<$Res> {
  _$OnLoadHomeworkDataCopyWithImpl(this._self, this._then);

  final OnLoadHomeworkData _self;
  final $Res Function(OnLoadHomeworkData) _then;

/// Create a copy of HomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? search = null,}) {
  return _then(OnLoadHomeworkData(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OnLoadHomeworkDetail implements HomeworkEvent {
  const OnLoadHomeworkDetail({required this.homeworkId});
  

 final  String homeworkId;

/// Create a copy of HomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadHomeworkDetailCopyWith<OnLoadHomeworkDetail> get copyWith => _$OnLoadHomeworkDetailCopyWithImpl<OnLoadHomeworkDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadHomeworkDetail&&(identical(other.homeworkId, homeworkId) || other.homeworkId == homeworkId));
}


@override
int get hashCode => Object.hash(runtimeType,homeworkId);

@override
String toString() {
  return 'HomeworkEvent.onLoadHomeworkDetail(homeworkId: $homeworkId)';
}


}

/// @nodoc
abstract mixin class $OnLoadHomeworkDetailCopyWith<$Res> implements $HomeworkEventCopyWith<$Res> {
  factory $OnLoadHomeworkDetailCopyWith(OnLoadHomeworkDetail value, $Res Function(OnLoadHomeworkDetail) _then) = _$OnLoadHomeworkDetailCopyWithImpl;
@useResult
$Res call({
 String homeworkId
});




}
/// @nodoc
class _$OnLoadHomeworkDetailCopyWithImpl<$Res>
    implements $OnLoadHomeworkDetailCopyWith<$Res> {
  _$OnLoadHomeworkDetailCopyWithImpl(this._self, this._then);

  final OnLoadHomeworkDetail _self;
  final $Res Function(OnLoadHomeworkDetail) _then;

/// Create a copy of HomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? homeworkId = null,}) {
  return _then(OnLoadHomeworkDetail(
homeworkId: null == homeworkId ? _self.homeworkId : homeworkId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OnDeleteHomework implements HomeworkEvent {
  const OnDeleteHomework({required this.homeworkId});
  

 final  String homeworkId;

/// Create a copy of HomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnDeleteHomeworkCopyWith<OnDeleteHomework> get copyWith => _$OnDeleteHomeworkCopyWithImpl<OnDeleteHomework>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnDeleteHomework&&(identical(other.homeworkId, homeworkId) || other.homeworkId == homeworkId));
}


@override
int get hashCode => Object.hash(runtimeType,homeworkId);

@override
String toString() {
  return 'HomeworkEvent.onDeleteHomework(homeworkId: $homeworkId)';
}


}

/// @nodoc
abstract mixin class $OnDeleteHomeworkCopyWith<$Res> implements $HomeworkEventCopyWith<$Res> {
  factory $OnDeleteHomeworkCopyWith(OnDeleteHomework value, $Res Function(OnDeleteHomework) _then) = _$OnDeleteHomeworkCopyWithImpl;
@useResult
$Res call({
 String homeworkId
});




}
/// @nodoc
class _$OnDeleteHomeworkCopyWithImpl<$Res>
    implements $OnDeleteHomeworkCopyWith<$Res> {
  _$OnDeleteHomeworkCopyWithImpl(this._self, this._then);

  final OnDeleteHomework _self;
  final $Res Function(OnDeleteHomework) _then;

/// Create a copy of HomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? homeworkId = null,}) {
  return _then(OnDeleteHomework(
homeworkId: null == homeworkId ? _self.homeworkId : homeworkId // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$HomeworkState {

 bool get isLoading; bool get isLoadingMore; List<HomeWorkData> get arrHomeWork; int get currentPage; int get lastPage; bool get hasMore; String get search; TextEditingController get searchController; HomeworkDetailData? get homeworkDetailData;
/// Create a copy of HomeworkState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HomeworkStateCopyWith<HomeworkState> get copyWith => _$HomeworkStateCopyWithImpl<HomeworkState>(this as HomeworkState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HomeworkState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other.arrHomeWork, arrHomeWork)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.search, search) || other.search == search)&&(identical(other.searchController, searchController) || other.searchController == searchController)&&(identical(other.homeworkDetailData, homeworkDetailData) || other.homeworkDetailData == homeworkDetailData));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(arrHomeWork),currentPage,lastPage,hasMore,search,searchController,homeworkDetailData);

@override
String toString() {
  return 'HomeworkState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, arrHomeWork: $arrHomeWork, currentPage: $currentPage, lastPage: $lastPage, hasMore: $hasMore, search: $search, searchController: $searchController, homeworkDetailData: $homeworkDetailData)';
}


}

/// @nodoc
abstract mixin class $HomeworkStateCopyWith<$Res>  {
  factory $HomeworkStateCopyWith(HomeworkState value, $Res Function(HomeworkState) _then) = _$HomeworkStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<HomeWorkData> arrHomeWork, int currentPage, int lastPage, bool hasMore, String search, TextEditingController searchController, HomeworkDetailData? homeworkDetailData
});




}
/// @nodoc
class _$HomeworkStateCopyWithImpl<$Res>
    implements $HomeworkStateCopyWith<$Res> {
  _$HomeworkStateCopyWithImpl(this._self, this._then);

  final HomeworkState _self;
  final $Res Function(HomeworkState) _then;

/// Create a copy of HomeworkState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? arrHomeWork = null,Object? currentPage = null,Object? lastPage = null,Object? hasMore = null,Object? search = null,Object? searchController = null,Object? homeworkDetailData = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,arrHomeWork: null == arrHomeWork ? _self.arrHomeWork : arrHomeWork // ignore: cast_nullable_to_non_nullable
as List<HomeWorkData>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,searchController: null == searchController ? _self.searchController : searchController // ignore: cast_nullable_to_non_nullable
as TextEditingController,homeworkDetailData: freezed == homeworkDetailData ? _self.homeworkDetailData : homeworkDetailData // ignore: cast_nullable_to_non_nullable
as HomeworkDetailData?,
  ));
}

}


/// Adds pattern-matching-related methods to [HomeworkState].
extension HomeworkStatePatterns on HomeworkState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HomeworkState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HomeworkState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HomeworkState value)  $default,){
final _that = this;
switch (_that) {
case _HomeworkState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HomeworkState value)?  $default,){
final _that = this;
switch (_that) {
case _HomeworkState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  List<HomeWorkData> arrHomeWork,  int currentPage,  int lastPage,  bool hasMore,  String search,  TextEditingController searchController,  HomeworkDetailData? homeworkDetailData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HomeworkState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.arrHomeWork,_that.currentPage,_that.lastPage,_that.hasMore,_that.search,_that.searchController,_that.homeworkDetailData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  List<HomeWorkData> arrHomeWork,  int currentPage,  int lastPage,  bool hasMore,  String search,  TextEditingController searchController,  HomeworkDetailData? homeworkDetailData)  $default,) {final _that = this;
switch (_that) {
case _HomeworkState():
return $default(_that.isLoading,_that.isLoadingMore,_that.arrHomeWork,_that.currentPage,_that.lastPage,_that.hasMore,_that.search,_that.searchController,_that.homeworkDetailData);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isLoadingMore,  List<HomeWorkData> arrHomeWork,  int currentPage,  int lastPage,  bool hasMore,  String search,  TextEditingController searchController,  HomeworkDetailData? homeworkDetailData)?  $default,) {final _that = this;
switch (_that) {
case _HomeworkState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.arrHomeWork,_that.currentPage,_that.lastPage,_that.hasMore,_that.search,_that.searchController,_that.homeworkDetailData);case _:
  return null;

}
}

}

/// @nodoc


class _HomeworkState implements HomeworkState {
  const _HomeworkState({required this.isLoading, required this.isLoadingMore, required final  List<HomeWorkData> arrHomeWork, required this.currentPage, required this.lastPage, required this.hasMore, required this.search, required this.searchController, required this.homeworkDetailData}): _arrHomeWork = arrHomeWork;
  

@override final  bool isLoading;
@override final  bool isLoadingMore;
 final  List<HomeWorkData> _arrHomeWork;
@override List<HomeWorkData> get arrHomeWork {
  if (_arrHomeWork is EqualUnmodifiableListView) return _arrHomeWork;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arrHomeWork);
}

@override final  int currentPage;
@override final  int lastPage;
@override final  bool hasMore;
@override final  String search;
@override final  TextEditingController searchController;
@override final  HomeworkDetailData? homeworkDetailData;

/// Create a copy of HomeworkState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HomeworkStateCopyWith<_HomeworkState> get copyWith => __$HomeworkStateCopyWithImpl<_HomeworkState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HomeworkState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&const DeepCollectionEquality().equals(other._arrHomeWork, _arrHomeWork)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.search, search) || other.search == search)&&(identical(other.searchController, searchController) || other.searchController == searchController)&&(identical(other.homeworkDetailData, homeworkDetailData) || other.homeworkDetailData == homeworkDetailData));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,const DeepCollectionEquality().hash(_arrHomeWork),currentPage,lastPage,hasMore,search,searchController,homeworkDetailData);

@override
String toString() {
  return 'HomeworkState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, arrHomeWork: $arrHomeWork, currentPage: $currentPage, lastPage: $lastPage, hasMore: $hasMore, search: $search, searchController: $searchController, homeworkDetailData: $homeworkDetailData)';
}


}

/// @nodoc
abstract mixin class _$HomeworkStateCopyWith<$Res> implements $HomeworkStateCopyWith<$Res> {
  factory _$HomeworkStateCopyWith(_HomeworkState value, $Res Function(_HomeworkState) _then) = __$HomeworkStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, List<HomeWorkData> arrHomeWork, int currentPage, int lastPage, bool hasMore, String search, TextEditingController searchController, HomeworkDetailData? homeworkDetailData
});




}
/// @nodoc
class __$HomeworkStateCopyWithImpl<$Res>
    implements _$HomeworkStateCopyWith<$Res> {
  __$HomeworkStateCopyWithImpl(this._self, this._then);

  final _HomeworkState _self;
  final $Res Function(_HomeworkState) _then;

/// Create a copy of HomeworkState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? arrHomeWork = null,Object? currentPage = null,Object? lastPage = null,Object? hasMore = null,Object? search = null,Object? searchController = null,Object? homeworkDetailData = freezed,}) {
  return _then(_HomeworkState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,arrHomeWork: null == arrHomeWork ? _self._arrHomeWork : arrHomeWork // ignore: cast_nullable_to_non_nullable
as List<HomeWorkData>,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,search: null == search ? _self.search : search // ignore: cast_nullable_to_non_nullable
as String,searchController: null == searchController ? _self.searchController : searchController // ignore: cast_nullable_to_non_nullable
as TextEditingController,homeworkDetailData: freezed == homeworkDetailData ? _self.homeworkDetailData : homeworkDetailData // ignore: cast_nullable_to_non_nullable
as HomeworkDetailData?,
  ));
}


}

// dart format on
