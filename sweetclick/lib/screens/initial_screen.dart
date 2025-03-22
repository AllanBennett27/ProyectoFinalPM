import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetclick/authentication/login.dart';
import 'package:sweetclick/screens/manage_desserts/manage_desserts.dart';
import 'package:sweetclick/screens/home_screen.dart';
import 'package:sweetclick/screens/shopcart_screen.dart';
import 'package:sweetclick/screens/user_screen.dart';

class InitialScreen extends StatefulWidget {
  final String initialValue;
  final String PfpValue;

  const InitialScreen(
      {super.key, required this.initialValue, required this.PfpValue});

  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

class _InitialScreenState extends State<InitialScreen> {
  final user = FirebaseAuth.instance.currentUser!.uid;
  late String username;
  late String pfpUrl;

  int _selectedIndex = 0;

  final List<Widget> _screens = [
    Home_screen(),
    ShopcartScreen(),
    UserScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    username = widget.initialValue;
    pfpUrl = widget.PfpValue;
    print("initial state ${widget.initialValue}");
    print("pfpUrl en InitialScreen: $pfpUrl");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //My background
      backgroundColor: Colors.white70,
      appBar: AppBar(
        title: Center(
          child:
              Text("Hello, $username", style: TextStyle(color: Colors.black)),
        ),
        backgroundColor: Colors.white70,
        leading: Builder(
          builder: (context) {
            return Container(
                margin: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(191, 82, 105, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                    onPressed: () {
                      Scaffold.of(context).openDrawer();
                    },
                    icon: Icon(Icons.menu, color: Colors.white)));
          },
        ),
      ),

      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromRGBO(191, 82, 105, 1),
              ),
              child: Column(
                children: [
                  ClipOval(
                    child: Image.network(
                      pfpUrl,
                      width: 100,
                      height: 100,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error);
                      },
                    ),
                  ),
                  Text(username,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home, color: Color.fromRGBO(191, 82, 105, 1)),
              title: Text('Home'),
              onTap: () {
                _onItemTapped(0);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart,
                  color: Color.fromRGBO(191, 82, 105, 1)),
              title: Text('Shopping Cart'),
              onTap: () {
                _onItemTapped(1);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading:
                  Icon(Icons.person, color: Color.fromRGBO(191, 82, 105, 1)),
              title: Text('User'),
              onTap: () {
                _onItemTapped(2);
                Navigator.of(context).pop();
              },
            ),
            ListTile(
              leading: Icon(Icons.logout_outlined,
                  color: Color.fromRGBO(191, 82, 105, 1)),
              title: Text('Logout'),
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            ),
            if (user == "5gHtW0ewpjWc3sKPKLrNdNGWfwl1" ||
                user == "OKcD1keUMcX6bwNvsepZ7JzTIu72")
              ListTile(
                leading: Icon(Icons.control_point,
                    color: Color.fromRGBO(191, 82, 105, 1)),
                title: Text('Manage desserts'),
                onTap: () {
                  Navigator.of(context).push(
                    //animation
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ManageDesserts(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = Offset(0.0, 1.0);
                        const end = Offset.zero;
                        const curve = Curves.ease;
                        var tween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var offsetAnimation = animation.drive(tween);

                        return SlideTransition(
                          position: offsetAnimation,
                          child: ManageDesserts(),
                        );
                      },
                    ),
                  );
                },
              ),
          ],
        ),
      ),

      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),

      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: Color.fromRGBO(191, 82, 105, 1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.transparent,
            iconSize: 30,
            selectedFontSize: 16,
            unselectedFontSize: 12,
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.shopping_cart),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'User',
              ),
            ],
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
