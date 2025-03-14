import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetclick/screens/add_desserts.dart';
import 'package:sweetclick/screens/home_screen.dart';
import 'package:sweetclick/screens/shopcart_screen.dart';
import 'package:sweetclick/screens/user_screen.dart';

class InitialScreen extends StatefulWidget {
  
  final String initialValue;

  const InitialScreen({super.key, required this.initialValue});


  @override
  State<InitialScreen> createState() => _InitialScreenState();
}

    class _InitialScreenState extends State<InitialScreen> {
      late String username;

      int _selectedIndex = 0;

    final List<Widget> _screens = [
       Home_screen(),
       ShopcartScreen(),
        UserScreen()
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
        print("initial state ${widget.initialValue}");
      }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      
      
      
      //My background
      backgroundColor: Colors.white70,
      appBar: AppBar(
      
        title:  Center(
          child: Text
                  ("Hello, $username",
                   
                  style: TextStyle(color: Colors.black)
                  ),
        
          
        ),
        backgroundColor: Colors.white70,
        
        leading: Builder(
          
          builder: (context){
            return Container(
                margin: EdgeInsets.all(8), 
                decoration: BoxDecoration(
                color: Colors.pink, 
                borderRadius: BorderRadius.circular(8),

                
                ),
                child: IconButton(
                  onPressed: (){
                    Scaffold.of(context).openDrawer();
                  },
                 icon: Icon(Icons.menu, color: Colors.white)
                 )
                
                   
            );
            
          },
        ),
        

      ),
      
      drawer: Drawer(
        
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              
              decoration: BoxDecoration(
                color: Colors.pink,
              
                ),
              child: Text('Menu',
              style: TextStyle(
                       color: Colors.white,
                       fontWeight: FontWeight.bold,
                       )
                       
              ),
              
              
            ),
               ListTile(
                leading: Icon(Icons.home, color: Colors.pink),
                title: Text('Home'),                
                onTap: () {
                 
                  _onItemTapped(0);
                    Navigator.of(context).pop();
                 
                },
              ),
               ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.pink),
                title: Text('shopping_cart'),
                onTap: () {
                  _onItemTapped(1);
                   Navigator.of(context).pop();
                
               
                },
              ),
              ListTile(
                leading: Icon(Icons.person, color: Colors.pink),
                title: Text('User'),
                onTap: () {
                  _onItemTapped(2);
                   Navigator.of(context).pop();
                
               
                },
              ),
              ListTile(
                leading: Icon(Icons.logout_outlined, color: Colors.pink),
                title: Text('Logout'),
                onTap: () {
                  FirebaseAuth.instance.signOut();
                   Navigator.of(context).pop();
                
               
                },
              ),
               ListTile(
                leading: Icon(Icons.add, color: Colors.pink),
                title: Text('Add a new dessert'),
                onTap: () {
                   Navigator.push(context,MaterialPageRoute(builder: (_)=>AddDesserts()));
                   
                
               
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
        color: Colors.pink, 
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
              icon: Icon(Icons.person ),
            
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