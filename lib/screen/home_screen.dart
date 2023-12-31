// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:furnicraft/screen/Create%20Product/add_kursi.dart';
import 'package:furnicraft/screen/Create%20Product/add_lemari.dart';
import 'package:furnicraft/screen/Create%20Product/add_meja.dart';

import 'about.dart';
import 'furniture_list.dart';
import 'profile_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'profile_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:furnicraft/utils/Card/custom_card_meja.dart';
import 'package:furnicraft/utils/Card/custom_card_kursi.dart';
import 'package:furnicraft/utils/Card/custom_card_lemari.dart';

late User loggedinUser;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _auth = FirebaseAuth.instance;
  List<String> cardData = List.generate(1, (index) => 'Card $index');
  // List<String> hari = ['1','1','1','1','1','1','1',];

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
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference kursi = firestore.collection('kursi');
    CollectionReference meja = firestore.collection('meja');
    CollectionReference lemari = firestore.collection('lemari');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Text(
          "FURNICRAFT",
          style: GoogleFonts.bebasNeue(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/profile_image.png'),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Nama Pengguna',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    'email@example.com',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileApp()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.update),
              title: Text('History'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FurnitureHistoryPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('About'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Handle Logout onTap
              },
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.zero,
                    child: CarouselSlider(
                      options: CarouselOptions(
                        height: 200,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        enlargeCenterPage: true,
                      ),
                      items: [
                        'logo_furnicraft.png',
                        'carousel_1.png',
                        'carousel_1.png',
                        'carousel_1.png'
                        // ... add more image URLs as needed
                      ].map((item) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 5.0),
                              child: Image.asset(
                                item,
                                fit: BoxFit
                                    .cover, // Untuk menyesuaikan gambar ke dalam container
                                width: 1000.0,
                                // Sesuaikan ukuran gambar sesuai kebutuhan
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: TextField(
                      keyboardType: TextInputType.number,
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.grey),
                        hintText: 'Search',
                        contentPadding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 20.0),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xFF000000), width: 1.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.all(
                              Radius.circular(15.0),
                            )),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.search), onPressed: () {}),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Card(
                          child: ListTile(
                            title: Text('Kursi'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: ListTile(
                            title: Text('Meja'),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: ListTile(title: Text('Lemari')),
                        ),
                      ),
                      Expanded(
                        child: Card(
                          child: ListTile(title: Text('Lampu')),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text('Kursi'),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        StreamBuilder(
                          stream: kursi.snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              List<Widget> customCards = snapshot.data!.docs
                                  .map(
                                    (e) => CustomCardKursi(
                                      (e.data() as dynamic)['id_kursi'] ??
                                          'N/A',
                                      (e.data() as dynamic)['nama'] ?? 'N/A',
                                      (e.data() as dynamic)['jenis'] ?? 'N/A',
                                      (e.data() as dynamic)['stock'] ?? 'N/A',
                                      (e.data() as dynamic)['gambar'] ?? 'N/A',
                                      e.id,
                                    ),
                                  )
                                  .toList();

                              return Row(
                                children: customCards,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text('Loading');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text('Meja'),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        StreamBuilder(
                          stream: meja.snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              List<Widget> customCards = snapshot.data!.docs
                                  .map(
                                    (e) => CustomCardMeja(
                                      (e.data() as dynamic)['id_meja'] ?? 'N/A',
                                      (e.data() as dynamic)['nama'] ?? 'N/A',
                                      (e.data() as dynamic)['jenis'] ?? 'N/A',
                                      (e.data() as dynamic)['stock'] ?? 'N/A',
                                      (e.data() as dynamic)['gambar'] ?? 'N/A',
                                      e.id,
                                    ),
                                  )
                                  .toList();

                              return Row(
                                children: customCards,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text('Loading');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 40,
                  ),
                  Text('Lemari'),
                  SizedBox(
                    height: 15,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: <Widget>[
                        StreamBuilder(
                          stream: lemari.snapshots(),
                          builder: (_, snapshot) {
                            if (snapshot.hasData) {
                              List<Widget> customCards = snapshot.data!.docs
                                  .map(
                                    (e) => CustomCardLemari(
                                      (e.data() as dynamic)['id_lemari'] ??
                                          'N/A',
                                      (e.data() as dynamic)['nama'] ?? 'N/A',
                                      (e.data() as dynamic)['jenis'] ?? 'N/A',
                                      (e.data() as dynamic)['stock'] ?? 'N/A',
                                      (e.data() as dynamic)['gambar'] ?? 'N/A',
                                      e.id,
                                    ),
                                  )
                                  .toList();

                              return Row(
                                children: customCards,
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Text('Loading');
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: FloatingActionButton(
              onPressed: () {
                // Show bottom sheet with three options
                showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ListTile(
                          leading: Icon(Icons.add),
                          title: Text('Add Kursi'),
                          onTap: () {
                            // Handle Option 1
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddKursi(),
                                ));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.add),
                          title: Text('Add Meja'),
                          onTap: () {
                            // Handle Option 2
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddMeja(),
                                ));
                          },
                        ),
                        ListTile(
                          leading: Icon(Icons.add),
                          title: Text('Add Lemari'),
                          onTap: () {
                            // Handle Option 3
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => AddLemari(),
                                ));
                          },
                        ),
                      ],
                    );
                  },
                );
              },
              child: Icon(Icons.add),
              backgroundColor: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
// Padding(
              //   padding: EdgeInsets.all(20),
              //   child:
              //   // ListView.builder(
              //   //   itemCount: hari.length + 1,
              //   //   itemBuilder: (context, index){
              //   //     if (index == 0){
              //   //       return Card(
              //   //         margin: EdgeInsets.all(20),
              //   //         child: ListTile(
              //   //           title: Text('card'),
              //   //         ),

              //   //       );
              //   //     }
              //   //   }
              //   // )
              //   GridView.builder(
              //     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 4, // Jumlah item dalam satu baris
              //       crossAxisSpacing:
              //           8.0, // Spasi antara item secara horizontal
              //       mainAxisSpacing: 8.0, // Spasi antara item secara vertikal
              //     ),
              //     itemCount: cardData.length,
              //     itemBuilder: (BuildContext context, int index) {
              //       return Card(
              //         child: ListTile(
              //           title: Text(cardData[index]),
              //         ),
              //       );
              //     },
              //   ),
              // )