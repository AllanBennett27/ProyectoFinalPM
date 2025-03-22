import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sweetclick/services/crud.dart';

class MyPostresPersonalizados extends StatefulWidget {
  final String dessertId;
  final String imageURL;
  final String name;
  const MyPostresPersonalizados(
      {super.key,
      required this.dessertId,
      required this.imageURL,
      required this.name});

  @override
  State<MyPostresPersonalizados> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyPostresPersonalizados> {
  late String DessertId;
  late String ImageURL;
  late String Name;
  final user = FirebaseAuth.instance.currentUser!.uid;
  final TextEditingController coberturacontroller =
      TextEditingController(); // DDL
  final TextEditingController cantidadpersonascontroller =
      TextEditingController(); // DDL
  final TextEditingController mensajecontroller =
      TextEditingController(); // Text
  final TextEditingController rellenocontroller =
      TextEditingController(); // DDL
  final TextEditingController sabortortacontroller =
      TextEditingController(); // DDL
  final TextEditingController comentarioadicionalcontroller =
      TextEditingController(); // Text

  String? _cobertura;
  String? _relleno;
  String? _cantidadpersonas;
  String? _sabortorta;
  List<String> tiposcoberturas = [
    'ButterCream Americano',
    'Merengue Italiano',
    'Ganache',
  ];

  List<String> tiposrelleno = [
    'Dulce de Leche',
    'Mermelada de Piña',
    'Nutella',
  ];
  List<String> cantidadpersonas = [
    '4 - 8',
    '12 - 15',
    '20 - 25',
  ];
  List<String> tiposabortorta = [
    'Chocolate',
    'Vainilla',
    'Fresa',
  ];
  final _formKey = GlobalKey<FormState>();

  //methods for validating the fields

  bool validateForm(GlobalKey<FormState> _formKey) {
    if (_formKey.currentState!.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void resetForm(bool value) {
    coberturacontroller.clear();
    cantidadpersonascontroller.clear();
    mensajecontroller.clear();
    rellenocontroller.clear();
    sabortortacontroller.clear();
    comentarioadicionalcontroller.clear();
  }

  @override
  void initState() {
    super.initState();
    DessertId = widget.dessertId;
    ImageURL = widget.imageURL;
    Name = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personalizar"),
        centerTitle: true,
        backgroundColor: Color.fromRGBO(191, 82, 105, 1),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Image.network(
                ImageURL,
                width: 150,
                height: 150,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 10),
              Text(
                Name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              //separador
              SizedBox(height: 8),
              //formulario
              Form(
                key: _formKey, //identificador del formulario
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 8),
                    //campo cobertura
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Cobertura",
                      ),
                      value: _cobertura,
                      items: tiposcoberturas.map((String cobertura) {
                        return DropdownMenuItem(
                          value: cobertura,
                          child: Text(cobertura),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _cobertura = newValue;
                        });
                        coberturacontroller.text = newValue ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Seleccione una Cobertura";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    //campo relleno
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Relleno",
                      ),
                      value: _relleno,
                      items: tiposrelleno.map((String relleno) {
                        return DropdownMenuItem(
                          value: relleno,
                          child: Text(relleno),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _relleno = newValue;
                        });
                        rellenocontroller.text = newValue ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Seleccione un Relleno";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    //campo sabor de torta
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Sabor de Torta",
                      ),
                      value: _sabortorta,
                      items: tiposabortorta.map((String sabortorta) {
                        return DropdownMenuItem(
                          value: sabortorta,
                          child: Text(sabortorta),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _sabortorta = newValue;
                        });
                        sabortortacontroller.text = newValue ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Seleccione un Sabor de la Torta";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    //campo cantidad personas
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: "Cantidad de Personas",
                      ),
                      value: _cantidadpersonas,
                      items: cantidadpersonas.map((String cantidadpersonas) {
                        return DropdownMenuItem(
                          value: cantidadpersonas,
                          child: Text(cantidadpersonas),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          _cantidadpersonas = newValue;
                        });
                        cantidadpersonascontroller.text = newValue ?? '';
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Seleccione la Cantidad de Personas";
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 8),
                    //campo Mensaje
                    TextFormField(
                      controller: mensajecontroller,
                      decoration: InputDecoration(
                        labelText: "Mensaje del Pastel",
                        hintText: "Mensaje del Pastel",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese un Mensaje para el pastel";
                        } else {
                          return null;
                        }
                      },
                      maxLines: 1,
                    ),

                    SizedBox(height: 8),
                    //campo Campo Adicional
                    TextFormField(
                      controller: comentarioadicionalcontroller,
                      decoration: InputDecoration(
                        labelText: "Comentario Adicional",
                        hintText: "Comentario Adicional",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Agregue un Comentario Adicional";
                        } else {
                          return null;
                        }
                      },
                      maxLines: 3,
                    ),
                    SizedBox(height: 8),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (validateForm(_formKey)) {
                            CRUDBakery().UploadPersonalize(
                                userId: user,
                                dessertId: DessertId,
                                name: Name,
                                imageUrl: ImageURL,
                                cobertura: coberturacontroller.text.trim(),
                                relleno: rellenocontroller.text.trim(),
                                sabortorta: sabortortacontroller.text.trim(),
                                cantidadpersonas:
                                    cantidadpersonascontroller.text.trim(),
                                mensaje: mensajecontroller.text.trim(),
                                comentarioadicional:
                                    comentarioadicionalcontroller.text.trim());
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Solicitud Enviada")),
                            );
                          }
                        },
                        child: Text("Create"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
