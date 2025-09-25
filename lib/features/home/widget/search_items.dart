import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:plotify/core/model/movies.dart';

class SearchItems extends StatelessWidget {
  final Data movie;
  final Function(int) onClick;
  const SearchItems({super.key, required this.movie, required this.onClick});

  Widget _buildMoviePoster() {
    return movie.poster != null
        ? ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
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

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final size = MediaQuery.of(context).size;
    const double itemHeight = 128;
    const double spacing = 16;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          onClick(movie.id!);
        },
        child: Container(
          width: double.infinity,
          height: itemHeight,
          decoration: BoxDecoration(
            border: BoxBorder.all(color: Colors.white, width: 3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMoviePoster(),
              const Gap(spacing),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.53,
                      child: Text(
                        movie.title ?? 'Untitled',
                        style: textTheme.titleMedium,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                    ),
                    Row(
                      children: [
                        _buildInfoItem(
                          Icons.calendar_month_rounded,
                          movie.year ?? "2000",
                          textTheme,
                        ),
                        const Gap(spacing),
                        _buildInfoItem(
                          Icons.star_border_rounded,
                          movie.imdbRating ?? "0.0",
                          textTheme,
                        ),
                      ],
                    ),
                    _buildInfoItem(
                      Icons.schedule_rounded,
                      "2 hr 28 min",
                      textTheme,
                    ),
                  ],
                ),
              ),
            ])
        ),
      ),
    );
  }
}
