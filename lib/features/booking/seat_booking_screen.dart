import 'package:flutter/material.dart';
import 'package:flutter_extensions_pack/flutter_extensions_pack.dart';
import 'package:ticket_booking_app/core/constants/app_colors.dart';
import 'package:ticket_booking_app/models/booking.dart';
import 'package:ticket_booking_app/widgets/appbar/booking_appbar.dart';
import 'package:ticket_booking_app/widgets/button/app_button.dart';

class SeatBookingScreen extends StatefulWidget {
  final String title;
  final Booking booking;

  const SeatBookingScreen({
    required this.title,
    required this.booking,
    super.key,
  });

  @override
  State<SeatBookingScreen> createState() => _SeatBookingScreenState();
}

class _SeatBookingScreenState extends State<SeatBookingScreen> {
  final _transformationController = TransformationController();
  double _scaleFactor = 1.0;
  final double _minScale = 1.0;
  final double _maxScale = 3.0;
  Seat? selectedSeat;

  void _zoomIn() {
    _scaleFactor = (_scaleFactor + 0.1).clamp(_minScale, _maxScale);
    _applyScale();
  }

  void _zoomOut() {
    _scaleFactor = (_scaleFactor - 0.1).clamp(_minScale, _maxScale);
    _applyScale();
  }

  void _applyScale() {
    _transformationController.value = Matrix4.identity()..scale(_scaleFactor);
  }

  void _onSeatSelected(Seat seat) {
    setState(() {
      seat.isBooked = true;
      seat.type == SeatType.Selected;
      selectedSeat = seat;
    });
  }

  void _onSeatBooked() {
    context.showSuccessSnack(
      'Congratulations! Seat no ${selectedSeat?.no} booked.',
    );
    context.pop();
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          BookingAppBar(
            title: widget.title,
            subtitle:
                '${widget.booking.slot?.date?.format('MMMM d, yyy')} | ${widget.booking.hall?.time} ${widget.booking.hall?.name}',
          ),
          Expanded(child: Stack(children: [_seatsView(), _zoomControls()])),
          Container(
            padding: 16.padAll,
            child: Column(
              children: [
                _seatsCategoryView(),
                24.spaceY,
                Row(
                  children: [
                    _priceTag(),
                    8.spaceX,
                    Expanded(
                      child: AppButton(
                        label: 'Proceed to pay',
                        onTap: _onSeatBooked,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _zoomControls() {
    return Positioned(
      bottom: 16,
      right: 16,
      child: Row(
        children: [
          IconButton.filled(
            onPressed: _zoomIn,
            icon: Icon(Icons.add),
            focusColor: Colors.amber,
          ),
          IconButton.filled(onPressed: _zoomOut, icon: Icon(Icons.remove)),
        ],
      ),
    );
  }

  Widget _seatsView() {
    return InteractiveViewer(
      transformationController: _transformationController,
      minScale: _minScale,
      maxScale: _maxScale,
      scaleFactor: _scaleFactor,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: EdgeInsets.fromLTRB(48, 16, 48, 16),
        color: AppColors.backgroundColor,
        child: Wrap(
          spacing: 8,
          children:
              widget.booking.hall?.seats.map((s) {
                return GestureDetector(
                  onTap: () => _onSeatSelected(s),
                  child: Icon(
                    Icons.tv,
                    size: 12,
                    color: widget.booking.getSeatColor(s.type),
                  ),
                );
              }).toList() ??
              [],
        ),
      ),
    );
  }

  Widget _priceTag() {
    return Container(
      height: 50,
      padding: 24.padX,
      decoration: BoxDecoration(
        color: AppColors.lightGrayColor,
        borderRadius: 10.circularRadius,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Totla Price',
            style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
          ),
          Text('\$ 50', style: context.style16W600),
        ],
      ),
    );
  }

  Widget _seatsCategoryView() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _seatCategory('Selected', AppColors.yellowColor),
              16.spaceY,
              _seatCategory('VIP', AppColors.purpleColor),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _seatCategory('Not available', Color(0XFF8F8F8F)),
              16.spaceY,
              _seatCategory('Regular', AppColors.buttonColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _seatCategory(String category, Color color) {
    return Row(
      children: [
        Icon(Icons.tv, color: color),
        16.spaceX,
        Text(
          category,
          style: context.style12W500.copyWith(
            color: Color(0XFF8F8F8F),
            height: 1.60,
          ),
        ),
      ],
    );
  }
}
