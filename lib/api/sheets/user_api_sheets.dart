import 'package:bar_scanner/model/secondary_map.dart';
import 'package:gsheets/gsheets.dart';

import '../../model/item.dart';

class UserSheetsApi {
  static const _credentials = r"""""";

static final _spreadsheetId = "";
static final _gsheets = GSheets(_credentials);
static Worksheet? _userSheet;
static Worksheet? _updateSheet;
static Worksheet? _loggedSheet;
static Worksheet? _itemNotFoundSheet;
static Worksheet? _secondarycodes;

static Future int() async {
  try{
    final spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
    _userSheet = await _getWorkSheet(spreadsheet, title: 'ROA stock');
    _updateSheet = await _getWorkSheet(spreadsheet, title: 'Update stock');
    _loggedSheet = await _getWorkSheet(spreadsheet, title: 'Logged stock');
    _itemNotFoundSheet = await _getWorkSheet(spreadsheet, title: 'Item Not Found');
    _secondarycodes = await _getWorkSheet(spreadsheet, title: 'Secondary-Primary');

    final firstRow = ItemFields.getFields();
    _updateSheet!.values.insertRow(1, firstRow); // FirstRow is the list of column titles
    _loggedSheet!.values.insertRow(1, firstRow);
    _itemNotFoundSheet!.values.insertRow(1, firstRow);
  } catch (e) {
    print('Init Error: $e');
  }
  
}

static Future<Worksheet> _getWorkSheet( // Function to return 
  Spreadsheet spreadsheet, {
    required String title,
  }
) async {
  try {
    return await spreadsheet.addWorksheet(title);
  } catch (e) {
    return spreadsheet.worksheetByTitle(title)!;
  }
  
}

static Future insert(List<Map<String, dynamic>>rowList) async {
  if(_updateSheet == null) return;
  _updateSheet!.values.map.appendRows(rowList);
}

static Future insertLog(List<Map<String, dynamic>>rowList) async {
  if(_loggedSheet == null) return;
  _loggedSheet!.values.map.appendRows(rowList);
}

static Future insertNotFound(List<Map<String, dynamic>>rowList) async {
  if(_itemNotFoundSheet == null) return;
  _itemNotFoundSheet!.values.map.appendRows(rowList);
}
// static Future<Item?> getById(dynamic id) async {
//   if (_userSheet == null) return null;

//   final json = await _userSheet!.values.map.rowByKey(id, fromColumn: 1);
//   return Item.fromJson(json);
// }

static Future<List<Item>> getAll() async {
  if (_userSheet == null) return <Item>[];

  final items = await _userSheet!.values.map.allRows();
  // print(items);
  // print("object items should be here");
  return items == null ? <Item>[] : items.map(Item.fromJson).toList();
}

static Future<List<Secondary>> getAllSec() async {
  if (_secondarycodes == null) return <Secondary>[];

  final itemsSec = await _secondarycodes!.values.map.allRows();
  // print(items);
  // print("object items should be here");
  return itemsSec == null ? <Secondary>[] : itemsSec.map(Secondary.fromJson).toList();
}

}
