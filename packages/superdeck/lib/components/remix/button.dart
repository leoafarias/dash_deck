import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:remix/remix.dart';

class SDButton extends StatelessWidget {
  const SDButton({
    required this.onPressed,
    super.key,
    required this.label,
    this.icon,
  });

  final VoidCallback onPressed;
  final String label;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return RxButton(
      onPressed: onPressed,
      iconLeft: icon,
      label: label,
    );
  }
}

class SDButtonSolid extends StatelessWidget {
  const SDButtonSolid({
    required this.onPressed,
    super.key,
    required this.label,
    this.icon,
  });

  final VoidCallback onPressed;
  final String label;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return RxButton(
      onPressed: onPressed,
      iconLeft: icon,
      label: label,
    );
  }
}

class SDOutlinedButton extends StatelessWidget {
  const SDOutlinedButton({
    required this.onPressed,
    super.key,
    required this.label,
    this.icon,
  });

  final VoidCallback onPressed;
  final String label;

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return RxButton(
      onPressed: onPressed,
      iconLeft: icon,
      label: label,
    );
  }
}

class SDIconButton extends StatelessWidget {
  const SDIconButton({
    required this.onPressed,
    super.key,
    required this.icon,
    this.selected = false,
  });

  final VoidCallback onPressed;
  final bool selected;

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return RxButton(
      onPressed: onPressed,
      iconLeft: icon,
      label: '',
    );
  }
}
