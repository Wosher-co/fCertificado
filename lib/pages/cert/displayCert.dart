import 'package:easyaccess/models/CertInfo.dart';
import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PaginatedCerts extends StatelessWidget {
  final List<CertInfo> certs;

  const PaginatedCerts({Key? key, required this.certs}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DisplayCert(certInfo: certs[0]);
  }
}

class DisplayCert extends StatelessWidget {
  final CertInfo certInfo;

  const DisplayCert({Key? key, required this.certInfo}) : super(key: key);

  Text getText(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // TODO: CHange
        title: Text('Certificate'),
        actions: <Widget>[
          PopupMenuButton<String>(
            itemBuilder: (BuildContext context) {
              return ["Home", "Profile", "Setting"].map((String choice) {
                return PopupMenuItem<String>(
                  child: Text(choice),
                  value: choice,
                );
              }).toList();
            },
            onSelected: (item) {
              switch (item) {
                case 'Home':
                  print('Home clicked');
                  break;
                case 'Profile':
                  print('Profile clicked');
                  break;
                case 'Setting':
                  print('Setting clicked');
                  break;
              }
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            QrImage(
              data: certInfo.qrInfo,
              version: QrVersions.auto,
              size: MediaQuery.of(context).size.width,
            ),
            getText('Name: ' + certInfo.name + ' ' + certInfo.lastNames),
            getText('Birth: ' + certInfo.date),
            getText('Service: ' + certInfo.service),
            getText('Country: ' + certInfo.country),
          ],
        ),
      ),
    );
  }
}
