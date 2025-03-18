import 'package:flutter/material.dart';
import 'package:sweetclick/screens/manage_desserts/add_desserts.dart';
import 'package:sweetclick/screens/manage_desserts/delete_desserts.dart';
import 'package:sweetclick/screens/manage_desserts/edit_desserts.dart';


class ManageDesserts extends StatefulWidget {
  const ManageDesserts({super.key});

  @override
  State<ManageDesserts> createState() => _ManageDessertsState();
}

class _ManageDessertsState extends State<ManageDesserts> {
 
  int _selectedIndex = 0; //el indice que me controla la view

  // Lista de vistas
  final List<Widget> _views = [
     AddDesserts(),
     EditDesserts(),
     DeleteDesserts()
     // Vista para agregar postres
    // Vista para eliminar postres
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage Desserts",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.pink,
      ),
      body: _views[_selectedIndex], // Muestra la vista actual
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index; // Cambia la vista al seleccionar un ícono
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: "Add",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: "Edit",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.delete),
            label: "Delete",
          ),
        ],
      ),
    );
  }
}


