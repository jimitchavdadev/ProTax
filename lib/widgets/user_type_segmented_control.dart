// lib/widgets/user_type_segmented_control.dart
import 'package:flutter/material.dart';

class UserTypeSegmentedControl extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelectionChanged;

  const UserTypeSegmentedControl({
    super.key,
    required this.selectedIndex,
    required this.onSelectionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: BoxDecoration(
        color: const Color(0xFFF0F2F5),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          _buildSegment("Individual", 0),
          _buildSegment("Business", 1),
        ],
      ),
    );
  }

  Widget _buildSegment(String text, int index) {
    bool isSelected = selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => onSelectionChanged(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                    ),
                  ]
                : [],
          ),
          child: Center(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: isSelected
                    ? const Color(0xFF111418)
                    : const Color(0xFF60748A),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
