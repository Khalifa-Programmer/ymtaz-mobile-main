import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/fuctions_helpers/functions_helpers.dart';
import 'package:yamtaz/feature/digital_office/logic/office_provider_cubit.dart';

class CustomExpansionTile extends StatefulWidget {
  CustomExpansionTile(
      {super.key,
      required this.service,
      required this.dayName,
      required this.isSwitched,
      required this.dayNum});

  final String service;
  String dayName;
  String dayNum;
  bool isSwitched;
  String? from;
  String? to;

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      enabled: widget.isSwitched ? true : false,
      leading: Transform.scale(
        scale: 0.8,
        child: CupertinoSwitch(
          value: widget.isSwitched,
          onChanged: (bool value) {
            setState(() {
              widget.isSwitched = value;
              if (widget.isSwitched) {
              } else {
                context
                    .read<OfficeProviderCubit>()
                    .removeDayFromWorkingHours(widget.dayNum);
              }
            });
          },
        ),
      ),
      title: Text(widget.dayName),
      backgroundColor: appColors.grey3,
      collapsedBackgroundColor: appColors.grey3,
      collapsedIconColor: appColors.grey5,
      iconColor: appColors.grey5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: appColors.grey3),
      ),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: appColors.grey3),
      ),
      children: [
        ListTile(
          onTap: () async {
            final selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (BuildContext context, Widget? child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child!,
                );
              },
            );

            if (selectedTime != null) {
              widget.from = formatTime24Hour(selectedTime);
              setState(() {});
            }
          },
          title: const Text('من'),
          trailing: Text(widget.from == null ? 'اختر التوقيت' : widget.from!),
        ),
        ListTile(
          onTap: () async {
            final selectedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
              builder: (BuildContext context, Widget? child) {
                return MediaQuery(
                  data: MediaQuery.of(context)
                      .copyWith(alwaysUse24HourFormat: false),
                  child: child!,
                );
              },
            );

            if (selectedTime != null) {
              widget.to = formatTime24Hour(selectedTime);
              setState(() {});
            }
          },
          title: const Text('الى'),
          trailing: Text(widget.to == null ? 'اختر التوقيت' : widget.to!),
        ),
        //حفظ التوقيت
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            onPressed: () {
              if (widget.from == null || widget.to == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('يجب اختيار التوقيت اولا'),
                  ),
                );
              } else {
                context.read<OfficeProviderCubit>().saveWorkingHours(
                    service: widget.service,
                    dayNum: widget.dayNum,
                    from: widget.from!,
                    to: widget.to!,
                    minsBetween: 15);
              }
            },
            child: const Text('حفظ التوقيت'),
          ),
        ),
      ],
    );
  }
}
