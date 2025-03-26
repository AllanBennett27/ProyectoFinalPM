import 'package:flutter/material.dart';
import 'package:sweetclick/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DeleteDesserts extends StatefulWidget {
  const DeleteDesserts({super.key});

  @override
  State<DeleteDesserts> createState() => _DeleteDessertsState();
}

class _DeleteDessertsState extends State<DeleteDesserts> {
  final CRUDBakery _crudBakery = CRUDBakery();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     body: 
          Column(
            children: [
              StreamBuilder<List<QueryDocumentSnapshot<Map<String, dynamic>>>>(
                stream: _crudBakery.getDesserts(), 
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No data here"),
                    );
                  }
              
                 
                 return Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(8),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.7, 
                    ),
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var dessert = snapshot.data![index].data();
                      
                      return Card(
                        clipBehavior: Clip.antiAlias, 
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Imagen
                            Expanded(
                              flex: 3, 
                              child: Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage(dessert['imageUrl']),
                                    fit: BoxFit.cover,
                                    onError: (exception, stackTrace) => Icon(Icons.broken_image),
                                  ),
                                ),
                              ),
                            ),
                            
                            // Texto
                            Expanded(
                              flex: 2, 
                              child: Padding(
                                padding: EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      dessert['name'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      dessert['type'],
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Lps. ${dessert['price']}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green[700],
                                          ),
                                        ),
                                        SizedBox(height: 10,),
                                         
                                          TextButton(
                                          onPressed: () {
                                            CRUDBakery().deleteDessert(snapshot.data![index].id);
                                          },
                                          child: const Icon(Icons.delete),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
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



