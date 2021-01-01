import 'package:flutter/material.dart';
import 'package:gimibits/exports.dart';

class NewsItem extends StatelessWidget {
  final Articles article;
  NewsItem({this.article});

  @override
  Widget build(BuildContext context) {
    print(article.urlToImage);
    return BoxPanel(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      padding: EdgeInsets.zero,
      child: Column(
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                  article.urlToImage ?? 'https://bitcoinist.com/wp-content/uploads/2020/11/philip-veater-6AtkTnXqeiI-unsplash-1920x1272.jpg',
                ),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(4.0),
                topRight: Radius.circular(4.0),
                bottomLeft: Radius.circular(8.0),
                bottomRight: Radius.circular(8.0),
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              article.description,
            ),
          )
        ],
      ),
    );
  }
}
