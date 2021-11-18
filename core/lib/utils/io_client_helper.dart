import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/io_client.dart';

class IoClientHelper {
  static Future<IOClient> get ioClient async {
    final certificates = await rootBundle.load('assets/cert.pem');

    SecurityContext securityContext = SecurityContext(withTrustedRoots: false);
    securityContext
        .setTrustedCertificatesBytes(certificates.buffer.asInt8List());
    HttpClient client = HttpClient(context: securityContext);

    client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;
    return IOClient(client);
  }
}
