import 'package:flutter/material.dart';
import 'package:sweetclick/pantalla_exito.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirmar Pedido'),
        backgroundColor: Color.fromRGBO(191, 82, 105, 1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Resumen de compra',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: Image.asset('assets/cheesecake.png', width: 50),
                title: Text('Raspberry Cheesecake'),
                subtitle: Text('L140.00'),
                trailing: Icon(Icons.delete, color: Colors.red),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Tarjeta de crédito o débito',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Número de tarjeta', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'Vence el MM/AA', border: OutlineInputBorder()),
              keyboardType: TextInputType.datetime,
            ),
            SizedBox(height: 10),
            TextField(
              decoration: InputDecoration(labelText: 'CVV', border: OutlineInputBorder()),
              keyboardType: TextInputType.number,
              obscureText: true,
            ),
            SizedBox(height: 20),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      {
                        Navigator.push(context,
                        MaterialPageRoute(builder: (context) => SuccessScreen()),
                         );
                         }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Pago simulado realizado con éxito.')),
                        
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(191, 82, 105, 1),
                      padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),

                    ),
                    child: Text('Confirmar', style: TextStyle(fontSize: 16, color: Colors.black)),
                  ),
                  SizedBox(height: 10), // Espaciado entre botones
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancelar', style: TextStyle(fontSize: 14, color: Colors.black)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
