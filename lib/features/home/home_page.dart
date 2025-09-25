import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:plotify/features/detail/detail_page.dart';
import 'package:plotify/features/home/home_provider.dart';
import 'package:plotify/features/home/widget/category_item.dart';
import 'package:plotify/features/home/widget/error_widget.dart';
import 'package:plotify/features/home/widget/movies_list.dart';
import 'package:plotify/features/home/widget/search_items.dart';
import 'package:plotify/features/home/widget/story_carousel_slider.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<HomeProvider>(context);
    final TextTheme textTheme = Theme.of(context).textTheme;
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.menu_rounded, size: 30, color: Colors.white),
            const Icon(CupertinoIcons.bell_fill, size: 25, color: Colors.white),
          ],
        ),
      ),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // Search bar as a sliver
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              child: SearchBar(
                controller: _searchController,
                leading: const Icon(Icons.search, color: Colors.white),
                hintText: "Search movies...",
                focusNode: _focusNode,
                trailing: [
                  if (_searchController.text.isNotEmpty)
                    IconButton(
                      onPressed: () {
                        _searchController.clear();
                        provider.cleanSearches();
                      },
                      icon: const Icon(
                        Icons.clear_rounded,
                        color: Colors.white,
                      ),
                    ),
                ],
                onChanged: (query) {
                  _searchController.text = query;
                },
                onSubmitted: (query) {
                  provider.updateQuery(query.trim());
                },
                onTapOutside: (event) {
                  _focusNode.unfocus();
                },
              ),
            ),
          ),
          // Main content
          SliverToBoxAdapter(
            child: Consumer<HomeProvider>(
              builder: (context, homeProvider, child) {
                if (homeProvider.isLoading) {
                  return const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  );
                }

                if (homeProvider.error != null &&
                    homeProvider.error!.isNotEmpty) {
                  return ShowError(
                    colorScheme: colorScheme,
                    textTheme: textTheme,
                    homeProvider: homeProvider,
                    isDetailPage: false,
                    detailProvider: null,
                  );
                }

                if (homeProvider.searches?.data == null ||
                    homeProvider.searches!.data!.isEmpty) {
                  if (homeProvider.query.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 40,
                          child: ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: homeProvider.getCategories().length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final categories = homeProvider.getCategories();
                              return Padding(
                                padding: index == 0
                                    ? const EdgeInsets.only(left: 16)
                                    : const EdgeInsets.all(0),
                                child: CategoryItem(
                                  categoryName: categories[index],
                                ),
                              );
                            },
                          ),
                        ),
                        const Gap(16),
                        Padding(
                          padding: const EdgeInsets.only(left: 16),
                          child: Text(
                            "Now Playing",
                            textAlign: TextAlign.start,
                            style: textTheme.titleMedium,
                          ),
                        ),
                        StoryCarousel(
                          images: homeProvider.getNowPlayingImages(),
                          imdbRating: homeProvider.getNowPlayingRating(),
                          title: homeProvider.getNowPlayingTitle(),
                        ),
                        MoviesList(
                          movies: homeProvider.trending!,
                          title: "Trending",
                        ),
                        MoviesList(
                          movies: homeProvider.newReleases!,
                          title: "New Release - Movies",
                        ),
                        MoviesList(
                          movies: homeProvider.newReleaseShows!,
                          title: "New Release - Shows",
                        ),
                        MoviesList(
                          movies: homeProvider.recommended!,
                          title: "Recommended",
                        ),
                        const Gap(128),
                      ],
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 64,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/image/not_found.png",
                            fit: BoxFit.contain,
                          ),
                          const Gap(16),
                          Text("Not Found", style: textTheme.titleLarge),
                          const Gap(16),
                          Text(
                            "We are sorry we cannot find the movie. We are constantly updating the app to contain all what you want.",
                            style: textTheme.bodyMedium!.copyWith(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    );
                  }
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 128),
                  itemCount: homeProvider.searches!.data!.length,
                  itemBuilder: (context, index) {
                    final movie = homeProvider.searches!.data![index];
                    return SearchItems(
                      movie: movie,
                      onClick: (int id) {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DetailPage(),
                            settings: RouteSettings(arguments: id),
                          ),
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
