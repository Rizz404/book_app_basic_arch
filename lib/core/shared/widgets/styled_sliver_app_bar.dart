import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StyledSliverAppBar extends StatelessWidget {
  final Widget title;
  final double? elevation;
  final bool? centerTitle;

  const StyledSliverAppBar({
    super.key,
    required this.title,
    this.elevation,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    // * Mendapatkan current location dari GoRouter
    final currentLocation = GoRouterState.of(context).uri.path;
    // * Memeriksa apakah sedang berada di menu screen
    final isMenuScreen = currentLocation == '/menu';

    return SliverAppBar(
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: elevation ?? 0,
      leading: ModalRoute.of(context)?.canPop == true
          ? IconButton(
              icon:
                  Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          : null,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: ModalRoute.of(context)?.canPop == true ? 48 : 0,
                  ),
                  child: title,
                ),
              ),
              const SizedBox(width: 8),
              // * Menampilkan icon menu hanya jika tidak berada di menu screen
              if (!isMenuScreen)
                IconButton(
                  onPressed: () => context.push('/menu'),
                  icon: Icon(
                    Icons.menu,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
            ],
          ),
        ),
      ),
      expandedHeight: 80,
      toolbarHeight: 80,
      centerTitle: centerTitle,
    );
  }
}
