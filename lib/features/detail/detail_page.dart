import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:plotify/core/constatns/constants.dart';
import 'package:plotify/features/detail/detail_provider.dart';
import 'package:plotify/features/detail/widget/full_screen_image_shower.dart';
import 'package:plotify/features/home/widget/error_widget.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final int id = ModalRoute.of(context)!.settings.arguments as int;
      context.read<DetailProvider>().setId(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: Consumer<DetailProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.white),
            );
          }

          if (provider.error != null) {
            return ShowError(
              colorScheme: ColorScheme.of(context),
              detailProvider: provider,
              homeProvider: null,
              isDetailPage: true,
              textTheme: TextTheme.of(context),
            );
          }

          final movie = provider.movie;
          if (movie == null) {
            return const Center(child: Text('No movie data available'));
          }

          return CustomScrollView(
            shrinkWrap: true,
            slivers: [
              SliverAppBar(
                floating: true,
                pinned: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: GestureDetector(
                    onLongPress: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => FullScreenImageShower(imageUrl: movie.poster!)
                        )
                      );
                    },
                    child: ClipRRect(
                      child: Image.network(
                        movie.poster!,
                        fit: BoxFit.fill,
                        alignment: AlignmentGeometry.topCenter,
                      ),
                    ),
                  ),
                ),
                elevation: 8,
                expandedHeight: 300,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white, size: 30),
                ),
                actions: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      CupertinoIcons.bell,
                      size: 30,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        movie.title!,
                        style: theme.textTheme.titleMedium,
                        maxLines: 1,
                      ),
                      Gap(16),
                      SizedBox(
                        height: 35,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: movie.genres!.length,
                          itemBuilder: (context, index) {
                            final genre = movie.genres![index];
                            return _buildGenresItem(context, genre, theme);
                          },
                        ),
                      ),
                      Gap(16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildInfoSection(
                            context,
                            theme,
                            Icons.calendar_month_rounded,
                            movie.year!,
                          ),
                          _buildInfoSection(
                            context,
                            theme,
                            Icons.star_rate_rounded,
                            movie.imdbRating!,
                          ),
                          _buildInfoSection(
                            context,
                            theme,
                            Icons.schedule_rounded,
                            movie.runtime!,
                          ),
                          Gap(16),
                        ],
                      ),
                      Gap(32),
                      Text(
                        movie.plot!,
                        style: theme.textTheme.titleSmall,
                        textAlign: TextAlign.justify,
                      ),
                      Gap(32),
                      Text("Detail", style: theme.textTheme.titleMedium),
                      Gap(8),
                      _buildDetailSection(
                        context,
                        theme,
                        "Country",
                        movie.country!,
                      ),
                      Gap(8),
                      _buildDetailSection(
                        context,
                        theme,
                        "Date Release",
                        movie.released!,
                      ),
                      Gap(8),
                      _buildDetailSection(
                        context,
                        theme,
                        "Director",
                        movie.director!
                      ),
                      Gap(8),
                      _buildDetailSection(
                        context,
                        theme,
                        "Meta Score",
                        movie.metascore!
                      ),
                      Gap(32),
                      Text("Shots", style: theme.textTheme.titleMedium),
                      Gap(8),
                      SizedBox(
                        height: 128,
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: movie.images!.length,
                          itemBuilder: (context, index) {
                            final image = movie.images![index];
                            return _buildShotsSection(context, image);
                          },
                        ),
                      ),
                      Gap(32)
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildGenresItem(BuildContext context, String genre, ThemeData theme) {
    return Container(
      width: 84,
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Center(
        child: Text(
          genre,
          style: theme.textTheme.titleSmall!.copyWith(color: AppColors.primary),
        ),
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    ThemeData theme,
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(icon, color: Colors.white, size: 30),
        Gap(8),
        Text(text, style: theme.textTheme.titleSmall),
      ],
    );
  }

  Widget _buildDetailSection(
    BuildContext context,
    ThemeData theme,
    String title,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.only(right: 16),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Row(
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall,
                  textAlign: TextAlign.start,
                ),
                const SizedBox(width: 8),
                Text(":", style: theme.textTheme.titleSmall),
              ],
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: theme.textTheme.titleSmall,
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildShotsSection(BuildContext context , String imageUrl) {
    return SizedBox(
      width: 250,
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => FullScreenImageShower(imageUrl: imageUrl)
                )
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(16),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
