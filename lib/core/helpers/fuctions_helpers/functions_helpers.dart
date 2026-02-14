import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/core/router/routes.dart';

import '../../../feature/layout/account/presentation/widgets/share_screen.dart';

String getTime(String timestamp) {
  DateTime dateTime = DateTime.parse(timestamp).toLocal();
  return "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}:${dateTime.second.toString().padLeft(2, '0')}";
}

int daysRemaining(DateTime endDate) {
  DateTime currentDate = DateTime.now();
  Duration difference = endDate.difference(currentDate);
  return difference.inDays;
}

String getDate(String? timestamp) {
  if (timestamp == null) {
    return "لا يوجد تاريخ";
  }

  try {
    DateTime dateTime = DateTime.parse(timestamp).toLocal();
    return "${dateTime.toLocal().year}-${dateTime.toLocal().month.toString().padLeft(2, '0')}-${dateTime.toLocal().day.toString().padLeft(2, '0')}";
  } catch (e) {
    return "لا يوجد تاريخ";
  }
}

String getTypeNotificationText(String type) {
  if (type == "service") {
    return "خدمات";
  } else if (type == "appointment") {
    return "موعد";
  } else if (type == "contact-us-request") {
    return "الشكاوي";
  } else if (type == "advisory_service") {
    return "الاستشارات";
  } else if (type == "laws") {
    return "الشَّذرات";
  } else {
    return "إشعار عام";
  }
}

String getTimeDate(String lastSeen) {
  // تحويل النص إلى DateTime
  DateTime lastSeenDateTime = DateTime.parse(lastSeen).toLocal();

  // تنسيق التاريخ والوقت باستخدام اللغة العربية
  final DateFormat dateFormatter = DateFormat('d MMMM yyyy   HH:mm', 'ar');
  // final DateFormat timeFormatter = DateFormat('HH:mm', 'ar');

  String formattedDate = dateFormatter.format(lastSeenDateTime);
  // String formattedTime = timeFormatter.format(lastSeenDateTime);

  return formattedDate;
}

String getDateEn(String lastSeen) {
  // Parse the input string to DateTime and convert to local time
  DateTime lastSeenDateTime = DateTime.parse(lastSeen).toLocal();

  // Format the date as yyyy-MM-dd
  final DateFormat dateFormatter = DateFormat('yyyy-MM-dd', 'en');

  String formattedDate = dateFormatter.format(lastSeenDateTime);

  return formattedDate;
}

enum NotificationType {
  global,
  xp,
  service,
  appointment,
  advisoryService, // use camelCase for enum values
  office,
  officeLawyer,
}

String typeNotificationNavigation(String type) {
  if (type == "service" || type == "service-offer") {
    return Routes.myServices;
  } else if (type == "appointment" || type == "offer-reservation") {
    return Routes.myAppointments;
  } else if (type == "contact-us-request") {
    return Routes.contactYmtaz;
  } else if (type == "advisory_service") {
    return Routes.myAdvisoryOrders;
  } else if (type == "service-lawyer" || type == "service-offer-lawyer") {
    return Routes.myServicesOffice;
  } else if (type == "appointment-lawyer" ||
      type == "offer-reservation-lawyer") {
    return Routes.myAppointmentOffice;
  } else if (type == "advisory_service-lawyer") {
    return Routes.myAdvisoriesOffice;
  } else if (type == "package") {
    return Routes.packageDetails;
  } else {
    return Routes.notificationsData;
  }
}

Future<void> openMap(String latitude, String longitude) async {
  final googleMapsUrl = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
  final appleMapsUrl =
      Uri.parse('https://maps.apple.com/?q=$latitude,$longitude');

  if (Platform.isIOS) {
    // Open in Apple Maps
    if (await canLaunchUrl(appleMapsUrl)) {
      await launchUrl(appleMapsUrl);
    } else {
      throw 'Could not open Apple Maps.';
    }
  } else if (Platform.isAndroid) {
    // Open in Google Maps
    if (await canLaunchUrl(googleMapsUrl)) {
      await launchUrl(googleMapsUrl);
    } else {
      throw 'Could not open Google Maps.';
    }
  } else {
    throw 'Unsupported platform.';
  }
}

String getOfferStatusText(String requestStatus) {
  final statusTextMap = {
    "pending-offer": 'عرض ',
    "pending-acceptance": 'بانتظار الموافقة',
    "declined": 'تم الرفض',
    "cancelled-by-client": 'تم الرفض',
    "accepted": 'تم القبول',
  };
  return statusTextMap.containsKey(requestStatus)
      ? statusTextMap[requestStatus]!
      : 'حالة غير معروفة';
}

ColorSwatch<int> getOfferStatusColor(String requestStatus) {
  final statusTextMap = {
    'pending-offer': Colors.blueAccent,
    'pending-acceptance': Colors.orange,
    "declined": Colors.red,
    "accepted": Colors.green,
  };
  return statusTextMap.containsKey(requestStatus)
      ? statusTextMap[requestStatus]!
      : Colors.orange;
}

String getStatusText(int requestStatus) {
  final statusTextMap = {
    1: 'جديد',
    2: 'انتظار',
    3: 'متأخر',
    4: 'غير مكتملة',
    5: 'مكتملة',
  };

  return statusTextMap.containsKey(requestStatus)
      ? statusTextMap[requestStatus]!
      : 'حالة غير معروفة';
}

ColorSwatch<int> getStatusColor(String requestStatus) {
  final statusTextMap = {
    'جديد': Colors.blueAccent,
    'انتظار': Colors.orange,
    'متأخر': Colors.deepOrange,
    'غير مكتملة': Colors.red,
    'مكتملة': Colors.green,
  };

  return statusTextMap.containsKey(requestStatus)
      ? statusTextMap[requestStatus]!
      : Colors.orange;
}

String formatTime24Hour(TimeOfDay time) {
  final hours = time.hour.toString().padLeft(2, '0');
  final minutes = time.minute.toString().padLeft(2, '0');
  return '$hours:$minutes';
}

Future shareText(
    BuildContext context, String appWelcomeMessage, String codeRef) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child:
            ShareScreen(appWelcomeMessage: appWelcomeMessage, codeRef: codeRef),
      );
    },
  );
}

Future inviteUser(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: InviteUserScreen(),
      );
    },
  );
}

List<TextSpan> highlightOccurrences(String source, String query) {
  if (query.isEmpty) {
    return [TextSpan(text: source)];
  }
  final matches = query.allMatches(source);
  if (matches.isEmpty) {
    return [TextSpan(text: source)];
  }

  List<TextSpan> spans = [];
  int start = 0;

  for (final match in matches) {
    if (match.start != start) {
      spans.add(TextSpan(text: source.substring(start, match.start)));
    }
    spans.add(TextSpan(
      text: source.substring(match.start, match.end),
      style: TextStyle(backgroundColor: Colors.yellow),
    ));
    start = match.end;
  }

  if (start != source.length) {
    spans.add(TextSpan(text: source.substring(start)));
  }

  return spans;
}
