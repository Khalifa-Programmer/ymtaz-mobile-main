import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/di/dependency_injection.dart';
import 'package:yamtaz/core/helpers/extentions.dart';
import 'package:yamtaz/core/widgets/alerts.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_cubit.dart';
import 'package:yamtaz/feature/contact_ymtaz/logic/contact_ymtaz_state.dart';
import 'package:yamtaz/feature/contact_ymtaz/presentation/my_messages.dart';
import 'package:yamtaz/feature/contact_ymtaz/presentation/send_support.dart';

class ContactYmtazScreen extends StatelessWidget {
  const ContactYmtazScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getit<ContactYmtazCubit>(),
      child: BlocConsumer<ContactYmtazCubit, ContactYmtazState>(
        listener: (context, state) {
          if (state is LoadingContactYmtazState) {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
              ),
            );
          }

          if (state is LoadedContactYmtazState) {}

          if (state is ErrorContactYmtazState) {}

          if (state is LoadingSendMessage) {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(
                  color: appColors.primaryColorYellow,
                ),
              ),
            );
          }

          if (state is SuccessSendMessage) {
            context.pop();

            AppAlerts.showAlert(
                context: context,
                message: "تم ارسال الرسالة بنجاح",
                buttonText: "استمرار",
                type: AlertType.success);
          }

          if (state is ErrorSendMessage) {
            context.pop();
            AppAlerts.showAlert(
                context: context,
                message: state.message,
                buttonText: "استمرار",
                type: AlertType.error);
          }
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
                body: TabBarView(children: [
                  BlocProvider.value(
                    value: getit<ContactYmtazCubit>()..getContactUsTypes(),
                    child: const SendSupportYmtaz(),
                  ),
                  const MyMessages()
                ]),
              ));
        },
      ),
    );
  }
}
