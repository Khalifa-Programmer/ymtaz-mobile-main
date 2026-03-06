import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/config/enviroment.dart';
import 'package:yamtaz/core/router/routes.dart';
import 'package:yamtaz/core/widgets/alerts.dart';

import 'new_payment_success.dart';

class WebPaymentScreen extends StatefulWidget {
  const WebPaymentScreen({super.key, required this.link});

  final String link;

  @override
  State<WebPaymentScreen> createState() => WebPaymentScreenState(link);
}

class WebPaymentScreenState extends State<WebPaymentScreen> {
  HeadlessInAppWebView? headlessWebView;
  PullToRefreshController? pullToRefreshController;
  InAppWebViewController? webViewController;

  WebPaymentScreenState(this.url);
  String url = "";
  bool success = false;
  int progress = 0;
  bool convertFlag = false;
  bool _hasNavigated = false;
  String? _publishableKey;

  @override
  void initState() {
    super.initState();
    _loadKey();
    
    pullToRefreshController = kIsWeb ||
            ![TargetPlatform.iOS, TargetPlatform.android]
                .contains(defaultTargetPlatform)
        ? null
        : PullToRefreshController(
            settings: PullToRefreshSettings(
              color: Colors.blue,
            ),
            onRefresh: () async {
              if (defaultTargetPlatform == TargetPlatform.android) {
                webViewController?.reload();
              } else if (defaultTargetPlatform == TargetPlatform.iOS ||
                  defaultTargetPlatform == TargetPlatform.macOS) {
                webViewController?.loadUrl(
                    urlRequest:
                        URLRequest(url: await webViewController?.getUrl()));
              }
            },
          );

    headlessWebView = HeadlessInAppWebView(
      initialUrlRequest: URLRequest(url: WebUri(url)),
      initialSettings: InAppWebViewSettings(isInspectable: kDebugMode),
      pullToRefreshController: pullToRefreshController,
      onWebViewCreated: (controller) {
        webViewController = controller;
        if (!mounted) return;
      },
      onLoadStart: (controller, url) async {
        if (!mounted) return;
        setState(() {
          this.url = url?.toString() ?? '';
        });
      },
      onProgressChanged: (controller, progress) {
        if (!mounted) return;
        setState(() {
          this.progress = progress;
        });
      },
      onLoadStop: (controller, url) async {
        if (!mounted) return;
        setState(() {
          this.url = url?.toString() ?? '';
        });
      },
    );
  }

  Future<void> _loadKey() async {
    final env = await Environment.current();
    if (mounted) {
      setState(() {
        _publishableKey = env.moyasarPublishableKey;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    headlessWebView?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("الدفع",
            textScaleFactor: .8,
            style: TextStyles.cairo_14_bold.copyWith(
              color: appColors.black,
            )),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;
          
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("تنبيه", textAlign: TextAlign.right),
              content: const Text("الخروج من عملية الدفع سيؤدي الي إلغاء طلبك، هل تريد الاستمرار؟", textAlign: TextAlign.right),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text("إلغاء"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close dialog
                    Navigator.pop(context); // Close payment screen
                  },
                  child: const Text("موافق , خروج"),
                ),
              ],
            ),
          );
        },
        child: Column(children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            // child: Text(
            //     "URL: ${(url.length > 40) ? "${url.substring(0, 40)}..." : url} - $progress%"),
            child: Text(
                " يرجى عدم الخروج من الصفحة حتي يتم الانتهاء من عملية الدفع - $progress%"),
          ),
          Expanded(
            child: InAppWebView(
              // Authorization : token
              initialUrlRequest: URLRequest(url: WebUri(url.toString().trim())),
              pullToRefreshController: pullToRefreshController,
              initialSettings: InAppWebViewSettings(
                javaScriptEnabled: true,
                useShouldOverrideUrlLoading: true,
                javaScriptCanOpenWindowsAutomatically: true,
                mediaPlaybackRequiresUserGesture: false,
                verticalScrollBarEnabled: false,
                horizontalScrollBarEnabled: false,
                cacheEnabled: true,
                domStorageEnabled: true,
              ),

              onWebViewCreated: (controller) {
                headlessWebView = null;
                webViewController = controller;
                
                // Set up JS Handlers to receive Intercepted data (Console only)
                controller.addJavaScriptHandler(handlerName: 'onNetworkData', callback: (args) {
                  var type = args[0]; // 'request' or 'response'
                  var dataStr = args[1].toString();
                  
                  // Filter out debugbar noise
                  if (dataStr.contains('_debugbar')) return;
                  
                  print('🌐 Network Intercept [$type]: $dataStr');
                  
                  // Detect the specific Backend Error seen in Terminal for logging
                  if (type == 'response' && (dataStr.contains('withBasicAuth') || dataStr.contains('Argument #1'))) {
                    print('❌ BACKEND ERROR DETECTED: Moyasar API Key likely missing on server.');
                  }
                });

                if (!mounted) return;
              },
              onLoadStart: (controller, url) {
                if (!mounted) return;
                print('🚀 Loading started: $url');
                setState(() {
                  this.url = url?.toString() ?? "";
                });
              },
              onProgressChanged: (controller, progress) async {
                if (!mounted) return;
                if (progress == 100) {
                  pullToRefreshController?.endRefreshing();
                  
                  // حقن الـ publishableKey وتصحيح روابط الـ Fetch
                  if (_publishableKey != null) {
                    await controller.evaluateJavascript(source: """
                      window.moyasar_publishable_key = '$_publishableKey';
                      
                      var originalFetch = window.fetch;
                      window.fetch = function(url, options) {
                          if (typeof url === 'string' && url.startsWith('/api/')) {
                              url = 'https://ymtaz.sa' + url;
                          }
                          return originalFetch(url, options);
                      };
                      console.log('🔑 Key & Fetch Ready');
                    """);
                  }
                  
                  if (kDebugMode) {
                    injectVisaData();
                  }
                }
                setState(() {
                  this.progress = progress;
                });
              },
              onLoadStop: (controller, url) async {
                if (!mounted) return;
                pullToRefreshController?.endRefreshing();
                print('🏁 URL Changed: $url');
                
                if (url != null && !_hasNavigated) {
                  String urlStr = url.toString();
                  var params = url.queryParameters;
                  
                  // فحص حالة الدفع بناءً على الموثق في ميسر
                  String? status = params['status']?.toLowerCase();
                  String? message = params['message'];

                  if (status == 'paid' || status == 'authorized' || urlStr.contains('success')) {
                      _hasNavigated = true;
                      print('✅ نجاح عملية الدفع - الحالة: $status');
                      Navigator.pop(context, 'success');
                      return;
                  }
                  
                  if (status == 'failed' || status == 'declined' || urlStr.contains('failed')) {
                      _hasNavigated = true;
                      String errorMsg = message ?? 'فشلت عملية الدفع، يرجى التأكد من بيانات البطاقة';
                      print('❌ فشل الدفع - الرسالة: $errorMsg');
                      Navigator.pop(context, {'status': 'failed', 'message': errorMsg});
                      return;
                  }
                }
              },
              onUpdateVisitedHistory: (controller, url, isReload) {
                if (!mounted || _hasNavigated || url == null) return;
                
                String urlStr = url.toString();
                var params = url.queryParameters;
                String? status = params['status']?.toLowerCase();

                // التقاط النجاح حتى لو حدث تغيير في التاريخ (Redirect فوري)
                if (status == 'paid' || status == 'authorized') {
                    _hasNavigated = true;
                    Navigator.pop(context, 'success');
                }
              },
              onTitleChanged: (controller, title) {
                if (!mounted || _hasNavigated) return;
                print('🏷️ WebView Title: $title');
                setState(() {
                  // Common success titles in various languages/gateways
                  if (title == "عملية دفع ناجحة" || 
                      title?.toLowerCase().contains("success") == true ||
                      title?.toLowerCase().contains("completed") == true ||
                      title == "تمت العملية بنجاح") {
                    success = true;
                    print('🎉 Success Title detected! success flag = true');
                  }
                });
                
                if (success && !_hasNavigated) {
                  _hasNavigated = true;
                  print('🎯 Success flag is true, returning to PackageDetails...');
                  Navigator.pop(context, 'success');
                }
              },
              onReceivedServerTrustAuthRequest: (controller, challenge) async {
                // السماح للمواقع بالتحميل حتى لو كانت شهادة الـ SSL غير صالحة (مفيد في التيست)
                return ServerTrustAuthResponse(action: ServerTrustAuthResponseAction.PROCEED);
              },
              onReceivedError: (controller, request, error) {
                pullToRefreshController?.endRefreshing();
                print('❌ WebView Error: ${error.description}');
                print('🔗 Failed URL: ${request.url}');
                
                // تنبيه عام عند حدوث خطأ في الاتصال
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('فشل تحميل الصفحة: ${error.description}'))
                );
              },
              onConsoleMessage: (controller, consoleMessage) {
                print('🖥️ JS Console: [${consoleMessage.messageLevel}] ${consoleMessage.message}');
              },
              onJsAlert: (controller, jsAlertRequest) async {
                print('📢 Page Alert: ${jsAlertRequest.message}');
                if (context.mounted) {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("رسالة من الصفحة"),
                      content: Text(jsAlertRequest.message ?? ""),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context), child: const Text("موافق")),
                      ],
                    ),
                  );
                }
                return JsAlertResponse(handledByClient: true);
              },
            ),
          )
        ]),
      ),
    );
  }

  Future<void> injectVisaData() async {
    // Replace the following lines with logic to retrieve saved Visa data from your app
    var initialData = {
      'creditCardNumber': '4000000000000002',
      'creditCardExp': '12/25',
      'cardCVV': '123',
      'bill_phone': '1234567890',
    };

    // Construct JavaScript code to set initial data with existence checks
    String script = '''
      (function() {
        function setValue(id, value) {
          var el = document.getElementById(id);
          if (el) {
            el.value = value;
            el.dispatchEvent(new Event('input', { bubbles: true }));
            el.dispatchEvent(new Event('change', { bubbles: true }));
          }
        }
        setValue('creditCardNumber', '${initialData['creditCardNumber']}');
        setValue('creditCardExp', '${initialData['creditCardExp']}');
        setValue('cardCVV', '${initialData['cardCVV']}');
        setValue('bill_phone', '${initialData['bill_phone']}');
        
        // Some gateways use different IDs
        setValue('card_number', '${initialData['creditCardNumber']}');
        setValue('cc-number', '${initialData['creditCardNumber']}');
        setValue('expiry_date', '${initialData['creditCardExp']}');
        setValue('cvv', '${initialData['cardCVV']}');
      })();
    ''';

    // Execute the JavaScript code in the web view
    if (mounted) {
      await webViewController?.evaluateJavascript(source: script);
    }
  }
}
