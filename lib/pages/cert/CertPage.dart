import 'package:easyaccess/db/dbManager.dart';
import 'package:easyaccess/models/CertInfo.dart';
import 'package:easyaccess/pages/cert/displayCert.dart';
import 'package:easyaccess/pages/cert/selectCert.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

class CertPage extends StatefulWidget {
  CertPage({Key? key}) : super(key: key);

  @override
  _CertPageState createState() => _CertPageState();
}

class _CertPageState extends State<CertPage> {
  final collectionName = "certs";
  final documentId = "cert";

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: DBManager.getAllPages(),
      builder: (BuildContext context, AsyncSnapshot<List<DBCert>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
          );
        }

        List<DBCert>? certs = snapshot.data;
        if (certs == null || certs.isEmpty) {
          return SelectCert(
            firstTime: true,
          );
        }

        List<CertInfo> certInfos = [];
        certs.map((DBCert cert) {
          return CertInfo.fromQRData(cert.qrData);
        }).forEach((element) => {
              if (element != null) {certInfos.add(element)}
            });

        return PaginatedCerts(
          certs: certInfos,
        );
      },
    );
  }
}
