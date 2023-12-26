import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
// import 'package:latihan_firebase/page/data_mhs_page.dart';
import '../utils/rounded_button.dart';
// import 'package:latihan_firebase/page/upload_page.dart';

late User loggedinUser;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  void initState() {
    super.initState();
    getCurrentUser();
  }

  //using this function you can use the credentials of the user
  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser;
      if (user != null) {
        loggedinUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              color: Colors.white,
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                _auth.signOut();
                Navigator.pop(context, 'login_page');
              },
              child: const Icon(
                Icons.power_settings_new,
                size: 26.0,
              ),
            ),
          ),
        ],
        title: Text('Home Page'),
        backgroundColor: Color(0xFF171a21),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF1b2838),
              ),
              child: Text(
                'Drawer Steam',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Data Mahasiswa'),
              // onTap: () {
              //   Navigator.push(
              //       context,
              //       MaterialPageRoute(
              // builder: (context) => DataMhs(),
              //       ));
              // },
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF1b2838),
      body: Center(
          child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Welcome Mahasiswa",
              style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFc7d5e0)),
            ),
            RoundedButton(
                colour: Colors.greenAccent,
                title: 'Data Mahasiswa',
                onPressed: () {
                  Navigator.pushNamed(context, 'data_mhs');
                }),
            RoundedButton(
                colour: Colors.greenAccent,
                title: 'Data Nilai',
                onPressed: () {
                  Navigator.pushNamed(context, 'nilai_mhs');
                }),
            RoundedButton(
                colour: Colors.greenAccent,
                title: 'Storage',
                onPressed: () {
                  Navigator.pushNamed(context, 'file_storage');
                }),
          ],
        ),
      )),
    );
  }
}
