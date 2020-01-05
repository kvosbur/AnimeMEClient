import 'package:anime_me/Controllers/LoginController.dart';
import 'package:anime_me/Controllers/RegistrationController.dart';
import 'package:anime_me/Screens/Login.dart';
import 'package:anime_me/Screens/Registration.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.deepPurple,
        backgroundColor: Colors.deepPurple,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(controller: LoginController(),),
        '/registration': (context) => RegistrationPage(controller: RegistrationController(),),
        '/main': (context) => MyHomePage(title: "Title",),
      },
    );
  }
}

abstract class MainPageWidget extends StatefulWidget {

  String title = "Title";

  List<Widget> appbarActions(context){
    return [];
  }


  bool showAppBar(){
    return true;
  }

}

class FillerWidget extends StatelessWidget {
  final Color color;

  FillerWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}

class FillerFeedWidget extends MainPageWidget {

  Color color;
  String title;
  FillerFeedWidget({this.color, this.title});

  @override
  _FillerFeedWidgetState createState() => _FillerFeedWidgetState();
}

class _FillerFeedWidgetState extends State<FillerFeedWidget> {

  @override
  Widget build(BuildContext context) {
    return FillerWidget(widget.color);
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  List<MainPageWidget> _children = [FillerFeedWidget(color: Colors.deepPurple, title: "Discover",),
    FillerFeedWidget(color: Colors.deepPurple, title: "Playlist",),
    FillerFeedWidget(color: Colors.deepPurple, title: "Playing",),
    FillerFeedWidget(color: Colors.deepPurple, title: "Profile",)];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: new Text(_children[_currentIndex].title, style: TextStyle(color: Colors.black)),
        actions: _children[_currentIndex].appbarActions(context),
      ),
      body: Center(
        child: _children[_currentIndex],
      ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: onTabTapped,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.search, color: Colors.white,),
              title: new Text('Discover', style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.music_note, color: Colors.white,),
              title: new Text('Playlist', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.play_arrow, color: Colors.white,),
              title: new Text('Playing', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black,
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.person, color: Colors.white,),
              title: new Text('Profile', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black,
            ),
          ],
        )
    );
  }
}
