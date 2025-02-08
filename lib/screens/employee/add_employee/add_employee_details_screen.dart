import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_coding/bloc/employee/add_employee/add_employee_details_screen_cubit.dart';
import 'package:realtime_innovations_coding/bloc/employee/add_employee/add_employee_details_screen_state.dart';
import 'package:realtime_innovations_coding/enums/role_enums.dart';
import 'package:realtime_innovations_coding/models/employee_model.dart';
import 'package:realtime_innovations_coding/utils/app_colors.dart';
import 'package:realtime_innovations_coding/utils/app_images_path.dart';
import 'package:realtime_innovations_coding/utils/app_strings.dart';
import 'package:realtime_innovations_coding/utils/app_text_styles.dart';
import 'package:realtime_innovations_coding/utils/page_utils.dart';
import 'package:realtime_innovations_coding/widgets/app_widgets.dart';
import 'package:realtime_innovations_coding/widgets/material/common_scaffold.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class AddEmployeeDetailsScreen extends StatelessWidget {
  const AddEmployeeDetailsScreen({super.key, this.employeeModel});

  final EmployeeModel? employeeModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AddEmployeeDetailsScreenCubit()..initialize(employeeModel),
      child: CommonScaffoldScreen(
          appBarActions: employeeModel == null
              ? null
              : [
                  GestureDetector(
                      onTap: () {
                        PageUtils.popRoute(context, result: employeeModel);
                      },
                      child: AppWidgets.icon(Icons.delete_outline_outlined, color: AppColors.white)),
                  AppWidgets.spacingWidget(0, 16)
                ],
          appBarTitle: employeeModel != null ? AppStrings.editEmployeeDetails : AppStrings.addEmployeeDetails,
          body: const AEDMainBody()),
    );
  }
}

class AEDMainBody extends StatelessWidget {
  const AEDMainBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddEmployeeDetailsScreenCubit, AddEmployeeDetailsScreenState>(
      listener: (context, state) {
        if (state is AEDSShowToastState) {
          AppWidgets.showToast(context, state.message);
        }
      },
      child: Column(
        children: [
          const Expanded(child: AEDEmployeeDetailsColumn()),
          const Divider(color: AppColors.borderColor, height: 1),
          AppWidgets.spacingWidget(12),
          const AEDBottomButtonsRow(),
          AppWidgets.spacingWidget(12),
        ],
      ),
    );
  }
}

class AEDBottomButtonsRow extends StatelessWidget {
  const AEDBottomButtonsRow({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<AddEmployeeDetailsScreenCubit>(context);

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
              cubit.onSaveEmpoyeeDetailsTap(context);
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
            showDatePickerDialog(context, true);
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
            showDatePickerDialog(context, false);
          },
          readOnly: true,
        )),
      ],
    );
  }

  void showDatePickerDialog(BuildContext context, bool isStartDate) {
    var cubit = BlocProvider.of<AddEmployeeDetailsScreenCubit>(context);
    cubit.setDateRangeControllerToNullOnPickerOpen(isStartDate);
    showDialog(
        context: context,
        builder: (_) {
          return BlocProvider.value(
            value: cubit,
            child: BlocBuilder<AddEmployeeDetailsScreenCubit, AddEmployeeDetailsScreenState>(
                buildWhen: (previous, current) {
              if (current is AEDSDatePickerMonthChangeState) {
                return true;
              }
              return false;
            }, builder: (context, state) {
              return Dialog(
                backgroundColor: AppColors.white,
                insetPadding: AppWidgets.edgeInsetsSymmetric(horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Container(
                  padding: AppWidgets.edgeInsetsSymmetric(horizontal: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppWidgets.spacingWidget(24),
                      // rows for start and end dates
                      datePickerSelectionButtonsRow(context, isStartDate),
                      AppWidgets.spacingWidget(24),

                      // month and year
                      currentMonthAndYearWidget(context),

                      AppWidgets.spacingWidget(26),

                      SfDateRangePicker(
                        headerHeight: 0,
                        initialSelectedDate: cubit.getDateTimeFromStringForInitialDate(isStartDate),
                        initialDisplayDate: cubit.getDateTimeFromStringForInitialDate(isStartDate),
                        minDate: isStartDate ? null : cubit.startDateDateTime,
                        onViewChanged: (dateRangePickerViewChangedArgs) {
                          cubit.emitDatePickerMonthChangeState();
                        },
                        onSelectionChanged: (dateRangePickerSelectionChangedArgs) {
                          if (isStartDate) {
                            cubit.setSelectedDatePickerStartDate(dateRangePickerSelectionChangedArgs.value as DateTime);
                          } else {
                            cubit.setSelectedDatePickerEndDate(dateRangePickerSelectionChangedArgs.value as DateTime);
                          }
                        },
                        todayHighlightColor: AppColors.primaryBgColor,
                        selectionColor: AppColors.primaryBgColor,
                        controller: cubit.dateRangePickerController,
                        monthFormat: "MMMM",
                        monthViewSettings: const DateRangePickerMonthViewSettings(
                          dayFormat: "EEE",
                          enableSwipeSelection: true,
                        ),
                        toggleDaySelection: true,
                        monthCellStyle: DateRangePickerMonthCellStyle(
                          todayTextStyle: AppTextStyles.appTextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.primaryBgColor),
                          todayCellDecoration: BoxDecoration(
                              border: Border.all(color: AppColors.primaryBgColor), shape: BoxShape.circle),
                          cellDecoration: const BoxDecoration(shape: BoxShape.circle),
                          textStyle: AppTextStyles.appTextStyle(
                              fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.appTextColor),
                        ),
                        selectionMode: DateRangePickerSelectionMode.single,
                        headerStyle: const DateRangePickerHeaderStyle(backgroundColor: AppColors.white),
                        selectionTextStyle: AppTextStyles.appTextStyle(
                            fontSize: 15, fontWeight: FontWeight.w400, color: AppColors.white),
                        backgroundColor: AppColors.white,
                        onCancel: () {
                          //
                        },
                        cancelText: "Cancel",
                        view: DateRangePickerView.month,
                      ),

                      AppWidgets.spacingWidget(24),

                      const Divider(color: AppColors.borderColor, height: 1),

                      AppWidgets.spacingWidget(24),

                      bottomButtonsRow(context, isStartDate),

                      AppWidgets.spacingWidget(16),
                    ],
                  ),
                ),
              );
            }),
          );
        });
  }

  Widget bottomButtonsRow(BuildContext context, bool isStartDate) {
    var cubit = BlocProvider.of<AddEmployeeDetailsScreenCubit>(context);

    return Row(
      children: [
        Expanded(
          child: Row(
            children: [
              AppWidgets.imageFromAssetWidget(AppImagesPath.calendarIcon, height: 23, widht: 20),
              AppWidgets.spacingWidget(0, 12),
              AppWidgets.textWidget(cubit.getDateDisplayText(isStartDate),
                  textStyle: AppTextStyles.appTextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.appTextColor)),
              AppWidgets.spacingWidget(0, 12),
            ],
          ),
        ),
        AppWidgets.buttonWidget(
          AppStrings.cancel,
          textColor: AppColors.primaryBgColor,
          backgroundColor: AppColors.buttonBgColor,
          onPressed: () {
            cubit.onCancelDatePickerTap(context);
          },
        ),
        AppWidgets.spacingWidget(0, 16),
        AppWidgets.buttonWidget(
          AppStrings.save,
          textColor: AppColors.white,
          onPressed: () {
            cubit.onSaveDatePickerTap(context);
          },
        ),
      ],
    );
  }

  Widget datePickerSelectionButtonsRow(BuildContext context, bool isStartDate) {
    var cubit = BlocProvider.of<AddEmployeeDetailsScreenCubit>(context);

    if (isStartDate) {
      return BlocBuilder<AddEmployeeDetailsScreenCubit, AddEmployeeDetailsScreenState>(buildWhen: (previous, current) {
        if (current is AEDSDatePickerMonthChangeState) {
          return true;
        }
        return false;
      }, builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: datePickerSelectionButtonWidget(AppStrings.today, cubit.isStartDateTodaySelected(), () {
                  cubit.setSelectedDatePickerStartDate(DateTime.now(), isSetFromButtons: true);
                })),
                AppWidgets.spacingWidget(0, 16),
                Expanded(
                    child: datePickerSelectionButtonWidget(
                        AppStrings.next + " " + cubit.getStartDateTomorrowDay(), cubit.isStartDateTomorrowSelected(),
                        () {
                  cubit.setSelectedDatePickerStartDate(DateTime.now().add(const Duration(days: 1)),
                      isSetFromButtons: true);
                })),
              ],
            ),
            AppWidgets.spacingWidget(16),
            Row(
              children: [
                Expanded(
                    child: datePickerSelectionButtonWidget(
                        AppStrings.next + " " + cubit.getStartDateDayAfterTomorrowDay(),
                        cubit.isStartDateDayAfterTomorrowSelected(), () {
                  cubit.setSelectedDatePickerStartDate(DateTime.now().add(const Duration(days: 2)),
                      isSetFromButtons: true);
                })),
                AppWidgets.spacingWidget(0, 16),
                Expanded(
                    child: datePickerSelectionButtonWidget(
                        AppStrings.afterOneWeek, cubit.isStartDateAfterOneWeekSelected(), () {
                  cubit.setSelectedDatePickerStartDate(DateTime.now().add(const Duration(days: 7)),
                      isSetFromButtons: true);
                })),
              ],
            ),
          ],
        );
      });
    }
    return BlocBuilder<AddEmployeeDetailsScreenCubit, AddEmployeeDetailsScreenState>(buildWhen: (previous, current) {
      if (current is AEDSDatePickerMonthChangeState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      return Column(
        children: [
          Row(
            children: [
              Expanded(
                  child: datePickerSelectionButtonWidget(AppStrings.noDate, cubit.isNoDateEndDateSelected(), () {
                cubit.setSelectedDatePickerEndDate(null, isSetFromButtons: true);
              })),
              AppWidgets.spacingWidget(0, 16),
              Expanded(
                  child: datePickerSelectionButtonWidget(AppStrings.today, cubit.isEndDateTodaySelected(), () {
                cubit.setSelectedDatePickerEndDate(DateTime.now(), isSetFromButtons: true);
              })),
            ],
          ),
        ],
      );
    });
  }

  Widget datePickerSelectionButtonWidget(String text, bool isSelected, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        padding: AppWidgets.edgeInsetsSymmetric(vertical: 8),
        decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryBgColor : AppColors.buttonBgColor,
            borderRadius: BorderRadius.circular(4)),
        duration: const Duration(milliseconds: 200),
        child: isSelected
            ? AppWidgets.textWidget(text,
                textAlign: TextAlign.center,
                textStyle:
                    AppTextStyles.appTextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.white))
            : AppWidgets.textWidget(text,
                textAlign: TextAlign.center,
                textStyle: AppTextStyles.appTextStyle(
                    fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.primaryBgColor)),
      ),
    );
  }

  Widget currentMonthAndYearWidget(BuildContext context) {
    var cubit = BlocProvider.of<AddEmployeeDetailsScreenCubit>(context);

    return BlocBuilder<AddEmployeeDetailsScreenCubit, AddEmployeeDetailsScreenState>(buildWhen: (previous, current) {
      if (current is AEDSDatePickerMonthChangeState) {
        return true;
      }
      return false;
    }, builder: (context, state) {
      return Container(
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
                onTap: () {
                  cubit.backwardDateTimeMonth();
                },
                child: AppWidgets.icon(Icons.arrow_left_sharp, color: AppColors.hintTextColor, size: 40)),
            AppWidgets.spacingWidget(0, 8),
            AppWidgets.textWidget(cubit.getDatePickerViewDate(),
                textStyle: AppTextStyles.appTextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
            AppWidgets.spacingWidget(0, 8),
            GestureDetector(
                onTap: () {
                  cubit.forwardDateTimeMonth();
                },
                child: AppWidgets.icon(Icons.arrow_right_sharp, color: AppColors.hintTextColor, size: 40)),
          ],
        ),
      );
    });
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
          showBottomModelOptions(context);
        },
        readOnly: true,
        suffixIcon: AppWidgets.icon(Icons.arrow_drop_down, color: AppColors.primaryBgColor));
  }

  void showBottomModelOptions(BuildContext context) {
    var cubit = BlocProvider.of<AddEmployeeDetailsScreenCubit>(context);

    showModalBottomSheet(
        context: context,
        backgroundColor: AppColors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topLeft: Radius.circular(16), topRight: Radius.circular(16))),
        builder: (ctx) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: RoleEnums.values.asMap().entries.map((value) {
              return GestureDetector(
                onTap: () {
                  cubit.setSelectedRole(context, value.value);
                },
                child: Container(
                    padding: AppWidgets.edgeInsetsSymmetric(vertical: 16),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: value.key >= RoleEnums.values.length - 1
                                ? BorderSide.none
                                : const BorderSide(color: AppColors.borderColor))),
                    width: MediaQuery.of(context).size.width,
                    child: AppWidgets.textWidget(value.value.toStringValue(), textAlign: TextAlign.center)),
              );
            }).toList(),
          );
        });
  }

  Widget divider() {
    return const Divider(color: AppColors.borderColor, height: 1);
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
