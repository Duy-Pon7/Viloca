import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:uuid/uuid.dart';
import 'package:vietour/core/error/exceptions.dart';
import 'package:vietour/core/error/failures.dart';
import 'package:vietour/features/blog/data/datasources/blog_remote_data_source.dart';
import 'package:vietour/features/blog/data/models/blog_model.dart';
import 'package:vietour/features/blog/domain/entities/blog.dart';
import 'package:vietour/features/blog/domain/repositories/blog_repository.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogRemoteDataSource blogRemoteDataSource;
  BlogRepositoryImpl(this.blogRemoteDataSource);
  @override
  Future<Either<Failure, Blog>> uploadBlog({
    required File image,
    required String posterId,
    required String title,
    required String content,
    required List<String> topics,
  }) async {
    try {
      BlogModel blogModel = BlogModel(
        id: const Uuid().v1(),
        posterId: posterId,
        title: title,
        content: content,
        imageUrl: '',
        topics: topics,
        updatedAt: DateTime.now(),
      );
      final imageUrl = await blogRemoteDataSource
          .uploadBlogImage(image: image, blog: blogModel);

      blogModel = blogModel.copyWith(imageUrl: imageUrl);

      final uploadBlog = await blogRemoteDataSource
          .uploadBlog(blogModel);
      return right(uploadBlog);
    } on ServerException catch (e) {
      return left(Failure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<Blog>>> GetAllBlogs() async {
    try {
      final blogs =
          await blogRemoteDataSource.getAllBlogs();
      return right(blogs);
    } on ServerException catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
