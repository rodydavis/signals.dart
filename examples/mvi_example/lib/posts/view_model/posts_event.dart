import 'package:signals_mvi_example/core/base_view_model.dart';

sealed class PostsEvent extends BaseEvent {}

final class FetchPosts extends PostsEvent {}
