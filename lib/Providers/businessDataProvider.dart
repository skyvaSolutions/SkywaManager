import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:skywamanager/Global&Constants/globalsAndConstants.dart';
import 'package:skywamanager/models/QMetaData.dart';
import 'package:skywamanager/services/qAPIServices.dart';

class businessDataProvider with ChangeNotifier {
  Future<void> getQMetaData() async {
    var data = await Dio().get(
        "https://shoeboxtx.veloxe.com:36251/api/GetQMetadata?UserToken=95A5B76C-9B05-4992-A44D-DEA8E7AE094C644791499&QID=46181836-EC04-469E-8B2B-1E9F9565E5D0");
    QMetaData temp = QMetaData.fromJson(data.data);
    print(data.data);
    queueData = temp;
  }

  Future<void> getReservationData(String id) async {
    print(
        "https://shoeboxtx.veloxe.com:36251/api/getAllReservationsForMyLocation?UserToken=95A5B76C-9B05-4992-A44D-DEA8E7AE094C644791499&QID=${id}");
    var data = await Dio().get(
        "https://shoeboxtx.veloxe.com:36251/api/getAllReservationsForMyLocation?UserToken=95A5B76C-9B05-4992-A44D-DEA8E7AE094C644791499&QID=${id}");
    print(data.data);
  }
}
