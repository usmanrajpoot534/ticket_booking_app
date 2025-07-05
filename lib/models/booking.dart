// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:ticket_booking_app/core/constants/app_colors.dart';

class Booking {
  Slot? slot;
  Hall? hall;

  Booking({this.slot, this.hall});

  Color getSeatColor(SeatType type) {
    if (type == SeatType.Selected) return AppColors.yellowColor;
    if (type == SeatType.VIP) return AppColors.purpleColor;
    if (type == SeatType.Regular) return AppColors.buttonColor;
    return AppColors.lightGrayColor;
  }
}

class Hall {
  String? name;
  String? time;
  num? rate;
  num? bonus;
  List<Seat> seats;
  bool isSelected;

  Hall({
    this.name,
    this.time,
    this.rate,
    this.bonus,
    this.seats = const [],
    this.isSelected = false,
  });
}

class Slot {
  bool isSelected;
  DateTime? date;

  Slot({this.isSelected = false, this.date});
}

class Seat {
  int? no;
  bool isBooked;
  SeatType type;

  Seat({this.no, this.isBooked = false, this.type = SeatType.Regular});
}

enum SeatType { Selected, Not_Available, VIP, Regular }
