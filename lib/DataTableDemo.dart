import 'package:flutter/material.dart';
import 'package:myfirstflutterapp/util/Repository.dart';

import 'Employee.dart';
import 'Services.dart';

// ignore: must_be_immutable
class DataTableDemo extends StatefulWidget {
  //
  int index = 0;

  DataTableDemo() : super();

  final String title = 'Flutter Data Table';

  @override
  DataTableDemoState createState() => DataTableDemoState();
}

class DataTableDemoState extends State<DataTableDemo> {
  Repository repo = Repository();
  List<Employee> _employees;
  GlobalKey<ScaffoldState> _scaffoldKey;
  List<String> _states = ["Choose a state"];
  String _selectedState = "Choose a state";

  // controller for the First Name TextField we are going to create.
  TextEditingController _firstNameController;

  // controller for the Last Name TextField we are going to create.
  TextEditingController _lastNameController;
  Employee _selectedEmployee;
  bool _isUpdating;
  String _titleProgress;

  @override
  void initState() {
    _states = List.from(_states)..addAll(repo.getStates());
    super.initState();
    _employees = [];
    _isUpdating = false;
    _titleProgress = widget.title;
    _scaffoldKey = GlobalKey(); // key to get the context to show a SnackBar
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _getEmployees1();
  }

  // Method to update title in the AppBar Title
  _showProgress(String message) {
    setState(() {
      _titleProgress = message;
    });
  }

  _showSnackBar(context, message) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _createTable() {
    _showProgress('Creating Table...');
    Services.createTable().then((result) {
      if ('success' == result) {
        // Table is created successfully.
        _showSnackBar(context, result);
        _showProgress(widget.title);
      }
    });
  }

  // Now lets add an Employee
  _addEmployee() {
    if (_firstNameController.text.isEmpty || _lastNameController.text.isEmpty) {
      _showSnackBar(context, "Empty field");
      return;
    }
    _showProgress('Adding Employee...');
    Services.addEmployee(_firstNameController.text, _lastNameController.text).then((result) {
      print(result);
      if ('success' == result) {
        _getEmployees1(); // Refresh the List after adding each employee...
        _clearValues();
      }
    });
  }

  _getEmployees1() {
    _showProgress('Loading Employees...');
    Services.getEmployees1().then((employees) {
      setState(() {
        _employees = employees;
      });
      _showProgress(widget.title); // Reset the title...
      print("Length ${employees.length}");
    });
  }

  _updateEmployee(Employee employee) {
    setState(() {
      _isUpdating = true;
    });
    _showProgress('Updating Employee...');
    Services.updateEmployee("employee.id", _firstNameController.text, _lastNameController.text).then((result) {
      if ('success' == result) {
        _getEmployees1(); // Refresh the list after update
        setState(() {
          _isUpdating = false;
        });
        _clearValues();
      }
    });
  }

  _deleteEmployee(Employee employee) {
    _showProgress('Deleting Employee...');
    Services.deleteEmployee("employee.id").then((result) {
      if ('success' == result) {
        _getEmployees1(); // Refresh after delete...
      }
    });
  }

  // Method to clear TextField values
  _clearValues() {
    _firstNameController.text = '';
    _lastNameController.text = '';
  }

  _showValues(Employee employee) {
    print("New String: ${employee.affiliate_name.substring(6)}");

    // from index 6 to the last index
    print("New String: ${employee.affiliate_name.substring(2, 6)}");
    _firstNameController.text = employee.affiliate_name;
    _lastNameController.text = employee.rank_name;
  }

  // Let's create a DataTable and show the employee list in it.
  SingleChildScrollView _dataBody() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    // var index = 0;
    print('inside databody');
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            DataColumn(
              label: Text('ID'),
            ),
            DataColumn(
              label: Text('FIRST NAME'),
            ),
            DataColumn(
              label: Text('LAST NAME'),
            ),
            // Lets add one more column to show a delete button
            DataColumn(
              label: Text('DELETE'),
            )
          ],
          rows: _employees
              .map(
                (employee) => DataRow(
              cells: [
                DataCell(
                  // Text('{$index+1}'),
                  Text(employee.id),
                  // Add tap in the row and populate the
                  // textfields with the corresponding values to update
                  onTap: () {
                    _showValues(employee);
                    // Set the Selected employee to Update
                    _selectedEmployee = employee;
                    setState(() {
                      _isUpdating = true;
                    });
                  },
                ),
                DataCell(
                  Text(
                    employee.affiliate_name.toUpperCase(),
                  ),
                  onTap: () {
                    _showValues(employee);
                    // Set the Selected employee to Update
                    _selectedEmployee = employee;
                    // Set flag updating to true to indicate in Update Mode
                    setState(() {
                      _isUpdating = true;
                    });
                  },
                ),
                DataCell(
                  Text(
                    employee.rank_name.toUpperCase(),
                  ),
                  onTap: () {
                    _showValues(employee);
                    // Set the Selected employee to Update
                    _selectedEmployee = employee;
                    setState(() {
                      _isUpdating = true;
                    });
                  },
                ),
                DataCell(IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteEmployee(employee);
                  },
                ))
              ],
              selected: false,
            ),
          )
              .toList(),
        ),
      ),
    );
  }

  // UI
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(_titleProgress), // we show the progress in the title...
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              _createTable();
            },
          ),
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              _getEmployees1();
            },
          )
        ],
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _firstNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'First Name',
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.all(20.0),
              child: TextField(
                controller: _lastNameController,
                decoration: InputDecoration.collapsed(
                  hintText: 'Last Name',
                ),
              ),
            ),
            DropdownButton<String>(
              isExpanded: true,
              items: _states.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              onChanged: (value) => _onSelectedState(value),
              value: _selectedState,
            ),
            // Add an update button and a Cancel Button
            // show these buttons only when updating an employee
            _isUpdating
                ? Row(
              children: <Widget>[
                OutlineButton(
                  child: Text('UPDATE'),
                  onPressed: () {
                    _updateEmployee(_selectedEmployee);
                  },
                ),
                OutlineButton(
                  child: Text('CANCEL'),
                  onPressed: () {
                    setState(() {
                      _isUpdating = false;
                    });
                    _clearValues();
                  },
                ),
              ],
            )
                : Container(),
            Expanded(
              child: _dataBody(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addEmployee();
        },
        child: Icon(Icons.add),
      ),
    );
  }

  void _onSelectedState(String value) {
    _firstNameController.text = value;
    _lastNameController.text = value;
    _addEmployee();
    setState(() {
      _selectedState = value;
    });
  }
}
