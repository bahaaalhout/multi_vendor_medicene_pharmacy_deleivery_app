import 'package:flutter/material.dart';

class CustomToggle extends StatelessWidget {
  final bool value;
  final ValueChanged<bool> onToggle;

  const CustomToggle({super.key, required this.value, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onToggle(!value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 42,
        height: 22,
        padding: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          color: value ? const Color(0xFF1B952B) : Colors.grey.shade500,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.transparent), // بدون حدود
        ),
        child: Align(
          alignment: value ? Alignment.centerRight : Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: value ? 16 : 18, // ⬅ تكبير الدائرة عند الإيقاف
            height: value ? 16 : 18,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ),
    );
  }
}
