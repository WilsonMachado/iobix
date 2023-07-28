import 'package:gsheets/gsheets.dart';

class AbpSheetApi {
  // Llave que me permite tener acceso al drive

  static const _credential = r''' 
{
  "type": "service_account",
  "project_id": "prueba-abp-keys",
  "private_key_id": "e486a2ecdea0fec93bf38c6787170fdd55353dff",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvAIBADANBgkqhkiG9w0BAQEFAASCBKYwggSiAgEAAoIBAQC7YdnjuiVbdN8L\nKYpJCwpI6fwxampKF+w4WxwtEWB/Z804UMEb4zioLatHCFBjoU94cXqSxKEn7f1u\npaD/ssQ+Dy1NfJo1XmMdrOEYz06T4alEc7xGOoJqDhnLB2ZY9/elu1E9GrZqboYG\nNu0ZxYNSzb+QnISRiuGqkcfgcBx1bE5PyaFIPuje32SX2ROfDsTEGEUM94r9q0/+\naSZXSNYxB39+A/L8ebUrh6k4Nu43hZhWamZLKFQ+ZfjeVyVZGbZi/sbM5bpnhf0y\n8QI1SCrFxDo7MWNx6642kMF3cIqcb+pdxRkwZPfGa3/WUi9pt1xq8y+FQ+4sEPy2\nIcJWdT91AgMBAAECggEAEsJUDvFWxhYoMjThbDiXuf76yXOu2mYUtvugEX742yho\nKigjfQg9ZtDTodPaQG8oxpUNwV3ACIBR697XBGJANTpNvcEoqwkdAR6KlnJCmplv\n2bOAeMNoxPdOa7386BFDEKt1EZn4AyW3cy3ShM76O7LvZ6nTt8JgnzPi/7wZjUOz\ni0QIqOJZTqIL6YEMjZaKY7YDm1zriBIh+oyTJfnS/Og5qP8wPA7VnEWrxe9Z0dL/\nQfXb5S9GY7U8hzt0PywZ8DEjsZ36NS9/raPWD+fTvPpLgNJO3P5KU7d2t/agBNMC\ne+CXjEm72iNzLih3dTFYQGtZSdz+zcTZE5+jTx5SrQKBgQDqT/1Mx128OwCv1GkW\n5gSw7xGi17yX/nEdWhHLurdArFW2JYW4PanEUb328ZnokzxK5NEWZg3SO2uS39XL\nBAAvMHoBvu4Qrk6lVklVjWy3rMAAarHJpxvAn0GbQYxnbVUEzayIO+N285dt3P2i\nkZY06MQCnrzb8mcTI6ouGVkQOwKBgQDMudrFEyjOBWb56/Cq9E4Ca4sWvcY1zAJc\nSXwVBS2exrSS3gUlboJ2kBIw3fYIXb+Gc4uVTppPU8zG0dRxhiHfrgJL6WuD/H7U\njzjpps7cTI7+5F2+ux7tjUAmMZ/vE6yKYZVAqOqJD7lye1p+94wMKnKIWfjcqYEQ\n7GBxmY8kDwKBgHnTyzTPd+o1l17Uhytzvz6rnrTXjOROVEvZl+UgmMVUlWAWVFd+\nIDXF9opeBhMJ8tBR9nC58Te802rTXNqootvmTZl4x1j++D85BPophTxe4pmU4Amk\nDGbzpu3tf+4Kx6ius6VF1jfz4Wkq/Ok43yt1Vuyx0ipd97/YzFQZs9gfAoGAcuwd\nr6VasZP8w2y70+uCYv9lu6VaP9a+uHmTyuT2P/wBX7R8JRAM8mtbmszukLG3ks0H\n3Q+btc4v1KfzXqrSFxNCPMTSUuwJcl7Xrumxk57yYollSm0WJnm1Oft/cSCVKbUv\nqHVp+vi1vFscaMujdSza0EnZVl1ck1htpzdxT+cCgYAqn2IsYK86xleUxlj5T20X\nte5MpdUX7CZ3JXyXI+tPXDxaEMvGnrKgNnOppTDB3Gqv1Rp7HL4A+f7qfwDUnDtH\nQX2LfMd5aPyidD/jqFDal8ZvvYBFRBx/wcexADu1CtfHfqFQBVexM5uK9feETttv\nDX3jOgUCOwoZ0+z26AAXgQ==\n-----END PRIVATE KEY-----\n",
  "client_email": "pruebaabpkeys@prueba-abp-keys.iam.gserviceaccount.com",
  "client_id": "105809415546412593151",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/pruebaabpkeys%40prueba-abp-keys.iam.gserviceaccount.com"
}
''';

  static final _spreadsheetId =
      '14XsMIIuB6b3TS2G1uUMeb9DOqRkIqSzRiBwXC695dmg'; // ID de la hoja de cálculo que contiene la información
  static final _gsheets = GSheets(_credential);
  static Worksheet _keySheet;
  static List<String> _sheetNames;
  static Spreadsheet spreadsheet;

  Future init() async {
    spreadsheet = await _gsheets.spreadsheet(_spreadsheetId);
    //_keySheet = spreadsheet.worksheetByTitle("Llaves_SMDCv3_Abril2023_Nuevas");
    _sheetNames = spreadsheet.sheets.map((sheet) => sheet.title).toList();
  }

  Future getById(int id) async {
    // Si retorna null, no han seteado la hoja de trabajo. De lo contrario, todo ok
    if (_keySheet == null) {
      return _keySheet;
    } else {
      String sn = await _keySheet.values.value(column: 3, row: id + 1);
      String devAddr = await _keySheet.values.value(column: 4, row: id + 1);
      String nwkS = await _keySheet.values.value(column: 5, row: id + 1);
      String appS = await _keySheet.values.value(column: 6, row: id + 1);

      return [sn, devAddr, nwkS, appS];
    }
  }

  Future<Map<int, String>> updateSpreadSheetsNames() async {
    await init();
    return getSpreadSheetsNames();
  }

  Future setWorkSpreadSheet(int key) async{
    await init();
    _keySheet = spreadsheet.worksheetByTitle(_sheetNames[key]);
    print("Seleccionando la hoja de trabajo: " + _sheetNames[key]);
  }

  Map<int, String> getSpreadSheetsNames() {
    return _sheetNames.asMap();
  }
}
