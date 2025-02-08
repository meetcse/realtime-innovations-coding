import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:realtime_innovations_coding/bloc/employee/employee_list_screen_cubit.dart';
import 'package:realtime_innovations_coding/bloc/employee/employee_list_screen_state.dart';
import 'package:realtime_innovations_coding/models/employee_model.dart';
import 'package:realtime_innovations_coding/utils/app_colors.dart';
import 'package:realtime_innovations_coding/utils/app_images_path.dart';
import 'package:realtime_innovations_coding/utils/app_strings.dart';
import 'package:realtime_innovations_coding/utils/app_text_styles.dart';
import 'package:realtime_innovations_coding/widgets/app_widgets.dart';
import 'package:realtime_innovations_coding/widgets/material/common_scaffold.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeListScreenCubit()..initialize(),
      child: Builder(builder: (ctx) {
        return CommonScaffoldScreen(
          backgroundColor: AppColors.borderColor,
          isBackButtonEnabled: false,
          appBarTitle: AppStrings.employeeList,
          body: const ELMainBody(),
          onFloatingActionButtonTap: () {
            var cubit = BlocProvider.of<EmployeeListScreenCubit>(ctx);
            cubit.onFLoatingActionButtonTap(ctx);
          },
        );
      }),
    );
  }
}

class ELMainBody extends StatelessWidget {
  const ELMainBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<EmployeeListScreenCubit>(context);

    return BlocConsumer<EmployeeListScreenCubit, EmployeeListScreenState>(listener: (context, state) {
      if (state is ELSSShowToastState) {
        AppWidgets.showToast(context, state.message, onPressed: () {
          cubit.onUndoDeletePressed();
        });
      }
    }, builder: (context, state) {
      if (cubit.currentEmployeesList.isEmpty && cubit.previousEmployeesList.isEmpty) {
        return const ELNoEmpRecordsWidget();
      }

      return SingleChildScrollView(
        child: Column(
          children: [
            AppWidgets.spacingWidget(16),
            const ELCurrentEmployeesList(),
            AppWidgets.spacingWidget(16),
            const ELPreviousEmployeesList(),
            AppWidgets.spacingWidget(12),
            const ELSwipeLeftToDeleteText(),
          ],
        ),
      );
    });
  }
}

class ELSwipeLeftToDeleteText extends StatelessWidget {
  const ELSwipeLeftToDeleteText({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppWidgets.edgeInsetsOnly(left: 16),
      child: Row(
        children: [
          AppWidgets.textWidget(AppStrings.swipeLeftToDelete,
              textStyle: AppTextStyles.appTextStyle(
                color: AppColors.hintTextColor,
              ))
        ],
      ),
    );
  }
}

class ELCurrentEmployeesList extends StatelessWidget {
  const ELCurrentEmployeesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeListScreenCubit, EmployeeListScreenState>(buildWhen: (previous, current) {
      if (current is ELSEmployeeListFetchSuccessState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      var cubit = BlocProvider.of<EmployeeListScreenCubit>(context);
      List<EmployeeModel> currentEmployees = cubit.currentEmployeesList;
      if (currentEmployees.isEmpty) {
        return Container();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: AppWidgets.edgeInsetsOnly(left: 16),
            child: AppWidgets.textWidget(AppStrings.currentEmployees,
                textStyle: AppTextStyles.appTextStyle(
                    fontWeight: FontWeight.w500, color: AppColors.primaryBgColor, fontSize: 16)),
          ),
          AppWidgets.spacingWidget(16),
          ...currentEmployees.asMap().entries.map((data) {
            return ELEmployeeListWidget(employee: data.value, isLastItem: currentEmployees.length - 1 == data.key);
          }).toList(),
        ],
      );
    });
  }
}

class ELPreviousEmployeesList extends StatelessWidget {
  const ELPreviousEmployeesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EmployeeListScreenCubit, EmployeeListScreenState>(buildWhen: (previous, current) {
      if (current is ELSEmployeeListFetchSuccessState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      var cubit = BlocProvider.of<EmployeeListScreenCubit>(context);
      List<EmployeeModel> previousEmployees = cubit.previousEmployeesList;
      if (previousEmployees.isEmpty) {
        return Container();
      }
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: AppWidgets.edgeInsetsOnly(left: 16),
            child: AppWidgets.textWidget(AppStrings.previousEmployees,
                textStyle: AppTextStyles.appTextStyle(
                    fontWeight: FontWeight.w500, color: AppColors.primaryBgColor, fontSize: 16)),
          ),
          AppWidgets.spacingWidget(16),
          ...previousEmployees.asMap().entries.map((data) {
            return ELEmployeeListWidget(employee: data.value, isLastItem: previousEmployees.length - 1 == data.key);
          }).toList(),
        ],
      );
    });
  }
}

class ELEmployeeListWidget extends StatelessWidget {
  const ELEmployeeListWidget({super.key, required this.employee, this.isLastItem = false});

  final EmployeeModel employee;
  final bool isLastItem;

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<EmployeeListScreenCubit>(context);

    return Slidable(
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        extentRatio: 0.2,
        children: [
          SlidableAction(
            autoClose: true,
            // An action can be bigger than the others.
            flex: 1,
            onPressed: (_) {
              cubit.deleteEmployeeData(employee);
            },
            backgroundColor: AppColors.redBgColor,
            foregroundColor: Colors.white,
            icon: Icons.delete,
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          cubit.onFLoatingActionButtonTap(context, employee: employee);
        },
        child: Container(
          color: AppColors.white,
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: AppWidgets.edgeInsetsOnly(left: 16, right: 16, top: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppWidgets.textWidget(employee.name ?? "",
                        textStyle: AppTextStyles.appTextStyle(fontSize: 16, fontWeight: FontWeight.w500)),

                    //
                    AppWidgets.spacingWidget(6),

                    //

                    AppWidgets.textWidget(employee.role ?? "",
                        textStyle: AppTextStyles.appTextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.hintTextColor)),
                    //

                    AppWidgets.spacingWidget(6),

                    AppWidgets.textWidget(cubit.getEmployeeJoiningAndEndingDate(employee),
                        textStyle: AppTextStyles.appTextStyle(
                            fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.hintTextColor)),
                  ],
                ),
              ),
              AppWidgets.spacingWidget(16),
              if (!isLastItem) const Divider(color: AppColors.borderColor, height: 1),
            ],
          ),
        ),
      ),
    );
  }
}

class ELNoEmpRecordsWidget extends StatelessWidget {
  const ELNoEmpRecordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppWidgets.imageFromAssetWidget(AppImagesPath.noEmpRecordsImage, height: 245, widht: 261),
    );
  }
}
