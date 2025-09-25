import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:plotify/core/constatns/constants.dart';
import 'package:plotify/core/model/movies.dart';

class WatchlistItem extends StatelessWidget {
  final Data movie;
  final ThemeData theme;
  final Function(int) onTap;
  final VoidCallback onDismissed;
  const WatchlistItem({
    super.key,
    required this.movie,
    required this.onTap,
    required this.onDismissed,
    required this.theme,
  });

    Widget _buildMoviePoster() {
    return movie.poster != null
        ? ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(4),
              bottomLeft: Radius.circular(4),
            ),
            child: Image.network(
              movie.poster!,
              fit: BoxFit.cover,
              height: 128,
              width: 128,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.movie,
                  size: 128,
                  color: Colors.white,
                );
              },
            ),
          )
        : const Icon(Icons.movie, size: 128, color: Colors.white);
  }

  Widget _buildInfoItem(IconData icon, String text, TextTheme textTheme) {
    return Row(
      children: [
        Icon(icon, color: Colors.white),
        const Gap(8),
        Text(text, style: textTheme.titleSmall),
      ],
    );
  }

  Widget _buildGenresSection() {
    return SizedBox(
      height: 35,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: movie.genres!.length,
        itemBuilder: (context, index) {
          final String genre = movie.genres![index];
          return Container(
            margin: const EdgeInsets.only(right: 8),
            padding: const EdgeInsets.symmetric(horizontal: 16 , vertical: 8),
            decoration: BoxDecoration(
              color: Color(0xFF385A64),
              borderRadius: BorderRadius.circular(12)
            ),
            child: Text(
              genre,
              style: theme.textTheme.titleSmall,
            ),
          );    
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(movie.id.toString()),
      direction: DismissDirection.endToStart,
      background: Container(
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.colorScheme.error.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(Icons.delete_sweep, size: 30, color: Colors.white),
      ),
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text(
                'Confirm Deletion',
                style: theme.textTheme.titleMedium,
              ),
              content: Text(
                'Are you sure you want to delete  ${movie.title}?',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.grey),
                ),
              backgroundColor: AppColors.primary,
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('Cancel' , style: TextStyle(color: Colors.white),),
                ),

                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red.shade400),
                  ),
                ),
              ],
            );
          },
        );
      },
      onDismissed: (direction) => onDismissed(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: InkWell(
          onTap: () {
            onTap(movie.id!);
          },
          child: Container(
            width: double.infinity,
            height: 150,
            decoration: BoxDecoration(
              border: BoxBorder.all(color: Colors.white, width: 3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildMoviePoster(),
                const Gap(16),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.53,
                        child: Text(
                          movie.title ?? 'Untitled',
                          style: theme.textTheme.titleMedium,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                      Row(
                        children: [
                          _buildInfoItem(
                            Icons.calendar_month_rounded,
                            movie.year ?? "2000",
                            theme.textTheme,
                          ),
                          const Gap(16),
                          _buildInfoItem(
                            Icons.star_border_rounded,
                            movie.imdbRating ?? "0.0",
                            theme.textTheme,
                          ),
                        ],
                      ),
                      _buildInfoItem(
                        Icons.schedule_rounded,
                        "2 hr 28 min",
                        theme.textTheme,
                      ),
                      _buildGenresSection()
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
