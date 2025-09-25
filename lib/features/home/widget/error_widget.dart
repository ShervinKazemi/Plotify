import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:plotify/features/detail/detail_provider.dart';
import 'package:plotify/features/home/home_provider.dart';

class ShowError extends StatelessWidget {
  const ShowError({
    super.key,
    required this.colorScheme,
    required this.textTheme,
    required this.homeProvider, required this.detailProvider ,required this.isDetailPage,
  });

  final ColorScheme colorScheme;
  final TextTheme textTheme;
  final HomeProvider? homeProvider;
  final DetailProvider? detailProvider;
  final bool isDetailPage;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 128),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: colorScheme.onErrorContainer),
        borderRadius: BorderRadius.circular(16),
        color: colorScheme.error.withValues(alpha: 0.4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(
              Icons.error_outline_rounded,
              color: colorScheme.onError,
              size: 128,
            ),
            const Gap(16),
            Text(
              "Oopps...",
              style: textTheme.titleLarge!.copyWith(color: colorScheme.onError),
            ),
            const Gap(16),
            ElevatedButton(
              onPressed: () {
                isDetailPage ? detailProvider?.getMovieById() : homeProvider?.initializeData();
              },
              child: Icon(
                Icons.threesixty_rounded,
                color: colorScheme.onErrorContainer,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}