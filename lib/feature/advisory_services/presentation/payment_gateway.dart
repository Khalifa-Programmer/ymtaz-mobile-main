import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/feature/advisory_services/data/model/advisory_request_response.dart';
import 'package:yamtaz/feature/advisory_services/presentation/invice_screen.dart';

class PaymentAdvisoryScreen extends StatefulWidget {
  const PaymentAdvisoryScreen(
      {super.key, required this.link, required this.data});

  final String link;
  final AdvisoryRequestResponse data;

  @override
  State<PaymentAdvisoryScreen> createState() =>
      PaymentAdvisoryScreenState(link, data);
}

class PaymentAdvisoryScreenState extends State<PaymentAdvisoryScreen> {
  HeadlessInAppWebView? headlessWebView;
  PullToRefreshController? pullToRefreshController;
  InAppWebViewController? webViewController;

  PaymentAdvisoryScreenState(this.url, this.data);

  final AdvisoryRequestResponse data;
  String url = "";
  bool success = false;
  int progress = 0;
  bool convertFlag = false;

  @override
  void initState() {
    super.initState();

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

        const snackBar = SnackBar(
          content: Text('HeadlessInAppWebView created!'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onLoadStart: (controller, url) async {
        setState(() {
          this.url = url?.toString() ?? '';
        });
      },
      onProgressChanged: (controller, progress) {
        setState(() {
          this.progress = progress;
        });
      },
      onLoadStop: (controller, url) async {
        setState(() {
          this.url = url?.toString() ?? '';
        });
      },
    );
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
      body: Column(children: <Widget>[
        Container(
          padding: const EdgeInsets.all(20.0),
          // child: Text(
          //     "URL: ${(url.length > 40) ? "${url.substring(0, 40)}..." : url} - $progress%"),
          child: Text(
              " يرجي عدم الخروج من الصفحة حتي يتم الانتهاء من عملية الدفع - $progress%"),
        ),
        Expanded(
          child: InAppWebView(
            initialUrlRequest: URLRequest(url: WebUri(url)),
            onWebViewCreated: (controller) {
              headlessWebView = null;
              webViewController = controller;
              const snackBar = SnackBar(
                content: Text(
                    'يرجي عدم الخروج من الصفحة حتي يتم الانتهاء من عملية الدفع'),
                duration: Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
            onLoadStart: (controller, url) {
              setState(() {
                this.url = url?.toString() ?? "";
              });
            },
            onProgressChanged: (controller, progress) {
              if (progress == 100) {
                pullToRefreshController?.endRefreshing();
                if (kDebugMode) {
                  injectVisaData();
                }
              }
              setState(() {
                this.progress = progress;
              });
            },
            onLoadStop: (controller, url) {
              pullToRefreshController?.endRefreshing();
              setState(() {
                this.url = url?.toString() ?? "";
              });
              if (url != null &&
                  url.toString().contains(
                      'https://api.ymtaz.sa/api/payments/callback/lawyer/') && success == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SuccessPaymentInvoice(data: data)));
                // AppAlerts.showAlert(
                //   context: context,
                //   message: "تمت عملية الدفع بنجاح",
                //   route: Routes.myServices,
                //   isForceRouting: false,
                //   buttonText: "عرض طلباتي",
                //   type: AlertType.success,
                // );
              } else if (url != null &&
                  url.toString().contains(
                      'https://api.ymtaz.sa/api/payments/callback/client/')&& success == true) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            SuccessPaymentInvoice(data: data)));
              }
            },

            onTitleChanged: (controller, title) {
              setState(() {
                if(title == "عملية دفع ناجحة"){
                   success = true;
                }
              });
            },
            onReceivedError: (controller, request, error) {
              pullToRefreshController?.endRefreshing();
            },
          ),
        )
      ]),
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

    // Construct JavaScript code to set initial data
    String script = '''
      document.getElementById('creditCardNumber').value = '${initialData['creditCardNumber']}';
      document.getElementById('creditCardExp').value = '${initialData['creditCardExp']}';
      document.getElementById('cardCVV').value = '${initialData['cardCVV']}';
      document.getElementById('bill_phone').value = '${initialData['bill_phone']}';
    ''';

    // Execute the JavaScript code in the web view
    await webViewController?.evaluateJavascript(source: script);
  }
}
