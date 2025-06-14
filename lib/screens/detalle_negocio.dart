import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/negocio.dart';
import '../widgets/base_screen.dart';
import '../widgets/equilibrio_chart.dart';
import '../helpers/db_helper.dart'; 

class DetalleNegocioScreen extends StatelessWidget {
  const DetalleNegocioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final negocio = ModalRoute.of(context)!.settings.arguments as Negocio;
    final puntoEquilibrio = negocio.calcularPuntoEquilibrioUnidades();
    final costoTotal = negocio.calcularCostoVariableUnitario();
    final precioVenta = negocio.CalcularPrecioUsuario();
    final ganancia = negocio.calcularGananciaPesos();
    final precioSugerido = negocio.CalcularPrecioSugerido();

void _mostrarInfo() {
  showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      
      backgroundColor: Colors.white,
      title: const Text('¿Qué es el Punto de Equilibrio?', style: TextStyle(color: Colors.brown),),
      content: const Text(
          'El Punto de Equilibrio es la cantidad mínima de unidades que debes vender para cubrir tus costos sin obtener pérdidas ni ganancias.',),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(ctx).pop(),
          child: const Text('Cerrar', style: TextStyle(color: Colors.brown),),
        ),
      ],
    ),
  );
}


    const double titleSize = 28;
    const double fontSize = 16;

    return BaseScreen(
      title: 'Detalle de Negocio',
      showBack: true,
      showBottomBar: false,
      showSkip: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Text(
                negocio.nombreNegocio,
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins (
                  fontSize: titleSize,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFBF5E0C),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: Colors.black, width: 1),
              ),
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tu negocio',
                        style: GoogleFonts.montserrat(
                            fontSize: fontSize, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 8),
                    Text('Campo: ${negocio.campo}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    const SizedBox(height: 4),
                    Text('Descripción: ${negocio.descripcion}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    const Divider(height: 30, thickness: 1),
                    Text('Tu Producto',
                        style: GoogleFonts.montserrat(
                            fontSize: fontSize, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text('Producto: ${negocio.nombreProducto}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                        Text(
                        'Margen de Ganancia: ${negocio.margenGanancia.toStringAsFixed(2)}%',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text(
                        'Ganancia: \$${negocio.calcularGananciaPesos().toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text('Costo unitario: \$${costoTotal.toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text('Precio: \$${precioVenta.toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),

                        const Divider(height: 30, thickness: 1),//SUGERENCIA

                    Text('Sugerencia',
                        style: GoogleFonts.montserrat(
                            fontSize: fontSize, color: Colors.grey, fontWeight: FontWeight.bold)),
                    const SizedBox(height: 10),
                    Text(
                        'Margen de Ganancia: 200%',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text(
                        'Ganancia: \$${negocio.calcularGananciaSugerida().toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),
                    Text('Precio Sugerido: \$${precioSugerido.toStringAsFixed(2)}',
                        style: GoogleFonts.montserrat(fontSize: fontSize)),

                    
                    const Divider(height: 30, thickness: 1),
                    Text( 'Materiales',
                        style: GoogleFonts.montserrat(fontSize: fontSize + 2,
                        fontWeight: FontWeight.bold, color: Colors.brown[800])),
                    const SizedBox(height: 12),
ListView.separated(
  shrinkWrap: true,
  physics: const NeverScrollableScrollPhysics(),
  itemCount: negocio.materiales.length,
  separatorBuilder: (_, __) => Divider(
    height: 16,
    thickness: 1,
    color: Colors.brown[200],
  ),
  itemBuilder: (context, index) {
    final material = negocio.materiales[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
         Text(
            '-${material.nombre}',
            style: GoogleFonts.montserrat(
              fontSize: fontSize,
              fontWeight: FontWeight.normal,
              color: Colors.black87,
            ),
          ),
        
        const SizedBox(height: 4),
        Text(
          'Cantidad: ${material.cantidad} ${material.unidad}',
          style: GoogleFonts.montserrat(fontSize: fontSize),
        ),
        Text(
          'Precio unitario: \$${material.costoUnitario.toStringAsFixed(2)}',
          style: GoogleFonts.montserrat(fontSize: fontSize),
        ),
      ],
    );
  },
),

 
                    const Divider(height: 30, thickness: 1),
                      Row(
  children: [
    Text(
      'Punto de Equilibrio',
      style: GoogleFonts.montserrat(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
      ),
    ),
    const SizedBox(width: 8),
    GestureDetector(
      onTap: _mostrarInfo,
      child: const Icon(Icons.info_outline, color: Color(0xFF795548)),
    ),
  ],
),

const SizedBox(height: 8),
Text(
  'Unidades necesarias para alcanzar el punto de equilibrio: ${puntoEquilibrio.toStringAsFixed(2)}',
  style: GoogleFonts.montserrat(fontSize: fontSize),
),
const SizedBox(height: 16),
EquilibrioChart(
  negocio: negocio,
  puntoEquilibrio: puntoEquilibrio,
  chartWidth: MediaQuery.of(context).size.width * 0.8,
),


                    const SizedBox(height: 24),
                    
                  ],
                ),
              ),
            ),
            ElevatedButton.icon(
  onPressed: () async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white, 
        title: const Text("¿Eliminar negocio?",
        style: TextStyle(color: Colors.brown),),
        content: const Text(
            "¿Deseas eliminar este negocio? Esta acción no se puede deshacer.",
        style: TextStyle(color: Colors.brown),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text("Cancelar",
        style: TextStyle(color: Colors.brown),),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text("Eliminar",
        style: TextStyle(color: Colors.red),),
          ),
        ],
      ),
    );

    if (confirm == true) {
      await DBHelper().eliminarNegocioPorId(negocio.id!);
      Navigator.pop(context);
    }
  },
  style: ElevatedButton.styleFrom(
    backgroundColor: Colors.white,
    foregroundColor: Colors.red, 
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12),
      side: const BorderSide(color: Colors.red, width: 1), 
    ),
  ),
  icon: const Icon(Icons.delete, color: Color(0xFFF44336)), 
  label: const Text(
    "Eliminar negocio",
    style: TextStyle(color: Colors.red), 
  ),
)

          ],
        ),
      ),
    );
  }
}

