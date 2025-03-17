
import 'package:flutter/material.dart';


// ignore: camel_case_types
class Home_screen extends StatefulWidget{
  

   const Home_screen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}
 
     

class HomePageState extends State <Home_screen>{

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      
      //My background
      backgroundColor: Colors.white70,
     
     
          

      body: Column(
        children: [
          
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            // ignore: sized_box_for_whitespace
            child: Container(
            
              width: 350,
              height: 250,
              
                
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

           SizedBox(height: 20,),
            Center(
              child: SearchAnchor(
              builder: (BuildContext context, SearchController controller) {
                
                return Container(
                  height: 40,
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
          
        ],
       
      ),

    );
  }

}