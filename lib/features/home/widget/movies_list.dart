import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:plotify/core/model/movies.dart';
import 'package:plotify/features/home/widget/movie_item.dart';

class MoviesList extends StatelessWidget {
  final Movies movies;
  final String title;
  const MoviesList({super.key, required this.movies, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: TextTheme.of(context).titleMedium),
              TextButton(
                onPressed: () {},
                child: Text("View all", style: TextStyle(color: Colors.grey)),
              ),
            ],
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.data!.length,
              itemBuilder: (context, index) {
                final movie = movies.data![index];
                return MovieItem(movie: movie , onClicked: (int id) {
                  
                },);
              },
            ),
          ),
        ],
      ),
    );
  }
}
