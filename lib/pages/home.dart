import 'package:easyaccess/components/AppButton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(
      title: Text("CHANGEME"),
    );
    final height = MediaQuery.of(context).size.height -
        appBar.preferredSize.height -
        MediaQuery.of(context).padding.top;
    return Scaffold(
      appBar: appBar,
      body: Container(
        height: height,
        width: MediaQuery.of(context).size.width,
        child: Center(
          child: GridView.count(
            crossAxisCount: 2,
            children: [
              MenuButton(
                text: AppLocalizations.of(context)!.home_cert,
                icon: Icons.document_scanner_sharp,
                onPressed: () => Navigator.pushNamed(context, "/cert"),
              ),
              MenuButton(
                text: AppLocalizations.of(context)!.home_dni,
                icon: Icons.perm_identity,
                onPressed: () => Navigator.pushNamed(context, "/dni"),
              ),
              MenuButton(
                text: AppLocalizations.of(context)!.home_creator,
                icon: Icons.person,
                onPressed: () => Navigator.pushNamed(context, "/creator"),
              ),
              MenuButton(
                text: AppLocalizations.of(context)!.home_donation,
                icon: Icons.attach_money_sharp,
                onPressed: () => Navigator.pushNamed(context, "/donate"),
              )
            ],
          ),
        ),
      ),
    );
  }
}

/*
MenuButton(
                  text: "Cert",
                  icon: Icons.document_scanner_sharp,
                  onPressed: () => {print("CERT")}),
              MenuButton(
                  text: "DNI",
                  icon: Icons.perm_identity,
                  onPressed: () => {print("DNI")})

*/
