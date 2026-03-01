import 'package:flutter/material.dart';

class JobInfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color? valueColor;

  const JobInfoTile({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 42,
          width: 42,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.08),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon,
              color: Theme.of(context).primaryColor, size: 20),
        ),
        const SizedBox(width: 12),

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label,
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      fontWeight: FontWeight.w500)),
              const SizedBox(height: 3),
              Text(
                value.isEmpty ? "Not provided" : value,
                style: TextStyle(
                  fontSize: 14.5,
                  fontWeight: FontWeight.w600,
                  color: valueColor ?? Colors.black87,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}

Color urgencyColor(String? u) {
  switch ((u ?? '').toLowerCase()) {
    case 'high':
      return Colors.red.shade600;
    case 'medium':
      return Colors.orange.shade700;
    case 'low':
      return Colors.green.shade600;
    default:
      return Colors.grey.shade700;
  }
}