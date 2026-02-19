import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

String removePlusSign(String phoneNumber) {
  if (phoneNumber.startsWith('+')) {
    return phoneNumber.substring(1);
  }
  return phoneNumber;
}
// String getLastSeenText(String lastSeenString) {
//   try {
//     DateTime lastSeen = DateTime.parse(lastSeenString); // تحويل النص إلى DateTime
//     return timeago.format(lastSeen, locale: 'ar'); // استخدام timeago لعرض النص النسبي
//   } catch (e) {
//     return 'غير معروف'; // في حالة فشل التحويل، عرض نص افتراضي
//   }
// }

String? getCountryCodeFromDialingCode(String dialingCode) {
  final Map<String, String> countryDialingCodes = {
    "93": "AF",
    "355": "AL",
    "213": "DZ",
    "376": "AD",
    "244": "AO",
    "1268": "AG",
    "54": "AR",
    "374": "AM",
    "61": "AU",
    "43": "AT",
    "994": "AZ",
    "1242": "BS",
    "973": "BH",
    "880": "BD",
    "1246": "BB",
    "375": "BY",
    "32": "BE",
    "501": "BZ",
    "229": "BJ",
    "975": "BT",
    "591": "BO",
    "387": "BA",
    "267": "BW",
    "55": "BR",
    "673": "BN",
    "359": "BG",
    "226": "BF",
    "257": "BI",
    "238": "CV",
    "855": "KH",
    "237": "CM",
    "1": "CA",
    "236": "CF",
    "235": "TD",
    "56": "CL",
    "86": "CN",
    "57": "CO",
    "269": "KM",
    "242": "CG",
    "243": "CD",
    "506": "CR",
    "385": "HR",
    "53": "CU",
    "357": "CY",
    "420": "CZ",
    "45": "DK",
    "253": "DJ",
    "1767": "DM",
    "1809": "DO",
    "593": "EC",
    "20": "EG",
    "503": "SV",
    "240": "GQ",
    "291": "ER",
    "372": "EE",
    "268": "SZ",
    "251": "ET",
    "679": "FJ",
    "358": "FI",
    "33": "FR",
    "241": "GA",
    "220": "GM",
    "995": "GE",
    "49": "DE",
    "233": "GH",
    "30": "GR",
    "1473": "GD",
    "502": "GT",
    "224": "GN",
    "245": "GW",
    "592": "GY",
    "509": "HT",
    "504": "HN",
    "36": "HU",
    "354": "IS",
    "91": "IN",
    "62": "ID",
    "98": "IR",
    "964": "IQ",
    "353": "IE",
    "972": "IL",
    "39": "IT",
    "1876": "JM",
    "81": "JP",
    "962": "JO",
    "7": "KZ",
    "254": "KE",
    "686": "KI",
    "850": "KP",
    "82": "KR",
    "965": "KW",
    "996": "KG",
    "856": "LA",
    "371": "LV",
    "961": "LB",
    "266": "LS",
    "231": "LR",
    "218": "LY",
    "423": "LI",
    "370": "LT",
    "352": "LU",
    "261": "MG",
    "265": "MW",
    "60": "MY",
    "960": "MV",
    "223": "ML",
    "356": "MT",
    "692": "MH",
    "222": "MR",
    "230": "MU",
    "52": "MX",
    "691": "FM",
    "373": "MD",
    "377": "MC",
    "976": "MN",
    "382": "ME",
    "212": "MA",
    "258": "MZ",
    "95": "MM",
    "264": "NA",
    "674": "NR",
    "977": "NP",
    "31": "NL",
    "64": "NZ",
    "505": "NI",
    "227": "NE",
    "234": "NG",
    "389": "MK",
    "47": "NO",
    "968": "OM",
    "92": "PK",
    "680": "PW",
    "970": "PS",
    "507": "PA",
    "675": "PG",
    "595": "PY",
    "51": "PE",
    "63": "PH",
    "48": "PL",
    "351": "PT",
    "974": "QA",
    "40": "RO",
    "7": "RU",
    "250": "RW",
    "1869": "KN",
    "1758": "LC",
    "1784": "VC",
    "685": "WS",
    "378": "SM",
    "239": "ST",
    "966": "SA",
    "221": "SN",
    "381": "RS",
    "248": "SC",
    "232": "SL",
    "65": "SG",
    "421": "SK",
    "386": "SI",
    "677": "SB",
    "252": "SO",
    "27": "ZA",
    "211": "SS",
    "34": "ES",
    "94": "LK",
    "249": "SD",
    "597": "SR",
    "46": "SE",
    "41": "CH",
    "963": "SY",
    "886": "TW",
    "992": "TJ",
    "255": "TZ",
    "66": "TH",
    "670": "TL",
    "228": "TG",
    "676": "TO",
    "1868": "TT",
    "216": "TN",
    "90": "TR",
    "993": "TM",
    "688": "TV",
    "256": "UG",
    "380": "UA",
    "971": "AE",
    "44": "GB",
    "1": "US",
    "598": "UY",
    "998": "UZ",
    "678": "VU",
    "58": "VE",
    "84": "VN",
    "967": "YE",
    "260": "ZM",
    "263": "ZW",
  };

  return countryDialingCodes[dialingCode];
}

Future<File?> pickFile() async {
  try {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: [
        'pdf',
        'png',
        'JPEG',
        'JPG',
        'jpg',
        'jpeg',
        'PNG',
        // 'PDF'
      ],
      allowMultiple: false,
    );

    if (result != null && result.files.isNotEmpty) {
      PlatformFile file = result.files.first;
      File pickedFile = File(file.path!);

      // if (file.size! > (5 * 1024 * 1024)) { // 5 MB limit as an example
      //   emit(const SignUpState.errorImage(
      //       error: 'File size exceeds the allowed limit (5 MB).'));
      //   print("object");
      //   return null;
      // }

      String fileExtension = extension(pickedFile.path);
      if (fileExtension == '.png' ||
          fileExtension == '.jpg' ||
          fileExtension == '.jpeg' ||
          fileExtension == '.PNG' ||
          fileExtension == '.JPG' ||
          fileExtension == '.JPEG' ||
          fileExtension == '.pdf') {
        return pickedFile;
      } else {
        return null;
      }

      // You can now use the pickedFile as needed

      // You can return the file if needed
      // return pickedFile;
    } else {}
  } catch (e) {}

  // If there is an error or the user cancels, return null
  return null;
}

Future<File> loadNetwork(String url) async {
  final response = await http.get(Uri.parse(url));
  final bytes = response.bodyBytes;
  final filename = basename(url);
  final dir = await getApplicationDocumentsDirectory();
  var file = File('${dir.path}/$filename');
  await file.writeAsBytes(bytes, flush: true);
  return file;
}
