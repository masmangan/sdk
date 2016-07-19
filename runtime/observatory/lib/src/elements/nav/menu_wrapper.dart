// Copyright (c) 2016, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:observatory/app.dart';
import 'package:observatory/src/elements/helpers/tag.dart';
import 'package:observatory/src/elements/shims/binding.dart';
import 'package:observatory/src/elements/nav/menu.dart';

class NavMenuElementWrapper extends HtmlElement {
  static final binder = new Binder<NavMenuElementWrapper>(
    const [const Binding('anchor'), const Binding('link'),
           const Binding('last')]);

  static const tag =
    const Tag<NavMenuElementWrapper>('nav-menu');

  String _anchor = '---';
  String _link;
  bool _last = false;
  String get anchor => _anchor;
  String get link => _link;
  bool get last => _last;
  set anchor(String value) {
    _anchor = value; render();
  }
  set link(String value) {
    _link = value; render();
  }
  set last(bool value) {
    _last = value; render();
  }

  NavMenuElementWrapper.created() : super.created() {
    binder.registerCallback(this);
    _anchor = getAttribute('anchor');
    _link = getAttribute('link');
    _last = getAttribute('') != null;
    createShadowRoot();
    render();
  }

  @override
  void attached() {
    super.attached();
    render();
  }

  void render() {
    shadowRoot.children = [];
    if (_anchor == null || _last == null) return;

    shadowRoot.children = [
      new NavMenuElement(_anchor, link: _link, last: last,
                                 queue: ObservatoryApplication.app.queue)
        ..children = [new ContentElement()]
    ];
  }
}
