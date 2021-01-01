import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../exports.dart';

class GBChat extends StatefulWidget {
  @override
  _GBChatState createState() => _GBChatState();
}

class _GBChatState extends State<GBChat> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Column(
        children: [
          buildCategoryBar(context),
          SizedBox(height: 10.0),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: Chat.messages().map((e) {
                  return ChatItem(
                    chat: e,
                    height: 90,
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(context) {
    return new AppBar(
      leading: CupertinoButton(
        child: IconWidget(
          iconPath: R.I.icBack,
          padding: 0.0,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: <Widget>[
          buildHeadingBar(context),
          Expanded(child: Container()),
          Padding(
            padding: EdgeInsets.only(left: 0.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).colorScheme.onBackground,
              ),
              height: 45,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  InkWell(
                    onTap: () => null,
                    child: IconWidget(
                      iconPath: R.I.icSearch,
                      color: AppTheme.getColor(context),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      topLeft: Radius.circular(10),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 0.5,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  InkWell(
                    onTap: () => null,
                    borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(10),
                      topRight: Radius.circular(10),
                    ),
                    child: IconWidget(
                      iconPath: R.I.icMore,
                      color: AppTheme.getColor(context),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
      elevation: 0,
    );
  }

  Widget buildBadge(int length) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(10),
      ),
      width: 20,
      height: 20,
      child: Center(
        child: Text(
          length.toString(),
          style: TextStyle(color: Colors.white, fontSize: 11),
        ),
      ),
    );
  }

  Container buildHeadingBar(context) {
    return Container(
      padding: EdgeInsets.only(left: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'Messages',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30.0),
          ),
          buildBadge(12)
        ],
      ),
    );
  }

  Container buildCategoryBar(context) {
    return Container(
      height: 45.0,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.only(left: 15.0, bottom: 0.0),
      child: Row(
        children: <Widget>[
          Container(
            child: Center(
              child: Text(
                'Inbox',
                style: TextStyle(color: Colors.white),
              ),
            ),
            width: 80.0,
            height: 32.0,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.7),
                  blurRadius: 2.0,
                )
              ],
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          SizedBox(width: 12.0),
          Text(
            'Archive',
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

class ChatItem extends StatelessWidget {
  final Chat chat;
  final double height;

  ChatItem({this.chat, this.height});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10),
      margin: EdgeInsets.symmetric(vertical: 1.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
      ),
      child: Container(
        height: (height - 1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(
                  'https://source.unsplash.com/${chat.avatar}',
                ),
              ),
              title: Column(
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        chat.name,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      Text(
                        chat.time,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.0),
                ],
              ),
              subtitle: Text(
                chat.message,
              ),
              contentPadding: EdgeInsets.only(
                top: 10.0,
                bottom: 10.0,
                left: 5.0,
                right: 10.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
