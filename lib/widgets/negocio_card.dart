import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../models/negocio.dart';

class NegocioCard extends StatelessWidget {
  final Negocio negocio;
  final VoidCallback? onTap;

  const NegocioCard({Key? key, required this.negocio, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(color: Colors.black, width: 1), 
      ),
      color: Colors.white, 
      child: ListTile(
        title: Text(
          negocio.nombreNegocio,
          style: GoogleFonts.montserrat(color: Colors.black),
        ),
        subtitle: Text(
          negocio.descripcion,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Color(0xFFA1887F)),
        onTap: onTap,
      ),
    );
  }
}
