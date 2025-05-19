import 'package:flutter/material.dart';
import '../../models/negocio.dart';

class NegocioCard extends StatelessWidget {
  final Negocio negocio;
  final VoidCallback? onTap;

  const NegocioCard({Key? key, required this.negocio, this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: ListTile(
        title: Text(negocio.nombreNegocio),
        subtitle: Text(negocio.descripcion, maxLines: 2, overflow: TextOverflow.ellipsis),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
