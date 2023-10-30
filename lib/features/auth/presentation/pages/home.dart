import 'package:flutter/material.dart';
import 'package:ui_one/features/auth/presentation/pages/model_page.dart';
import 'package:ui_one/features/auth/presentation/pages/reentreno.dart';

class HomeScreen extends StatefulWidget {
  static const String id = "home";
  const HomeScreen({Key? key}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0; // Índice actual para la barra de navegación

  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.black, // Cambia el color de fondo aquí

      appBar: AppBar(
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        title: ShaderMask(
          shaderCallback: (Rect bounds) {
            return LinearGradient(
              colors: [Colors.grey, Colors.white], // Degradado blanco y gris
            ).createShader(bounds);
          },
          child: const Text(
            'Bienvenido',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.white
            ),
          ),
        ),
      ),
      body: _buildBody(currentIndex), // Contenido de la página
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.orange, // Cambia el color de fondo aquí

        fixedColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Cuenta',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Acerca de ',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index; // Cambia el índice al tocar un botón
          });
        },
      ),
    );
  }

  Widget _buildBody(int index) {
    switch (index) {
      case 0:
        return Column(
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    colors: [Colors.grey, Colors.white], // Degradado blanco y gris
                  ).createShader(bounds);
                },
                child: Text(
                  'Modelo IA',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey, 
                  ),
                ),
              ),
            ),
            Expanded(
              child: GridViewButtons(),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}

class GridViewButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 1,
      children: <Widget>[
        CustomButton(
          icon: Icons.money,
          label: 'Model Prediction',
          data: ModelPage.id,
        ),
        CustomButton(
          icon: Icons.lightbulb,
          label: 'Deep Learning',
          data: Reentreno.id,
        ),
        CustomButton(
          icon: Icons.history,
          label: 'Historial',
          data: HomeScreen.id,
        ),
      ],
    );
  }
}

class CustomButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String data;

  CustomButton({required this.icon, required this.label, required this.data});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Realiza una acción cuando se toca el botón
        print('Botón $label presionado');
        Navigator.pushNamed(context, data);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedContainer(
            duration: Duration(milliseconds: 200),
            padding: EdgeInsets.all(45.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(200, 211, 40, 17),
              borderRadius: BorderRadius.circular(9.0),
            ),
            child: Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 30),
          ShaderMask(
            shaderCallback: (Rect bounds) {
              return LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.grey, Colors.white], // Degradado blanco y gris
              ).createShader(bounds);
            },
            child: Text(label),
          ),
        ],
      ),
    );
  }
}
