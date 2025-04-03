import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:vietour/core/utils/calculate_reading_time.dart';
import 'package:vietour/features/blog/domain/entities/blog.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  final Color color;
  const BlogCard({
    super.key,
    required this.blog,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      height: 200,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children:
                      blog.topics
                          .map(
                            (e) => Padding(
                              padding: const EdgeInsets.all(
                                4.0,
                              ),
                              child: Chip(label: Text(e)),
                            ),
                          )
                          .toList(),
                ),
              ),
              Text(
                blog.title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          Text('${calculateReadingTime(blog.content)} min'),
        ],
      ),
    );
  }
}
