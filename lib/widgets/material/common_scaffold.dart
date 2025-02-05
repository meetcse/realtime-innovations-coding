import 'package:flutter/material.dart';
import 'package:realtime_innovations_coding/utils/app_colors.dart';
import 'package:realtime_innovations_coding/widgets/app_widgets.dart';

class CommonScaffoldScreen extends StatelessWidget {
  const CommonScaffoldScreen({Key? key, required this.body, this.appBarTitle, this.onBackTap, this.appBarActions})
      : super(key: key);

  final Widget body;
  final String? appBarTitle;
  final Function? onBackTap;
  final List<Widget>? appBarActions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: appBarTitle == null || appBarTitle == '' ? null : _buildAppBar(context),
      body: body,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppWidgets.appBarNormalWithLeadingAndAction(
      appBarTitle!,
      leading: AppWidgets.backButton(context, onTap: onBackTap),
      actions: appBarActions,
    );
  }
}
