import 'package:flutter/material.dart';
import 'package:penatu/ui/styles/theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final Color? color;

  const PrimaryButton(
      {required this.label,
      required this.onPressed,
      this.color,
      this.isFullWidth = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
            backgroundColor: color ?? Theme.of(context).colorScheme.primary),
        child: Text(
          label,
          style: TextStyle(color: Theme.of(context).colorScheme.background),
        ),
      ),
    );
  }
}

class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final bool isFullWidth;
  final Color? color;

  const SecondaryButton(
      {required this.label,
      required this.onPressed,
      this.color,
      this.isFullWidth = false,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isFullWidth ? double.infinity : null,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          side:
              BorderSide(color: color ?? Theme.of(context).colorScheme.primary),
        ),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: color ?? Theme.of(context).colorScheme.primary),
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData? icon;

  const CustomTextButton(
      {required this.label, required this.onPressed, this.icon, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? TextButton.icon(
            label: Text(label),
            onPressed: onPressed,
            style: TextButton.styleFrom(),
            icon: Icon(
              icon,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
        : TextButton(
            onPressed: onPressed,
            style: TextButton.styleFrom(),
            child: Text(label),
          );
  }
}
