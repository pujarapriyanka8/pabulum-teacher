// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'submitted_work_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SubmittedHomeworkEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmittedHomeworkEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubmittedHomeworkEvent()';
}


}

/// @nodoc
class $SubmittedHomeworkEventCopyWith<$Res>  {
$SubmittedHomeworkEventCopyWith(SubmittedHomeworkEvent _, $Res Function(SubmittedHomeworkEvent) __);
}


/// Adds pattern-matching-related methods to [SubmittedHomeworkEvent].
extension SubmittedHomeworkEventPatterns on SubmittedHomeworkEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadSubmittedHomework value)?  onLoadSubmittedHomework,TResult Function( OnLoadSubmittedHomeworkDetail value)?  onLoadSubmittedHomeworkDetail,TResult Function( OnSelectReviewStatus value)?  onSelectReviewStatus,TResult Function( OnSubmitReview value)?  onSubmitReview,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadSubmittedHomework() when onLoadSubmittedHomework != null:
return onLoadSubmittedHomework(_that);case OnLoadSubmittedHomeworkDetail() when onLoadSubmittedHomeworkDetail != null:
return onLoadSubmittedHomeworkDetail(_that);case OnSelectReviewStatus() when onSelectReviewStatus != null:
return onSelectReviewStatus(_that);case OnSubmitReview() when onSubmitReview != null:
return onSubmitReview(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadSubmittedHomework value)  onLoadSubmittedHomework,required TResult Function( OnLoadSubmittedHomeworkDetail value)  onLoadSubmittedHomeworkDetail,required TResult Function( OnSelectReviewStatus value)  onSelectReviewStatus,required TResult Function( OnSubmitReview value)  onSubmitReview,}){
final _that = this;
switch (_that) {
case OnLoadSubmittedHomework():
return onLoadSubmittedHomework(_that);case OnLoadSubmittedHomeworkDetail():
return onLoadSubmittedHomeworkDetail(_that);case OnSelectReviewStatus():
return onSelectReviewStatus(_that);case OnSubmitReview():
return onSubmitReview(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadSubmittedHomework value)?  onLoadSubmittedHomework,TResult? Function( OnLoadSubmittedHomeworkDetail value)?  onLoadSubmittedHomeworkDetail,TResult? Function( OnSelectReviewStatus value)?  onSelectReviewStatus,TResult? Function( OnSubmitReview value)?  onSubmitReview,}){
final _that = this;
switch (_that) {
case OnLoadSubmittedHomework() when onLoadSubmittedHomework != null:
return onLoadSubmittedHomework(_that);case OnLoadSubmittedHomeworkDetail() when onLoadSubmittedHomeworkDetail != null:
return onLoadSubmittedHomeworkDetail(_that);case OnSelectReviewStatus() when onSelectReviewStatus != null:
return onSelectReviewStatus(_that);case OnSubmitReview() when onSubmitReview != null:
return onSubmitReview(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( int page,  String query)?  onLoadSubmittedHomework,TResult Function( int submittedHomeworkId)?  onLoadSubmittedHomeworkDetail,TResult Function( String status)?  onSelectReviewStatus,TResult Function()?  onSubmitReview,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadSubmittedHomework() when onLoadSubmittedHomework != null:
return onLoadSubmittedHomework(_that.page,_that.query);case OnLoadSubmittedHomeworkDetail() when onLoadSubmittedHomeworkDetail != null:
return onLoadSubmittedHomeworkDetail(_that.submittedHomeworkId);case OnSelectReviewStatus() when onSelectReviewStatus != null:
return onSelectReviewStatus(_that.status);case OnSubmitReview() when onSubmitReview != null:
return onSubmitReview();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( int page,  String query)  onLoadSubmittedHomework,required TResult Function( int submittedHomeworkId)  onLoadSubmittedHomeworkDetail,required TResult Function( String status)  onSelectReviewStatus,required TResult Function()  onSubmitReview,}) {final _that = this;
switch (_that) {
case OnLoadSubmittedHomework():
return onLoadSubmittedHomework(_that.page,_that.query);case OnLoadSubmittedHomeworkDetail():
return onLoadSubmittedHomeworkDetail(_that.submittedHomeworkId);case OnSelectReviewStatus():
return onSelectReviewStatus(_that.status);case OnSubmitReview():
return onSubmitReview();case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( int page,  String query)?  onLoadSubmittedHomework,TResult? Function( int submittedHomeworkId)?  onLoadSubmittedHomeworkDetail,TResult? Function( String status)?  onSelectReviewStatus,TResult? Function()?  onSubmitReview,}) {final _that = this;
switch (_that) {
case OnLoadSubmittedHomework() when onLoadSubmittedHomework != null:
return onLoadSubmittedHomework(_that.page,_that.query);case OnLoadSubmittedHomeworkDetail() when onLoadSubmittedHomeworkDetail != null:
return onLoadSubmittedHomeworkDetail(_that.submittedHomeworkId);case OnSelectReviewStatus() when onSelectReviewStatus != null:
return onSelectReviewStatus(_that.status);case OnSubmitReview() when onSubmitReview != null:
return onSubmitReview();case _:
  return null;

}
}

}

/// @nodoc


class OnLoadSubmittedHomework implements SubmittedHomeworkEvent {
  const OnLoadSubmittedHomework({this.page = 1, this.query = ''});
  

@JsonKey() final  int page;
@JsonKey() final  String query;

/// Create a copy of SubmittedHomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadSubmittedHomeworkCopyWith<OnLoadSubmittedHomework> get copyWith => _$OnLoadSubmittedHomeworkCopyWithImpl<OnLoadSubmittedHomework>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadSubmittedHomework&&(identical(other.page, page) || other.page == page)&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,page,query);

@override
String toString() {
  return 'SubmittedHomeworkEvent.onLoadSubmittedHomework(page: $page, query: $query)';
}


}

/// @nodoc
abstract mixin class $OnLoadSubmittedHomeworkCopyWith<$Res> implements $SubmittedHomeworkEventCopyWith<$Res> {
  factory $OnLoadSubmittedHomeworkCopyWith(OnLoadSubmittedHomework value, $Res Function(OnLoadSubmittedHomework) _then) = _$OnLoadSubmittedHomeworkCopyWithImpl;
@useResult
$Res call({
 int page, String query
});




}
/// @nodoc
class _$OnLoadSubmittedHomeworkCopyWithImpl<$Res>
    implements $OnLoadSubmittedHomeworkCopyWith<$Res> {
  _$OnLoadSubmittedHomeworkCopyWithImpl(this._self, this._then);

  final OnLoadSubmittedHomework _self;
  final $Res Function(OnLoadSubmittedHomework) _then;

/// Create a copy of SubmittedHomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? page = null,Object? query = null,}) {
  return _then(OnLoadSubmittedHomework(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OnLoadSubmittedHomeworkDetail implements SubmittedHomeworkEvent {
  const OnLoadSubmittedHomeworkDetail({required this.submittedHomeworkId});
  

 final  int submittedHomeworkId;

/// Create a copy of SubmittedHomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadSubmittedHomeworkDetailCopyWith<OnLoadSubmittedHomeworkDetail> get copyWith => _$OnLoadSubmittedHomeworkDetailCopyWithImpl<OnLoadSubmittedHomeworkDetail>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadSubmittedHomeworkDetail&&(identical(other.submittedHomeworkId, submittedHomeworkId) || other.submittedHomeworkId == submittedHomeworkId));
}


@override
int get hashCode => Object.hash(runtimeType,submittedHomeworkId);

@override
String toString() {
  return 'SubmittedHomeworkEvent.onLoadSubmittedHomeworkDetail(submittedHomeworkId: $submittedHomeworkId)';
}


}

/// @nodoc
abstract mixin class $OnLoadSubmittedHomeworkDetailCopyWith<$Res> implements $SubmittedHomeworkEventCopyWith<$Res> {
  factory $OnLoadSubmittedHomeworkDetailCopyWith(OnLoadSubmittedHomeworkDetail value, $Res Function(OnLoadSubmittedHomeworkDetail) _then) = _$OnLoadSubmittedHomeworkDetailCopyWithImpl;
@useResult
$Res call({
 int submittedHomeworkId
});




}
/// @nodoc
class _$OnLoadSubmittedHomeworkDetailCopyWithImpl<$Res>
    implements $OnLoadSubmittedHomeworkDetailCopyWith<$Res> {
  _$OnLoadSubmittedHomeworkDetailCopyWithImpl(this._self, this._then);

  final OnLoadSubmittedHomeworkDetail _self;
  final $Res Function(OnLoadSubmittedHomeworkDetail) _then;

/// Create a copy of SubmittedHomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? submittedHomeworkId = null,}) {
  return _then(OnLoadSubmittedHomeworkDetail(
submittedHomeworkId: null == submittedHomeworkId ? _self.submittedHomeworkId : submittedHomeworkId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnSelectReviewStatus implements SubmittedHomeworkEvent {
  const OnSelectReviewStatus({required this.status});
  

 final  String status;

/// Create a copy of SubmittedHomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSelectReviewStatusCopyWith<OnSelectReviewStatus> get copyWith => _$OnSelectReviewStatusCopyWithImpl<OnSelectReviewStatus>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSelectReviewStatus&&(identical(other.status, status) || other.status == status));
}


@override
int get hashCode => Object.hash(runtimeType,status);

@override
String toString() {
  return 'SubmittedHomeworkEvent.onSelectReviewStatus(status: $status)';
}


}

/// @nodoc
abstract mixin class $OnSelectReviewStatusCopyWith<$Res> implements $SubmittedHomeworkEventCopyWith<$Res> {
  factory $OnSelectReviewStatusCopyWith(OnSelectReviewStatus value, $Res Function(OnSelectReviewStatus) _then) = _$OnSelectReviewStatusCopyWithImpl;
@useResult
$Res call({
 String status
});




}
/// @nodoc
class _$OnSelectReviewStatusCopyWithImpl<$Res>
    implements $OnSelectReviewStatusCopyWith<$Res> {
  _$OnSelectReviewStatusCopyWithImpl(this._self, this._then);

  final OnSelectReviewStatus _self;
  final $Res Function(OnSelectReviewStatus) _then;

/// Create a copy of SubmittedHomeworkEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? status = null,}) {
  return _then(OnSelectReviewStatus(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class OnSubmitReview implements SubmittedHomeworkEvent {
  const OnSubmitReview();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSubmitReview);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SubmittedHomeworkEvent.onSubmitReview()';
}


}




/// @nodoc
mixin _$SubmittedHomeworkState {

// List.
 bool get isLoading; bool get isLoadingMore; bool get hasMore; int get currentPage; int get lastPage; String get query; TextEditingController get searchController; List<SubmittedHomeworkData> get arrSubmittedHomework;// Detail and review.
 bool get isLoadingDetail; bool get isSubmitting; bool get isSubmitted; String get selectedStatus; TextEditingController get commentController; SubmittedHomeworkDetailModel? get submittedHomeworkDetailData;// Messages.
 String? get errorMessage; String? get detailErrorMessage; String? get reviewErrorMessage; String? get successMessage;
/// Create a copy of SubmittedHomeworkState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubmittedHomeworkStateCopyWith<SubmittedHomeworkState> get copyWith => _$SubmittedHomeworkStateCopyWithImpl<SubmittedHomeworkState>(this as SubmittedHomeworkState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubmittedHomeworkState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.query, query) || other.query == query)&&(identical(other.searchController, searchController) || other.searchController == searchController)&&const DeepCollectionEquality().equals(other.arrSubmittedHomework, arrSubmittedHomework)&&(identical(other.isLoadingDetail, isLoadingDetail) || other.isLoadingDetail == isLoadingDetail)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.commentController, commentController) || other.commentController == commentController)&&(identical(other.submittedHomeworkDetailData, submittedHomeworkDetailData) || other.submittedHomeworkDetailData == submittedHomeworkDetailData)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.detailErrorMessage, detailErrorMessage) || other.detailErrorMessage == detailErrorMessage)&&(identical(other.reviewErrorMessage, reviewErrorMessage) || other.reviewErrorMessage == reviewErrorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,hasMore,currentPage,lastPage,query,searchController,const DeepCollectionEquality().hash(arrSubmittedHomework),isLoadingDetail,isSubmitting,isSubmitted,selectedStatus,commentController,submittedHomeworkDetailData,errorMessage,detailErrorMessage,reviewErrorMessage,successMessage);

@override
String toString() {
  return 'SubmittedHomeworkState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, currentPage: $currentPage, lastPage: $lastPage, query: $query, searchController: $searchController, arrSubmittedHomework: $arrSubmittedHomework, isLoadingDetail: $isLoadingDetail, isSubmitting: $isSubmitting, isSubmitted: $isSubmitted, selectedStatus: $selectedStatus, commentController: $commentController, submittedHomeworkDetailData: $submittedHomeworkDetailData, errorMessage: $errorMessage, detailErrorMessage: $detailErrorMessage, reviewErrorMessage: $reviewErrorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class $SubmittedHomeworkStateCopyWith<$Res>  {
  factory $SubmittedHomeworkStateCopyWith(SubmittedHomeworkState value, $Res Function(SubmittedHomeworkState) _then) = _$SubmittedHomeworkStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool hasMore, int currentPage, int lastPage, String query, TextEditingController searchController, List<SubmittedHomeworkData> arrSubmittedHomework, bool isLoadingDetail, bool isSubmitting, bool isSubmitted, String selectedStatus, TextEditingController commentController, SubmittedHomeworkDetailModel? submittedHomeworkDetailData, String? errorMessage, String? detailErrorMessage, String? reviewErrorMessage, String? successMessage
});




}
/// @nodoc
class _$SubmittedHomeworkStateCopyWithImpl<$Res>
    implements $SubmittedHomeworkStateCopyWith<$Res> {
  _$SubmittedHomeworkStateCopyWithImpl(this._self, this._then);

  final SubmittedHomeworkState _self;
  final $Res Function(SubmittedHomeworkState) _then;

/// Create a copy of SubmittedHomeworkState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? hasMore = null,Object? currentPage = null,Object? lastPage = null,Object? query = null,Object? searchController = null,Object? arrSubmittedHomework = null,Object? isLoadingDetail = null,Object? isSubmitting = null,Object? isSubmitted = null,Object? selectedStatus = null,Object? commentController = null,Object? submittedHomeworkDetailData = freezed,Object? errorMessage = freezed,Object? detailErrorMessage = freezed,Object? reviewErrorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,searchController: null == searchController ? _self.searchController : searchController // ignore: cast_nullable_to_non_nullable
as TextEditingController,arrSubmittedHomework: null == arrSubmittedHomework ? _self.arrSubmittedHomework : arrSubmittedHomework // ignore: cast_nullable_to_non_nullable
as List<SubmittedHomeworkData>,isLoadingDetail: null == isLoadingDetail ? _self.isLoadingDetail : isLoadingDetail // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,commentController: null == commentController ? _self.commentController : commentController // ignore: cast_nullable_to_non_nullable
as TextEditingController,submittedHomeworkDetailData: freezed == submittedHomeworkDetailData ? _self.submittedHomeworkDetailData : submittedHomeworkDetailData // ignore: cast_nullable_to_non_nullable
as SubmittedHomeworkDetailModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,detailErrorMessage: freezed == detailErrorMessage ? _self.detailErrorMessage : detailErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,reviewErrorMessage: freezed == reviewErrorMessage ? _self.reviewErrorMessage : reviewErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubmittedHomeworkState].
extension SubmittedHomeworkStatePatterns on SubmittedHomeworkState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubmittedHomeworkState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubmittedHomeworkState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubmittedHomeworkState value)  $default,){
final _that = this;
switch (_that) {
case _SubmittedHomeworkState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubmittedHomeworkState value)?  $default,){
final _that = this;
switch (_that) {
case _SubmittedHomeworkState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  bool hasMore,  int currentPage,  int lastPage,  String query,  TextEditingController searchController,  List<SubmittedHomeworkData> arrSubmittedHomework,  bool isLoadingDetail,  bool isSubmitting,  bool isSubmitted,  String selectedStatus,  TextEditingController commentController,  SubmittedHomeworkDetailModel? submittedHomeworkDetailData,  String? errorMessage,  String? detailErrorMessage,  String? reviewErrorMessage,  String? successMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubmittedHomeworkState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.currentPage,_that.lastPage,_that.query,_that.searchController,_that.arrSubmittedHomework,_that.isLoadingDetail,_that.isSubmitting,_that.isSubmitted,_that.selectedStatus,_that.commentController,_that.submittedHomeworkDetailData,_that.errorMessage,_that.detailErrorMessage,_that.reviewErrorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  bool isLoadingMore,  bool hasMore,  int currentPage,  int lastPage,  String query,  TextEditingController searchController,  List<SubmittedHomeworkData> arrSubmittedHomework,  bool isLoadingDetail,  bool isSubmitting,  bool isSubmitted,  String selectedStatus,  TextEditingController commentController,  SubmittedHomeworkDetailModel? submittedHomeworkDetailData,  String? errorMessage,  String? detailErrorMessage,  String? reviewErrorMessage,  String? successMessage)  $default,) {final _that = this;
switch (_that) {
case _SubmittedHomeworkState():
return $default(_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.currentPage,_that.lastPage,_that.query,_that.searchController,_that.arrSubmittedHomework,_that.isLoadingDetail,_that.isSubmitting,_that.isSubmitted,_that.selectedStatus,_that.commentController,_that.submittedHomeworkDetailData,_that.errorMessage,_that.detailErrorMessage,_that.reviewErrorMessage,_that.successMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  bool isLoadingMore,  bool hasMore,  int currentPage,  int lastPage,  String query,  TextEditingController searchController,  List<SubmittedHomeworkData> arrSubmittedHomework,  bool isLoadingDetail,  bool isSubmitting,  bool isSubmitted,  String selectedStatus,  TextEditingController commentController,  SubmittedHomeworkDetailModel? submittedHomeworkDetailData,  String? errorMessage,  String? detailErrorMessage,  String? reviewErrorMessage,  String? successMessage)?  $default,) {final _that = this;
switch (_that) {
case _SubmittedHomeworkState() when $default != null:
return $default(_that.isLoading,_that.isLoadingMore,_that.hasMore,_that.currentPage,_that.lastPage,_that.query,_that.searchController,_that.arrSubmittedHomework,_that.isLoadingDetail,_that.isSubmitting,_that.isSubmitted,_that.selectedStatus,_that.commentController,_that.submittedHomeworkDetailData,_that.errorMessage,_that.detailErrorMessage,_that.reviewErrorMessage,_that.successMessage);case _:
  return null;

}
}

}

/// @nodoc


class _SubmittedHomeworkState implements SubmittedHomeworkState {
  const _SubmittedHomeworkState({required this.isLoading, required this.isLoadingMore, required this.hasMore, required this.currentPage, required this.lastPage, required this.query, required this.searchController, required final  List<SubmittedHomeworkData> arrSubmittedHomework, required this.isLoadingDetail, required this.isSubmitting, required this.isSubmitted, required this.selectedStatus, required this.commentController, this.submittedHomeworkDetailData, this.errorMessage, this.detailErrorMessage, this.reviewErrorMessage, this.successMessage}): _arrSubmittedHomework = arrSubmittedHomework;
  

// List.
@override final  bool isLoading;
@override final  bool isLoadingMore;
@override final  bool hasMore;
@override final  int currentPage;
@override final  int lastPage;
@override final  String query;
@override final  TextEditingController searchController;
 final  List<SubmittedHomeworkData> _arrSubmittedHomework;
@override List<SubmittedHomeworkData> get arrSubmittedHomework {
  if (_arrSubmittedHomework is EqualUnmodifiableListView) return _arrSubmittedHomework;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arrSubmittedHomework);
}

// Detail and review.
@override final  bool isLoadingDetail;
@override final  bool isSubmitting;
@override final  bool isSubmitted;
@override final  String selectedStatus;
@override final  TextEditingController commentController;
@override final  SubmittedHomeworkDetailModel? submittedHomeworkDetailData;
// Messages.
@override final  String? errorMessage;
@override final  String? detailErrorMessage;
@override final  String? reviewErrorMessage;
@override final  String? successMessage;

/// Create a copy of SubmittedHomeworkState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubmittedHomeworkStateCopyWith<_SubmittedHomeworkState> get copyWith => __$SubmittedHomeworkStateCopyWithImpl<_SubmittedHomeworkState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubmittedHomeworkState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.lastPage, lastPage) || other.lastPage == lastPage)&&(identical(other.query, query) || other.query == query)&&(identical(other.searchController, searchController) || other.searchController == searchController)&&const DeepCollectionEquality().equals(other._arrSubmittedHomework, _arrSubmittedHomework)&&(identical(other.isLoadingDetail, isLoadingDetail) || other.isLoadingDetail == isLoadingDetail)&&(identical(other.isSubmitting, isSubmitting) || other.isSubmitting == isSubmitting)&&(identical(other.isSubmitted, isSubmitted) || other.isSubmitted == isSubmitted)&&(identical(other.selectedStatus, selectedStatus) || other.selectedStatus == selectedStatus)&&(identical(other.commentController, commentController) || other.commentController == commentController)&&(identical(other.submittedHomeworkDetailData, submittedHomeworkDetailData) || other.submittedHomeworkDetailData == submittedHomeworkDetailData)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.detailErrorMessage, detailErrorMessage) || other.detailErrorMessage == detailErrorMessage)&&(identical(other.reviewErrorMessage, reviewErrorMessage) || other.reviewErrorMessage == reviewErrorMessage)&&(identical(other.successMessage, successMessage) || other.successMessage == successMessage));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,isLoadingMore,hasMore,currentPage,lastPage,query,searchController,const DeepCollectionEquality().hash(_arrSubmittedHomework),isLoadingDetail,isSubmitting,isSubmitted,selectedStatus,commentController,submittedHomeworkDetailData,errorMessage,detailErrorMessage,reviewErrorMessage,successMessage);

@override
String toString() {
  return 'SubmittedHomeworkState(isLoading: $isLoading, isLoadingMore: $isLoadingMore, hasMore: $hasMore, currentPage: $currentPage, lastPage: $lastPage, query: $query, searchController: $searchController, arrSubmittedHomework: $arrSubmittedHomework, isLoadingDetail: $isLoadingDetail, isSubmitting: $isSubmitting, isSubmitted: $isSubmitted, selectedStatus: $selectedStatus, commentController: $commentController, submittedHomeworkDetailData: $submittedHomeworkDetailData, errorMessage: $errorMessage, detailErrorMessage: $detailErrorMessage, reviewErrorMessage: $reviewErrorMessage, successMessage: $successMessage)';
}


}

/// @nodoc
abstract mixin class _$SubmittedHomeworkStateCopyWith<$Res> implements $SubmittedHomeworkStateCopyWith<$Res> {
  factory _$SubmittedHomeworkStateCopyWith(_SubmittedHomeworkState value, $Res Function(_SubmittedHomeworkState) _then) = __$SubmittedHomeworkStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, bool isLoadingMore, bool hasMore, int currentPage, int lastPage, String query, TextEditingController searchController, List<SubmittedHomeworkData> arrSubmittedHomework, bool isLoadingDetail, bool isSubmitting, bool isSubmitted, String selectedStatus, TextEditingController commentController, SubmittedHomeworkDetailModel? submittedHomeworkDetailData, String? errorMessage, String? detailErrorMessage, String? reviewErrorMessage, String? successMessage
});




}
/// @nodoc
class __$SubmittedHomeworkStateCopyWithImpl<$Res>
    implements _$SubmittedHomeworkStateCopyWith<$Res> {
  __$SubmittedHomeworkStateCopyWithImpl(this._self, this._then);

  final _SubmittedHomeworkState _self;
  final $Res Function(_SubmittedHomeworkState) _then;

/// Create a copy of SubmittedHomeworkState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? isLoadingMore = null,Object? hasMore = null,Object? currentPage = null,Object? lastPage = null,Object? query = null,Object? searchController = null,Object? arrSubmittedHomework = null,Object? isLoadingDetail = null,Object? isSubmitting = null,Object? isSubmitted = null,Object? selectedStatus = null,Object? commentController = null,Object? submittedHomeworkDetailData = freezed,Object? errorMessage = freezed,Object? detailErrorMessage = freezed,Object? reviewErrorMessage = freezed,Object? successMessage = freezed,}) {
  return _then(_SubmittedHomeworkState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,lastPage: null == lastPage ? _self.lastPage : lastPage // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,searchController: null == searchController ? _self.searchController : searchController // ignore: cast_nullable_to_non_nullable
as TextEditingController,arrSubmittedHomework: null == arrSubmittedHomework ? _self._arrSubmittedHomework : arrSubmittedHomework // ignore: cast_nullable_to_non_nullable
as List<SubmittedHomeworkData>,isLoadingDetail: null == isLoadingDetail ? _self.isLoadingDetail : isLoadingDetail // ignore: cast_nullable_to_non_nullable
as bool,isSubmitting: null == isSubmitting ? _self.isSubmitting : isSubmitting // ignore: cast_nullable_to_non_nullable
as bool,isSubmitted: null == isSubmitted ? _self.isSubmitted : isSubmitted // ignore: cast_nullable_to_non_nullable
as bool,selectedStatus: null == selectedStatus ? _self.selectedStatus : selectedStatus // ignore: cast_nullable_to_non_nullable
as String,commentController: null == commentController ? _self.commentController : commentController // ignore: cast_nullable_to_non_nullable
as TextEditingController,submittedHomeworkDetailData: freezed == submittedHomeworkDetailData ? _self.submittedHomeworkDetailData : submittedHomeworkDetailData // ignore: cast_nullable_to_non_nullable
as SubmittedHomeworkDetailModel?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,detailErrorMessage: freezed == detailErrorMessage ? _self.detailErrorMessage : detailErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,reviewErrorMessage: freezed == reviewErrorMessage ? _self.reviewErrorMessage : reviewErrorMessage // ignore: cast_nullable_to_non_nullable
as String?,successMessage: freezed == successMessage ? _self.successMessage : successMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
