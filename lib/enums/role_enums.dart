import 'package:realtime_innovations_coding/utils/app_strings.dart';

enum RoleEnums {
  productDesigner,
  flutterDeveloper,
  qaTester,
  productOwner;
}

extension RoleEnumsExtension on RoleEnums {
  String toStringValue() {
    switch (this) {
      case RoleEnums.flutterDeveloper:
        return AppStrings.flutterDeveloper;

      case RoleEnums.productDesigner:
        return AppStrings.productDesigner;
      case RoleEnums.productOwner:
        return AppStrings.productOwner;
      case RoleEnums.qaTester:
        return AppStrings.qaTester;
    }
  }
}

extension RoleEnumsExtensionOnString on String {
  RoleEnums toRoleEnumsValue() {
    switch (this) {
      case AppStrings.flutterDeveloper:
        return RoleEnums.flutterDeveloper;
      case AppStrings.productDesigner:
        return RoleEnums.productDesigner;
      case AppStrings.productOwner:
        return RoleEnums.productOwner;
      case AppStrings.qaTester:
        return RoleEnums.qaTester;
      default:
        return RoleEnums.flutterDeveloper;
    }
  }
}
