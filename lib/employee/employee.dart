import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sqlite_bloc/employee/bloc/bloc.dart';
import 'package:flutter_sqlite_bloc/employee/bloc/employee_bloc.dart';
import 'package:flutter_sqlite_bloc/employee/bloc/employee_event.dart';
import 'package:flutter_sqlite_bloc/employee/models/employee.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  EmployeeBloc _employeeBloc;
  TextEditingController controller = TextEditingController();
  bool isUpdate;

  @override
  void initState() {
    super.initState();
    isUpdate = false;
    _employeeBloc = BlocProvider.of<EmployeeBloc>(context);
    _employeeBloc.add(LoadEmployee());
  }

  @override
  Widget build(BuildContext context) {
    Employee employee;
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter SQLite BLoc'),
        ),
        body: SingleChildScrollView(
            child: Column(children: <Widget>[
          SizedBox(
            height: 10.0,
          ),
          TextFormField(
            controller: controller,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                hintText: 'Enter Name',
                hintStyle: TextStyle(color: Colors.black26),
                border: const OutlineInputBorder(
                    borderSide:
                        BorderSide(width: 10.0, style: BorderStyle.none),
                    borderRadius:
                        BorderRadius.all(const Radius.circular(20.0))),
                focusedBorder: OutlineInputBorder(),
                labelText: 'Name'),
            validator: (val) => val.length == 0 ? 'Enter Name' : null,
            // onSaved: (val) => name = val,
          ),
          SizedBox(
            height: 10.0,
          ),
          BlocBuilder<EmployeeBloc, EmployeeState>(
              bloc: _employeeBloc,
              builder: (context, state) {
                if (state is EmployeeLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is EmployeeListLoaded) {
                  return Column(children: <Widget>[
                    FlatButton(
                        color: Theme.of(context).primaryColor,
                        child:
                            Text('Add', style: TextStyle(color: Colors.white)),
                        onPressed: () => _employeeBloc.add(
                            Add(employee: Employee(name: controller.text)))),
                    isUpdate == true
                        ? RaisedButton(
                            color: Theme.of(context).primaryColor,
                            child: Text(
                              'Update',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              _employeeBloc.add(Update(
                                  updateEmployee: Employee(
                                      id: employee.id, name: controller.text)));
                              isUpdate = false;
                            })
                        : Container(),
                    SizedBox(
                      height: 30.0,
                    ),
                    Container(
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            shrinkWrap: true,
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.employeeList == null
                                ? isUpdate = false
                                : state.employeeList.length,
                            itemBuilder: (context, index) {
                              employee = state.employeeList[index];

                              return Column(children: <Widget>[
                                Row(children: <Widget>[
                                  SizedBox(
                                    width: 10.0,
                                  ),
                                  SizedBox(
                                    width: 100.0,
                                    child: Text(
                                      employee.name,
                                      style: TextStyle(
                                          color: Theme.of(context)
                                              .textTheme
                                              .body2
                                              .color),
                                    ),
                                  ),
                                  Spacer(
                                    flex: 10,
                                  ),
                                  InkWell(
                                    onTap: () => _employeeBloc
                                        .add(Delete(id: employee.id)),
                                    child: Icon(
                                      Icons.delete_forever,
                                      color: Theme.of(context).primaryColor,
                                    ),
                                  ),
                                  Spacer(
                                    flex: 1,
                                  ),
                                  IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.purple,
                                      ),
                                      onPressed: () {
                                        controller.text = '';
                                        isUpdate = true;
                                        controller.text = employee.name;
                                        //TODO:we can used here action event update in future..
                                        setState(() {});
                                      }),
                                ])
                              ]);
                            }))
                  ]);
                } else if (state is EmployeeError) {
                  Text(state.message);
                }
                return Center(child: CircularProgressIndicator());
              }),
        ])));
  }
}

class LoadEmployeeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
