import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/feature/digital_office/data/models/my_office_response_model.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/constants/colors.dart';
import 'analytics_card.dart';

class TabsAnalysis extends StatefulWidget {
  TabsAnalysis({super.key, required this.data});

  OfficeData data;

  @override
  State<TabsAnalysis> createState() => _TabsAnalysisState();
}

class _TabsAnalysisState extends State<TabsAnalysis>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFFF3F9FF),
            Color(0xFFFFFAF2),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 45,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
              color: appColors.grey1w5.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15).r,
                topRight: Radius.circular(15).r,
                bottomLeft: Radius.circular(15).r,
                bottomRight: Radius.circular(15).r,
              ),
            ),
            child: TabBar(
                indicator: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    25,
                  ),
                  color: appColors.blue100,
                ),
                controller: _tabController,
                labelStyle: TextStyles.cairo_10_bold,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                overlayColor: WidgetStateProperty.all(Colors.transparent),
                unselectedLabelColor: appColors.blue100,
                labelColor: Colors.white,
                unselectedLabelStyle: TextStyles.cairo_10_semiBold,
                tabs: const [
                  Tab(
                    text: 'الاستشارات',
                  ),
                  Tab(
                    text: 'الخدمات',
                  ),
                  Tab(
                    text: 'المواعيد',
                  ),
                ]),
          ),
          SizedBox(
            height: 120,
            child: TabBarView(
              controller: _tabController,
              children: [
                // AnalyticsTotalCard(data: data),
                AnalyticsCard(
                    data: widget.data.advisoryServices?.toJson() ?? {}),
                AnalyticsCard(data: widget.data.services?.toJson() ?? {}),
                AnalyticsCard(data: widget.data.appointments?.toJson() ?? {}),
              ],
            ),
          )

          // Add static rows for country, city, nationality, phone, degree, email, etc.
        ],
      ),
    );
  }
}
