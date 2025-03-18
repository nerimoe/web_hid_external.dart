@JS()
library web_hid;

import 'dart:html' show EventTarget, EventListener, Event;
import 'dart:js_util' show promiseToFuture;

import 'dart:js' show allowInterop;
import 'dart:js_util' as js_util;

import 'dart:typed_data';

import 'package:js/js.dart';

import 'src/js_facade.dart';

part 'src/web_hid_base.dart';

@JS('navigator.hid')
external _Hid? get _hid;

bool canUseHid() => _hid != null;

Hid? _instance;
Hid get hid {
  if (_hid != null) {
    return _instance ??= Hid._(_hid!);
  }
  throw 'navigator.hid unavailable';
}

class HidReport {
  final int reportId;
  final List<int> data;
  HidReport(this.reportId, this.data);
}

typedef ReportListener = dynamic Function(HidReport report);
