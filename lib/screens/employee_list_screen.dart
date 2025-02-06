import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_coding/bloc/employee/employee_list_screen_cubit.dart';
import 'package:realtime_innovations_coding/bloc/employee/employee_list_screen_state.dart';
import 'package:realtime_innovations_coding/utils/app_images_path.dart';
import 'package:realtime_innovations_coding/utils/app_strings.dart';
import 'package:realtime_innovations_coding/widgets/app_widgets.dart';
import 'package:realtime_innovations_coding/widgets/material/common_scaffold.dart';

class EmployeeListScreen extends StatelessWidget {
  const EmployeeListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmployeeListScreenCubit(),
      child: CommonScaffoldScreen(
        isBackButtonEnabled: false,
        appBarTitle: AppStrings.employeeList,
        body: const ELMainBody(),
        onFloatingActionButtonTap: () {
          //
        },
      ),
    );
  }
}

class ELMainBody extends StatelessWidget {
  const ELMainBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<EmployeeListScreenCubit>(context);

    return BlocBuilder<EmployeeListScreenCubit, EmployeeListScreenState>(builder: (context, state) {
      if (cubit.getEmployees.isEmpty) {
        return const ELNoEmpRecordsWidget();
      }

      return Column(
        children: [],
      );
    });
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
