class TripModel {
  final String departureCity;
  final String arrivalCity;
  final String departureCountry;
  final String arrivalCountry;
  final String flightDate;
  final String weight;
  final String description;
  final String userId;
  final String userName;
  final String email;
  final String pricePerKg;
  final String flightNo;

  TripModel(
      {required this.departureCity,
      required this.arrivalCity,
      required this.departureCountry,
      required this.arrivalCountry,
      required this.flightDate,
      required this.weight,
      required this.description,
      required this.userId,
      required this.userName,
      required this.email,
      required this.pricePerKg,
      required this.flightNo});
}