import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

void main() => runApp(BreakEvenApp());

class BreakEvenApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BizBloom',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/menu': (context) => inicio(),
        '/calcu': (context) => Calculadora(),
      },
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              height: 250,
              padding: EdgeInsets.all(15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              'BizBloom',
              style: GoogleFonts.montserrat(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 90, 44, 18),
              ),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 18),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                elevation: 5,
                backgroundColor: Color(0xFFEBDBA9),
              ),
              child: Text(
                'Comenzar',
                style:
                    GoogleFonts.montserrat(fontSize: 20, color: Colors.black),
              ),
              onPressed: () => Navigator.pushNamed(context, '/menu'),
            )
          ],
        ),
      ),
    );
  }
}

class inicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Encamina tu\nnegocio',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),

            // Botón
            ElevatedButton(
              onPressed: () {
                print("Calculando nuevo negocio...");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEBDBA9), // #EBDBA9
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Calcular Nuevo Negocio',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    Icons.folder_open,
                    color: Colors.black,
                    size: 30,
                  ),
                ],
              ),
            ),
            SizedBox(height: 40),

            Text(
              'Historial de negocios',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40),

            Text(
              'No se encontraron negocios',
              style: TextStyle(
                fontSize: 24,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(
                Icons.home,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Navigator.pushNamed(context, '/menu'),
            ),
            IconButton(
              icon: Icon(
                Icons.calculate,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => Navigator.pushNamed(context, '/calcu'),
            ),
          ],
        ),
      ),
    );
  }
}

//INICIA CALCULADORA
class Calculadora extends StatefulWidget {
  @override
  _CalculadoraState createState() => _CalculadoraState();
}

class _CalculadoraState extends State<Calculadora> {
  List<Map<String, dynamic>> materiales = [
    {
      'cantidad': TextEditingController(),
      'costo': TextEditingController(),
      'unidad': 'kg'
    },
  ];

  final TextEditingController costoFijoController = TextEditingController();
  double totalCosto = 0.0;

  void agregarMaterial() {
    setState(() {
      materiales.add({
        'cantidad': TextEditingController(),
        'costo': TextEditingController(),
        'unidad': 'kg',
      });
    });
  }

  void eliminarMaterial(int index) {
    setState(() {
      materiales.removeAt(index);
    });
  }

  void calcularCosto() {
    double total = 0.0;
    for (var mat in materiales) {
      double cantidad = double.tryParse(mat['cantidad'].text) ?? 0;
      double costo = double.tryParse(mat['costo'].text.replaceAll('\$', '')) ??
          0; // Remover "$" antes de convertir
      total += cantidad * costo;
    }

    double costosFijos = double.tryParse(costoFijoController.text) ?? 0;
    total += costosFijos;

    setState(() {
      totalCosto = total;
    });
  }

  String formatear(double valor) {
    return NumberFormat.currency(locale: 'es_MX', symbol: '\$').format(valor);
  }

  Widget construirMaterial(int index) {
    final material = materiales[index];

    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Material',
                style: GoogleFonts.montserrat(fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(Icons.delete_outline, color: Colors.black),
              onPressed: () => eliminarMaterial(index),
            ),
          ],
        ),
        SizedBox(height: 8),
        Text('Cantidad', style: GoogleFonts.montserrat()),
        SizedBox(height: 5),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: material['cantidad'],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: '0.0',
                  border: OutlineInputBorder(),
                  isDense: true,
                ),
              ),
            ),
            SizedBox(width: 10),
            DropdownButton<String>(
              value: material['unidad'],
              items: ['g', 'kg', 'unidad'].map((String unidad) {
                return DropdownMenuItem<String>(
                  value: unidad,
                  child: Text(unidad),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  material['unidad'] = newValue;
                });
              },
            ),
          ],
        ),
        SizedBox(height: 8),
        Text('Costo Unitario de Material', style: GoogleFonts.montserrat()),
        SizedBox(height: 5),
        TextField(
          controller: material['costo'],
          keyboardType: TextInputType.number,
          textAlign: TextAlign.center, // Centrar
          decoration: InputDecoration(
            hintText: '\$0.00',
            hintStyle: TextStyle(fontSize: 20),
            border: InputBorder.none, // Eliminar el borde
          ),
          onChanged: (value) {
            if (!value.startsWith('\$')) {
              material['costo'].text = '\$' + value.replaceAll('\$', '');
              material['costo'].selection = TextSelection.fromPosition(
                TextPosition(offset: material['costo'].text.length),
              );
            }
          },
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text('Calculadora',
            style: GoogleFonts.montserrat(color: Colors.black)),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          children: [
            Text(
              'Calcula tu costo de producción por unidad',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(),
            ),
            SizedBox(height: 20),
            ...List.generate(materiales.length, construirMaterial),
            ElevatedButton.icon(
              onPressed: agregarMaterial,
              icon: Icon(Icons.add, color: Colors.black),
              label: Text('Agregar Material',
                  style: GoogleFonts.montserrat(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEBDBA9),
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
            SizedBox(height: 30),
            Text('Costos Fijos Mensuales', style: GoogleFonts.montserrat()),
            SizedBox(height: 10),
            TextField(
              controller: costoFijoController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center, // Centra el texto
              style: TextStyle(fontSize: 20), // Agranda el texto
              decoration: InputDecoration(
                hintText: '\$0.00',
                hintStyle: TextStyle(fontSize: 20),
                border: InputBorder.none, // Elimina el borde y sombreado
              ),
              onChanged: (value) {
                if (!value.startsWith('\$')) {
                  costoFijoController.text = '\$' + value.replaceAll('\$', '');
                  costoFijoController.selection = TextSelection.fromPosition(
                    TextPosition(offset: costoFijoController.text.length),
                  );
                }
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcularCosto,
              child: Text('Calcular',
                  style: GoogleFonts.montserrat(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xFFEBDBA9),
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 14),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'El costo unitario de tu producto es de:',
              style: GoogleFonts.montserrat(),
            ),
            SizedBox(height: 10),
            Text(
              formatear(totalCosto),
              style: GoogleFonts.montserrat(
                  fontSize: 28, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Icon(Icons.home, color: Colors.black),
              onPressed: () => Navigator.pushNamed(context, '/menu'),
            ),
            IconButton(
              icon: Icon(Icons.calculate, color: Colors.black),
              onPressed: () => Navigator.pushNamed(context, '/calcu'),
            ),
          ],
        ),
      ),
    );
  }
}
