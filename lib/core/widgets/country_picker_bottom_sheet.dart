import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/countries.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class CountryPickerBottomSheet extends StatefulWidget {
  final Function(Country) onCountrySelected;
  final String selectedCountryCode;

  const CountryPickerBottomSheet({
    super.key,
    required this.onCountrySelected,
    required this.selectedCountryCode,
  });

  @override
  State<CountryPickerBottomSheet> createState() => _CountryPickerBottomSheetState();
}

class _CountryPickerBottomSheetState extends State<CountryPickerBottomSheet> {
  List<Country> filteredCountries = [];
  final TextEditingController searchController = TextEditingController();
  
  @override
  void initState() {
    super.initState();
    // Organizar los países con árabes primero, con Arabia Saudita y Egipto al principio
    _organizeCountries();
    
    searchController.addListener(_filterCountries);
  }
  
  void _organizeCountries() {
    // Crea una copia de la lista de países
    List<Country> arabCountries = [];
    List<Country> otherCountries = [];
    Country? saudiArabia;
    Country? egypt;
    
    // Separar países árabes y no árabes
    for (var country in countries) {
      // Identificar Arabia Saudita y Egipto
      if (country.code == "SA") {
        saudiArabia = country;
        continue;
      } else if (country.code == "EG") {
        egypt = country;
        continue;
      }
      
      // Identificar otros países árabes por su código de país
      if (_isArabCountry(country.code)) {
        arabCountries.add(country);
      } else {
        otherCountries.add(country);
      }
    }
    
    // Ordenar alfabéticamente los países árabes y los demás
    arabCountries.sort((a, b) => _getLocalizedName(a).compareTo(_getLocalizedName(b)));
    otherCountries.sort((a, b) => _getLocalizedName(a).compareTo(_getLocalizedName(b)));
    
    // Combinar listas: Arabia Saudita, Egipto, otros países árabes, y luego el resto
    List<Country> organizedCountries = [];
    if (saudiArabia != null) organizedCountries.add(saudiArabia);
    if (egypt != null) organizedCountries.add(egypt);
    organizedCountries.addAll(arabCountries);
    organizedCountries.addAll(otherCountries);
    
    filteredCountries = organizedCountries;
  }
  
  // Función para verificar si un país es árabe
  bool _isArabCountry(String countryCode) {
    // Códigos de países principalmente árabes
    const arabCountryCodes = [
      "DZ", // Algeria
      "BH", // Bahrain
      "KM", // Comoros
      "DJ", // Djibouti
      "EG", // Egypt (ya tratado por separado)
      "IQ", // Iraq
      "JO", // Jordan
      "KW", // Kuwait
      "LB", // Lebanon
      "LY", // Libya
      "MR", // Mauritania
      "MA", // Morocco
      "OM", // Oman
      "PS", // Palestine
      "QA", // Qatar
      "SA", // Saudi Arabia (ya tratado por separado)
      "SO", // Somalia
      "SD", // Sudan
      "SY", // Syria
      "TN", // Tunisia
      "AE", // United Arab Emirates
      "YE", // Yemen
    ];
    
    return arabCountryCodes.contains(countryCode);
  }
  
  // Obtener el nombre localizado en árabe, o el nombre predeterminado si no está disponible
  String _getLocalizedName(Country country) {
    return country.nameTranslations["ar"] ?? country.name;
  }
  
  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
  
  void _filterCountries() {
    if (searchController.text.isEmpty) {
      // Al limpiar la búsqueda, volver a organizar los países según el orden árabe
      _organizeCountries();
    } else {
      setState(() {
        filteredCountries = countries.where((country) {
          final name = country.name.toLowerCase();
          final arabicName = country.nameTranslations["ar"]?.toLowerCase() ?? "";
          final code = country.code.toLowerCase();
          final dialCode = country.dialCode.toLowerCase();
          final query = searchController.text.toLowerCase();
          
          return name.contains(query) || 
                 arabicName.contains(query) ||
                 code.contains(query) || 
                 dialCode.contains(query);
        }).toList();
        
        // Mantener el orden de países árabes primero incluso durante la búsqueda
        filteredCountries.sort((a, b) {
          final aIsArab = _isArabCountry(a.code);
          final bIsArab = _isArabCountry(b.code);
          
          if (aIsArab && !bIsArab) return -1;
          if (!aIsArab && bIsArab) return 1;
          
          // Si ambos son árabes o ninguno es árabe, ordenar por nombre
          return _getLocalizedName(a).compareTo(_getLocalizedName(b));
        });
        
        // Asegurar que Arabia Saudita y Egipto permanezcan en la parte superior si están en los resultados
        final saudiIndex = filteredCountries.indexWhere((country) => country.code == "SA");
        final egyptIndex = filteredCountries.indexWhere((country) => country.code == "EG");
        
        if (saudiIndex != -1) {
          final saudi = filteredCountries.removeAt(saudiIndex);
          filteredCountries.insert(0, saudi);
        }
        
        if (egyptIndex != -1) {
          final egypt = filteredCountries.removeAt(egyptIndex > 0 && saudiIndex != -1 ? egyptIndex - 1 : egyptIndex);
          filteredCountries.insert(saudiIndex != -1 ? 1 : 0, egypt);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.r),
          topRight: Radius.circular(20.r),
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 12.h),
            child: Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: appColors.grey3,
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: Text(
              "اختر الدولة",
              style: TextStyles.cairo_14_bold,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: "بحث عن دولة",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: appColors.grey2,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  vertical: 12.h,
                  horizontal: 16.w,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredCountries.length,
              itemBuilder: (context, index) {
                final country = filteredCountries[index];
                final isSelected = country.dialCode == widget.selectedCountryCode;
                
                // Mostrar el nombre del país en árabe si está disponible
                String countryName = country.nameTranslations["ar"] ?? country.name;
                
                return ListTile(
                  leading: Text(
                    country.flag,
                    style: TextStyle(fontSize: 24.sp),
                  ),
                  title: Text(
                    countryName,
                    style: TextStyles.cairo_12_medium,
                    textDirection: TextDirection.rtl,
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "+${country.dialCode}",
                        style: TextStyles.cairo_12_medium.copyWith(
                          color: appColors.grey5,
                        ),
                      ),
                      horizontalSpace(10.w),
                      if (isSelected)
                        Icon(
                          Icons.check_circle,
                          color: appColors.primaryColorYellow,
                          size: 20.r,
                        ),
                    ],
                  ),
                  onTap: () {
                    widget.onCountrySelected(country);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

void showCountryPicker({
  required BuildContext context,
  required Function(Country) onCountrySelected,
  required String selectedCountryCode,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => CountryPickerBottomSheet(
      onCountrySelected: onCountrySelected,
      selectedCountryCode: selectedCountryCode,
    ),
  );
}
