import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:vietour/core/error/failures.dart';
import 'package:vietour/core/usercase/usecase.dart';
import 'package:vietour/features/blog/domain/entities/blog.dart';
import 'package:vietour/features/blog/domain/repositories/blog_repository.dart';

class UploadBlog
    implements Usecase<Blog, UploadBlogParams> {
  final BlogRepository blogRepository;
  UploadBlog(this.blogRepository);
  @override
  Future<Either<Failure, Blog>> call(
    UploadBlogParams params,
  ) async {
    return await blogRepository.uploadBlog(
      image: params.image,
      posterId: params.posterId,
      title: params.title,
      content: params.content,
      topics: params.topics,
    );
  }
}

class UploadBlogParams {
  final File image;
  final String posterId;
  final String title;
  final String content;
  final List<String> topics;

  UploadBlogParams({
    required this.image,
    required this.posterId,
    required this.title,
    required this.content,
    required this.topics,
  });
}
