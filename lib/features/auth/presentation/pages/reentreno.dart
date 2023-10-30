import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Reentreno extends StatefulWidget {
  static const String id = "Reentreno";
  const Reentreno({super.key});

  @override
  State<Reentreno> createState() => _ReentrenoState();
}

class _ReentrenoState extends State<Reentreno> {
  final _formKey = GlobalKey<FormState>();
  String _respuesta = '';
  TextEditingController _urlController = TextEditingController();
  TextEditingController _shaController = TextEditingController();

  Future<void> _consultarModelo() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
  }

  Future<void> _llamadoAPI() async {
    print(_urlController.text);
    final url = Uri.parse(
        'https://api.github.com/repos/IrvingCM123/carprediction/dispatches');

    final body = json.encode({
      "event_type": "ml_ci_cd",
      "client_payload": {
        "dataseturl":
            _urlController.text,
        "sha": _shaController.text,
      }
    });

    final headers = {
      'Authorization': 'bearer token',
      'Accept': 'application/vnd.github.v3+json',
      'Content-type': 'application/json',
    };

    final response = await http.post(url, body: body, headers: headers);

    if (response.statusCode == 204) {
      setState(() {
        _respuesta = 'Llamado a API exitoso';
      });
    } else {
      setState(() {
        _respuesta = 'Error al hacer el llamado a la API';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Cambia el color de fondo aquí

      appBar: AppBar(
        title: Text(
          "IA Machine Learning",
          style: TextStyle(
            color: Colors.white, // Texto del título en blanco
            // Aquí puedes ajustar otros estilos de texto, como tamaño de fuente, etc.
          ),
        ),
        backgroundColor: Colors.orange,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller:
                        _shaController, // Asociar el controlador al campo
                    decoration: InputDecoration(
                      labelText: 'Nombre',
                      labelStyle: TextStyle(
                        color: Colors.grey, // Color del texto del label (gris)
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Color del borde cuando no está enfocado
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .blue), // Color del borde cuando está enfocado
                      ),
                      hintStyle: TextStyle(
                          color: Colors
                              .grey), // Color del texto de sugerencia (gris)
                    ),
                    style: TextStyle(
                      color:
                          Colors.white, // Color del texto de entrada (blanco)
                      // Aquí puedes ajustar otros estilos de texto, como tamaño de fuente, etc.
                    ),
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextFormField(
                    controller:
                        _urlController, // Asociar el controlador al campo
                    decoration: InputDecoration(
                      labelText: 'URL',
                      labelStyle: TextStyle(
                        color: Colors.grey, // Color del texto del label (gris)
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .white), // Color del borde cuando no está enfocado
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors
                                .blue), // Color del borde cuando está enfocado
                      ),
                      hintStyle: TextStyle(
                          color: Colors
                              .grey), // Color del texto de sugerencia (gris)
                    ),
                    style: TextStyle(
                      color:
                          Colors.white, // Color del texto de entrada (blanco)
                      // Aquí puedes ajustar otros estilos de texto, como tamaño de fuente, etc.
                    ),
                    // No establecer el keyboardType, ya que es un campo de URL
                    onSaved: (value) {},
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _llamadoAPI,
                  child: const Text('Reentrenar Modelo'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                    padding:
                        EdgeInsets.symmetric(horizontal: 125, vertical: 22),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(_respuesta),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
