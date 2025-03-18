import 'package:flutter/material.dart';
import 'package:sweetclick/services/crud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditDesserts extends StatefulWidget {
  const EditDesserts({super.key});

  @override
  State<EditDesserts> createState() => _EditDessertsState();
}

class _EditDessertsState extends State<EditDesserts> {
   final CRUDBakery _crudBakery = CRUDBakery();

   final TextEditingController descriptioncontroller = TextEditingController();
  final TextEditingController imageUrlcontroller = TextEditingController();
  final TextEditingController namecontroller = TextEditingController();
  final TextEditingController pricecontroller = TextEditingController();
   final TextEditingController typecontroller = TextEditingController();

       String? _postreSeleccionado;

   List<String> tiposDePostres = [
   'Tortas',
  'Postres fríos',
  'Postres calientes',
  'Galletas y brownies',
  'Helados',
  'Otros',
];

 

    void openDessertEditBox({String? docID, String?  description, String? imageUrl, String? name, String? price, String? type }) {
    descriptioncontroller.text = description ?? '';
    imageUrlcontroller.text = imageUrl ?? '';
    namecontroller.text = name ?? '';
    pricecontroller.text = price ?? '';
    typecontroller.text = type ?? '';
    _postreSeleccionado = type;

    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                 
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: descriptioncontroller,
                          decoration: const InputDecoration(
                            labelText: 'descripcion',
                          ),
                          maxLines: null,
                        ),
                      ),
                      
                    ],
                    
                  ),
                   TextField(
                    controller: imageUrlcontroller,
                    decoration: const InputDecoration(
                      labelText: 'ImageUrl',
                      
                    ),
                   ),
                   TextField(
                    controller: namecontroller,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                    ),
                   ),
                   TextField(
                    controller: pricecontroller,
                    decoration: const InputDecoration(
                      labelText: 'Price',
                    ),
                   ),
                    DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: "Select your type of dessert",

                ),
                value: _postreSeleccionado,
                items: tiposDePostres.map((String postres){
                  return DropdownMenuItem(
                    value: postres,
                    child: Text(postres),
                  
                  );
                }).toList(),
                onChanged: (String? newValue){
                  setState(() {
                    _postreSeleccionado = newValue;
                  });
                  typecontroller.text = newValue ?? '';
                },
                validator: (value){
                  if(value == null || value.isEmpty){
                    return "Please select a type of dessert";
                  }
                  return null;
                },
                ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    if (descriptioncontroller.text.isNotEmpty &&
                        imageUrlcontroller.text.isNotEmpty && 
                        namecontroller.text.isNotEmpty &&
                        pricecontroller.text.isNotEmpty &&
                        typecontroller.text.isNotEmpty) {
                          if(docID != null){
                       _crudBakery.updateDessert(
                            docID,
                            descriptioncontroller.text,
                             imageUrlcontroller.text,
                             namecontroller.text,
                             double.tryParse(pricecontroller.text) ?? 0.0,
                             typecontroller.text);
                          }

                           descriptioncontroller.clear();
                            imageUrlcontroller.clear();
                            namecontroller.clear();
                            pricecontroller.clear();
                            typecontroller.clear();
                            Navigator.pop(context);
                    } else {
                      
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Por favor, llena todos los campos'),
                          duration: Duration(seconds: 2), // Duración del mensaje
                        ),
                      );
                    }
                    
                    //mensaje de que se guardo
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Postre actualizado'),
                          duration: Duration(seconds: 2), // Duración del mensaje
                        ),
                      );
                  

                    
                  },
                  
                  child: const Text("Guardar"),
                  
                )
              ],
            ));
  }

  
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
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        childAspectRatio: 1,
                      ),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var dessert = snapshot.data![index].data();
                         String docID = snapshot.data![index].id;
              
                        return SizedBox(
                          width: 50,
                          height: 150,
                            child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
                              elevation: 10,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                      '${dessert['type']}\n Lps.${dessert['price']}',
                                    ),
                                  ),
                                  
                                  
                                        TextButton(
                                          onPressed: () {
                                            openDessertEditBox(
                                            docID: docID, // Pass the document ID
                                            description: dessert['description'],
                                            imageUrl: dessert['imageUrl'],
                                            name: dessert['name'],
                                            price: dessert['price'].toString(),
                                            type: dessert['type'],
                                            );
                                          },
                                          child: const Icon(Icons.edit),
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

