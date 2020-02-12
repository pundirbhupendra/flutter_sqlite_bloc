import 'package:equatable/equatable.dart';

import 'package:flutter_sqlite_bloc/employee/models/employee.dart';

abstract class EmployeeEvent extends Equatable {
  const EmployeeEvent();
}

class LoadEmployee extends EmployeeEvent {
  @override
  List<Object> get props => [];
}

class Delete extends EmployeeEvent {
  int id;
  Delete({this.id});
  @override
  List<Object> get props => [id];
}

class Add extends EmployeeEvent {
  Employee employee;
  Add({this.employee});
  @override
  List<Object> get props => [employee];
}
class Update extends EmployeeEvent {
  Employee updateEmployee;
  Update({this.updateEmployee});
  @override
  List<Object> get props => [updateEmployee];
}
