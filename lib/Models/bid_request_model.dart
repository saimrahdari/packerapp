class BidRequestModel {
  final String bidRequestId;
  final String departureCity;
  final String arrivalCity;
  final String departureCountry;
  final String arrivalCountry;
  final String description;
  final String flightDate;
  final String weight;
  final String pricePerKg;
  final String flightNo;
  final String bidderUserId;
  final String bidderEmail;
  final String bidderUserName;
  final String amount;
  final String message;
  final String status;

  BidRequestModel(
      {required this.bidRequestId,
      required this.departureCity,
      required this.arrivalCity,
      required this.departureCountry,
      required this.arrivalCountry,
      required this.description,
      required this.flightDate,
      required this.weight,
      required this.pricePerKg,
      required this.flightNo,
      required this.bidderUserId,
      required this.bidderEmail,
      required this.bidderUserName,
      required this.amount,
      required this.message,
      required this.status});
}