import 'package:dio/dio.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/api_client.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';
import '../models/post_model.dart';

class PostRepositoryImpl implements PostRepository {
  final ApiClient apiClient;

  PostRepositoryImpl(this.apiClient);

  @override
  Future<List<Post>> getPosts() async {
    try {
      final response = await apiClient.get('/posts');
      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;
        return data.map((json) => PostModel.fromJson(json)).toList();
      } else {
        throw const ServerFailure('Failed to load posts');
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionError) {
        throw const NetworkFailure();
      }
      throw ServerFailure(e.message ?? 'Unknown error occurred');
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }
}
