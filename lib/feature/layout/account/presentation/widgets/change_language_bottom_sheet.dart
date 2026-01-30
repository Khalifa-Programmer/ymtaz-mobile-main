import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/router/routes.dart';

class LanguageBottomSheet extends StatelessWidget {
  const LanguageBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('English'),
            onTap: () {
              EasyLocalization.of(context)!.setLocale(Locale('en'));
              context.pushNamedAndRemoveUntil(Routes.splash,
                  predicate: (Route<dynamic> route) => false);
            },
          ),
          ListTile(
            title: Text('العربية'),
            onTap: () {
              EasyLocalization.of(context)!.setLocale(Locale('ar'));
              context.pushNamedAndRemoveUntil(Routes.splash,
                  predicate: (Route<dynamic> route) => false);
            },
          ),
          // Add more languages as needed
          SizedBox(height: 16), // Spacer
          ListTile(
            title: Text('Cancel'),
            onTap: () {
              Navigator.pop(context); // Close the bottom sheet
            },
          ),
        ],
      ),
    );
  }
}
