import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

/// reference https://www.dicoding.com/academies/199/discussions/136107
/// reference https://stackoverflow.com/a/69511058/13238988
class Shared {
  static Future<HttpClient> customHttpClient() async {
    SecurityContext context = SecurityContext(withTrustedRoots: false);

    try {
      /// load cert
      List<int> bytes =
          (await rootBundle.load('assets/cert.pem')).buffer.asUint8List();

      /// set cert to trusted certificate
      context.setTrustedCertificatesBytes(bytes);

      /// handling cert
    } on TlsException catch (e) {
      if (e.osError?.message != null &&
          e.osError!.message.contains('CERT_ALREADY_IN_HASH_TABLE')) {
        log('createHttpClient() - cert already trusted! Skipping.');
      } else {
        log('createHttpClient().setTrustedCertificateBytes EXCEPTION: $e');
        rethrow;
      }
    } catch (e) {
      log('error $e');
      rethrow;
    }

    /// set context to HttpClient
    HttpClient _client = HttpClient(context: context);
    _client.badCertificateCallback =
        (X509Certificate cert, String host, int port) => false;

    return _client;
  }

  static Future<http.Client> createLEClient() async {
    IOClient client = IOClient(await customHttpClient());
    return client;
  }
}
