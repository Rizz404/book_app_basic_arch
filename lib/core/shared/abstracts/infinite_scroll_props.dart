import 'package:flutter/material.dart';

// * Base class untuk properti yang digunakan di infinite scroll components
abstract class InfiniteScrollProps<T> {
  final List<T> items;
  final bool isLoading;
  final bool isInitialLoading;
  final String? errorMessage;
  final Function()? onRetry;
  final Function() onLoadMore;
  final Function(T) onItemSelected;
  final ScrollController scrollController;
  final String emptyMessage;

  const InfiniteScrollProps({
    required this.items,
    required this.isLoading,
    required this.isInitialLoading,
    this.errorMessage,
    this.onRetry,
    required this.onLoadMore,
    required this.onItemSelected,
    required this.scrollController,
    required this.emptyMessage,
  });
}
