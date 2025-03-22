import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetclick/pantalla_exito.dart';
import 'package:sweetclick/services/crud.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  final CRUDBakery _crudBakery = CRUDBakery();
  final TextEditingController numerotarjetacontroller = TextEditingController();
  final TextEditingController fechavencimientocontroller =
      TextEditingController();
  final TextEditingController cvvcontroller = TextEditingController();

  void resetForm(bool value) {
    numerotarjetacontroller.clear();
    fechavencimientocontroller.clear();
    cvvcontroller.clear();
  }

  final _formKey = GlobalKey<FormState>();

  //methods for validating the fields

  bool validateForm(GlobalKey<FormState> _formKey) {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmar Pedido'),
        backgroundColor: Color.fromRGBO(191, 82, 105, 1),
      ),
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _crudBakery.getCart(user),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return const Center(
              child: Text("Tu carrito está vacío"),
            );
          }

          final cartData = snapshot.data!.data();
          if (cartData == null) {
            return const Center(
              child: Text("Error al cargar el carrito"),
            );
          }

          final List<dynamic> items = cartData["items"] ?? [];
          final double totalCarrito = cartData["total"] ?? 0.0;
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index] as Map<String, dynamic>?;
                    if (item == null) {
                      return const Center(
                          child: Text("Producto no disponible"));
                    }

                    final name =
                        item["name"] as String? ?? "Nombre no disponible";
                    final price = item["price"] as double? ?? 0.0;
                    final imageUrl = item["imageUrl"] as String?;
                    final quantity = item["quantity"] as int? ?? 0;
                    //final dessertId = item["dessertId"] as String?;

                    final totalPorProducto = quantity * price;

                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      margin: const EdgeInsets.symmetric(
                          vertical: 4, horizontal: 4),
                      elevation: 10,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          if (imageUrl != null)
                            Image.network(
                              imageUrl,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          else
                            const Icon(Icons.image, size: 100),
                          ListTile(
                            title: Text(name),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Cantidad: $quantity'),
                                Text(
                                    'Precio unitario: Lps.${price.toStringAsFixed(2)}'),
                                Text(
                                    'Total: Lps.${totalPorProducto.toStringAsFixed(2)}'),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    //Total del carrito de compras
                    Text(
                      'Total del carrito: Lps.${totalCarrito.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    //Formulario
                    SizedBox(height: 10),
                    Form(
                      key: _formKey, //identificador del formulario
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Tarjeta de crédito o débito',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: numerotarjetacontroller,
                              decoration: InputDecoration(
                                labelText: "Número de Tarjeta",
                                hintText: "Número de Tarjeta",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Ingrese el Número de Tarjeta";
                                } else {
                                  return null;
                                }
                              },
                              maxLines: 1,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: fechavencimientocontroller,
                              decoration: InputDecoration(
                                labelText: "Fecha de Vencimiento",
                                hintText: "Fecha de Vencimiento",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Ingrese la Fecha de Vencimiento";
                                } else {
                                  return null;
                                }
                              },
                              maxLines: 1,
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              controller: cvvcontroller,
                              decoration: InputDecoration(
                                labelText: "CVV",
                                hintText: "CVV",
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Ingrese el CVV";
                                } else {
                                  return null;
                                }
                              },
                              maxLines: 1,
                            ),
                            //Boton de realizar pago
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                {
                                  if (validateForm(_formKey)) {
                                    CRUDBakery().UploadPayment(
                                        total: totalCarrito.toString(),
                                        numerotarjeta:
                                            numerotarjetacontroller.text.trim(),
                                        fechavencimiento:
                                            fechavencimientocontroller.text
                                                .trim(),
                                        cvv: cvvcontroller.text.trim());
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SuccessScreen()),
                                    );
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'Pago simulado realizado con éxito.')),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Color.fromRGBO(191, 82, 105, 1),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 15),
                              ),
                              child: Text('Confirmar',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black)),
                            ),
                          ]),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
