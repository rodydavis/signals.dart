import 'package:crud_dio/helper/dio_helper.dart';
import 'package:crud_dio/model/post_model.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi()
abstract class RestClient {
  factory RestClient() => _RestClient(DioClient.instance.dio);

  @GET('/posts')
  Future<List<Post>> getPosts();

  @GET('/posts/{id}')
  Future<Post> getPost(@Path('id') int id);

  @POST('/posts')
  Future<Post> createPost(@Body() Post post);

  @PUT('/posts/{id}')
  Future<Post> updatePost(@Path() int id, @Body() Post post);

  @DELETE('/posts/{id}')
  Future<void> deletePost(@Path() int id);
}
