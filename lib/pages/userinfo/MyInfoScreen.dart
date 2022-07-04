import 'package:ekidzee/helper/LocalConstant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyInfoScreen extends StatefulWidget{

  @override
  // ignore: library_private_types_in_public_api
  _MyInfo createState() => _MyInfo();

}

class _MyInfo extends State<MyInfoScreen>{

  String displayName='';
  String emailId='';
  String userType='';
  String mobileNumber='';

  loadUserData() async{
    final prefs = await SharedPreferences.getInstance();
    displayName = prefs.getString(LocalConstant.KEY_DISPLAY_NAME) as String;
    emailId = prefs.getString(LocalConstant.KEY_EMAILID) as String;
    mobileNumber = prefs.getString(LocalConstant.KEY_MOBILENO) as String;
    userType = prefs.getString(LocalConstant.KEY_USER_TYPE_NAME) as String;
    setState(() {});
  }

@override
  Widget build(BuildContext context) {
  loadUserData();
    return Scaffold(
      /*appBar: new AppBar(
        title: new Text(widget.title),
        actions: <Widget>[
          new IconButton(icon: const Icon(Icons.save), onPressed: () {})
        ],
      ),*/
      body: Column(
        children:  <Widget>[
          ListTile(
            leading: Icon(Icons.verified_user_sharp),
            title: Text(displayName),
            subtitle: const Text('Name'),
          ),
          ListTile(
            leading: const Icon(Icons.email),
            title: Text(emailId),
            subtitle: const Text('E-Mail'),
          ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: const Text('User Type'),
            subtitle: Text(userType),
          ),
          Divider(
            height: 1.0,
          ),
          // const ListTile(
          //   leading: Icon(Icons.label),
          //   title: Text('Nick'),
          //   subtitle: Text('None'),
          // ),
          // ListTile(
          //   leading: Icon(Icons.today),
          //   title: Text('Birthday'),
          //   subtitle: Text('February 20, 1980'),
          // ),
          // ListTile(
          //   leading: Icon(Icons.group),
          //   title: Text('Contact group'),
          //   subtitle: Text('Not specified'),
          // ),
          Center(
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Padding(
                      padding: new EdgeInsets.all(7.0),
                      child: Row(
                        children: <Widget>[
                          Padding(
                            padding: new EdgeInsets.all(7.0),
                            child: new Text('IllumeKit',style: new TextStyle(fontSize: 18.0),),
                          ),
                          Padding(
                            padding: new EdgeInsets.all(7.0),
                            child: new Icon(Icons.check),
                          ),
                          Padding(
                            padding: new EdgeInsets.all(7.0),
                            child: new Text('KG KIT',style: new TextStyle(fontSize: 18.0)),
                          ),
                          Padding(
                            padding: new EdgeInsets.all(7.0),
                            child: new Icon(Icons.check),
                          ),
                        ],
                      )
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}