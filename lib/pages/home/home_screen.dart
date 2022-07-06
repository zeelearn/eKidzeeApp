import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ekidzee/helper/KidzeePref.dart';
import 'package:ekidzee/helper/LocalConstant.dart';
import 'package:ekidzee/model/ActivityPlanerModel.dart';
import 'package:ekidzee/pages/about/about_screen.dart';
import 'package:ekidzee/pages/ecampus/CloudScreen.dart';
import 'package:ekidzee/pages/notification/UserNotification.dart';
import 'package:ekidzee/pages/userinfo/MyInfoScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constants.dart';
import '../../model/PushNotification.dart';
import '../../ui/KidzeeAppTheme.dart';
import '../../widget/HomeAppBarDesign.dart';
import '../intro/splash.dart';
import 'ActivityPlannerView.dart';


class MyHomePage extends StatefulWidget {
  final String title;
  final String name;

  MyHomePage({required this.name, required this.title}) : super();

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  int _selectedDestination = 0;
  late String mTitle = "", mClassName = "";
  AnimationController? animationController;
  List<ActivityPlanerModel> bannerList = ActivityPlanerModel.bannerlList;
  final ScrollController _scrollController = ScrollController();
  KidzeePref mKidzeePref = KidzeePref();
  late int _totalNotifications;
  PushNotification? _notificationInfo;

  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now().add(const Duration(days: 5));

  List<String> images = [
    "assets/images/kidzee.png",
    "assets/images/kidzee.png",
    "assets/images/kidzee.png",
    "assets/images/kidzee.png",
  ];

  @override
  void initState() {
    print('----------------INIT------');
    mKidzeePref.init();
    animationController = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    checkForInitialMessage();
    super.initState();
    print('----------------INIT------');
    getUserInfo();
  }

// For handling notification when the app is in terminated state
  checkForInitialMessage() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    RemoteMessage? initialMessage =
    await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      PushNotification notification = PushNotification(
        title: initialMessage.notification?.title,
        body: initialMessage.notification?.body,
      );
      setState(() {
        _notificationInfo = notification;
        _totalNotifications++;
      });
    }
  }

  Future<void> getUserInfo() async {
    await Firebase.initializeApp();
    final prefs = await SharedPreferences.getInstance();
    String title = prefs.getString(LocalConstant.KEY_DISPLAY_NAME) as String;
    String className = mKidzeePref.getString(LocalConstant.KEY_EMAILID);
    setState(() {
      print(title);
      mTitle = prefs.getString(LocalConstant.KEY_DISPLAY_NAME) as String;
      mClassName = className;
    });

    final CollectionReference collectionRef =
    FirebaseFirestore.instance.collection("tActivity");
    // to get data from all documents sequentially
    bannerList.clear();
    collectionRef.snapshots().listen((result) {
      result.docChanges.forEach((res) {
        if (res.type == DocumentChangeType.added) {
          print("added");
          print(res.doc.data());
          setState(() {
            bannerList.add(ActivityPlanerModel(
              image_path: res.doc['image_path'],
              title: res.doc['title'],
              desc: res.doc['desc'],
              background: res.doc['background'],
              full_image: res.doc['full_image'],
              isDownload: res.doc['isDownload'],
              rating: 3.4,
              reviews: 80,
            ));
          });
        } else if (res.type == DocumentChangeType.modified) {
          print("modified");
          print(res.doc.data());
        } else if (res.type == DocumentChangeType.removed) {
          print("removed");
          print(res.doc.data());
        }
      });
    });
  }
  bool _isOpened = false;
  @override
  Widget build(BuildContext context) {
    EasyLoading.init();
    return  WillPopScope(
      onWillPop: () async{
        onBackClickListener();
         return false;
      },
      child: Scaffold(
        key: _scaffoldKey,
        // appBar: AppBar(
        //   title: KidzeeWidget().getAppBarUI(context),
        // ),
        appBar: AppBar(title: Text(mTitle)),
        drawer: getNavigationalDrawar(),
        body: getScreen(),
      ),
    );
  }

  Widget getAppbar(){
    return AppBar(
      backgroundColor: kPrimaryLightColor,
      centerTitle: true,
      title: const Text(
        'Kidzee',
        style:
        TextStyle(fontSize: 17, color: Colors.white, letterSpacing: 0.53),
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(20),
        ),
      ),
      leading: InkWell(
        onTap: () {
          _scaffoldKey.currentState?.openDrawer();
        },
        child: const Icon(
          Icons.subject,
          color: Colors.white,
        ),
      ),
      actions: [
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => UserNotification()));
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications,
              size: 20,
            ),
          ),
        ),
      ],
      bottom: PreferredSize(
          child: getAppBottomView(),
          preferredSize: Size.fromHeight(80.0)),
    );
  }

  Widget getAppBottomView() {
    return Container(
      padding: EdgeInsets.only(left: 30, bottom: 20),
      child: Row(
        children: [
          getProfileView(),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hubert Wong',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Colors.white),
                ),
                Text(
                  'hubert.wong@mail.com',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                Text(
                  '+1 1254 251 241',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }


  Widget getProfileView(){
    return Stack(
      children: [
        const CircleAvatar(
          radius: 32,
          backgroundColor: Colors.white,
          child: Icon(Icons.person_outline_rounded),
        ),
        Positioned(
            bottom: 1,
            right: 1,
            child: Container(
              height: 30,
              width: 30,
              decoration: const BoxDecoration(
                  color: Colors.amber,
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Icon(
                Icons.edit,
                color: kPrimaryLightColor,
                size: 20,
              ),
            )
        )
      ],
    );
  }

  @override
  Widget build2(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      // appBar: AppBar(
      //   title: KidzeeWidget().getAppBarUI(context),
      // ),
      appBar: AppBar(title: Text(mTitle)),
      drawer: getNavigationalDrawar(),
      body: getScreen(),
    );
  }

  void selectDestination(int index) {
    Navigator.of(context).pop();
    setState(() {
      _selectedDestination = index;
    });
  }

  Widget getNavigationalDrawar() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail: Text(mTitle),
            accountName: Text(mClassName),
            currentAccountPicture: CircleAvatar(
              radius: 50.0,
              backgroundColor: Color(0xFF778899),
              backgroundImage: NetworkImage(
                  "https://cdn.iconscout.com/icon/premium/png-64-thumb/student-353-789528.png"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Digital Learning',
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Home'),
            selected: _selectedDestination == 0,
            onTap: () => selectDestination(0),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('My Info'),
            selected: _selectedDestination == 1,
            onTap: () => selectDestination(1),
          ),
          ListTile(
            leading: Icon(Icons.favorite),
            title: Text('e-Campus'),
            selected: _selectedDestination == 2,
            onTap: () => selectDestination(2),
          )/*,
          ListTile(
            leading: Icon(Icons.delete),
            title: Text('Rhymes and AV\s'),
            selected: _selectedDestination == 3,
            onTap: () => selectDestination(3),
          ),
          ListTile(
            leading: Icon(Icons.label),
            title: Text('Events and Happening'),
            selected: _selectedDestination == 4,
            onTap: () => selectDestination(4),
          ),
          ListTile(
            leading: Icon(Icons.label),
            title: Text('Student Diary'),
            selected: _selectedDestination == 5,
            onTap: () => selectDestination(5),
          ),
          Divider(
            height: 1,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Online Class',
            ),
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Schedule Class'),
            selected: _selectedDestination == 6,
            onTap: () => selectDestination(6),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Social',
            ),
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Holiday List'),
            selected: _selectedDestination == 7,
            onTap: () => selectDestination(7),
          ),
          ListTile(
            leading: Icon(Icons.bookmark),
            title: Text('Socual Media'),
            selected: _selectedDestination == 8,
            onTap: () => selectDestination(8),
          )*/,ListTile(
            leading: new Image.asset('assets/icons/ic_logout.png'),
            title: Text('Log Out'),
            selected: _selectedDestination == 9,
            onTap: () => signOut(),
          ),
        ],
      ),
    );
  }

  Widget getHotelViewList() {
    final List<Widget> hotelListViews = <Widget>[];
    for (int i = 0; i < bannerList.length; i++) {
      final int count = bannerList.length;
      final Animation<double> animation =
      Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: animationController!,
          curve: Interval((1 / count) * i, 1.0, curve: Curves.fastOutSlowIn),
        ),
      );
      hotelListViews.add(
        ActivityPlannerView(
          callback: () {},
          hotelData: bannerList[i],
          animation: animation,
          animationController: animationController!,
        ),
      );
    }
    animationController?.forward();
    return Column(
      children: hotelListViews,
    );
  }

  Future<DocumentSnapshot> getActivityPlannerData() async {
    await Firebase.initializeApp();
    return await FirebaseFirestore.instance
        .collection(LocalConstant.FB_ACTIVITY_PLANNER)
        .doc()
        .get();
  }

  Widget getFilterBarUI() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: 24,
            decoration: BoxDecoration(
              color: KidzeeAppTheme.buildLightTheme().backgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    offset: const Offset(0, -2),
                    blurRadius: 8.0),
              ],
            ),
          ),
        ),
        Container(
          color: KidzeeAppTheme.buildLightTheme().backgroundColor,
          child: Padding(
            padding:
            const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'My Activity Planner',
                      style: TextStyle(
                        fontWeight: FontWeight.w100,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    focusColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    splashColor: Colors.grey.withOpacity(0.2),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    onTap: () {
                      /*FocusScope.of(context).requestFocus(FocusNode());
                      Navigator.push<dynamic>(
                        context,
                        MaterialPageRoute<dynamic>(
                            builder: (BuildContext context) => FiltersScreen(),
                            fullscreenDialog: true),
                      );*/
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Filter',
                            style: TextStyle(
                              fontWeight: FontWeight.w100,
                              fontSize: 16,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.sort,
                                color: KidzeeAppTheme.buildLightTheme()
                                    .primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Divider(
            height: 1,
          ),
        )
      ],
    );
  }

  // void showDemoDialog({BuildContext? context}) {
  //   showDialog<dynamic>(
  //     context: context!,
  //     builder: (BuildContext context) => CalendarPopupView(
  //       barrierDismissible: true,
  //       minimumDate: DateTime.now(),
  //       //  maximumDate: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 10),
  //       initialEndDate: endDate,
  //       initialStartDate: startDate,
  //       onApplyClick: (DateTime startData, DateTime endData) {
  //         setState(() {
  //           startDate = startData;
  //           endDate = endData;
  //         });
  //       },
  //       onCancelClick: () {},
  //     ),
  //   );
  // }

  @override
  Widget build12(BuildContext context) {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;
    return Theme(
        data: KidzeeAppTheme.buildLightTheme(),
        child: Container(
            child: Scaffold(
                appBar: HomeAppBarDesign("Kidzee"),
                drawer: getNavigationalDrawar(),
                body: getScreen())));
  }


  Widget getScreen() {
    switch (_selectedDestination) {
      case 0:
        return Container(
          color: KidzeeAppTheme.buildLightTheme().backgroundColor,
          child: ListView.builder(
            itemCount: bannerList.length,
            padding: const EdgeInsets.only(top: 8),
            scrollDirection: Axis.vertical,
            itemBuilder: (BuildContext context, int index) {
              final int count = bannerList.length > 10 ? 10 : bannerList.length;
              final Animation<double> animation =
              Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
                  parent: animationController!,
                  curve: Interval((1 / count) * index, 1.0,
                      curve: Curves.fastOutSlowIn)));
              animationController?.forward();
              return ActivityPlannerView(
                callback: () {},
                hotelData: bannerList[index],
                animation: animation,
                animationController: animationController!,
              );
            },
          ),
        );
       case 1:
         return MyInfoScreen();
      // case 1:
      //   return KltHomePage();
      case 2:
        return ECampusScreen();
      default:
        return AboutUs(name: '', title: '');
    }
  }


  Widget getSearchBarUI() {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: KidzeeAppTheme.buildLightTheme().backgroundColor,
                  borderRadius: const BorderRadius.all(
                    Radius.circular(38.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 8.0),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 16, right: 16, top: 4, bottom: 4),
                  child: TextField(
                    onChanged: (String txt) {},
                    style: const TextStyle(
                      fontSize: 18,
                    ),
                    cursorColor: KidzeeAppTheme.buildLightTheme().primaryColor,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'London...',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: KidzeeAppTheme.buildLightTheme().primaryColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(38.0),
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    color: Colors.grey.withOpacity(0.4),
                    offset: const Offset(0, 2),
                    blurRadius: 8.0),
              ],
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: const BorderRadius.all(
                  Radius.circular(32.0),
                ),
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                },
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Icon(FontAwesomeIcons.search,
                      size: 20,
                      color: KidzeeAppTheme.buildLightTheme().backgroundColor),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onBackClickListener() {
    if(_selectedDestination==0) {
      // set up the buttons
      Widget cancelButton = TextButton(
        child: Text("Cancel"),
        onPressed: () {},
      );
      Widget continueButton = TextButton(
        child: Text("Exit"),
        onPressed: () {
          Navigator.pop(context);
        },
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("AlertDialog"),
        content: Text("Would you like to Exit?"),
        actions: [
          cancelButton,
          continueButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }else{
      setState(() {
        _selectedDestination = 0;
      });
    }
  }

  signOut() async{
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();
    await Future.delayed(Duration(seconds: 2));

    Future.delayed(const Duration(milliseconds: 1000), () {
      SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    });
  }

  // Widget getTimeDateUI() {
  //   return Padding(
  //     padding: const EdgeInsets.only(left: 18, bottom: 16),
  //     child: Row(
  //       children: <Widget>[
  //         Expanded(
  //           child: Row(
  //             children: <Widget>[
  //               Material(
  //                 color: Colors.transparent,
  //                 child: InkWell(
  //                   focusColor: Colors.transparent,
  //                   highlightColor: Colors.transparent,
  //                   hoverColor: Colors.transparent,
  //                   splashColor: Colors.grey.withOpacity(0.2),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(4.0),
  //                   ),
  //                   onTap: () {
  //                     FocusScope.of(context).requestFocus(FocusNode());
  //                     // setState(() {
  //                     //   isDatePopupOpen = true;
  //                     // });
  //                     //showDemoDialog(context: context);
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(
  //                         left: 8, right: 8, top: 4, bottom: 4),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Text(
  //                           'Choose date',
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.w100,
  //                               fontSize: 16,
  //                               color: Colors.grey.withOpacity(0.8)),
  //                         ),
  //                         const SizedBox(
  //                           height: 8,
  //                         ),
  //                         Text(
  //                           '${DateFormat("dd, MMM").format(startDate)} - ${DateFormat("dd, MMM").format(endDate)}',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w100,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.only(right: 8),
  //           child: Container(
  //             width: 1,
  //             height: 42,
  //             color: Colors.grey.withOpacity(0.8),
  //           ),
  //         ),
  //         Expanded(
  //           child: Row(
  //             children: <Widget>[
  //               Material(
  //                 color: Colors.transparent,
  //                 child: InkWell(
  //                   focusColor: Colors.transparent,
  //                   highlightColor: Colors.transparent,
  //                   hoverColor: Colors.transparent,
  //                   splashColor: Colors.grey.withOpacity(0.2),
  //                   borderRadius: const BorderRadius.all(
  //                     Radius.circular(4.0),
  //                   ),
  //                   onTap: () {
  //                     FocusScope.of(context).requestFocus(FocusNode());
  //                   },
  //                   child: Padding(
  //                     padding: const EdgeInsets.only(
  //                         left: 8, right: 8, top: 4, bottom: 4),
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       crossAxisAlignment: CrossAxisAlignment.start,
  //                       children: <Widget>[
  //                         Text(
  //                           'Number of Rooms',
  //                           style: TextStyle(
  //                               fontWeight: FontWeight.w100,
  //                               fontSize: 16,
  //                               color: Colors.grey.withOpacity(0.8)),
  //                         ),
  //                         const SizedBox(
  //                           height: 8,
  //                         ),
  //                         Text(
  //                           '1 Room - 2 Adults',
  //                           style: TextStyle(
  //                             fontWeight: FontWeight.w100,
  //                             fontSize: 16,
  //                           ),
  //                         ),
  //                       ],
  //                     ),
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

class ContestTabHeader extends SliverPersistentHeaderDelegate {
  ContestTabHeader(
      this.searchUI,
      );
  final Widget searchUI;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return searchUI;
  }

  @override
  double get maxExtent => 52.0;

  @override
  double get minExtent => 52.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
