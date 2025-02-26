
import 'package:flutter/material.dart';

// ignore: camel_case_types
class Home_screen extends StatefulWidget{
   final String initialValue;

   const Home_screen({super.key, required this.initialValue});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}
 
     

class HomePageState extends State <Home_screen>{
late String username;
//  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    username = widget.initialValue;
    print("initial state ${widget.initialValue}");
  }
  @override
  Widget build(BuildContext context) {
    

    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
       home: Scaffold(
      
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
            )
          ],
        ),
      ),
          

      body: Column(
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // ignore: sized_box_for_whitespace
            child: Container(
            
              width: 300,
              height: 200,
            
                
                child: Stack(
                children: [
                    Image.network("https://media.tenor.com/CgRQNtNwE-oAAAAM/desserts-food.gif",
                                   fit: BoxFit.cover,
                                   width: double.infinity, 
                                  height: double.infinity,
                                ),
                   
                    Center(
                      child: Text(
                        "¿Que se antoja hoy?",
                        style: TextStyle(
                            backgroundColor: Colors.pink.withValues(alpha: 0.5),
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            )
                        ,)
                        ,),
                ]
                )
               
              
               
            ),
          ),

           Expanded(
            child: Center(
              child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                
                return Container(
                  height: 42,
                   padding: EdgeInsets.symmetric(horizontal: 32.0),
            
                  child: SearchBar(
                  
                    controller: controller,
                   
                    onTap: () {
                      controller.openView();
                    },
                    onChanged: (_) {
                      controller.openView();
                    },
                    leading: const Icon(Icons.search),
                   
                  ),
                );
              },
              suggestionsBuilder: (BuildContext context, SearchController controller) {
                 final List<String> items = [
                      'Pasteles',
                      'Tartas',
                      'Galletas',
                      'Helados',
                      'Dulces de temporada'
                    ];
            
                return List<ListTile>.generate(items.length, (int index) {
                  final String item = items[index];
                  return ListTile(
                    title: Text(item),
                    onTap: () {
                      setState(() {
                        controller.closeView(item);
                      });
                    },
                  );
                });
              },
            ),
            ),
          ),
        ],
       
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
          currentIndex: 1,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
        ),
      ),
    ),
    )
    );
  }

}