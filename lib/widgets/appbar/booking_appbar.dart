import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:ticket_booking_app/core/constants/app_colors.dart';

class BookingAppBar extends StatelessWidget {
  final String title;
  final String subtitle;

  const BookingAppBar({required this.title, required this.subtitle, super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: 80,
        padding: 16.padAll,
        child: Row(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: context.pop,
                  icon: Icon(Icons.arrow_back_ios),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(title, style: context.style16W500.copyWith(height: 1.25)),
                8.spaceY,
                Text(
                  subtitle,
                  style: context.style12W500.copyWith(
                    height: 1.25,
                    color: AppColors.buttonColor,
                  ),
                ),
              ],
            ),
            Expanded(child: SizedBox.shrink()),
          ],
        ),
      ),
    );
  }
}
