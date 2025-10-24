import 'package:flutter/material.dart';

void main() {
  runApp(TravelGuideApp());
}

class TravelGuideApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Travel Guide',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue.shade700,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        scaffoldBackgroundColor: Colors.blue.shade50,
      ),
      home: MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ListScreen(),
    AboutScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Travel Guide'),
        centerTitle: true,
      ),
      body: SafeArea(child: _screens[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "Destinations"),
          BottomNavigationBarItem(icon: Icon(Icons.info_outline), label: "About"),
        ],
      ),
    );
  }
}

// ------------------------- HOME SCREEN -------------------------
class HomeScreen extends StatelessWidget {
  final TextEditingController destinationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
            height: 250,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            margin: EdgeInsets.all(12),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [BoxShadow(blurRadius: 4, color: Colors.grey.shade400)],
            ),
            child: Column(
              children: [
                Text(
                  'Welcome to Travel Guide App!',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                RichText(
                  text: TextSpan(
                    text: "Explore the ",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                    children: [
                      TextSpan(
                          text: "World",
                          style: TextStyle(
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold)),
                      TextSpan(text: " with "),
                      TextSpan(
                          text: "Us!",
                          style: TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold)),
                    ],
                  ),
                ),
                SizedBox(height: 15),
                TextField(
                  controller: destinationController,
                  decoration: InputDecoration(
                    labelText: "Enter Destination",
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                          "Searching for ${destinationController.text.isEmpty ? "Destinations" : destinationController.text}..."),
                    ));
                  },
                  child: Text("Search Destination"),
                ),
                TextButton(
                  onPressed: () {
                    print("Travel more, Explore more!");
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Keep exploring the world!")));
                  },
                  child: Text("Learn More"),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ------------------------- LIST SCREEN -------------------------
class ListScreen extends StatelessWidget {
  final List<Map<String, String>> destinations = [
    {'name': 'Paris', 'desc': 'City of lights and love.'},
    {'name': 'Tokyo', 'desc': 'A blend of tradition and technology.'},
    {'name': 'New York', 'desc': 'The city that never sleeps.'},
    {'name': 'Dubai', 'desc': 'Modern architecture and desert adventures.'},
    {'name': 'London', 'desc': 'Rich history and iconic landmarks.'},
    {'name': 'Istanbul', 'desc': 'Where east meets west.'},
    {'name': 'Bangkok', 'desc': 'Temples, street food, and nightlife.'},
    {'name': 'Bali', 'desc': 'Island paradise of Indonesia.'},
    {'name': 'Cairo', 'desc': 'Home of the Great Pyramids.'},
    {'name': 'Rome', 'desc': 'The Eternal City full of history.'},
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: destinations.length,
      itemBuilder: (context, index) {
        final destination = destinations[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: ListTile(
            leading: Icon(Icons.location_on, color: Colors.blueAccent),
            title: Text(destination['name']!),
            subtitle: Text(destination['desc']!),
          ),
        );
      },
    );
  }
}

// ------------------------- ABOUT SCREEN -------------------------
class AboutScreen extends StatelessWidget {
  final List<Map<String, String>> landmarks = [
    {'img': 'https://upload.wikimedia.org/wikipedia/commons/a/a8/Eiffel_Tower_in_Paris.jpg', 'name': 'Eiffel Tower'},
    {'img': 'https://upload.wikimedia.org/wikipedia/commons/9/9e/Taj_Mahal%2C_Agra%2C_India_edit3.jpg', 'name': 'Taj Mahal'},
    {'img': 'https://upload.wikimedia.org/wikipedia/commons/a/a1/Great_Wall_of_China_July_2006.JPG', 'name': 'Great Wall'},
    {'img': 'https://upload.wikimedia.org/wikipedia/commons/9/9c/Statue_of_Liberty_7.jpg', 'name': 'Statue of Liberty'},
    {'img': 'https://upload.wikimedia.org/wikipedia/commons/6/6e/Sydney_Opera_House%2C_2019.jpg', 'name': 'Sydney Opera House'},
    {'img': 'https://upload.wikimedia.org/wikipedia/commons/d/d6/Pyramids_of_Giza.jpg', 'name': 'Pyramids of Giza'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate:
        SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 10, mainAxisSpacing: 10),
        itemCount: landmarks.length,
        itemBuilder: (context, index) {
          final landmark = landmarks[index];
          return Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(landmark['img']!, fit: BoxFit.cover),
                ),
              ),
              SizedBox(height: 5),
              Text(landmark['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          );
        },
      ),
    );
  }
}
