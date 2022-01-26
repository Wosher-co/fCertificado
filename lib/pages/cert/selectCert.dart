import 'dart:io';

import 'package:easyaccess/models/CertInfo.dart';
import 'package:easyaccess/pages/cert/displayCert.dart';
import 'package:easyaccess/pages/components/buttons.dart';
import 'package:easyaccess/utils/certUtils.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dart_base45/dart_base45.dart';
import 'package:cbor/cbor.dart';
import 'package:dart_cose/dart_cose.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SelectCert extends StatelessWidget {
  final bool firstTime;

  const SelectCert({Key? key, this.firstTime = false}) : super(key: key);

  void _wrongFile() {}

  void _saveCert(String qrData) {}

  void _selectCert(bool pdf) async {
    FilePickerResult? result;
    if (pdf) {
      result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ["pdf"],
        type: FileType.custom,
      );
    } else {
      result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.image,
      );
    }

    if (result == null || result.files[0].path == null) {
      _wrongFile();
      return;
    }

    final String? data = pdf
        ? await CertUtils.getPdfData(result.files[0].path!)
        : await CertUtils.getImageData(result.files[0].path!);

    if (data == null || data.isEmpty) {
      _wrongFile();
      return;
    }

    _saveCert(data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.cert_select_title),
      ),
      body: Container(
        width: double.infinity,
        height: MediaQuery.of(context).size.height * 0.6,
        padding: const EdgeInsets.all(15.0),
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                this.firstTime
                    ? AppLocalizations.of(context)!.cert_select_start_guide
                    : AppLocalizations.of(context)!.cert_select_guide,
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
            ),
            Column(
              children: [
                CertButton(
                  buttonText: AppLocalizations.of(context)!.cert_select_pdf,
                  onPressed: () => _selectCert(true),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Divider(
                    color: Theme.of(context).secondaryHeaderColor,
                    height: 2,
                    thickness: 2,
                  ),
                ),
                CertButton(
                  buttonText: AppLocalizations.of(context)!.cert_select_image,
                  onPressed: () => _selectCert(false),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
