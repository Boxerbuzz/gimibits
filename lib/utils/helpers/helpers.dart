import 'dart:io';
import 'dart:async' show Future, FutureOr, TimeoutException;
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'dart:math' as math;

///
/// General purpose functions and utilities used through out the app
///
class Helpers {
  static Future<http.Response> httpGetRetry(
      String url, Map<String, dynamic> headers) async {
    http.Response response = await asyncRetry(
      () => http.get(url, headers: headers).timeout(Duration(seconds: 30)),
      //TODO
      retryIf: (e) => e is SocketException || e is TimeoutException,
      maxAttempts: 2,
    );
    return response;
  }

  String locale(BuildContext context) =>
      Localizations.localeOf(context, nullOk: true).toString();

  /// Currency formatter for NGN.
  NumberFormat fiatFormat(BuildContext context,
      {int decimal = 2, String sym = '\$'}) {
    return NumberFormat.currency(
      locale: locale(context),
      name: sym,
      //Change the symbol to any desired symbol
      decimalDigits: decimal,
    );
  }

  static String getAvatar(String email) {
    final String str =
        md5.convert(utf8.encode(email.toLowerCase() ?? '')).toString();
    return 'https://www.gravatar.com/avatar/$str?s=500?&d=retro';
  }

  String numberToPriceString(num value) {
    return value.toString().replaceAllMapped(
        new RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},');
  }
}

navigateRoute(Widget destination, BuildContext context, {bool pop = false}) {
  if (pop == true) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (_) => destination));
  } else {
    Navigator.push(context, MaterialPageRoute(builder: (_) => destination));
  }
}

final _rand = math.Random();

class RetryConfig {
  final Duration delayFactor;
  final double randomizationFactor;
  final Duration maxDelay;
  final int maxAttempts;

  const RetryConfig({
    this.delayFactor = const Duration(milliseconds: 200),
    this.randomizationFactor = 0.25,
    this.maxDelay = const Duration(seconds: 30),
    this.maxAttempts = 4,
  });

  Duration delay(int attempt) {
    assert(attempt >= 0, 'attempt cannot be negative');
    if (attempt <= 0) {
      return Duration.zero;
    }
    final rf = (randomizationFactor * (_rand.nextDouble() * 2 - 1) + 1);
    final exp = math.min(attempt, 31); // prevent overflows.
    final delay = (delayFactor * math.pow(2.0, exp) * rf);
    return delay < maxDelay ? delay : maxDelay;
  }

  Future<T> asyncRetry<T>(
    FutureOr<T> Function() fn, {
    FutureOr<bool> Function(Exception) retryIf,
    FutureOr<void> Function(Exception) onRetry,
  }) async {
    int attempt = 0;
    while (true) {
      attempt++;
      try {
        return await fn();
      } on Exception catch (e) {
        if (attempt >= maxAttempts ||
            (retryIf != null && !(await retryIf(e)))) {
          rethrow;
        }
        if (onRetry != null) {
          await onRetry(e);
        }
      }
      await Future.delayed(delay(attempt));
    }
  }
}

Future<T> asyncRetry<T>(
  FutureOr<T> Function() fn, {
  Duration delayFactor = const Duration(milliseconds: 200),
  double randomizationFactor = 0.25,
  Duration maxDelay = const Duration(seconds: 30),
  int maxAttempts = 8,
  FutureOr<bool> Function(Exception) retryIf,
  FutureOr<void> Function(Exception) onRetry,
}) =>
    RetryConfig(
      delayFactor: delayFactor,
      randomizationFactor: randomizationFactor,
      maxDelay: maxDelay,
      maxAttempts: maxAttempts,
    ).asyncRetry(fn, retryIf: retryIf, onRetry: onRetry);
