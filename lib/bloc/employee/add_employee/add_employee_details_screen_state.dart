import 'package:flutter/material.dart';

@immutable
abstract class AddEmployeeDetailsScreenState {
  const AddEmployeeDetailsScreenState();
}

class AEDSInitialState extends AddEmployeeDetailsScreenState {
  const AEDSInitialState();
}

class AEDSTempState extends AddEmployeeDetailsScreenState {
  const AEDSTempState();
}

class AEDSDatePickerMonthChangeState extends AddEmployeeDetailsScreenState {
  const AEDSDatePickerMonthChangeState();
}

class AEDSShowToastState extends AddEmployeeDetailsScreenState {
  final String message;
  const AEDSShowToastState(this.message);

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return false;

    return o is AEDSShowToastState && o.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}
