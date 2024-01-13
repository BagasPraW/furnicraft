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
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            color: Colors.white,
            onPressed: () {
              showSearch(
                context: context,
                delegate: FurnitureSearchDelegate(),
              );
            },
          )
        ],
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
                        'carousel_1.png',
                        'carousel_2.png',
                        'carousel_3.png',
                        'carousel_4.png',
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
                  SizedBox(height: 20),
                  Divider(),
                  const SizedBox(height: 20),
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
              child: Column(
                children: [
                  FloatingActionButton(
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
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.black,
                  ),
                  SizedBox(height: 10),
                  FloatingActionButton(
                    onPressed: () {
                      Navigator.pushNamed(context, 'add_history_csv');
                    },
                    child: Icon(
                      Icons.list,
                      color: Colors.white,
                    ),
                    backgroundColor: Colors.black,
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

class FurnitureSearchDelegate extends SearchDelegate<String> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final CollectionReference kursiCollection =
      FirebaseFirestore.instance.collection('kursi');
  final CollectionReference mejaCollection =
      FirebaseFirestore.instance.collection('meja');
  final CollectionReference lemariCollection =
      FirebaseFirestore.instance.collection('lemari');

  @override
  String get searchFieldLabel => 'Search Furniture';

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: searchInCollections(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.data?.isEmpty ?? true) {
          return Center(child: Text('No results found'));
        }

        return ListView(
          children: snapshot.data?.map<Widget>((result) {
                // Ensure result is a QueryDocumentSnapshot
                if (result is QueryDocumentSnapshot) {
                  return GestureDetector(
                    onTap: () {
                      // Handle item tap
                      // For example, fill the search query with the selected suggestion
                      showResults(context);
                    },
                    child: ListTile(
                      title: Text(result['nama'] ?? 'N/A'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jenis: ${result['jenis'] ?? 'N/A'}'),
                          Text('Stock: ${result['stock'] ?? 'N/A'}'),
                        ],
                      ),
                      leading: Image.asset(
                        result['gambar'] ??
                            'assets/placeholder.png', // Replace with your placeholder image path
                        width: 50, // Set your preferred width
                        height: 50, // Set your preferred height
                      ),
                      // Add more details as needed
                    ),
                  );
                } else {
                  return SizedBox
                      .shrink(); // Return an empty widget if the type is unexpected
                }
              })?.toList() ??
              [], // Use the null-aware operator to handle potential null values
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return FutureBuilder(
      future: searchInCollections(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.data?.isEmpty ?? true) {
          return Center(child: Text('No results found'));
        }

        return ListView(
          children: snapshot.data?.map<Widget>((result) {
                // Ensure result is a Map<String, dynamic>
                if (result is Map<String, dynamic>) {
                  return GestureDetector(
                    onTap: () {
                      // Handle item tap
                      // For example, fill the search query with the selected suggestion
                      showResults(context);
                    },
                    child: ListTile(
                      title: Text(result['nama'] ?? 'N/A'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Jenis: ${result['jenis'] ?? 'N/A'}'),
                          Text('Stock: ${result['stock'] ?? 'N/A'}'),
                        ],
                      ),
                      leading: Image.asset(
                        result['gambar'] ??
                            'assets/placeholder.png', // Replace with your placeholder image path
                        width: 50, // Set your preferred width
                        height: 50, // Set your preferred height
                      ),
                      // Add more details as needed
                    ),
                  );
                } else {
                  return SizedBox
                      .shrink(); // Return an empty widget if the type is unexpected
                }
              })?.toList() ??
              [], // Use the null-aware operator to handle potential null values
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> searchInCollections() async {
    // Search in all three collections and combine the results
    final kursiResults = await kursiCollection
        .where('nama', isGreaterThanOrEqualTo: query)
        .where('nama', isLessThan: query + 'z')
        .get();

    final mejaResults = await mejaCollection
        .where('nama', isGreaterThanOrEqualTo: query)
        .where('nama', isLessThan: query + 'z')
        .get();

    final lemariResults = await lemariCollection
        .where('nama', isGreaterThanOrEqualTo: query)
        .where('nama', isLessThan: query + 'z')
        .get();

    // Combine the results from all three collections
    final List<Map<String, dynamic>> combinedResults = [
      ...kursiResults.docs.map((e) => e.data() as Map<String, dynamic>),
      ...mejaResults.docs.map((e) => e.data() as Map<String, dynamic>),
      ...lemariResults.docs.map((e) => e.data() as Map<String, dynamic>),
    ];

    return combinedResults;
  }
}
