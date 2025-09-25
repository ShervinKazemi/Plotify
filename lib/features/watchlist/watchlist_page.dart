import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:plotify/core/constatns/constants.dart';
import 'package:plotify/features/home/widget/error_widget.dart';
import 'package:plotify/features/home/widget/search_items.dart';
import 'package:plotify/features/watchlist/watchlist_provider.dart';
import 'package:plotify/features/watchlist/widget/watchlist_item.dart';
import 'package:plotify/routes/app_route.dart';
import 'package:provider/provider.dart';

class WatchlistPage extends StatelessWidget {
  const WatchlistPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Consumer<WatchlistProvider>(
        builder: (context, watchlistProvider, child) {
          if (watchlistProvider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (watchlistProvider.error != null &&
              watchlistProvider.error!.isNotEmpty) {
            return Center(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 128,
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: theme.colorScheme.onErrorContainer),
                  borderRadius: BorderRadius.circular(16),
                  color: theme.colorScheme.error.withValues(alpha: 0.4),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.error_outline_rounded,
                        color: theme.colorScheme.onError,
                        size: 128,
                      ),
                      const Gap(16),
                      Text(
                        "Oopps...",
                        style: theme.textTheme.titleLarge!.copyWith(
                          color: theme.colorScheme.onError,
                        ),
                      ),
                      const Gap(16),
                      ElevatedButton(
                        onPressed: () {
                          watchlistProvider.initializeData();
                        },
                        child: Icon(
                          Icons.threesixty_rounded,
                          color: theme.colorScheme.onErrorContainer,
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }

          if (watchlistProvider.movies!.data == null ||
              watchlistProvider.movies!.data!.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/image/not_found.png",
                    fit: BoxFit.contain,
                  ),
                  const Gap(16),
                  Text(
                    "Sorry, You haven’t added any movie or TV show to your watchlist",
                    style: theme.textTheme.bodyMedium!.copyWith(
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                automaticallyImplyLeading: false,
                title: Text("Watchlist"),
                centerTitle: true,
                backgroundColor: AppColors.primary,
              ),
              SliverPadding(
                padding: const EdgeInsets.only(bottom: 128),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final movie = watchlistProvider.movies!.data![index];
                    return WatchlistItem(
                      movie: movie,
                      theme: theme,
                      onDismissed: () => watchlistProvider.deleteUser(movie),
                      onTap: (int id) {
                        Navigator.pushNamed(
                          context,
                          AppRoute.detail,
                          arguments: id,
                        );
                      },
                    );
                  }, childCount: watchlistProvider.movies!.data!.length),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
