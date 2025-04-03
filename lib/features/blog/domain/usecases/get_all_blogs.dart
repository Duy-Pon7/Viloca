import 'package:fpdart/fpdart.dart';
import 'package:vietour/core/error/failures.dart';
import 'package:vietour/core/usercase/usecase.dart';
import 'package:vietour/features/blog/domain/entities/blog.dart';
import 'package:vietour/features/blog/domain/repositories/blog_repository.dart';

class GetAllBlogs implements Usecase<List<Blog>, NoParams> {
  final BlogRepository blogRepository;
  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failure, List<Blog>>> call(
    NoParams params,
  ) async {
    return await blogRepository.GetAllBlogs();
  }
}
