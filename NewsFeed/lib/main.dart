import 'package:flutter/material.dart';

void main() {
  runApp(const NewsFeedApp());
}

class NewsFeedApp extends StatelessWidget {
  const NewsFeedApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News Feed',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const NewsFeeds(),
    );
  }
}

class NewsFeeds extends StatelessWidget {
  const NewsFeeds({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Feed'),
      ),
      body: OrientationBuilder(
        builder: (context, orientation) {
          return NewsFeedList(orientation: orientation);
        },
      ),
    );
  }
}

class NewsFeedList extends StatelessWidget {
  final Orientation orientation;

  const NewsFeedList({super.key, required this.orientation});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: newsFeed.length,
      itemBuilder: (context, index) {
        return _buildArticleCard(newsFeed[index]);
      },
    );
  }

  Widget _buildArticleCard(NewsFeed news) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: orientation == Orientation.portrait
          ? _buildPortraitLayout(news)
          : _buildLandscapeLayout(news),
    );
  }

  Widget _buildPortraitLayout(NewsFeed news) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(news.thumbnailUrl),
      ],
    );
  }

  Widget _buildLandscapeLayout(NewsFeed news) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 120.0,
          height: 120.0,
          child: Image.network(news.thumbnailUrl),
        ),
      ],
    );
  }
}

class NewsFeed {
  final String thumbnailUrl;

  NewsFeed({
    required this.thumbnailUrl,
  });
}

List<NewsFeed> newsFeed = [
  NewsFeed(
    thumbnailUrl:
        'https://images.pexels.com/photos/16416071/pexels-photo-16416071/free-photo-of-iced-coffee-and-orange-juice-in-glasses-with-straws.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
  ),
  NewsFeed(
    thumbnailUrl:
        'https://images.pexels.com/photos/16347929/pexels-photo-16347929/free-photo-of-palm-trees-between-buildings.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
  ),
  NewsFeed(
    thumbnailUrl:
        'https://images.pexels.com/photos/16416071/pexels-photo-16416071/free-photo-of-iced-coffee-and-orange-juice-in-glasses-with-straws.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
  ),
  NewsFeed(
    thumbnailUrl:
        'https://images.pexels.com/photos/16347929/pexels-photo-16347929/free-photo-of-palm-trees-between-buildings.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
  ),
  NewsFeed(
    thumbnailUrl:
        'https://images.pexels.com/photos/16416071/pexels-photo-16416071/free-photo-of-iced-coffee-and-orange-juice-in-glasses-with-straws.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
  ),
  NewsFeed(
    thumbnailUrl:
        'https://images.pexels.com/photos/16347929/pexels-photo-16347929/free-photo-of-palm-trees-between-buildings.jpeg?auto=compress&cs=tinysrgb&w=600&lazy=load',
  ),
  // Add more news articles here...
];
