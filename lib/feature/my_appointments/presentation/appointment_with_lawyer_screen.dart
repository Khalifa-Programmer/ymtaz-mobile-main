import 'dart:io';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/constants/validators.dart';
import 'package:yamtaz/core/helpers/shared_functions.dart';
import 'package:yamtaz/core/widgets/custom_button.dart';
import 'package:yamtaz/core/widgets/custom_container.dart';
import 'package:yamtaz/core/widgets/primary/text_form_primary.dart';
import 'package:yamtaz/core/widgets/spacing.dart';
import 'package:yamtaz/feature/my_appointments/data/model/working_hours_response.dart';
import 'package:yamtaz/feature/my_appointments/logic/appointments_state.dart';
import 'package:yamtaz/feature/my_appointments/presentation/select_appointment_screen.dart';

import '../../../config/themes/styles.dart';
import '../../../core/constants/assets.dart';
import '../../../core/di/dependency_injection.dart';
import '../../../l10n/locale_keys.g.dart';
import '../../../main.dart';
import '../../../yamtaz.dart';
import '../../advisory_window/presentation/widgets/item_card_widget.dart';
import '../../auth/sign_up/data/models/countries_response.dart';
import '../data/model/dates_types_response_model.dart';
import '../logic/appointments_cubit.dart';

DateTime scheduleTime = DateTime.now();

class AppointmentData extends StatefulWidget {
  AppointmentData(
      {super.key,
      this.selectedMainType = -1,
      this.selectedMainTypeIndex = -1,
      this.reservationsType});

  ReservationsType? reservationsType;
  int? selectedMainType;
  int selectedMainTypeIndex;
  int? selectedImportance = -1;
  bool? locationLoading = false;
  int selectedCountry = -1;
  int selectedRegion = -1;
  int selectedDistrict = -1;
  int selectedHours = -1;

  DateTime? _selectedDate;
  List<AvailableTime>? _selectedDateTimes;
  Position? _currentPosition;
  File? documentFile;

  TextEditingController hint = TextEditingController();

  @override
  State<AppointmentData> createState() => _AppointmentDataState();
}

class _AppointmentDataState extends State<AppointmentData> {
  TextEditingController externalController2 = TextEditingController();
  int selectedTimeId = -1;
  String selectedTimeFrom = "";
  String selectedTimeTo = "";
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: widget.selectedMainType == -1,
      onPopInvoked: (didPop) {
        if (!didPop) {
          setState(() {
            widget.selectedMainType = -1;
            widget.selectedMainTypeIndex = -1;
          });
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("مفكرة المواعيد",
              style: TextStyles.cairo_14_bold.copyWith(
                color: appColors.black,
              )),
          leading: widget.selectedMainType != -1 
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      widget.selectedMainType = -1;
                      widget.selectedMainTypeIndex = -1;
                    });
                  },
                )
              : null,
        ),
        body: BlocConsumer<AppointmentsCubit, AppointmentsState>(
          listener: (context, state) {
            // state.whenOrNull(
            //   loadingRequest: () {
            //     showDialog(
            //       context: context,
            //       barrierDismissible: false,
            //       builder: (context) => Dialog(
            //         surfaceTintColor: Colors.transparent,
            //         shape: const RoundedRectangleBorder(
            //             borderRadius: BorderRadius.all(Radius.circular(20))),
            //         child: Container(
            //           padding: EdgeInsets.all(16.sp),
            //           child: Row(
            //             mainAxisSize: MainAxisSize.min,
            //             children: [
            //               const CircularProgressIndicator(
            //                 color: appColors.primaryColorYellow,
            //               ),
            //               horizontalSpace(16.sp),
            //               const Text("جاري حجز الموعد"),
            //             ],
            //           ),
            //         ),
            //       ),
            //     );
            //   },
            //   loadedRequest: (data) {
            //     if (data.data!.paymentUrl != null) {
            //       Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => PaymentAppointmetns(
            //                   link: data.data!.paymentUrl!, data: data)));
            //       context.read<AppointmentsCubit>().clear();
            //     }
            //   },
            //   errorRequest: (message) {
            //     showDialog(
            //       context: context,
            //       builder: (context) => AlertDialog(
            //         title: const Text("حدث خطأ"),
            //         content: Text(message),
            //       ),
            //     );
            //   },
            // );
          },
          builder: (context, state) {
            return ConditionalBuilder(
              condition:
                  context.read<AppointmentsCubit>().datesTypesResponse != null &&
                      context.read<AppointmentsCubit>().countriesResponse != null,
              builder: (BuildContext context) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Form(
                  key: context.read<AppointmentsCubit>().formKey,
                  child: ConditionalBuilder(
                    condition: widget.selectedMainType == -1,
                    builder: (BuildContext context) {
                      return _buildMainType();
                    },
                    fallback: (BuildContext context) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16, horizontal: 16),
                        child: Column(
                          children: [
                            _buildAppointmentDetails(
                                widget.reservationsType != null
                                    ? widget.reservationsType!
                                    : context
                                            .read<AppointmentsCubit>()
                                            .datesTypesResponse!
                                            .data!
                                            .reservationsTypes![
                                        widget.selectedMainTypeIndex]),
                            verticalSpace(20.h),
                            CustomButton(
                              title: "التالي",
                              onPress: () {
                                if (context
                                        .read<AppointmentsCubit>()
                                        .formKey
                                        .currentState!
                                        .validate() &&
                                    widget.selectedMainType != -1 &&
                                    widget.selectedImportance != -1 &&
                                    widget.selectedHours != -1 &&
                                    widget.selectedCountry != -1 &&
                                    widget.selectedRegion != -1 &&
                                    widget.selectedDistrict != -1 &&
                                    externalController2.text.isNotEmpty &&
                                    _selectedDate != null &&
                                    selectedTimeFrom.isNotEmpty) {
                                  FormData data = FormData.fromMap({
                                    "reservation_type_id": widget.selectedMainType,
                                    "importance_id": widget.selectedImportance,
                                    "hours": widget.selectedHours,
                                    "region_id": widget.selectedRegion,
                                    "city_id": widget.selectedDistrict,
                                    "latitude": widget._currentPosition!.latitude,
                                    "longitude": widget._currentPosition!.longitude,
                                    "description": externalController2.text,
                                    "date": DateFormat("yyyy-MM-dd")
                                        .format(_selectedDate!),
                                    "from": selectedTimeFrom,
                                    "to": selectedTimeFrom
                                  });
                                  if (widget.documentFile != null) {
                                    data.files.add(MapEntry(
                                        "document",
                                        MultipartFile.fromFileSync(
                                            widget.documentFile!.path)));
                                  }

                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => BlocProvider.value(
                                        value: getit<AppointmentsCubit>()
                                          ..getLawyers(
                                              widget.selectedMainType.toString(),
                                              widget.selectedDistrict.toString(),
                                              widget.selectedRegion.toString(),
                                              widget.selectedCountry.toString()),
                                        child: SelectLawyerScreen(dataForm: data),
                                      ),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('يرجى ملء جميع الحقول المطلوبة'),
                                    ),
                                  );
                                }
                              },
                            ).animate().fadeIn(duration: 500.ms),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              fallback: (BuildContext context) => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    Text("جاري تحميل المواعيد"),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Future<void> _getCurrentPosition() async {
    setState(() {
      widget.locationLoading = true;
    });
    final hasPermission = await _getLocation();
    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      setState(() => widget._currentPosition = position);
    }).catchError((e) {
      debugPrint(e);
    });
    setState(() {
      widget.locationLoading = false;
    });
  }

  Future<bool> _getLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    permission = await Geolocator.checkPermission();
    if (!serviceEnabled) {
      setState(() {
        widget.locationLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('يرجى تفعيل خدمات الموقع لتتمكن من اختيار الموقع')));
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Location permissions are denied')));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Location permissions are permanently denied, we cannot request permissions.')));
      return false;
    }
    return true;
  }

  Widget _buildMainType() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0.w),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            verticalSpace(20.sp),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: context
                  .read<AppointmentsCubit>()
                  .datesTypesResponse!
                  .data!
                  .reservationsTypes!
                  .length,
              itemBuilder: (context, index) {
                var item = context
                    .read<AppointmentsCubit>()
                    .datesTypesResponse!
                    .data!
                    .reservationsTypes![index];
                return ItemCardWidget(
                  index: index,
                  name: item.name!,


                  total: "0",
                  id: item.id!,
                  onPressed: () {
                    widget.selectedMainType = item.id;
                    widget.selectedMainTypeIndex = index;
                    setState(() {});
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  _buildAppointmentDetails(ReservationsType reservationsTypes) {
    return Column(
      children: [
        CustomContainer(
            title: 'مستوى الطلب',
            child: CustomDropdown<TypesImportance>(
              validator: (value) {
                if (value == null) {
                  return 'مستوى الطلب';
                }
                return null;
              },
              hintText: 'مستوى الطلب',
              items: reservationsTypes.typesImportance!,
              onChanged: (value) {
                widget.selectedImportance = value!.reservationImportanceId;
                setState(() {});
              },
            )),
        CustomContainer(
            title: 'عدد ساعات الاجتماع',
            child: CustomDropdown<String>(
              validator: (value) {
                if (value == null) {
                  return 'يرجى اختيار عدد ساعات الاجتماع';
                }
                return null;
              },
              hintText: 'عدد ساعات الاجتماع',
              items: const ["1", "2", "3", "4", "5", "6", "7", "8"],
              onChanged: (value) {
                setState(() {
                  // context
                  //     .read<AppointmentsCubit>()
                  //     .getAvailableTimes(int.parse(value!));
                  widget.selectedHours = int.parse(value!);
                });
              },
            )),
        CustomTextFieldPrimary(
            hintText: "مضمون الطلب عن الموعد",
            externalController: externalController2,
            validator: Validators.validateNotEmpty,
            multiLine: true,
            title: "مضمون الطلب عن الموعد"),
        ConditionalBuilder(
          condition: widget.documentFile == null,
          builder: (BuildContext context) => Animate(
            effects: [FadeEffect(delay: 200.ms)],
            child: GestureDetector(
              onTap: () async => {
                hideKeyboard(navigatorKey.currentContext!),
                widget.documentFile = await pickFile(),
                setState(() {})
              },
              child: Column(
                children: [
                  Container(
                    height: 150.h,
                    width: MediaQuery.of(context).size.width,
                    padding:
                        EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                    decoration: BoxDecoration(
                      color: widget.documentFile != null
                          ? appColors.blue100
                          : appColors.white,
                      borderRadius: BorderRadius.circular(12.sp),
                      border: Border.all(
                        color: widget.documentFile != null
                            ? appColors.blue100
                            : appColors.grey2,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(AppAssets.upload),
                        verticalSpace(20.h),
                        Text(
                          widget.documentFile != null
                              ? "تم إرفاق ملف"
                              : "إرفاق ملف",
                          style: TextStyle(
                            fontFamily: 'Cairo',
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w400,
                            color: widget.documentFile != null
                                ? appColors.white
                                : appColors.blue100,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Animate(
                    effects: [FadeEffect(delay: 200.ms)],
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(10.0), // زاوية الحواف
                        ),
                        child: const Row(
                          children: [
                            Icon(Icons.check, color: Colors.green),
                            // علامة صح
                            SizedBox(width: 8.0),
                            // مسافة بين العلامة والنص
                            Text("png, jpg, jpeg, pdf"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          fallback: (BuildContext context) => const SizedBox(),
        ),
        ConditionalBuilder(
          condition: widget.documentFile != null,
          builder: (BuildContext context) => Animate(
            effects: [FadeEffect(delay: 200.ms)],
            child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.sp),
                ),
                leading: const Icon(
                  Icons.file_copy,
                  color: appColors.blue90,
                ),
                title: Text(
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  textWidthBasis: TextWidthBasis.longestLine,
                  widget.documentFile!.path.split('/').last,
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: appColors.black,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "حجم الملف: ${(widget.documentFile!.lengthSync() / 1024).toStringAsFixed(2)} KB",
                      style: TextStyle(
                        fontFamily: 'Cairo',
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w400,
                        color: appColors.grey5,
                      ),
                    ),
                    if (!widget.documentFile!.path
                        .toLowerCase()
                        .endsWith('.pdf'))
                      Text(
                        "اضغط للعرض",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400,
                          color: appColors.grey5,
                        ),
                      ),
                  ],
                ),
                onTap: () {
                  if (widget.documentFile!.path
                      .toLowerCase()
                      .endsWith('.pdf')) {
                  } else {
                    // viewImage(context, documentFile!);
                  }
                },
                trailing: GestureDetector(
                  onTap: () {
                    widget.documentFile = null;
                    setState(() {});
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: appColors
                          .red5, // Light red color for the circle background
                    ),
                    padding: const EdgeInsets.all(8.0),
                    // Adjust the padding as needed
                    child: const Icon(
                      Icons.delete,
                      color: appColors.red,
                    ),
                  ),
                )),
          ),
          fallback: (BuildContext context) => const SizedBox(),
        ),
        CustomContainer(
            title: 'اختر الدولة',
            child: CustomDropdown<Country>(
              validator: (value) {
                if (value == null) {
                  return 'يرجى اختيار الدولة';
                }
                return null;
              },
              hintText: 'الدولة',
              items: context
                  .read<AppointmentsCubit>()
                  .countriesResponse!
                  .data!
                  .countries!,
              onChanged: (value) {
                context
                    .read<AppointmentsCubit>()
                    .selectCounrty(value!.regions!, value.id!);
                setState(() {
                  widget.selectedCountry = value.id!;
                });
              },
            )),
        Visibility(
          visible: context.read<AppointmentsCubit>().selectedCountry != -1,
          child: ConditionalBuilder(
            condition: context.read<AppointmentsCubit>().regions!.isNotEmpty,
            builder: (BuildContext context) => CustomContainer(
              title: LocaleKeys.region.tr(),
              child: CustomDropdown<Region>(
                hintText: LocaleKeys.selectRegion.tr(),
                items: context.read<AppointmentsCubit>().regions!,
                onChanged: (value) {
                  context
                      .read<AppointmentsCubit>()
                      .selectRegion(value!.cities ?? [], value.id!);
                  setState(() {
                    widget.selectedRegion = value.id!;
                    // print(context.read<AppointmentsCubit>().selectedRegion);
                  });
                },
              ),
            ),
            fallback: (BuildContext context) => const Text("لا يوجد مناطق"),
          ),
        ),
        Visibility(
          visible: context.read<AppointmentsCubit>().cities != [] ||
              context.read<AppointmentsCubit>().cities != null,
          child: ConditionalBuilder(
            condition: context.read<AppointmentsCubit>().cities!.isNotEmpty,
            builder: (BuildContext context) => CustomContainer(
              title: LocaleKeys.city.tr(),
              child: CustomDropdown<City>(
                hintText: LocaleKeys.selectCity.tr(),
                items: context.read<AppointmentsCubit>().cities,
                onChanged: (value) {
                  setState(() {
                    widget.selectedDistrict = value!.id!;
                    // print(widget.selectedDistrict);
                  });
                },
              ),
            ),
            fallback: (BuildContext context) => const Text("لا يوجد مدن"),
          ),
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () => {
                  setState(() {
                    _getCurrentPosition();
                  })
                },
                child: Container(
                  height: 50.h,
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                  decoration: BoxDecoration(
                    color: appColors.blue100,
                    borderRadius: BorderRadius.circular(12.sp),
                  ),
                  child: ConditionalBuilder(
                    condition: widget.locationLoading == true,
                    builder: (BuildContext context) => const Center(
                      child: CupertinoActivityIndicator(
                        color: Colors.white,
                      ),
                    ),
                    fallback: (BuildContext context) => Animate(
                      effects: [FadeEffect(delay: 200.ms)],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget._currentPosition == null
                                ? "اختر الموقع"
                                : '${widget._currentPosition?.latitude}. تم اختيار الموقع',
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              color: appColors.white,
                            ),
                          ),
                          const Icon(
                            CupertinoIcons.location,
                            color: appColors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        CustomButton(
            onPress: () => _selectDate(context),
            bgColor: appColors.blue100,
            title: _selectedDate == null
                ? 'اختر التاريخ'
                : 'التاريخ المختار: ${_selectedDate!.toLocal()}'.split(' ')[0]),
        if (_selectedDate != null && selectedTimeFrom.isNotEmpty)
          Text('الوقت المختار: $selectedTimeFrom '),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      _selectTime(context);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        selectedTimeFrom = "${picked.hour}:${picked.minute}";
        selectedTimeTo = "${picked.hour + 1}:${picked.minute}";
      });
    }
  }
}
