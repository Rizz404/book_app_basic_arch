import 'package:book_app_basic_arch/feature/book/model/book_model.dart';
import 'package:flutter/material.dart';

class BookImageCarousel extends StatefulWidget {
  final List<BookPictureModel> bookPictures;

  const BookImageCarousel({super.key, required this.bookPictures});

  @override
  State<BookImageCarousel> createState() => _BookImageCarouselState();
}

class _BookImageCarouselState extends State<BookImageCarousel> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.bookPictures.isEmpty) {
      return SizedBox(
        height: 300,
        child: _buildPlaceholder(),
      );
    }

    return Stack(
      children: [
        SizedBox(
          height: 300,
          child: PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemCount: widget.bookPictures.length,
            itemBuilder: (context, index) {
              final image = widget.bookPictures[index];
              final bool isPlaceholderImage =
                  image.url == 'http://placeimg.com/640/480';

              if (isPlaceholderImage) {
                return _buildPlaceholder();
              }

              return Image.network(
                image.url,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    _buildPlaceholder(),
              );
            },
          ),
        ),
        // Gradient overlay
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
          ),
        ),
        // Page indicator
        if (widget.bookPictures.length > 1)
          Positioned(
            bottom: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.bookPictures.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == entry.key
                        ? Colors.white
                        : Colors.white.withOpacity(0.4),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }

  Widget _buildPlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade300,
            Colors.grey.shade200,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          Icons.book,
          size: 64,
          color: Colors.grey.shade400,
        ),
      ),
    );
  }
}
