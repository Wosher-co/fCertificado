import 'dart:convert';
import 'dart:io';

import 'package:dart_base45/dart_base45.dart';
import 'package:dart_cose/dart_cose.dart';

class CertInfo {
  final String qrInfo;

  final String country;
  final String service;
  final String name;
  final String lastNames;
  final String date;

  // Create constructor with required on all fields
  CertInfo({
    required this.qrInfo,
    required this.country,
    required this.service,
    required this.name,
    required this.lastNames,
    required this.date,
  });

  // Map to CertInfo
  factory CertInfo.fromQRMap(String originalQR, Map<dynamic, dynamic> map) {
    // TODO: Missing fields like expiration date, etc.

    return CertInfo(
      qrInfo: originalQR,
      country: map[1] as String,
      service: map[-260][1]['v'][0]['is'] as String,
      name: map[-260][1]['nam']['gn'] as String,
      lastNames: map[-260][1]['nam']['fn'] as String,
      date: map[-260][1]['dob'] as String,
    );
  }

  // Convert to json string
  String toJson() {
    return json.encode(toMap());
  }

  // Convert to map
  Map<String, dynamic> toMap() {
    return {
      'qrInfo': qrInfo,
      'country': country,
      'service': service,
      'name': name,
      'lastNames': lastNames,
      'date': date,
    };
  }

  // To string
  @override
  String toString() {
    return 'CertInfo{qrInfo: $qrInfo, country: $country, service: $service, name: $name, lastNames: $lastNames, date: $date}';
  }

  static CertInfo? fromQRData(String qrData) {
    print(qrData);
    if (qrData == null || qrData == "" || qrData.substring(0, 4) != "HC1:") {
      // Invalid file
      return null;
    }
    var base45_decoded = Base45.decode(qrData.substring(4));
    var inflated = zlib.decode(base45_decoded);
    final r = Cose.decodeAndVerify(
      inflated,
      {'kid': '''pem'''},
    );
    var cert = CertInfo.fromQRMap(qrData, r.payload);
  }
}
