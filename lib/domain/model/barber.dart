import 'package:flutter/foundation.dart';

class Barber {
  String name, address, ratingString, image;
  double rating;
  bool isIndividual, isNew, isPopular, isRecent;

  Barber(
      {@required this.name,
      @required this.address,
      @required this.image,
      @required this.rating,
      @required this.isIndividual,
      @required this.isNew,
      @required this.isPopular}) {
    // isRecent is almost useless in this task, so lets make it true in every object
    isRecent = true;

    if (rating > 5) rating = 5;
    if (rating < 0) rating = 0;

    if (rating > 4) {
      ratingString = 'Отлично';
    } else if (rating > 3) {
      ratingString = 'Хорошо';
    } else if (rating > 2) {
      ratingString = 'Так себе';
    } else {
      ratingString = 'Плохо';
    }
  }

  factory Barber.fromJson(Map<String, dynamic> json) {
    return Barber(
      name: json["name"],
      address: json["address"],
      image: json["image"],
      rating: json["rating"],
      isIndividual: json["isIndividual"],
      isNew: json["isNew"],
      isPopular: json["isPopular"],
    );
  }
}
