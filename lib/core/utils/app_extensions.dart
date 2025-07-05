import 'package:stacked/stacked.dart';
import 'package:ticket_booking_app/services/api_client.dart';

extension ClientExtension on BaseViewModel {
  ApiClient get client => ApiClient();
}
