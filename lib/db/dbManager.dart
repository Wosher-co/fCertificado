import 'package:easyaccess/utils/stringUtils.dart';
import 'package:localstore/localstore.dart';

class DBCert {
  final String qrData;
  final int page;

  DBCert({required this.qrData, required this.page});
}

class DBManager {
  static final db = Localstore.instance;
  static const certsCollectionName = "FUCKCERTS";
  static const otherCollectionName = "ILLBERICHONEDAY";

  static Future<int> _getNextPage() {
    return getTotalPages().then((value) => value + 1);
  }

  static Future<int> getTotalPages() {
    return db.collection(certsCollectionName).stream.length;
  }

  static Future<int> savePage(String qrData) async {
    int newPageNumber = await _getNextPage();

    await db
        .collection(certsCollectionName)
        .doc(StringUtils.generateRandomString(16))
        .set({'qr': qrData, 'page': 0});

    return newPageNumber;
  }

  static Future<List<DBCert>> getAllPages() async {
    final pages = await db.collection(certsCollectionName).get();

    final List<DBCert> certs = [];

    if (pages == null || pages.isEmpty) {
      return certs;
    }

    pages.forEach((key, doc) {
      certs.add(DBCert(qrData: doc['qr'], page: doc['page']));
    });
    // Return a list of all the qr codes ordered by the page number
    return certs;
  }

  static Future<void> deletePage(int page) async {
    final certs = await getAllPages();
    certs.forEach((element) async {
      if (element.page == page) {
        await db.collection(certsCollectionName).doc(element.qrData).delete();
      }
    });
  }
}
