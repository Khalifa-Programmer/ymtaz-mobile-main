import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_cubit.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_state.dart';
import 'package:yamtaz/feature/contact_ymtaz/presentation/my_messages.dart';
import 'package:yamtaz/feature/contact_ymtaz/presentation/send_support.dart';

class ContactYmtazScreen extends StatefulWidget {
  const ContactYmtazScreen({super.key});

  @override
  State<ContactYmtazScreen> createState() => _ContactYmtazScreenState();
}

class _ContactYmtazScreenState extends State<ContactYmtazScreen> {
  bool _isSendingDialogShown = false;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ContactYmtazCubit>();
    cubit.getContactUsTypes();
    cubit.getData();
  }

  void _popSendingDialog() {
    if (_isSendingDialogShown && mounted) {
      _isSendingDialogShown = false;
      Navigator.of(context, rootNavigator: true).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ContactYmtazCubit, ContactYmtazState>(
      listener: (context, state) {
        state.maybeWhen(
          loadingSendMessage: () {
            _isSendingDialogShown = true;
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
              ),
            );
          },
          successSendMessage: (_) {
            _popSendingDialog();
            AppAlerts.showAlert(
                context: context,
                message: "تم ارسال الرسالة بنجاح",
                buttonText: "استمرار",
                type: AlertType.success);
          },
          errorSendMessage: (message) {
            _popSendingDialog();
            AppAlerts.showAlert(
                context: context,
                message: message,
                buttonText: "حاول مرة اخرى",
                type: AlertType.error);
          },
          error: (message) {
            AppAlerts.showAlert(
                context: context,
                message: message,
                buttonText: "استمرار",
                type: AlertType.error);
          },
          orElse: () {},
        );
      },
      builder: (context, state) {
        return DefaultTabController(
          length: 2,
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              centerTitle: true,
              title: Text(
                "تواصل معنا",
                style: TextStyles.cairo_16_bold.copyWith(
                  color: appColors.black,
                ),
              ),
              bottom: TabBar(
                  indicatorColor: appColors.primaryColorYellow,
                  labelStyle: TextStyles.cairo_14_bold,
                  indicatorSize: TabBarIndicatorSize.tab,
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                  unselectedLabelColor: const Color(0xFF808D9E),
                  unselectedLabelStyle: TextStyles.cairo_14_semiBold,
                  tabs: const [
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("تواصل معنا"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("الرسائل"),
                      ),
                    ),
                  ]),
            ),
            body: const TabBarView(children: [
              SendSupportYmtaz(),
              MyMessages()
            ]),
          ),
        );
      },
    );
  }
}
