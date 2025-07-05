import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:ticket_booking_app/core/constants/app_colors.dart';
import 'package:ticket_booking_app/features/booking/seat_booking_screen.dart';
import 'package:ticket_booking_app/models/booking.dart';
import 'package:ticket_booking_app/models/movies_record.dart';
import 'package:ticket_booking_app/widgets/appbar/booking_appbar.dart';
import 'package:ticket_booking_app/widgets/button/app_button.dart';

class HallSelectionScreen extends StatefulWidget {
  final Movie movie;
  const HallSelectionScreen(this.movie, {super.key});

  @override
  State<HallSelectionScreen> createState() => _HallSelectionScreenState();
}

class _HallSelectionScreenState extends State<HallSelectionScreen> {
  late Booking _booking;
  late List<Hall> _halls;
  late List<Slot> _slots;
  @override
  void initState() {
    super.initState();
    _booking = Booking();
    _halls = _dummyHalls();
    _slots = _dummySlots();
  }

  void _onSlotSelected(Slot slot) {
    setState(() {
      for (final s in _slots) {
        s.isSelected = false;
      }

      slot.isSelected = true;
    });
  }

  void _onHallSelected(Hall hall) {
    setState(() {
      for (final h in _halls) {
        h.isSelected = false;
      }

      hall.isSelected = true;
    });
  }

  void _onHallBooked() {
    {
      if (_halls.any((h) => h.isSelected) == false) return;
      if (_slots.any((h) => h.isSelected) == false) return;
      _booking.hall = _halls.firstWhere((h) => h.isSelected);
      _booking.slot = _slots.firstWhere((s) => s.isSelected);

      context.push(
        SeatBookingScreen(title: widget.movie.title!, booking: _booking),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BookingAppBar(
            title: '${widget.movie.title}',
            subtitle:
                'In Theaters ${widget.movie.releaseDate?.dateFromString.format('MMM d, y')}',
          ),
          Expanded(
            child: Container(
              padding: 16.padAll,
              color: AppColors.backgroundColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date',
                    style: context.style16W500.copyWith(height: 1.25),
                  ),
                  16.spaceY,
                  _slotsList(),
                  32.spaceY,
                  _hallsList(),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: 16.padAll,
            color: AppColors.backgroundColor,
            child: AppButton(label: 'Select Seats', onTap: _onHallBooked),
          ),
        ],
      ),
    );
  }

  Widget _hallsList() {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _halls.length,
        itemBuilder: (context, index) {
          final hall = _halls[index];

          return Padding(
            padding: EdgeInsets.only(right: index == 3 ? 0 : 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _hallLabel(hall, context),
                8.spaceY,
                _hallCard(hall, context),
                16.spaceY,
                _hallPricingTag(context, hall),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _hallPricingTag(BuildContext context, Hall hall) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'From ',
          style: context.style12W500.copyWith(color: Color(0XFF8F8F8F)),
        ),
        Text('${hall.rate}\$ ', style: context.style12W600),
        Text(
          'or ',
          style: context.style12W500.copyWith(color: Color(0XFF8F8F8F)),
        ),
        Text('${hall.bonus}', style: context.style12W600),
      ],
    );
  }

  Widget _hallCard(Hall hall, BuildContext context) {
    return GestureDetector(
      onTap: () => _onHallSelected(hall),
      child: Container(
        padding: EdgeInsets.fromLTRB(48, 16, 48, 16),
        width: context.kWidth * 0.7,
        decoration: BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: 10.circularRadius,
          border: Border.all(
            color: hall.isSelected
                ? AppColors.buttonColor
                : AppColors.lightGrayColor,
          ),
          boxShadow: [
            BoxShadow(
              spreadRadius: 4,
              color: Color.fromARGB(25, 0, 0, 0),
              blurRadius: 10,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Wrap(
          spacing: 8,
          children: hall.seats.map((s) {
            return Icon(
              Icons.tv,
              size: 12,
              color: _booking.getSeatColor(s.type),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _hallLabel(Hall hall, BuildContext context) {
    return Row(
      children: [
        Text('${hall.time}', style: context.style12W500.copyWith(height: 1.60)),
        8.spaceX,
        Text(
          '${hall.name}',
          style: context.style12W400.copyWith(
            color: Color(0XFF8F8F8F),
            height: 1.60,
          ),
        ),
      ],
    );
  }

  Widget _slotsList() {
    return SizedBox(
      height: 32,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _slots.length,
        itemBuilder: (context, index) {
          final slot = _slots[index];

          return GestureDetector(
            onTap: () => _onSlotSelected(slot),
            child: Container(
              height: 32,
              padding: 16.padX,
              margin: index == 9 ? null : EdgeInsets.only(right: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: slot.isSelected
                    ? AppColors.buttonColor
                    : AppColors.lightGrayColor,
                borderRadius: 10.circularRadius,
              ),
              child: Text(
                '${slot.date?.format('d MMM')}',
                style: context.style12W600.copyWith(
                  color: slot.isSelected ? Colors.white : null,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  List<Slot> _dummySlots() {
    final slots = List.generate(
      10,
      (i) => Slot(date: DateTime(2025, 7, i + 4)),
    );
    return slots;
  }

  List<Hall> _dummyHalls() {
    return List.generate(
      4,
      (i) => Hall(
        name: 'Hall ${i + 1}',
        time: '0${i + 1}:30',
        rate: (i + 1) * 50,
        bonus: (i + 1) * 500,
        seats: List.generate(
          100,
          (i) => Seat(no: i + 1, type: _setSeatType(i)),
        ),
      ),
    );
  }

  SeatType _setSeatType(int i) {
    if (i <= 12) return SeatType.VIP;
    return SeatType.Regular;
  }
}
