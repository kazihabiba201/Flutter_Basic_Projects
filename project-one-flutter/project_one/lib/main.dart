import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter App'),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/images/flutter.png',
                    width: 50,
                    height: 50,
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Kazi Habiba',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 16,
                child: Text(
                  '1',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text('Page 1'),
              onTap: () {
                _tabController.animateTo(0);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 16,
                child: Text(
                  '2',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text('Page 2'),
              onTap: () {
                _tabController.animateTo(1);
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const CircleAvatar(
                backgroundColor: Colors.blue,
                radius: 16,
                child: Text(
                  '3',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              title: const Text('Page 3'),
              onTap: () {
                _tabController.animateTo(2);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          Pages(
              1,
              Color.fromARGB(255, 54, 152, 244),
              Color.fromARGB(255, 245, 246, 247),
              Color.fromARGB(255, 15, 15, 15)),
          Pages(
              2,
              Color.fromARGB(255, 236, 205, 28),
              Color.fromARGB(255, 231, 96, 191),
              Color.fromARGB(255, 246, 246, 247)),
          Pages(
              3,
              Color.fromARGB(255, 231, 96, 191),
              Color.fromARGB(255, 236, 205, 28),
              Color.fromARGB(255, 255, 255, 255)),
        ],
      ),
      bottomNavigationBar: Material(
        color: Colors.blue,
        child: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(icon: Icon(Icons.looks_one), text: 'Tab 1'),
            Tab(icon: Icon(Icons.looks_two), text: 'Tab 2'),
            Tab(icon: Icon(Icons.looks_3), text: 'Tab 3'),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}

class Pages extends StatelessWidget {
  final int pageNumber;
  final Color buttonColor;
  final Color backgroundColor;
  final Color textColor;

  const Pages(
      this.pageNumber, this.buttonColor, this.backgroundColor, this.textColor,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: buttonColor,
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: Container(
        color: backgroundColor,
        child: Center(
          child: Text(
            'Page $pageNumber',
            style: TextStyle(
              fontSize: 24,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
