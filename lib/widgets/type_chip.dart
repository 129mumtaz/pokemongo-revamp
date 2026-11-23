import 'package:flutter/material.dart';

class TypeChip extends StatelessWidget {
  final String type;
  const TypeChip({super.key, required this.type});

  Color _typeColor() {
    if (type.contains('Water')) return const Color(0xFF2E86DE);
    if (type.contains('Fire')) return const Color(0xFFE85D4A);
    if (type.contains('Grass')) return const Color(0xFF376B4D);
    if (type.contains('Electric')) return const Color(0xFFE5A800);
    if (type.contains('Ice')) return const Color(0xFF10AC84);
    if (type.contains('Fighting')) return const Color(0xFFEE5253);
    if (type.contains('Poison')) return const Color(0xFF8854D0);
    if (type.contains('Ground')) return const Color(0xFFCD6133);
    if (type.contains('Flying')) return const Color(0xFF54A0FF);
    if (type.contains('Psychic')) return const Color(0xFFF368E0);
    if (type.contains('Bug')) return const Color(0xFF10AC84);
    if (type.contains('Rock')) return const Color(0xFF576574);
    if (type.contains('Ghost')) return const Color(0xFF5F27CD);
    if (type.contains('Dragon')) return const Color(0xFFFF9F43);
    if (type.contains('Dark')) return const Color(0xFF222F3E);
    if (type.contains('Steel')) return const Color(0xFF8395A7);
    if (type.contains('Fairy')) return const Color(0xFFFF9FF3);
    return const Color(0xFF777777);
  }

  @override
  Widget build(BuildContext context) {
    final color = _typeColor();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
      ),
      child: Text(
        type,
        style: TextStyle(
          color: color,
          fontSize: 10,
          fontWeight: FontWeight.w600,
          fontFamily: 'Montserrat',
        ),
      ),
    );
  }
}
