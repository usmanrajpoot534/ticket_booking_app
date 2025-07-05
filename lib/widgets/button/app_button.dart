import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:ticket_booking_app/core/constants/app_colors.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;

  const AppButton({this.onTap, required this.label, super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
        foregroundColor: WidgetStateProperty.all(Colors.white),
        backgroundColor: WidgetStateProperty.all(AppColors.buttonColor),
        fixedSize: WidgetStateProperty.all(Size(double.infinity, 50)),
      ),
      child: Text(
        label,
        style: context.style14W600.copyWith(letterSpacing: 0.2),
      ),
    );
  }
}
