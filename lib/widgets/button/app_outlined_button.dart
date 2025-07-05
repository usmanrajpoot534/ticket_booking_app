import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:ticket_booking_app/core/constants/app_colors.dart';

class AppOutlinedButton extends StatelessWidget {
  final VoidCallback? onTap;
  final String label;
  final IconData? icon;
  final bool loading;
  const AppOutlinedButton({
    this.onTap,
    required this.label,
    this.icon,
    this.loading = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: 10.circularRadius,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: loading ? null : onTap,
        child: Ink(
          width: double.infinity,
          height: 50,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.buttonColor),
            borderRadius: 10.circularRadius,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[Icon(icon, color: Colors.white), 4.spaceX],
              Text(
                label,
                style: context.style14W600.copyWith(
                  color: Colors.white,
                  letterSpacing: 0.2,
                ),
              ),
              if (loading) ...[
                12.spaceX,
                SizedBox(
                  height: 12,
                  width: 12,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
