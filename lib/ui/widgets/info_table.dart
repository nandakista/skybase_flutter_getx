import 'package:flutter/material.dart';
import 'package:skybase/core/themes/app_style.dart';

class InfoTable extends StatelessWidget {
  final Map<String, String> data;
  final TextStyle? headerTextStyle;
  final TextStyle? cellTextStyle;
  final Map<String, TextStyle> cellTextStyles;
  final double? headerFlex;
  final TextAlign cellTextAlign;
  final bool separatorEnabled;
  final EdgeInsets cellPadding;
  final Color? evenColor;
  final double separatorSpacing;

  const InfoTable({
    Key? key,
    required this.data,
    this.headerTextStyle,
    this.cellTextStyle,
    this.headerFlex,
    this.cellTextStyles = const {},
    this.cellTextAlign = TextAlign.start,
    this.separatorEnabled = true,
    this.cellPadding = const EdgeInsets.fromLTRB(16, 8, 16, 8),
    this.evenColor,
    this.separatorSpacing = 4,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<TableRow> children = [];
    final data = this.data.entries;

    final headerTextStyle = this.headerTextStyle ?? AppStyle.small;
    final cellTextStyle = this.cellTextStyle ?? AppStyle.small;

    final evenRowDecoration =
        evenColor != null ? BoxDecoration(color: evenColor) : null;

    var idx = -1;
    for (var item in data) {
      idx += 1;
      children.add(TableRow(
        decoration: idx % 2 == 0 ? null : evenRowDecoration,
        children: [
          TableCell(
            child: Padding(
              padding: cellPadding,
              child: _HeaderStyle(
                style: headerTextStyle,
                child: Text(item.key, style: headerTextStyle),
              ),
            ),
          ),
          if (separatorEnabled)
            TableCell(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: (cellPadding.top + cellPadding.bottom) / 2.0),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: separatorSpacing),
                  child: _HeaderStyle(
                    style: headerTextStyle,
                    child: Text(':', style: headerTextStyle),
                  ),
                ),
              ),
            )
          else
            const TableCell(child: SizedBox()),
          TableCell(
            child: Padding(
              padding: cellPadding,
              child: _CellStyle(
                style: cellTextStyles[item.key] ?? cellTextStyle,
                child: Text(
                  item.value,
                  style: cellTextStyle,
                  textAlign: cellTextAlign,
                ),
              ),
            ),
          ),
        ],
      ));
    }

    return Table(
      columnWidths: {
        0: IntrinsicColumnWidth(flex: headerFlex),
        1: const IntrinsicColumnWidth(),
        2: const FlexColumnWidth(),
      },
      children: children,
    );
  }
}

const _infoTableHeaderStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.w400,
  color: Colors.black,
  height: 1.4,
);

class _HeaderStyle extends StatelessWidget {
  final Widget child;
  final TextStyle style;

  const _HeaderStyle({
    Key? key,
    required this.child,
    this.style = const TextStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: _infoTableHeaderStyle.merge(style),
      child: child,
    );
  }
}

const _infoTableCellStyle = TextStyle(
  fontSize: 12,
  fontWeight: FontWeight.normal,
  color: Colors.black,
  height: 1.4,
);

class _CellStyle extends StatelessWidget {
  final Widget child;
  final TextStyle style;

  const _CellStyle({
    Key? key,
    required this.child,
    this.style = const TextStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: _infoTableCellStyle.merge(style),
      child: child,
    );
  }
}
