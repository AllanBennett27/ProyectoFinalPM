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
                      String docID = snapshot.data![index].id;
                      
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
                                        
                                        IconButton(
                                          icon: Icon(Icons.edit, size: 20),
                                          onPressed: () => openDessertEditBox(
                                            docID: docID,
                                            description: dessert['description'],
                                            imageUrl: dessert['imageUrl'],
                                            name: dessert['name'],
                                            price: dessert['price'].toString(),
                                            type: dessert['type'],
                                          ),
                                          padding: EdgeInsets.zero,
                                          constraints: BoxConstraints(),
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

