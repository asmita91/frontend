import 'package:flutter/material.dart';

class ReusableCard extends StatefulWidget {
  final String title;
  final String subtitle;
  final bool isFavourite;
  final VoidCallback onTap;

  const ReusableCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.isFavourite,
    required this.onTap,
  }) : super(key: key);

  @override
  _ReusableCardState createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: ListTile(
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(widget.subtitle),
        trailing: GestureDetector(
          onTap: widget.onTap,
          child: Icon(
            widget.isFavourite ? Icons.favorite : Icons.favorite_border,
            size: 25,
            color: widget.isFavourite ? Colors.red : null,
          ),
        ),
        leading: const Icon(Icons.account_circle_outlined, size: 30),
        contentPadding: const EdgeInsets.all(20),
      ),
    );
  }
}
