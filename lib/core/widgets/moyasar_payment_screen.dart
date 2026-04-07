import 'dart:io';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:moyasar/moyasar.dart';
import 'package:yamtaz/config/enviroment.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';

class MoyasarPaymentScreen extends StatefulWidget {
  final String amount;
  final String description;
  final String? packageId;
  final String? transactionId;
  final Map<String, String>? metadata;

  const MoyasarPaymentScreen({
    super.key,
    required this.amount,
    required this.description,
    this.packageId,
    this.transactionId,
    this.metadata,
  });

  @override
  State<MoyasarPaymentScreen> createState() => _MoyasarPaymentScreenState();
}

class _MoyasarPaymentScreenState extends State<MoyasarPaymentScreen> {
  PaymentConfig? config;
  bool isLoading = true;
  Key _cardKey = UniqueKey(); // مفتاح للتحكم في إعادة بناء واجهة البطاقة

  @override
  void initState() {
    super.initState();
    _setupErrorInterceptor();
    _initializeConfig();
  }

  // اعتراض الأخطاء غير المعالجة التي تحدث داخل مكتبة ميسر (Bug Fix)
  void _setupErrorInterceptor() {
    // 1. للأخطاء المتزامنة (Synchronous)
    final originalOnError = FlutterError.onError;
    FlutterError.onError = (FlutterErrorDetails details) {
      final errorStr = details.exception.toString();
      if (_isMoyasarCrash(errorStr)) {
        debugPrint('⚠️ Caught Moyasar Sync Crash: $errorStr');
        _handleCaughtCrash();
        return;
      }
      originalOnError?.call(details);
    };

    // 2. للأخطاء غير المتزامنة (Asynchronous) - مثل أخطاء الـ Future في الـ API
    final originalDispatcherOnError = PlatformDispatcher.instance.onError;
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      final errorStr = error.toString();
      if (_isMoyasarCrash(errorStr)) {
        debugPrint('⚠️ Caught Moyasar Async Crash: $errorStr');
        _handleCaughtCrash();
        return true; 
      }
      return originalDispatcherOnError?.call(error, stack) ?? false;
    };
  }

  bool _isMoyasarCrash(String errorStr) {
    // التحقق من الخطأ بأكثر من صيغة لضمان القبض عليه
    return (errorStr.contains("Null") && errorStr.contains("subtype") && errorStr.contains("String")) ||
           (errorStr.contains("Null") && errorStr.contains("String") && errorStr.contains("expected"));
  }

  void _handleCaughtCrash() {
    // استخدام microtask لضمان التنفيذ على الـ Main Thread وتجنب تعارض الـ build
    Future.microtask(() {
      if (!mounted) return;
      
      // إظهار رسالة الخطأ
      _handlePaymentError('عذراً، حدث خطأ تقني. يرجى التأكد من استخدام بطاقة دفع حقيقية صالحة (وليست تجريبية) في هذه البيئة.');
      
      setState(() {
        _cardKey = UniqueKey(); // إعادة بناء الواجهة بالكامل لتصفير الـ Loading
      });
    });
  }

  void _initializeConfig() async {
    try {
      final env = await Environment.current();
      
      // المبلغ في ميسر يمرر بـ "الهللة" (Halala) لذا نضرب في 100
      double price = double.tryParse(widget.amount.replaceAll(',', '')) ?? 0.0;
      int amountInHalala = (price * 100).toInt();

      // تجهيز الميتا داتا (Metadata)
      Map<String, String> meta = {};
      
      // إضافة الميتا داتا الممررة يدوياً (أولوية قصوى)
      if (widget.metadata != null) {
        meta.addAll(widget.metadata!);
      }
      
      // إضافة البيانات التقليدية للباقات إذا لم تمرر ميتا داتا مخصصة تغطيها
      if (widget.packageId != null && !meta.containsKey('package_id')) {
        meta['package_id'] = widget.packageId!;
      }
      
      if (widget.transactionId != null && !meta.containsKey('transaction_id')) {
        meta['transaction_id'] = widget.transactionId!;
      } else if (widget.packageId != null && !meta.containsKey('order_number')) {
        meta['order_number'] = 'ORD-PCKG-${widget.packageId}';
      }

      setState(() {
        config = PaymentConfig(
          publishableApiKey: env.moyasarPublishableKey,
          amount: amountInHalala,
          description: widget.description,
          metadata: meta,
          creditCard: CreditCardConfig(saveCard: false, manual: false),
          applePay: ApplePayConfig(
            merchantId: 'merchant.com.ymtaz.app',
            label: 'Yamtaz App',
            manual: false,
            saveCard: false,
          ),
        );
        
        // 🚀 طباعة كافة بيانات العملية للترمينال (Debugging)
        print('--- 💳 MOYASAR INITIALIZATION ---');
        print('🔑 API Key: ${env.moyasarPublishableKey}');
        print('💰 Amount (Original): ${widget.amount} SAR');
        print('💰 Amount (Halala): $amountInHalala');
        print('📝 Description: ${widget.description}');
        print('📦 Metadata: ${config?.metadata}');
        print('🍎 Apple Pay Merchant: ${config?.applePay?.merchantId}');
        print('----------------------------------');
        
        isLoading = false;
      });
    } catch (e) {
      print('❌ Error initializing Moyasar: $e');
      if (mounted) {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // إجبار الواجهة على اللغة العربية واتجاه اليمين لليسار (RTL)
    return Localizations.override(
      context: context,
      locale: const Locale('ar'),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('إتمام عملية الدفع', style: TextStyles.cairo_16_bold),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed: () => Navigator.pop(context),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ملخص الباقة
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: appColors.blue100.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: appColors.blue100.withValues(alpha: 0.1)),
                    ),
                    child: Column(
                      children: [
                        Text(
                          widget.description,
                          style: TextStyles.cairo_14_bold,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'المبلغ الإجمالي: ${widget.amount} ر.س',
                          style: TextStyles.cairo_18_bold.copyWith(color: appColors.blue100),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  // تنبيه لبيئة الإنتاج
                  FutureBuilder<EnvironmentType>(
                    future: Environment.current(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data == EnvironmentType.prod) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.orange.withOpacity(0.3)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.warning_amber_rounded, color: Colors.orange, size: 20),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'تنبيه: أنت بجلسة دفع حقيقية. يرجى استخدام بطاقة بنكية صالحة (بطاقات الاختبار لا تعمل هنا).',
                                  style: TextStyles.cairo_12_semiBold.copyWith(color: Colors.orange[900]),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                  const SizedBox(height: 12),
                  
                  // نموذج البطاقة من ميسر
                  if (config != null && (widget.metadata?['payment_method'] == 'credit_card' || widget.metadata?['payment_method'] == 'google_pay' || widget.metadata?['payment_method'] == null))
                    CreditCard(
                      key: _cardKey, // استخدام المفتاح للتحكم في الحالة
                      config: config!,
                      locale: const Localization.ar(), // تعريب نصوص مكتبة ميسر الداخلية هنا
                      onPaymentResult: (result) {
                        if (result is PaymentResponse) {
                          if (result.status == PaymentStatus.paid) {
                            _handlePaymentSuccess(result);
                          } else {
                            _handlePaymentError(result);
                          }
                        } else {
                          _handlePaymentError(result);
                        }
                      },
                    )
                  else if (config == null)
                    const Center(child: CircularProgressIndicator()),
                  
                  const SizedBox(height: 24),
                  
                  // دعم آبل باي (فقط على iOS)
                  if (Platform.isIOS && config != null && widget.metadata?['payment_method'] == 'apple_pay')
                    ApplePay(
                      config: config!,
                      onPaymentResult: (result) {
                        if (result is PaymentResponse) {
                          if (result.status == PaymentStatus.paid) {
                            _handlePaymentSuccess(result);
                          } else {
                            _handlePaymentError(result);
                          }
                        } else {
                          _handlePaymentError(result);
                        }
                      },
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _handlePaymentSuccess(PaymentResponse response) {
    print('--- ✅ MOYASAR PAYMENT SUCCESS ---');
    print('🆔 ID: ${response.id}');
    print('🏷️ Status: ${response.status}');
    print('💰 Amount: ${response.amount} ${response.currency}');
    print('📦 Metadata Received: ${response.metadata}');
    print('📅 Created At: ${response.createdAt}');
    print('----------------------------------');
    
    Navigator.pop(context, 'success');
  }

  void _handlePaymentError(dynamic error) {
    print('--- ❌ MOYASAR PAYMENT ERROR ---');
    print('🛑 Raw Error Object: $error');
    
    String message = 'حدث خطأ أثناء الدفع';
    
    try {
      if (error is String) {
        print('💬 Error Type: String');
        message = _translateErrorMessage(error);
      } else if (error is PaymentResponse) {
        print('💬 Error Type: PaymentResponse');
        print('🏷️ Status: ${error.status}');
        String? reason;
        try {
          reason = (error.source as dynamic).message?.toString() ?? error.status.toString();
          print('🎯 Source Message: $reason');
        } catch (_) {
          reason = error.status.toString();
        }
        message = _translateErrorMessage(reason);
      } else {
        print('💬 Error Type: ${error.runtimeType}');
        try {
          message = _translateErrorMessage((error as dynamic).message?.toString() ?? error.toString());
        } catch (_) {
          message = _translateErrorMessage(error.toString());
        }
      }
    } catch (e) {
      print('⚠️ Exception while parsing error: $e');
      message = error.toString();
    }
    
    print('🏁 Final User Message: $message');
    print('----------------------------------');
    
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message, style: TextStyles.cairo_14_semiBold.copyWith(color: Colors.white)),
          backgroundColor: Colors.red,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _translateErrorMessage(String? error) {
    if (error == null) return 'فشلت عملية الدفع، يرجى التأكد من البيانات';
    
    final Map<String, String> translations = {
      '3d_secure_failed': 'فشل التحقق من الأمان 3D Secure',
      'insufficient_funds': 'الرصيد غير كافٍ في البطاقة',
      'card_declined': 'تم رفض البطاقة من قبل البنك المصدر',
      'expired_card': 'البطاقة منتهية الصلاحية',
      'incorrect_cvv': 'رمز الأمان (CVV) غير صحيح',
      'invalid_card_number': 'رقم البطاقة غير صحيح',
      'invalid_expiry_date': 'تاريخ الانتهاء غير صحيح',
      'unsupported_card': 'نوع البطاقة غير مدعوم',
      'canceled': 'تم إلغاء عملية الدفع',
      'timeout': 'انتهت مهلة الطلب، يرجى المحاولة مرة أخرى',
    };

    String lowerError = error.toLowerCase();
    
    for (var key in translations.keys) {
      if (lowerError.contains(key)) {
        return translations[key]!;
      }
    }

    if (lowerError.contains('null') && lowerError.contains('subtype') && lowerError.contains('string')) {
      return 'فشلت معالجة الطلب: يرجى التأكد من استخدام بطاقة حقيقية صالحة (وليست تجريبية) في هذه البيئة.';
    }

    if (lowerError.contains('failed') || lowerError.contains('error')) {
      return 'فشلت عملية الدفع، يرجى التأكد من بيانات البطاقة والمحاولة مرة أخرى';
    }

    return error; // قد يكون الخطأ بالعربية أصلاً
  }
}
