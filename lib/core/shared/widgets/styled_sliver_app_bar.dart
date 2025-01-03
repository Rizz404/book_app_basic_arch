import 'package:flutter/material.dart';

class StyledSliverAppBar extends StatelessWidget {
  final Widget title;
  final List<Widget>? actions;
  final double? elevation;
  final bool? centerTitle;

  const StyledSliverAppBar({
    super.key,
    required this.title,
    this.actions,
    this.elevation,
    this.centerTitle = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: false,
      pinned: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: elevation ?? 0,
      leading: ModalRoute.of(context)?.canPop ==
              true // * Periksa apakah bisa pop
          ? IconButton(
              icon:
                  Icon(Icons.arrow_back, color: Theme.of(context).primaryColor),
              onPressed: () {
                Navigator.of(context).pop(); // * Fungsi back
              },
            )
          : null, // * Tidak tampilkan tombol back jika tidak bisa pop
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
              Row(children: actions ?? []),
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
