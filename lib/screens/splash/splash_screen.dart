import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realtime_innovations_coding/bloc/splash/splash_screen_cubit.dart';
import 'package:realtime_innovations_coding/utils/app_images_path.dart';
import 'package:realtime_innovations_coding/widgets/app_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtime_innovations_coding/widgets/material/common_scaffold.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashScreenCubit()..init(context),
      child: const CommonScaffoldScreen(body: SSMainBody()),
    );
  }
}

class SSMainBody extends StatelessWidget {
  const SSMainBody({super.key});

  @override
  Widget build(BuildContext context) {
    var cubit = BlocProvider.of<SplashScreenCubit>(context);
    return Center(
      child: SizedBox(
        height: 300.h,
        width: 300.w,
        child: AppWidgets.imageFromAssetWidget(AppImagesPath.splashImage),
      ),
    );
  }
}
