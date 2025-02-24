
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
                            backgroundColor: Color.fromARGB(255, 156, 3, 75).withValues(alpha: 0.5),
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

          Container(
            
            height: 100,
             margin: EdgeInsets.symmetric(horizontal: 16.0),
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20), 
                          color: const Color.fromARGB(255, 156, 3, 75)),
           
           

          ),
        ],


      ),

   
    )
    );
  }

}