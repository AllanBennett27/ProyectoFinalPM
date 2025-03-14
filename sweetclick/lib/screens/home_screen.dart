

import 'package:flutter/material.dart';
import 'package:sweetclick/Services/crud.dart';


// ignore: camel_case_types
class Home_screen extends StatefulWidget{
  

   const Home_screen({super.key});

  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }

}
 
     

class HomePageState extends State <Home_screen>{
  final CRUDBakery _crudBakery = CRUDBakery();

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
            
              width: 300,
              height: 200,
            
                
                child: Stack(
                children: [
                    Image.network("https://media.tenor.com/CgRQNtNwE-oAAAAM/desserts-food.gif",
                                   fit: BoxFit.cover,
                                   width: double.infinity, 
                                  height: double.infinity,
                                  repeat: ImageRepeat.repeat,
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


           FutureBuilder(
            future: _crudBakery.getDesserts(),
            builder: (context, snapshot) {
              if(snapshot.connectionState == ConnectionState.waiting){
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if(!snapshot.hasData){
                return const Text("No data here");
              }
              return Expanded( 
              child: GridView.builder( 
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 10, 
                    mainAxisSpacing: 10, 
                    childAspectRatio: 1, 
                      ),
                      itemCount:snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var dessert = snapshot.data![index];
                        return SizedBox(
                           width: 50, 
                           height: 150,
                          child: Card( 
                            shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                            margin: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                            elevation: 10,
                            child: Column(
                              children: [
                              Image.network(
                              dessert['imageUrl'], 
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            ),
                            ListTile(
                              title: Text(dessert['name']), 
                              subtitle: Text(
                                  '${dessert['description']}\n\$${dessert['price']}'), 
                             ),
                              ],
                            ), 
                          ),
                        ); 
                      }, 
                    ), 
                  
                       );
            },
           ), 
                   
        ],
       
      ),

    );
  }

}