import 'package:flutter/material.dart';

class BookOfferCarousel extends StatefulWidget {
  final List<String> bannerImages;

  const BookOfferCarousel({
    super.key,
    required this.bannerImages,
  });

  @override
  State<BookOfferCarousel> createState() => _BookOfferCarouselState();
}

class _BookOfferCarouselState extends State<BookOfferCarousel> {
  int _currentPage = 0;
  final PageController _pageController = PageController();
  late final List<String> _infiniteList;
  bool _isAutoScrolling = true;

  @override
  void initState() {
    super.initState();

    // * Setup infinite list
    _infiniteList = [
      widget.bannerImages.last,
      ...widget.bannerImages,
      widget.bannerImages.first,
    ];

    // * Start auto-scroll
    _startAutoScroll();
  }

  void _startAutoScroll() {
    if (!_isAutoScrolling) return;

    Future.delayed(const Duration(seconds: 5), () {
      if (_isAutoScrolling) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeInOut,
        );
        _startAutoScroll(); // * Recursive call for continuous auto-scroll
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      if (index == 0) {
        // * Smoothly jump to last item
        Future.delayed(const Duration(milliseconds: 300), () {
          _pageController.jumpToPage(widget.bannerImages.length);
        });
        _currentPage = widget.bannerImages.length - 1;
      } else if (index == widget.bannerImages.length + 1) {
        // * Smoothly jump to first item
        Future.delayed(const Duration(milliseconds: 300), () {
          _pageController.jumpToPage(1);
        });
        _currentPage = 0;
      } else {
        _currentPage = index - 1;
      }
    });
  }

  void _stopAutoScroll() {
    setState(() {
      _isAutoScrolling = false;
    });
  }

  void _restartAutoScroll() {
    setState(() {
      _isAutoScrolling = true;
      _startAutoScroll();
    });
  }

  void _goToNextPage() {
    _stopAutoScroll();
    _pageController.nextPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    _restartAutoScroll();
  }

  void _goToPreviousPage() {
    _stopAutoScroll();
    _pageController.previousPage(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    _restartAutoScroll();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) {
        _stopAutoScroll();
      },
      onLongPressEnd: (_) {
        _startAutoScroll();
      },
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // * PageView with infinite scroll
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: SizedBox(
              height: 200,
              child: PageView.builder(
                controller: _pageController,
                itemCount: _infiniteList.length,
                onPageChanged: _onPageChanged,
                itemBuilder: (context, index) {
                  return Image.network(
                    _infiniteList[index],
                    fit: BoxFit.cover,
                  );
                },
              ),
            ),
          ),

          // * Dots indicator
          Positioned(
            bottom: 10,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.bannerImages.asMap().entries.map((entry) {
                return Container(
                  width: 8,
                  height: 8,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentPage == entry.key
                        ? Colors.white
                        : Colors.white.withOpacity(0.5),
                  ),
                );
              }).toList(),
            ),
          ),

          // * Left Arrow Button
          Positioned(
            left: 10,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: _goToPreviousPage,
            ),
          ),

          // * Right Arrow Button
          Positioned(
            right: 10,
            top: 0,
            bottom: 0,
            child: IconButton(
              icon: const Icon(Icons.arrow_forward, color: Colors.white),
              onPressed: _goToNextPage,
            ),
          ),
        ],
      ),
    );
  }
}
