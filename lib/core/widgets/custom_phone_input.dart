import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/helpers/countries.dart';
import 'package:yamtaz/core/widgets/country_picker_bottom_sheet.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class CustomPhoneInput extends StatefulWidget {
  final TextEditingController phoneController;
  final ValueNotifier<String> phoneCodeNotifier;
  final Function(bool) onPhoneValidChanged;
  final String? Function(String?)? validator;
  final bool enabled;
  final bool isVerified;

  const CustomPhoneInput({
    Key? key,
    required this.phoneController,
    required this.phoneCodeNotifier,
    required this.onPhoneValidChanged,
    this.validator,
    this.enabled = true,
    this.isVerified = false,
  }) : super(key: key);

  @override
  State<CustomPhoneInput> createState() => _CustomPhoneInputState();
}

class _CustomPhoneInputState extends State<CustomPhoneInput> {
  Country selectedCountry = countries.firstWhere(
    (country) => country.dialCode == "966",
    orElse: () => countries.first,
  );

  final FocusNode _focusNode = FocusNode();
  bool _isFocused = false;
  String? _errorText;
  int _currentLength = 0; // لتتبع عدد الأرقام المدخلة حاليًا

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_handleFocusChange);
    
    // تحديث العداد الأولي اعتمادًا على النص الموجود مسبقًا
    _currentLength = widget.phoneController.text.length;

    // Initialize selected country from phone code notifier
    if (widget.phoneCodeNotifier.value.isNotEmpty) {
      selectedCountry = countries.firstWhere(
        (country) => country.dialCode == widget.phoneCodeNotifier.value,
        orElse: () => countries.first,
      );
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    // Validate when focus is lost
    if (!_focusNode.hasFocus && widget.validator != null) {
      final errorText = widget.validator!(widget.phoneController.text);
      setState(() {
        _errorText = errorText;
      });
      widget.onPhoneValidChanged(errorText == null);
    }
  }

  void _selectCountry(Country country) {
    setState(() {
      selectedCountry = country;
    });
    widget.phoneCodeNotifier.value = country.dialCode;
    
    // Check phone number validity against new country
    _validatePhoneNumber();
  }

  void _validatePhoneNumber() {
    if (widget.validator != null) {
      final errorText = widget.validator!(widget.phoneController.text);
      setState(() {
        _errorText = errorText;
      });
      widget.onPhoneValidChanged(errorText == null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "رقم الهاتف",
            style: TextStyles.cairo_12_bold,
          ),
          verticalSpace(8.h),
          Container(
            decoration: BoxDecoration(
              color: widget.enabled ? Colors.white : appColors.grey2,
              borderRadius: BorderRadius.circular(8.r),
              border: Border.all(
                color: _errorText != null
                    ? appColors.red
                    : _isFocused
                        ? appColors.primaryColorYellow
                        : appColors.grey2,
                width: 1.w,
              ),
            ),
            child: Row(
              children: [
                // Country picker button
                InkWell(
                  onTap: widget.enabled
                      ? () => showCountryPicker(
                            context: context,
                            selectedCountryCode: selectedCountry.dialCode,
                            onCountrySelected: _selectCountry,
                          )
                      : null,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 14.h,
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        left: BorderSide(
                          color: _isFocused ? appColors.grey3 : appColors.grey2,
                          width: 1.w,
                        ),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          selectedCountry.flag,
                          style: TextStyle(fontSize: 18.sp),
                        ),
                        horizontalSpace(8.w),
                        Text(
                          "+${selectedCountry.dialCode}",
                          style: TextStyles.cairo_12_medium,
                        ),
                        horizontalSpace(4.w),
                        if (widget.enabled)
                          Icon(
                            Icons.arrow_drop_down,
                            size: 18.r,
                            color: appColors.grey5,
                          ),
                      ],
                    ),
                  ),
                ),
                
                // Phone input field
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextField(
                        controller: widget.phoneController,
                        focusNode: _focusNode,
                        enabled: widget.enabled,
                        keyboardType: TextInputType.phone,
                        textAlign: TextAlign.right,
                        textDirection: TextDirection.ltr,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(selectedCountry.maxLength),
                        ],
                        style: TextStyles.cairo_13_bold,
                        cursorColor: appColors.primaryColorYellow,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                          hintText: "${_getPhoneHint()} أدخل رقم الهاتف",
                          hintStyle: TextStyle(
                            color: appColors.grey10,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          ),
                          suffixIcon: widget.isVerified
                              ? Icon(
                                  Icons.check_circle,
                                  color: appColors.green,
                                  size: 20.r,
                                )
                              : null,
                        ),
                        onChanged: (value) {
                          setState(() {
                            _currentLength = value.length;
                          });
                          // Optionally validate on each change
                          if (value.length >= selectedCountry.minLength &&
                              value.length <= selectedCountry.maxLength) {
                            _validatePhoneNumber();
                          }
                        },
                      ),
                      if (widget.enabled)
                        Padding(
                          padding: EdgeInsets.only(bottom: 4.h, left: 16.w, right: 16.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "$_currentLength/${selectedCountry.maxLength}",
                                style: TextStyle(
                                  color: _currentLength >= selectedCountry.minLength 
                                      ? appColors.green 
                                      : appColors.grey5,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (_errorText != null)
            Padding(
              padding: EdgeInsets.only(top: 4.h, right: 12.w),
              child: Text(
                _errorText!,
                style: TextStyle(
                  color: appColors.red,
                  fontSize: 12.sp,
                ),
              ),
            ),
          if (widget.isVerified)
            Padding(
              padding: EdgeInsets.only(top: 4.h, right: 12.w),
              child: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: appColors.green,
                    size: 15.r,
                  ),
                  horizontalSpace(5.w),
                  Text(
                    "تم تأكيد رقم الهاتف بنجاح",
                    style: TextStyles.cairo_10_bold.copyWith(color: appColors.green),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
  
  // إضافة دالة للحصول على تلميح عدد أرقام الهاتف المناسب للدولة المختارة
  String _getPhoneHint() {
    if (selectedCountry.minLength == selectedCountry.maxLength) {
      return "(${selectedCountry.minLength} رقم)";
    } else {
      return "(${selectedCountry.minLength}-${selectedCountry.maxLength} رقم)";
    }
  }
}