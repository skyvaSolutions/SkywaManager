import 'dart:convert';

import 'package:skywamanager/Global&Constants/UserSettingsConstants.dart';
import 'package:skywamanager/Global&Constants/globalsAndConstants.dart';
import 'package:dio/dio.dart';class userModel {
  String gender;
  Name name;
  Location location;
  String email;

  userModel({this.gender, this.name, this.location, this.email});

  userModel.fromJson(Map<String, dynamic> json) {
    gender = json['gender'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['gender'] = this.gender;
    if (this.name != null) {
      data['name'] = this.name.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location.toJson();
    }
    data['email'] = this.email;
    return data;
  }
}

class Name {
  String title;
  String first;
  String last;

  Name({this.title, this.first, this.last});

  Name.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    first = json['first'];
    last = json['last'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['first'] = this.first;
    data['last'] = this.last;
    return data;
  }
}

class Location {
  Street street;
  String city;
  String state;
  String country;
  var postcode;
  Coordinates coordinates;
  Timezone timezone;

  Location(
      {this.street,
      this.city,
      this.state,
      this.country,
      this.postcode,
      this.coordinates,
      this.timezone});

  Location.fromJson(Map<String, dynamic> json) {
    street =
        json['street'] != null ? new Street.fromJson(json['street']) : null;
    city = json['city'];
    state = json['state'];
    country = json['country'];
    postcode = json['postcode'];
    coordinates = json['coordinates'] != null
        ? new Coordinates.fromJson(json['coordinates'])
        : null;
    timezone = json['timezone'] != null
        ? new Timezone.fromJson(json['timezone'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.street != null) {
      data['street'] = this.street.toJson();
    }
    data['city'] = this.city;
    data['state'] = this.state;
    data['country'] = this.country;
    data['postcode'] = this.postcode;
    if (this.coordinates != null) {
      data['coordinates'] = this.coordinates.toJson();
    }
    if (this.timezone != null) {
      data['timezone'] = this.timezone.toJson();
    }
    return data;
  }
}

class Street {
  int number;
  String name;

  Street({this.number, this.name});

  Street.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['name'] = this.name;
    return data;
  }
}

class Coordinates {
  String latitude;
  String longitude;

  Coordinates({this.latitude, this.longitude});

  Coordinates.fromJson(Map<String, dynamic> json) {
    latitude = json['latitude'];
    longitude = json['longitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;
    return data;
  }
}

class Timezone {
  String offset;
  String description;

  Timezone({this.offset, this.description});

  Timezone.fromJson(Map<String, dynamic> json) {
    offset = json['offset'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['offset'] = this.offset;
    data['description'] = this.description;
    return data;
  }
}