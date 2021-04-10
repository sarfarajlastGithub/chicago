// Licensed to the Apache Software Foundation (ASF) under one or more
// contributor license agreements.  See the NOTICE file distributed with
// this work for additional information regarding copyright ownership.
// The ASF licenses this file to you under the Apache License,
// Version 2.0 (the "License"); you may not use this file except in
// compliance with the License.  You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:chicago/chicago.dart' as chicago;
import 'package:flutter/widgets.dart';

import 'text.dart';

class ListsDemo extends StatelessWidget {
  const ListsDemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return chicago.Rollup(
      heading: const HeaderText('Lists'),
      child: chicago.Border(
        borderColor: const Color(0xff999999),
        backgroundColor: const Color(0xffffffff),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(4, 2, 4, 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              BasicListDemo(),
              SizedBox(width: 12),
              LazyListDemo(),
              SizedBox(width: 12),
              MultiSelectListDemo(),
              SizedBox(width: 12),
              ImageListDemo(),
              SizedBox(width: 12),
              ListButtonsDemo(),
            ],
          ),
        ),
      ),
    );
  }
}

class BasicListDemo extends StatefulWidget {
  const BasicListDemo({Key? key}) : super(key: key);

  @override
  _BasicListDemoState createState() => _BasicListDemoState();
}

class _BasicListDemoState extends State<BasicListDemo> {
  late chicago.ListViewSelectionController _selectionController;

  static const List<String> _colors = [
    'Blue',
    'Green',
    'Orange',
    'Purple',
    'Red',
    'Yellow',
  ];

  static Widget _buildItem({
    required BuildContext context,
    required int index,
    required bool isSelected,
    required bool isHighlighted,
    required bool isDisabled,
  }) {
    String text = _colors[index];
    return isSelected ? WhiteText(text) : Text(text);
  }

  @override
  void initState() {
    super.initState();
    _selectionController = chicago.ListViewSelectionController();
  }

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        const BoldText('Basic'),
        const SizedBox(height: 4),
        SizedBox(
          width: 72,
          height: 90,
          child: chicago.Border(
            borderColor: const Color(0xff999999),
            child: chicago.ScrollableListView(
              itemHeight: 19,
              length: _colors.length,
              selectionController: _selectionController,
              itemBuilder: _buildItem,
            ),
          ),
        ),
      ],
    );
  }
}

class LazyListDemo extends StatefulWidget {
  const LazyListDemo({Key? key}) : super(key: key);

  @override
  _LazyListDemoState createState() => _LazyListDemoState();
}

class _LazyListDemoState extends State<LazyListDemo> {
  late chicago.ListViewSelectionController _selectionController;

  static Widget _buildItem({
    required BuildContext context,
    required int index,
    required bool isSelected,
    required bool isHighlighted,
    required bool isDisabled,
  }) {
    String text = '${index + 1}';
    return isSelected ? WhiteText(text) : Text(text);
  }

  @override
  void initState() {
    super.initState();
    _selectionController = chicago.ListViewSelectionController();
  }

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BoldText('Lazy'),
        const SizedBox(height: 4),
        SizedBox(
          width: 90,
          height: 90,
          child: chicago.Border(
            borderColor: const Color(0xff999999),
            child: chicago.ScrollableListView(
              itemHeight: 19,
              length: 1000000,
              selectionController: _selectionController,
              itemBuilder: _buildItem,
            ),
          ),
        ),
      ],
    );
  }
}

class MultiSelectListDemo extends StatefulWidget {
  const MultiSelectListDemo({Key? key}) : super(key: key);

  @override
  _MultiSelectListDemoState createState() => _MultiSelectListDemoState();
}

class _MultiSelectListDemoState extends State<MultiSelectListDemo> {
  late chicago.ListViewSelectionController _selectionController;

  static const List<String> _shapes = [
    'Circle',
    'Ellipse',
    'Square',
    'Rectangle',
    'Hexagon',
    'Octagon',
  ];

  static Widget _buildItem({
    required BuildContext context,
    required int index,
    required bool isSelected,
    required bool isHighlighted,
    required bool isDisabled,
  }) {
    String text = _shapes[index];
    return isSelected ? WhiteText(text) : Text(text);
  }

  @override
  void initState() {
    super.initState();
    _selectionController = chicago.ListViewSelectionController(selectMode: chicago.SelectMode.multi)
      ..selectedRanges = [chicago.Span(0, 0), chicago.Span(2, 3)];
  }

  @override
  void dispose() {
    _selectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BoldText('Multi-Select'),
        const SizedBox(height: 4),
        SizedBox(
          width: 90,
          height: 90,
          child: chicago.Border(
            borderColor: const Color(0xff999999),
            child: chicago.ScrollableListView(
              itemHeight: 19,
              length: _shapes.length,
              selectionController: _selectionController,
              itemBuilder: _buildItem,
            ),
          ),
        ),
      ],
    );
  }
}

class ImageListDemo extends StatefulWidget {
  const ImageListDemo({Key? key}) : super(key: key);

  @override
  _ImageListDemoState createState() => _ImageListDemoState();
}

class _ImageItem {
  const _ImageItem(this.name, this.asset);

  final String name;
  final String asset;
}

class _ImageListDemoState extends State<ImageListDemo> {
  late chicago.ListViewSelectionController _selectionController;
  late chicago.ListViewItemDisablerController _disablerController;

  static const List<_ImageItem> _items = [
    _ImageItem('Anchor', 'assets/anchor.png'),
    _ImageItem('Bell', 'assets/bell.png'),
    _ImageItem('Clock', 'assets/clock.png'),
    _ImageItem('Cup', 'assets/cup.png'),
    _ImageItem('House', 'assets/house.png'),
    _ImageItem('Star', 'assets/star.png'),
  ];

  static Widget _buildItem({
    required BuildContext context,
    required int index,
    required bool isSelected,
    required bool isHighlighted,
    required bool isDisabled,
  }) {
    final String text = _items[index].name;
    return Row(
      children: [
        Image.asset(_items[index].asset),
        SizedBox(width: 4),
        isDisabled
            ? GreyText(text)
            : isSelected
                ? WhiteText(text)
                : Text(text),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _selectionController = chicago.ListViewSelectionController();
    _disablerController = chicago.ListViewItemDisablerController()
      ..filter = (int index) => index == 2 || index == 3;
  }

  @override
  void dispose() {
    _selectionController.dispose();
    _disablerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const BoldText('Image'),
        const SizedBox(height: 4),
        SizedBox(
          width: 90,
          height: 90,
          child: chicago.Border(
            borderColor: const Color(0xff999999),
            child: chicago.ScrollableListView(
              itemHeight: 19,
              length: _items.length,
              selectionController: _selectionController,
              itemDisabledController: _disablerController,
              itemBuilder: _buildItem,
            ),
          ),
        ),
      ],
    );
  }
}

class ListButtonsDemo extends StatefulWidget {
  const ListButtonsDemo({Key? key}) : super(key: key);

  @override
  _ListButtonsDemoState createState() => _ListButtonsDemoState();
}

class _ColorItem {
  const _ColorItem(this.color, this.name);

  final Color color;
  final String name;
}

class _ListButtonsDemoState extends State<ListButtonsDemo> {
  late chicago.ListViewSelectionController _basicSelectionController;
  late chicago.ListViewSelectionController _imageSelectionController;
  late chicago.ListViewSelectionController _colorSelectionController;

  Widget _buildColorItem(
    _ColorItem item, {
    bool isSelected = false,
    bool includeName = true,
  }) {
    Widget result = SizedBox(
      width: 19,
      height: 19,
      child: chicago.SetBaseline(
        baseline: 15.5,
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(),
            color: item.color,
          ),
        ),
      ),
    );
    if (includeName) {
      result = Row(
        children: [
          result,
          SizedBox(width: 8),
          isSelected ? WhiteText(item.name) : Text(item.name),
        ],
      );
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    _basicSelectionController = chicago.ListViewSelectionController()..selectedIndex = 0;
    _imageSelectionController = chicago.ListViewSelectionController()..selectedIndex = 2;
    _colorSelectionController = chicago.ListViewSelectionController()..selectedIndex = 0;
  }

  @override
  void dispose() {
    _basicSelectionController.dispose();
    _imageSelectionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BoldText('List Buttons'),
        SizedBox(height: 4),
        chicago.Form(
          children: [
            chicago.FormField(
              label: 'Basic',
              child: chicago.ListButton<String>(
                items: ['Red', 'Orange', 'Yellow', 'Green', 'Blue', 'Purple'],
                selectionController: _basicSelectionController,
              ),
            ),
            chicago.FormField(
              label: 'Image',
              child: chicago.ListButton<String>(
                items: ['anchor', 'bell', 'clock', 'cup', 'house', 'star'],
                selectionController: _imageSelectionController,
                builder: (BuildContext context, String? item, bool isForMeasurementOnly) {
                  final String asset = item as String;
                  final String path = 'assets/$asset.png';
                  final String label = asset[0].toUpperCase() + asset.substring(1);
                  return Padding(
                    padding: EdgeInsets.all(1),
                    child: Row(
                      children: [
                        Image.asset(path),
                        SizedBox(width: 4),
                        Text(
                          label,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ],
                    ),
                  );
                },
                itemBuilder: (
                  BuildContext context,
                  String item,
                  bool isSelected,
                  bool isHighlighted,
                  bool isDisabled,
                ) {
                  final String path = 'assets/$item.png';
                  final String label = item[0].toUpperCase() + item.substring(1);
                  return Padding(
                    padding: const EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Image.asset(path),
                        const SizedBox(width: 4),
                        isDisabled
                            ? GreyText(label)
                            : isSelected
                                ? WhiteText(label)
                                : Text(label),
                      ],
                    ),
                  );
                },
              ),
            ),
            chicago.FormField(
              label: 'Color',
              child: chicago.ListButton<_ColorItem>(
                selectionController: _colorSelectionController,
                items: const <_ColorItem>[
                  _ColorItem(Color(0xffff0000), 'Red'),
                  _ColorItem(Color(0xffffa500), 'Orange'),
                  _ColorItem(Color(0xffffff00), 'Yellow'),
                  _ColorItem(Color(0xff00ff00), 'Green'),
                  _ColorItem(Color(0xff0000ff), 'Blue'),
                  _ColorItem(Color(0xff4b0082), 'Indigo'),
                  _ColorItem(Color(0xff8f008f), 'Violet'),
                ],
                builder: (BuildContext context, _ColorItem? item, bool isForMeasurementOnly) {
                  return _buildColorItem(item!, isSelected: false, includeName: false);
                },
                itemBuilder: (
                  BuildContext context,
                  _ColorItem item,
                  bool isSelected,
                  bool isHighlighted,
                  bool isDisabled,
                ) {
                  return Padding(
                    padding: EdgeInsets.all(5),
                    child: _buildColorItem(item, isSelected: isSelected),
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}