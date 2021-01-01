import 'package:flutter/material.dart';

import '../../exports.dart';

class GBNews extends StatelessWidget {
  static Screen gmNews = Screen(
    title: 'News',
    contentBuilder: (context) => GBNews(),
  );

  @override
  Widget build(BuildContext context) {
    final _store = Provider.of<MainProvider>(context);
    return Scaffold(
      body: FutureBuilder<News>(
        future: _store.fetchNews(''),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return Center(
              child: SpinKitThreeBounce(
                size: 40.0,
                duration: Duration(milliseconds: 1500),
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          return SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
            child: Column(
              children: snapshot.data.articles.map((e) {
                print(snapshot.data.totalResults);
                return NewsItem(article: e);
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}
