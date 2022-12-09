class OrderModel {
  final String id;
  final String bidRequestId;
  final String delivery;
  final String userId;
  final String email;
  final String userName;
  final String amount;
  final String departureCity;
  final String arrivalCity;
  final String departureCountry;
  final String arrivalCountry;
  final String bidderEmail;
  final String bidderUserId;
  final String bidderUserName;
  final String description;
  final String flightDate;
  final String message;
  final String status;
  final String weight;

  OrderModel(
      {required this.id,
      required this.bidRequestId,
      required this.delivery,
      required this.userId,
      required this.email,
      required this.userName,
      required this.amount,
      required this.departureCity,
      required this.arrivalCity,
      required this.departureCountry,
      required this.arrivalCountry,
      required this.bidderEmail,
      required this.bidderUserId,
      required this.bidderUserName,
      required this.description,
      required this.flightDate,
      required this.message,
      required this.status,
      required this.weight});
}