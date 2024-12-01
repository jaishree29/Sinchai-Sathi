import 'package:flutter/material.dart';

class ListItem extends StatelessWidget {
  final IconData leadingIcon;
  final String boldText;
  final String trailingText;
  final Color backgroundColor;
  final Color iconColor;
  final Color textColor;
  final Color trailingTextColor;

  const ListItem({
    super.key,
    required this.leadingIcon,
    required this.boldText,
    required this.trailingText,
    this.backgroundColor = Colors.transparent,
    this.iconColor = Colors.black,
    this.textColor = Colors.black,
    this.trailingTextColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey.shade400),
                  color: iconColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Icon(
                  leadingIcon,
                  color: iconColor,
                ),
              ),
              const SizedBox(width: 16.0),
              Text(
                boldText,
                style: TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 18.0,
                  color: textColor,
                ),
              ),
            ],
          ),
          Text(
            trailingText,
            style: TextStyle(
              fontSize: 16.0,
              color: trailingTextColor,
            ),
          ),
        ],
      ),
    );
  }
}

