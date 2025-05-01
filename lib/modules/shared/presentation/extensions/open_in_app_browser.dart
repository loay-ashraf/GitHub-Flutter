import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

extension OpenInAppBrowserWidget on Widget {
  void openBrowser({required String url}) async {
    final ChromeSafariBrowser browser = ChromeSafariBrowser();
    await browser.open(
      url: WebUri(url),
      settings: ChromeSafariBrowserSettings(
        dismissButtonStyle: DismissButtonStyle.CLOSE,
        barCollapsingEnabled: true,
      ),
    );
  }
}

extension OpenInAppBrowserState on State {
  void openBrowser({required String url}) async {
    final ChromeSafariBrowser browser = ChromeSafariBrowser();
    await browser.open(
      url: WebUri(url),
      settings: ChromeSafariBrowserSettings(
        dismissButtonStyle: DismissButtonStyle.CLOSE,
        barCollapsingEnabled: true,
      ),
    );
  }
}
