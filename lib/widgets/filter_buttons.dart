import 'package:flutter/material.dart';

class FilterButtonsWidget extends StatelessWidget {
  final VoidCallback onAllSelected;
  final VoidCallback onFavoritesSelected;
  final bool isAllSelected;

  const FilterButtonsWidget({
    Key? key,
    required this.onAllSelected,
    required this.onFavoritesSelected,
    required this.isAllSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilterButton(
          text: "All",
          isSelected: isAllSelected,
          onPressed: onAllSelected,
        ),
        SizedBox(width: 10),
        FilterButton(
          text: "Favourite",
          isSelected: !isAllSelected,
          onPressed: onFavoritesSelected,
        ),
      ],
    );
  }
}

class FilterButton extends StatelessWidget {
  final String text;
  final bool isSelected;
  final VoidCallback onPressed;

  const FilterButton({
    Key? key,
    required this.text,
    required this.isSelected,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor:
            isSelected ? Colors.purple.shade700 : Colors.grey.shade300,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      child: Text(
        text,
        style: TextStyle(color: isSelected ? Colors.white : Colors.black),
      ),
    );
  }
}
