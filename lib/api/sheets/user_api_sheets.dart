import 'package:bar_scanner/model/secondary_map.dart';
import 'package:gsheets/gsheets.dart';

import '../../model/item.dart';

class UserSheetsApi {
  static const _credentials = r"""
{
  "type": "service_account",
  "project_id": "rock-of-ages-414013",
  "private_key_id": "f6bdbf90715b693dc7bccba788ea4757fd433c31",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQCuYHltGcGQStgB\nWekpquh87TDa0mCYjwl8JLtYzokiYpHTJ/Bo8aIl0/BDqpGcJMAlAS+0SWCVQ7EP\nhHTrNfpCAqXQND6We5Jq+Di6e7aNo4CeDjwdK4rrL1wZL1t2auOgX2ffiCnoqgrr\nBOESOd6XUT3MeLhXj+jXRNXnXthmNSRMhwpnx3N1L3BeBQLbSqrKxGiY3e1RyRbB\n4m447AsOkIRIQV2Lh+R/88Im42QP8Uc1H3D4+jOjqRRkXqcZ1y94EpgTT5HIteuX\nARTmTy9mV3cp4SKyEskFQ3qfSiVSNmzGNzRd17q0Ys6Jbt13hDgJl/OJsWz0/l5f\nHBu2eEi7AgMBAAECggEAOUfHm2cShmuPeSInzWAu7pqbqcXhpTuXSghm4k02Du2C\nKXK9Ljvxn6t3CUNGgZww4fb5zKct6tpJl2dTYNBiXLyx6yq+RIBjIHBZciihVvWW\nklTqukpLX+Y2wq8jxEpoa43reSopWhxBaeI4bNxFmj89paUiKOFFAzHBcjddrnTL\nDSwsB8iI9w+4odCm+8cDtbC8Yvh5EHE6rxzl6oxt67yozZVO3oNQM5gIuddvTPB7\nioN2Fe5kQJRekWPYyl29wdCT3uUNjLMN7ORZGTitYEizkRYSWNAS4zO1IBcZCdEu\nLFqQH6/j0DdSVuu8WRgmkNajE9A33vhjVBFhOvTGgQKBgQDnbGsSOvl/G+JEftjP\nsZxyOGqT0YjZ9TPq8X7rweCo6e2I+xTPj/UFeKG1+7XLdRXTVU/vKljy6eAkxJT9\nDsDdJ6gsfMLHjI5NqCDVtUZ4pptefP0DOjt2ftpql47Kaxf5CgAZ/97/HsYWjrCG\nj/uUkGAJ4Bw43dWOkizTEtEeEwKBgQDA5SkVVV8d7SDX8ngbCrD8ZHHHmzp8YFxX\nGFA7sYXQBLyc/8JVnoI9CCyDoc5CphXboKejwK/46dGyxDHOyRVGDCF7SodQiliU\nIpnHKfkg//i+qMfsTOhm8H/Llc8IsqzFAdfSnGDD9Gvitu/1n0ZuSHLxbyH0dPTX\npLuoxB3fuQKBgAg03AcleDt9raRoKyASWE3kmkLrp0KzY0ftkGaj1WeoA/hbjv1d\nSX8MLA/cATJZ0JBR8ie1BLp4eK5VGkNvBn/RLDGHqxCQd2thjuiFKR6WKeRL4lz+\n76TgEra88R9UdOEr7Zz+adX6LWQXY0MiT/WQuRcgj1+k3jHUFSrW+/tpAoGAPQ/N\n44z04TpRbUq6LoVB5YO+aNuAtiKi2Ic/zsWxgFofguuLjyLwQ3W08a5k5sBApxfC\nOZojmn4Z/acRxU3uSBBLAQZks2A4Dhyt5VgqHwIoseIn92uZHgz/x2iS80PsYSjm\nMyuBjkZvaINUjsJuvzZ7/GWbsBDd+O2S4ifC9TECgYB1jHHKkkMLU9q3Uz6N0Qw6\n5OncRLJobpYs6/Ce4DjSAVGyOyIFOsGGEHpo/3J2AnDiuwnmSi62+BOgqV3kRPei\nO8FJDkpIOaT3GQGXuiMh143hjvdeFgieYtSXIHkmpsdPs3ggEAm0JF5+ibrOpIER\nxfzPb6BFBH0QKEtqlWx2Kw==\n-----END PRIVATE KEY-----\n",
  "client_email": "rock-of-ages@rock-of-ages-414013.iam.gserviceaccount.com",
  "client_id": "102858526049704571824",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/rock-of-ages%40rock-of-ages-414013.iam.gserviceaccount.com",
  "universe_domain": "googleapis.com"
}
""";

static final _spreadsheetId = "1V65EJsn6i7A7ZmciQMnZCgD36eYjkMlsFyN1mYyoeQg";
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