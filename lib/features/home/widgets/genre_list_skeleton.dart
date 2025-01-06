import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GenreListSkeleton extends StatelessWidget {
  const GenreListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: Container(
        decoration: const BoxDecoration(
          border: Border.symmetric(
            horizontal: BorderSide(width: 1, color: Color(0xE9BBB280)),
          ),
        ),
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {},
                child: Text(
                  BoneMock.title,
                  style: TextStyle(
                    color: Colors.grey.shade700,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
