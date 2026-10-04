// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ChatEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent()';
}


}

/// @nodoc
class $ChatEventCopyWith<$Res>  {
$ChatEventCopyWith(ChatEvent _, $Res Function(ChatEvent) __);
}


/// Adds pattern-matching-related methods to [ChatEvent].
extension ChatEventPatterns on ChatEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( OnLoadChats value)?  onLoadChats,TResult Function( OnLoadMessages value)?  onLoadMessages,TResult Function( OnLoadAllStudent value)?  onLoadAllStudent,TResult Function( OnSendMessage value)?  onSendMessage,TResult Function( OnSearchChats value)?  onSearchChats,required TResult orElse(),}){
final _that = this;
switch (_that) {
case OnLoadChats() when onLoadChats != null:
return onLoadChats(_that);case OnLoadMessages() when onLoadMessages != null:
return onLoadMessages(_that);case OnLoadAllStudent() when onLoadAllStudent != null:
return onLoadAllStudent(_that);case OnSendMessage() when onSendMessage != null:
return onSendMessage(_that);case OnSearchChats() when onSearchChats != null:
return onSearchChats(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( OnLoadChats value)  onLoadChats,required TResult Function( OnLoadMessages value)  onLoadMessages,required TResult Function( OnLoadAllStudent value)  onLoadAllStudent,required TResult Function( OnSendMessage value)  onSendMessage,required TResult Function( OnSearchChats value)  onSearchChats,}){
final _that = this;
switch (_that) {
case OnLoadChats():
return onLoadChats(_that);case OnLoadMessages():
return onLoadMessages(_that);case OnLoadAllStudent():
return onLoadAllStudent(_that);case OnSendMessage():
return onSendMessage(_that);case OnSearchChats():
return onSearchChats(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( OnLoadChats value)?  onLoadChats,TResult? Function( OnLoadMessages value)?  onLoadMessages,TResult? Function( OnLoadAllStudent value)?  onLoadAllStudent,TResult? Function( OnSendMessage value)?  onSendMessage,TResult? Function( OnSearchChats value)?  onSearchChats,}){
final _that = this;
switch (_that) {
case OnLoadChats() when onLoadChats != null:
return onLoadChats(_that);case OnLoadMessages() when onLoadMessages != null:
return onLoadMessages(_that);case OnLoadAllStudent() when onLoadAllStudent != null:
return onLoadAllStudent(_that);case OnSendMessage() when onSendMessage != null:
return onSendMessage(_that);case OnSearchChats() when onSearchChats != null:
return onSearchChats(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  onLoadChats,TResult Function( int studentId,  int page)?  onLoadMessages,TResult Function()?  onLoadAllStudent,TResult Function( int studentId)?  onSendMessage,TResult Function( String query)?  onSearchChats,required TResult orElse(),}) {final _that = this;
switch (_that) {
case OnLoadChats() when onLoadChats != null:
return onLoadChats();case OnLoadMessages() when onLoadMessages != null:
return onLoadMessages(_that.studentId,_that.page);case OnLoadAllStudent() when onLoadAllStudent != null:
return onLoadAllStudent();case OnSendMessage() when onSendMessage != null:
return onSendMessage(_that.studentId);case OnSearchChats() when onSearchChats != null:
return onSearchChats(_that.query);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  onLoadChats,required TResult Function( int studentId,  int page)  onLoadMessages,required TResult Function()  onLoadAllStudent,required TResult Function( int studentId)  onSendMessage,required TResult Function( String query)  onSearchChats,}) {final _that = this;
switch (_that) {
case OnLoadChats():
return onLoadChats();case OnLoadMessages():
return onLoadMessages(_that.studentId,_that.page);case OnLoadAllStudent():
return onLoadAllStudent();case OnSendMessage():
return onSendMessage(_that.studentId);case OnSearchChats():
return onSearchChats(_that.query);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  onLoadChats,TResult? Function( int studentId,  int page)?  onLoadMessages,TResult? Function()?  onLoadAllStudent,TResult? Function( int studentId)?  onSendMessage,TResult? Function( String query)?  onSearchChats,}) {final _that = this;
switch (_that) {
case OnLoadChats() when onLoadChats != null:
return onLoadChats();case OnLoadMessages() when onLoadMessages != null:
return onLoadMessages(_that.studentId,_that.page);case OnLoadAllStudent() when onLoadAllStudent != null:
return onLoadAllStudent();case OnSendMessage() when onSendMessage != null:
return onSendMessage(_that.studentId);case OnSearchChats() when onSearchChats != null:
return onSearchChats(_that.query);case _:
  return null;

}
}

}

/// @nodoc


class OnLoadChats implements ChatEvent {
  const OnLoadChats();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadChats);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.onLoadChats()';
}


}




/// @nodoc


class OnLoadMessages implements ChatEvent {
  const OnLoadMessages({required this.studentId, this.page = 1});
  

 final  int studentId;
@JsonKey() final  int page;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnLoadMessagesCopyWith<OnLoadMessages> get copyWith => _$OnLoadMessagesCopyWithImpl<OnLoadMessages>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadMessages&&(identical(other.studentId, studentId) || other.studentId == studentId)&&(identical(other.page, page) || other.page == page));
}


@override
int get hashCode => Object.hash(runtimeType,studentId,page);

@override
String toString() {
  return 'ChatEvent.onLoadMessages(studentId: $studentId, page: $page)';
}


}

/// @nodoc
abstract mixin class $OnLoadMessagesCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $OnLoadMessagesCopyWith(OnLoadMessages value, $Res Function(OnLoadMessages) _then) = _$OnLoadMessagesCopyWithImpl;
@useResult
$Res call({
 int studentId, int page
});




}
/// @nodoc
class _$OnLoadMessagesCopyWithImpl<$Res>
    implements $OnLoadMessagesCopyWith<$Res> {
  _$OnLoadMessagesCopyWithImpl(this._self, this._then);

  final OnLoadMessages _self;
  final $Res Function(OnLoadMessages) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? studentId = null,Object? page = null,}) {
  return _then(OnLoadMessages(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnLoadAllStudent implements ChatEvent {
  const OnLoadAllStudent();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnLoadAllStudent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ChatEvent.onLoadAllStudent()';
}


}




/// @nodoc


class OnSendMessage implements ChatEvent {
  const OnSendMessage({required this.studentId});
  

 final  int studentId;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSendMessageCopyWith<OnSendMessage> get copyWith => _$OnSendMessageCopyWithImpl<OnSendMessage>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSendMessage&&(identical(other.studentId, studentId) || other.studentId == studentId));
}


@override
int get hashCode => Object.hash(runtimeType,studentId);

@override
String toString() {
  return 'ChatEvent.onSendMessage(studentId: $studentId)';
}


}

/// @nodoc
abstract mixin class $OnSendMessageCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $OnSendMessageCopyWith(OnSendMessage value, $Res Function(OnSendMessage) _then) = _$OnSendMessageCopyWithImpl;
@useResult
$Res call({
 int studentId
});




}
/// @nodoc
class _$OnSendMessageCopyWithImpl<$Res>
    implements $OnSendMessageCopyWith<$Res> {
  _$OnSendMessageCopyWithImpl(this._self, this._then);

  final OnSendMessage _self;
  final $Res Function(OnSendMessage) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? studentId = null,}) {
  return _then(OnSendMessage(
studentId: null == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class OnSearchChats implements ChatEvent {
  const OnSearchChats({required this.query});
  

 final  String query;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnSearchChatsCopyWith<OnSearchChats> get copyWith => _$OnSearchChatsCopyWithImpl<OnSearchChats>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnSearchChats&&(identical(other.query, query) || other.query == query));
}


@override
int get hashCode => Object.hash(runtimeType,query);

@override
String toString() {
  return 'ChatEvent.onSearchChats(query: $query)';
}


}

/// @nodoc
abstract mixin class $OnSearchChatsCopyWith<$Res> implements $ChatEventCopyWith<$Res> {
  factory $OnSearchChatsCopyWith(OnSearchChats value, $Res Function(OnSearchChats) _then) = _$OnSearchChatsCopyWithImpl;
@useResult
$Res call({
 String query
});




}
/// @nodoc
class _$OnSearchChatsCopyWithImpl<$Res>
    implements $OnSearchChatsCopyWith<$Res> {
  _$OnSearchChatsCopyWithImpl(this._self, this._then);

  final OnSearchChats _self;
  final $Res Function(OnSearchChats) _then;

/// Create a copy of ChatEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? query = null,}) {
  return _then(OnSearchChats(
query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc
mixin _$ChatState {

 bool get isLoading; List<ChatListData> get students; List<ChatDetailData> get messages; List<AllStudentData> get arrAllStudentData; TextEditingController get searchController; TextEditingController get messageController; ScrollController get scrollController; bool get isLoadingMore; bool get isSending; bool get hasError; bool get hasMore; int get currentPage; String get query; bool get isLoadingMoreMessages; int get messagePage; int get messageLastPage; String get messageError; int? get studentId;
/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ChatStateCopyWith<ChatState> get copyWith => _$ChatStateCopyWithImpl<ChatState>(this as ChatState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ChatState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other.students, students)&&const DeepCollectionEquality().equals(other.messages, messages)&&const DeepCollectionEquality().equals(other.arrAllStudentData, arrAllStudentData)&&(identical(other.searchController, searchController) || other.searchController == searchController)&&(identical(other.messageController, messageController) || other.messageController == messageController)&&(identical(other.scrollController, scrollController) || other.scrollController == scrollController)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.query, query) || other.query == query)&&(identical(other.isLoadingMoreMessages, isLoadingMoreMessages) || other.isLoadingMoreMessages == isLoadingMoreMessages)&&(identical(other.messagePage, messagePage) || other.messagePage == messagePage)&&(identical(other.messageLastPage, messageLastPage) || other.messageLastPage == messageLastPage)&&(identical(other.messageError, messageError) || other.messageError == messageError)&&(identical(other.studentId, studentId) || other.studentId == studentId));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(students),const DeepCollectionEquality().hash(messages),const DeepCollectionEquality().hash(arrAllStudentData),searchController,messageController,scrollController,isLoadingMore,isSending,hasError,hasMore,currentPage,query,isLoadingMoreMessages,messagePage,messageLastPage,messageError,studentId);

@override
String toString() {
  return 'ChatState(isLoading: $isLoading, students: $students, messages: $messages, arrAllStudentData: $arrAllStudentData, searchController: $searchController, messageController: $messageController, scrollController: $scrollController, isLoadingMore: $isLoadingMore, isSending: $isSending, hasError: $hasError, hasMore: $hasMore, currentPage: $currentPage, query: $query, isLoadingMoreMessages: $isLoadingMoreMessages, messagePage: $messagePage, messageLastPage: $messageLastPage, messageError: $messageError, studentId: $studentId)';
}


}

/// @nodoc
abstract mixin class $ChatStateCopyWith<$Res>  {
  factory $ChatStateCopyWith(ChatState value, $Res Function(ChatState) _then) = _$ChatStateCopyWithImpl;
@useResult
$Res call({
 bool isLoading, List<ChatListData> students, List<ChatDetailData> messages, List<AllStudentData> arrAllStudentData, TextEditingController searchController, TextEditingController messageController, ScrollController scrollController, bool isLoadingMore, bool isSending, bool hasError, bool hasMore, int currentPage, String query, bool isLoadingMoreMessages, int messagePage, int messageLastPage, String messageError, int? studentId
});




}
/// @nodoc
class _$ChatStateCopyWithImpl<$Res>
    implements $ChatStateCopyWith<$Res> {
  _$ChatStateCopyWithImpl(this._self, this._then);

  final ChatState _self;
  final $Res Function(ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? isLoading = null,Object? students = null,Object? messages = null,Object? arrAllStudentData = null,Object? searchController = null,Object? messageController = null,Object? scrollController = null,Object? isLoadingMore = null,Object? isSending = null,Object? hasError = null,Object? hasMore = null,Object? currentPage = null,Object? query = null,Object? isLoadingMoreMessages = null,Object? messagePage = null,Object? messageLastPage = null,Object? messageError = null,Object? studentId = freezed,}) {
  return _then(_self.copyWith(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,students: null == students ? _self.students : students // ignore: cast_nullable_to_non_nullable
as List<ChatListData>,messages: null == messages ? _self.messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatDetailData>,arrAllStudentData: null == arrAllStudentData ? _self.arrAllStudentData : arrAllStudentData // ignore: cast_nullable_to_non_nullable
as List<AllStudentData>,searchController: null == searchController ? _self.searchController : searchController // ignore: cast_nullable_to_non_nullable
as TextEditingController,messageController: null == messageController ? _self.messageController : messageController // ignore: cast_nullable_to_non_nullable
as TextEditingController,scrollController: null == scrollController ? _self.scrollController : scrollController // ignore: cast_nullable_to_non_nullable
as ScrollController,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isLoadingMoreMessages: null == isLoadingMoreMessages ? _self.isLoadingMoreMessages : isLoadingMoreMessages // ignore: cast_nullable_to_non_nullable
as bool,messagePage: null == messagePage ? _self.messagePage : messagePage // ignore: cast_nullable_to_non_nullable
as int,messageLastPage: null == messageLastPage ? _self.messageLastPage : messageLastPage // ignore: cast_nullable_to_non_nullable
as int,messageError: null == messageError ? _self.messageError : messageError // ignore: cast_nullable_to_non_nullable
as String,studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [ChatState].
extension ChatStatePatterns on ChatState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ChatState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ChatState value)  $default,){
final _that = this;
switch (_that) {
case _ChatState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ChatState value)?  $default,){
final _that = this;
switch (_that) {
case _ChatState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool isLoading,  List<ChatListData> students,  List<ChatDetailData> messages,  List<AllStudentData> arrAllStudentData,  TextEditingController searchController,  TextEditingController messageController,  ScrollController scrollController,  bool isLoadingMore,  bool isSending,  bool hasError,  bool hasMore,  int currentPage,  String query,  bool isLoadingMoreMessages,  int messagePage,  int messageLastPage,  String messageError,  int? studentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.isLoading,_that.students,_that.messages,_that.arrAllStudentData,_that.searchController,_that.messageController,_that.scrollController,_that.isLoadingMore,_that.isSending,_that.hasError,_that.hasMore,_that.currentPage,_that.query,_that.isLoadingMoreMessages,_that.messagePage,_that.messageLastPage,_that.messageError,_that.studentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool isLoading,  List<ChatListData> students,  List<ChatDetailData> messages,  List<AllStudentData> arrAllStudentData,  TextEditingController searchController,  TextEditingController messageController,  ScrollController scrollController,  bool isLoadingMore,  bool isSending,  bool hasError,  bool hasMore,  int currentPage,  String query,  bool isLoadingMoreMessages,  int messagePage,  int messageLastPage,  String messageError,  int? studentId)  $default,) {final _that = this;
switch (_that) {
case _ChatState():
return $default(_that.isLoading,_that.students,_that.messages,_that.arrAllStudentData,_that.searchController,_that.messageController,_that.scrollController,_that.isLoadingMore,_that.isSending,_that.hasError,_that.hasMore,_that.currentPage,_that.query,_that.isLoadingMoreMessages,_that.messagePage,_that.messageLastPage,_that.messageError,_that.studentId);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool isLoading,  List<ChatListData> students,  List<ChatDetailData> messages,  List<AllStudentData> arrAllStudentData,  TextEditingController searchController,  TextEditingController messageController,  ScrollController scrollController,  bool isLoadingMore,  bool isSending,  bool hasError,  bool hasMore,  int currentPage,  String query,  bool isLoadingMoreMessages,  int messagePage,  int messageLastPage,  String messageError,  int? studentId)?  $default,) {final _that = this;
switch (_that) {
case _ChatState() when $default != null:
return $default(_that.isLoading,_that.students,_that.messages,_that.arrAllStudentData,_that.searchController,_that.messageController,_that.scrollController,_that.isLoadingMore,_that.isSending,_that.hasError,_that.hasMore,_that.currentPage,_that.query,_that.isLoadingMoreMessages,_that.messagePage,_that.messageLastPage,_that.messageError,_that.studentId);case _:
  return null;

}
}

}

/// @nodoc


class _ChatState implements ChatState {
  const _ChatState({required this.isLoading, required final  List<ChatListData> students, required final  List<ChatDetailData> messages, required final  List<AllStudentData> arrAllStudentData, required this.searchController, required this.messageController, required this.scrollController, this.isLoadingMore = false, this.isSending = false, this.hasError = false, this.hasMore = false, this.currentPage = 0, this.query = '', this.isLoadingMoreMessages = false, this.messagePage = 0, this.messageLastPage = 1, this.messageError = '', this.studentId}): _students = students,_messages = messages,_arrAllStudentData = arrAllStudentData;
  

@override final  bool isLoading;
 final  List<ChatListData> _students;
@override List<ChatListData> get students {
  if (_students is EqualUnmodifiableListView) return _students;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_students);
}

 final  List<ChatDetailData> _messages;
@override List<ChatDetailData> get messages {
  if (_messages is EqualUnmodifiableListView) return _messages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_messages);
}

 final  List<AllStudentData> _arrAllStudentData;
@override List<AllStudentData> get arrAllStudentData {
  if (_arrAllStudentData is EqualUnmodifiableListView) return _arrAllStudentData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_arrAllStudentData);
}

@override final  TextEditingController searchController;
@override final  TextEditingController messageController;
@override final  ScrollController scrollController;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool isSending;
@override@JsonKey() final  bool hasError;
@override@JsonKey() final  bool hasMore;
@override@JsonKey() final  int currentPage;
@override@JsonKey() final  String query;
@override@JsonKey() final  bool isLoadingMoreMessages;
@override@JsonKey() final  int messagePage;
@override@JsonKey() final  int messageLastPage;
@override@JsonKey() final  String messageError;
@override final  int? studentId;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ChatStateCopyWith<_ChatState> get copyWith => __$ChatStateCopyWithImpl<_ChatState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ChatState&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&const DeepCollectionEquality().equals(other._students, _students)&&const DeepCollectionEquality().equals(other._messages, _messages)&&const DeepCollectionEquality().equals(other._arrAllStudentData, _arrAllStudentData)&&(identical(other.searchController, searchController) || other.searchController == searchController)&&(identical(other.messageController, messageController) || other.messageController == messageController)&&(identical(other.scrollController, scrollController) || other.scrollController == scrollController)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.isSending, isSending) || other.isSending == isSending)&&(identical(other.hasError, hasError) || other.hasError == hasError)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.query, query) || other.query == query)&&(identical(other.isLoadingMoreMessages, isLoadingMoreMessages) || other.isLoadingMoreMessages == isLoadingMoreMessages)&&(identical(other.messagePage, messagePage) || other.messagePage == messagePage)&&(identical(other.messageLastPage, messageLastPage) || other.messageLastPage == messageLastPage)&&(identical(other.messageError, messageError) || other.messageError == messageError)&&(identical(other.studentId, studentId) || other.studentId == studentId));
}


@override
int get hashCode => Object.hash(runtimeType,isLoading,const DeepCollectionEquality().hash(_students),const DeepCollectionEquality().hash(_messages),const DeepCollectionEquality().hash(_arrAllStudentData),searchController,messageController,scrollController,isLoadingMore,isSending,hasError,hasMore,currentPage,query,isLoadingMoreMessages,messagePage,messageLastPage,messageError,studentId);

@override
String toString() {
  return 'ChatState(isLoading: $isLoading, students: $students, messages: $messages, arrAllStudentData: $arrAllStudentData, searchController: $searchController, messageController: $messageController, scrollController: $scrollController, isLoadingMore: $isLoadingMore, isSending: $isSending, hasError: $hasError, hasMore: $hasMore, currentPage: $currentPage, query: $query, isLoadingMoreMessages: $isLoadingMoreMessages, messagePage: $messagePage, messageLastPage: $messageLastPage, messageError: $messageError, studentId: $studentId)';
}


}

/// @nodoc
abstract mixin class _$ChatStateCopyWith<$Res> implements $ChatStateCopyWith<$Res> {
  factory _$ChatStateCopyWith(_ChatState value, $Res Function(_ChatState) _then) = __$ChatStateCopyWithImpl;
@override @useResult
$Res call({
 bool isLoading, List<ChatListData> students, List<ChatDetailData> messages, List<AllStudentData> arrAllStudentData, TextEditingController searchController, TextEditingController messageController, ScrollController scrollController, bool isLoadingMore, bool isSending, bool hasError, bool hasMore, int currentPage, String query, bool isLoadingMoreMessages, int messagePage, int messageLastPage, String messageError, int? studentId
});




}
/// @nodoc
class __$ChatStateCopyWithImpl<$Res>
    implements _$ChatStateCopyWith<$Res> {
  __$ChatStateCopyWithImpl(this._self, this._then);

  final _ChatState _self;
  final $Res Function(_ChatState) _then;

/// Create a copy of ChatState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? isLoading = null,Object? students = null,Object? messages = null,Object? arrAllStudentData = null,Object? searchController = null,Object? messageController = null,Object? scrollController = null,Object? isLoadingMore = null,Object? isSending = null,Object? hasError = null,Object? hasMore = null,Object? currentPage = null,Object? query = null,Object? isLoadingMoreMessages = null,Object? messagePage = null,Object? messageLastPage = null,Object? messageError = null,Object? studentId = freezed,}) {
  return _then(_ChatState(
isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,students: null == students ? _self._students : students // ignore: cast_nullable_to_non_nullable
as List<ChatListData>,messages: null == messages ? _self._messages : messages // ignore: cast_nullable_to_non_nullable
as List<ChatDetailData>,arrAllStudentData: null == arrAllStudentData ? _self._arrAllStudentData : arrAllStudentData // ignore: cast_nullable_to_non_nullable
as List<AllStudentData>,searchController: null == searchController ? _self.searchController : searchController // ignore: cast_nullable_to_non_nullable
as TextEditingController,messageController: null == messageController ? _self.messageController : messageController // ignore: cast_nullable_to_non_nullable
as TextEditingController,scrollController: null == scrollController ? _self.scrollController : scrollController // ignore: cast_nullable_to_non_nullable
as ScrollController,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,isSending: null == isSending ? _self.isSending : isSending // ignore: cast_nullable_to_non_nullable
as bool,hasError: null == hasError ? _self.hasError : hasError // ignore: cast_nullable_to_non_nullable
as bool,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,query: null == query ? _self.query : query // ignore: cast_nullable_to_non_nullable
as String,isLoadingMoreMessages: null == isLoadingMoreMessages ? _self.isLoadingMoreMessages : isLoadingMoreMessages // ignore: cast_nullable_to_non_nullable
as bool,messagePage: null == messagePage ? _self.messagePage : messagePage // ignore: cast_nullable_to_non_nullable
as int,messageLastPage: null == messageLastPage ? _self.messageLastPage : messageLastPage // ignore: cast_nullable_to_non_nullable
as int,messageError: null == messageError ? _self.messageError : messageError // ignore: cast_nullable_to_non_nullable
as String,studentId: freezed == studentId ? _self.studentId : studentId // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
