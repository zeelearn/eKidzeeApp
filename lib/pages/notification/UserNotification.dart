import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/NotificationModel.dart';
import 'DetailPage.dart';

class UserNotification extends StatefulWidget{
  UserNotification({Key? key}) : super(key: key);

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<UserNotification> {
  late List lessons;

  @override
  void initState() {
    lessons = getNotification();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(NotificationModel notificationModel) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.autorenew, color: Colors.white),
      ),
      title: Text(
        notificationModel.subject,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Flexible(
            child: RichText(
              overflow: TextOverflow.ellipsis,
              maxLines: 3, // this will show dots(...) after 3 lines
              strutStyle: const StrutStyle(fontSize: 12.0),
              text: TextSpan(
                  style: const TextStyle(color: Colors.white),
                  text: notificationModel.message
              ),
            ),
          ),
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(notificationModel: notificationModel)));
      },
    );

    Card makeCard(NotificationModel model) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(model),
      ),
    );

    final makeBody = Container(
      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: lessons.length,
        itemBuilder: (BuildContext context, int index) {
          return makeCard(lessons[index]);
        },
      ),
    );

    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      title: Text("Notifications"),
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: makeBody,
      //bottomNavigationBar: makeBottom,
    );
  }
}

List getNotification() {
  return [
    NotificationModel(
        notificationId: 1,
        subject: "Beginner",
        notificationtype: 'promo',
        message: 'Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.',
        image_url: 'https://t3.ftcdn.net/jpg/02/72/78/44/360_F_272784427_ct2LctMwGutHuaxtPjOPq5DgKCzteLF6.jpg',
        time : "05/07/2022 11:15",
        isSeen:0,
        indicatorValue: 1.0),
    NotificationModel(
        notificationId: 1,
        subject: "Beginner",
        notificationtype: 'promo',
        message: 'Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.',
        image_url: 'https://t3.ftcdn.net/jpg/02/72/78/44/360_F_272784427_ct2LctMwGutHuaxtPjOPq5DgKCzteLF6.jpg',
        time : "05/07/2022 11:15",
        isSeen:0 ,
        indicatorValue: 1.0),
    NotificationModel(
        notificationId: 1,
        subject: "Beginner",
        notificationtype: 'promo',
        message: 'Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.',
        image_url: 'https://t3.ftcdn.net/jpg/02/72/78/44/360_F_272784427_ct2LctMwGutHuaxtPjOPq5DgKCzteLF6.jpg',
        time : "05/07/2022 11:15",
        isSeen:0 ,
        indicatorValue: 1.0),
    NotificationModel(
        notificationId: 1,
        subject: "Beginner",
        notificationtype: 'promo',
        message: 'Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.',
        image_url: 'https://t3.ftcdn.net/jpg/02/72/78/44/360_F_272784427_ct2LctMwGutHuaxtPjOPq5DgKCzteLF6.jpg',
        time : "05/07/2022 11:15",
        isSeen:0 ,
        indicatorValue: 1.0),
    NotificationModel(
        notificationId: 1,
        subject: "Beginner",
        notificationtype: 'promo',
        message: 'Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.',
        image_url: 'https://t3.ftcdn.net/jpg/02/72/78/44/360_F_272784427_ct2LctMwGutHuaxtPjOPq5DgKCzteLF6.jpg',
        time : "05/07/2022 11:15",
        isSeen:0 ,
        indicatorValue: 1.0),
    NotificationModel(
        notificationId: 1,
        subject: "Beginner",
        notificationtype: 'promo',
        message: 'Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.',
        image_url: 'https://t3.ftcdn.net/jpg/02/72/78/44/360_F_272784427_ct2LctMwGutHuaxtPjOPq5DgKCzteLF6.jpg',
        time : "05/07/2022 11:15",
        isSeen:0 ,
        indicatorValue: 1.0),
    NotificationModel(
        notificationId: 1,
        subject: "Beginner",
        notificationtype: 'promo',
        message: 'Start by taking a couple of minutes to read the info in this section. Launch your app and click on the Settings menu.  While on the settings page, click the Save button.  You should see a circular progress indicator display in the middle of the page and the user interface elements cannot be clicked due to the modal barrier that is constructed.',
        image_url: 'https://t3.ftcdn.net/jpg/02/72/78/44/360_F_272784427_ct2LctMwGutHuaxtPjOPq5DgKCzteLF6.jpg',
        time : "05/07/2022 11:15",
        isSeen:0,
        indicatorValue: 1.0 ),
  ];
}