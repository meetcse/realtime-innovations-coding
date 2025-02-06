import 'package:flutter/material.dart';
import 'package:realtime_innovations_coding/utils/app_colors.dart';
import 'package:realtime_innovations_coding/widgets/app_widgets.dart';

class CommonScaffoldScreen extends StatelessWidget {
  const CommonScaffoldScreen(
      {Key? key,
      required this.body,
      this.appBarTitle,
      this.onBackTap,
      this.appBarActions,
      this.onFloatingActionButtonTap,
      this.isBackButtonEnabled = true})
      : super(key: key);

  final Widget body;
  final String? appBarTitle;
  final Function? onBackTap;
  final List<Widget>? appBarActions;
  final bool isBackButtonEnabled;
  final Function()? onFloatingActionButtonTap;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: _buildAppBar(context),
      body: body,
      floatingActionButton: onFloatingActionButtonTap != null
          ? FloatingActionButton(
              backgroundColor: AppColors.primaryBgColor,
              onPressed: onFloatingActionButtonTap,
              child: const Icon(Icons.add, color: AppColors.white),
            )
          : null,
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppWidgets.appBarNormalWithLeadingAndAction(
      appBarTitle!,
      leading: isBackButtonEnabled ? AppWidgets.backButton(context, onTap: onBackTap) : null,
      actions: appBarActions,
    );
  }
}
