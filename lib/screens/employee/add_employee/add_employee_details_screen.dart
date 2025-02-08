import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_coding/bloc/employee/add_employee/add_employee_details_screen_cubit.dart';
import 'package:realtime_innovations_coding/utils/app_colors.dart';
import 'package:realtime_innovations_coding/utils/app_images_path.dart';
import 'package:realtime_innovations_coding/utils/app_strings.dart';
import 'package:realtime_innovations_coding/utils/page_utils.dart';
import 'package:realtime_innovations_coding/widgets/app_widgets.dart';
import 'package:realtime_innovations_coding/widgets/material/common_scaffold.dart';

class AddEmployeeDetailsScreen extends StatelessWidget {
  const AddEmployeeDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddEmployeeDetailsScreenCubit(),
      child: const CommonScaffoldScreen(appBarTitle: AppStrings.addEmployeeDetails, body: AEDMainBody()),
    );
  }
}

class AEDMainBody extends StatelessWidget {
  const AEDMainBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Expanded(child: AEDEmployeeDetailsColumn()),
        const Divider(color: AppColors.borderColor, height: 1),
        AppWidgets.spacingWidget(12),
        const AEDBottomButtonsRow(),
        AppWidgets.spacingWidget(12),
      ],
    );
  }
}

class AEDBottomButtonsRow extends StatelessWidget {
  const AEDBottomButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppWidgets.edgeInsetsSymmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          AppWidgets.buttonWidget(
            AppStrings.cancel,
            textColor: AppColors.primaryBgColor,
            backgroundColor: AppColors.buttonBgColor,
            onPressed: () {
              PageUtils.popRoute(context);
            },
          ),
          AppWidgets.spacingWidget(0, 16),
          AppWidgets.buttonWidget(
            AppStrings.save,
            textColor: AppColors.white,
            onPressed: () {
              //TODO:
            },
          ),
        ],
      ),
    );
  }
}

class AEDEmployeeDetailsColumn extends StatelessWidget {
  const AEDEmployeeDetailsColumn({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: AppWidgets.edgeInsetsSymmetric(horizontal: 16),
        child: Column(
          children: [
            AppWidgets.spacingWidget(24),
            const AEDEmployeeNameTextField(),
            AppWidgets.spacingWidget(24),
            const AEDSelectRoleDropDown(),
            AppWidgets.spacingWidget(24),
            const AEDDatesRow(),
          ],
        ),
      ),
    );
  }
}

class AEDDatesRow extends StatelessWidget {
  const AEDDatesRow({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AddEmployeeDetailsScreenCubit>(context);

    return Row(
      children: [
        Expanded(
            child: AppWidgets.textFieldWithRectBorder(
          prefixConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          prefixIcon: Container(
              margin: AppWidgets.edgeInsetsAll(12),
              child: AppWidgets.imageFromAssetWidget(AppImagesPath.calendarIcon, height: 20, widht: 20)),
          hintText: AppStrings.noDate,
          controller: cubit.startDateController,
          onTap: () {
            //TODO:
          },
          readOnly: true,
        )),
        Container(
            margin: AppWidgets.edgeInsetsSymmetric(horizontal: 16),
            child: AppWidgets.icon(Icons.arrow_forward_rounded, color: AppColors.primaryBgColor)),
        Expanded(
            child: AppWidgets.textFieldWithRectBorder(
          prefixConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
          prefixIcon: Container(
              margin: AppWidgets.edgeInsetsAll(12),
              child: AppWidgets.imageFromAssetWidget(AppImagesPath.calendarIcon, height: 20, widht: 20)),
          hintText: AppStrings.noDate,
          controller: cubit.endDateController,
          onTap: () {
            //TODO:
          },
          readOnly: true,
        )),
      ],
    );
  }
}

class AEDSelectRoleDropDown extends StatelessWidget {
  const AEDSelectRoleDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AddEmployeeDetailsScreenCubit>(context);
    return AppWidgets.textFieldWithRectBorder(
        prefixConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: Container(
            margin: AppWidgets.edgeInsetsAll(20),
            child: AppWidgets.imageFromAssetWidget(AppImagesPath.selectRoleIcon, height: 20, widht: 20)),
        hintText: AppStrings.selectRole,
        controller: cubit.selectRoleController,
        onTap: () {
          //TODO:
        },
        readOnly: true,
        suffixIcon: AppWidgets.icon(Icons.arrow_drop_down, color: AppColors.primaryBgColor));
  }
}

class AEDEmployeeNameTextField extends StatelessWidget {
  const AEDEmployeeNameTextField({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AddEmployeeDetailsScreenCubit>(context);
    return AppWidgets.textFieldWithRectBorder(
        prefixConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        prefixIcon: Container(
            margin: AppWidgets.edgeInsetsAll(20),
            child: AppWidgets.imageFromAssetWidget(AppImagesPath.personIcon, height: 20, widht: 20)),
        hintText: AppStrings.employeeName,
        controller: cubit.employeeNameController);
  }
}
