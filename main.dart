import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.teal, width: 2.0),
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ),
      home: CalculatorPage(),
    );
  }
}

class CalculatorPage extends StatefulWidget {
  @override
  _CalculatorPageState createState() => _CalculatorPageState();
}

class _CalculatorPageState extends State<CalculatorPage> {
  String _selectedCalculator = 'BMI';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Multi Calculator App')),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                _buildCalculatorButton('BMI'),
                _buildCalculatorButton('Tip'),
                _buildCalculatorButton('Age'),
                _buildCalculatorButton('Currency'),
                _buildCalculatorButton('ToDo'),
                _buildCalculatorButton('Quadratic'),
                _buildCalculatorButton('Temp'),
                _buildCalculatorButton('Speed'),
                _buildCalculatorButton('Discount'),
                _buildCalculatorButton('Fuel'),
              ],
            ),
          ),
          Expanded(
            child: AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: _getCalculatorWidget(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCalculatorButton(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () => setState(() => _selectedCalculator = title),
        child: Text(title + ' Calculator'),
      ),
    );
  }

  Widget _getCalculatorWidget() {
    switch (_selectedCalculator) {
      case 'BMI':
        return BMICalculator();
      case 'Tip':
        return TipCalculator();
      case 'Age':
        return AgeCalculator();
      case 'Currency':
        return CurrencyConverter();
      case 'ToDo':
        return ToDoList();
      case 'Quadratic':
        return QuadraticSolver();
      case 'Temp':
        return TemperatureConverter();
      case 'Speed':
        return SpeedCalculator();
      case 'Discount':
        return DiscountCalculator();
      case 'Fuel':
        return FuelEfficiencyCalculator();
      default:
        return Center(child: Text('Select a calculator'));
    }
  }
}

// --- All Calculator Widgets --- //

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  double _bmi = 0;

  void _calculateBMI() {
    final weight = double.tryParse(_weightController.text) ?? 0;
    final height = double.tryParse(_heightController.text) ?? 0;
    setState(() => _bmi = weight > 0 && height > 0 ? weight / (height * height) : 0);
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalculatorBody(
      children: [
        _buildTextField(_weightController, 'Weight (kg)'),
        _buildTextField(_heightController, 'Height (m)'),
        _buildButton('Calculate BMI', _calculateBMI),
        _buildResult('BMI: ${_bmi.toStringAsFixed(2)}'),
      ],
    );
  }
}

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  final TextEditingController _billController = TextEditingController();
  double _tipPercentage = 15, _total = 0;

  void _calculateTip() {
    final bill = double.tryParse(_billController.text) ?? 0;
    setState(() => _total = bill + (bill * _tipPercentage / 100));
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalculatorBody(
      children: [
        _buildTextField(_billController, 'Bill Amount'),
        Slider(
          value: _tipPercentage,
          min: 0,
          max: 100,
          label: _tipPercentage.toStringAsFixed(0),
          onChanged: (value) => setState(() => _tipPercentage = value),
        ),
        _buildButton('Calculate Tip', _calculateTip),
        _buildResult('Total: ${_total.toStringAsFixed(2)}'),
      ],
    );
  }
}

class AgeCalculator extends StatefulWidget {
  @override
  _AgeCalculatorState createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  final TextEditingController _dobController = TextEditingController();
  String _age = '';

  void _calculateAge() {
    final dob = DateTime.tryParse(_dobController.text);
    if (dob != null) {
      final now = DateTime.now();
      final years = now.year - dob.year;
      final months = now.month - dob.month;
      final days = now.day - dob.day;
      setState(() => _age = '$years years, $months months, $days days');
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalculatorBody(
      children: [
        _buildTextField(_dobController, 'Date of Birth (yyyy-mm-dd)'),
        _buildButton('Calculate Age', _calculateAge),
        _buildResult('Age: $_age'),
      ],
    );
  }
}

class CurrencyConverter extends StatefulWidget {
  @override
  _CurrencyConverterState createState() => _CurrencyConverterState();
}

class _CurrencyConverterState extends State<CurrencyConverter> {
  final TextEditingController _amountController = TextEditingController();
  double _convertedAmount = 0;
  final double _rate = 0.85;

  void _convertCurrency() {
    final amount = double.tryParse(_amountController.text) ?? 0;
    setState(() => _convertedAmount = amount * _rate);
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalculatorBody(
      children: [
        _buildTextField(_amountController, 'Amount (USD)'),
        _buildButton('Convert to EUR', _convertCurrency),
        _buildResult('Converted Amount: ${_convertedAmount.toStringAsFixed(2)} EUR'),
      ],
    );
  }
}

class ToDoList extends StatefulWidget {
  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  final List<String> _tasks = [];
  final TextEditingController _taskController = TextEditingController();

  void _addTask() {
    setState(() {
      _tasks.add(_taskController.text);
      _taskController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalculatorBody(
      children: [
        _buildTextField(_taskController, 'New Task'),
        _buildButton('Add Task', _addTask),
        Expanded(
          child: ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index) => ListTile(title: Text(_tasks[index])),
          ),
        ),
      ],
    );
  }
}

class QuadraticSolver extends StatefulWidget {
  @override
  _QuadraticSolverState createState() => _QuadraticSolverState();
}

class _QuadraticSolverState extends State<QuadraticSolver> {
  final TextEditingController _aController = TextEditingController();
  final TextEditingController _bController = TextEditingController();
  final TextEditingController _cController = TextEditingController();
  String _solution = '';

  void _solveQuadratic() {
    final a = double.tryParse(_aController.text) ?? 0;
    final b = double.tryParse(_bController.text) ?? 0;
    final c = double.tryParse(_cController.text) ?? 0;
    if (a != 0) {
      final discriminant = b * b - 4 * a * c;
      if (discriminant > 0) {
        final root1 = (-b + sqrt(discriminant)) / (2 * a);
        final root2 = (-b - sqrt(discriminant)) / (2 * a);
        setState(() => _solution = 'Roots: $root1, $root2');
      } else if (discriminant == 0) {
        final root = -b / (2 * a);
        setState(() => _solution = 'Root: $root');
      } else {
        setState(() => _solution = 'No Real Solutions');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalculatorBody(
      children: [
        _buildTextField(_aController, 'a'),
        _buildTextField(_bController, 'b'),
        _buildTextField(_cController, 'c'),
        _buildButton('Solve', _solveQuadratic),
        _buildResult('Solution: $_solution'),
      ],
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  final TextEditingController _tempController = TextEditingController();
  double _convertedTemp = 0;

  void _convertTemp() {
    final tempC = double.tryParse(_tempController.text) ?? 0;
    setState(() => _convertedTemp = (tempC * 9 / 5) + 32);
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalculatorBody(
      children: [
        _buildTextField(_tempController, 'Temperature (Celsius)'),
        _buildButton('Convert to Fahrenheit', _convertTemp),
        _buildResult('Fahrenheit: ${_convertedTemp.toStringAsFixed(2)}'),
      ],
    );
  }
}

class SpeedCalculator extends StatefulWidget {
  @override
  _SpeedCalculatorState createState() => _SpeedCalculatorState();
}

class _SpeedCalculatorState extends State<SpeedCalculator> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  double _speed = 0;

  void _calculateSpeed() {
    final distance = double.tryParse(_distanceController.text) ?? 0;
    final time = double.tryParse(_timeController.text) ?? 0;
    setState(() => _speed = time > 0 ? distance / time : 0);
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalculatorBody(
      children: [
        _buildTextField(_distanceController, 'Distance (km)'),
        _buildTextField(_timeController, 'Time (hours)'),
        _buildButton('Calculate Speed', _calculateSpeed),
        _buildResult('Speed: ${_speed.toStringAsFixed(2)} km/h'),
      ],
    );
  }
}

class DiscountCalculator extends StatefulWidget {
  @override
  _DiscountCalculatorState createState() => _DiscountCalculatorState();
}

class _DiscountCalculatorState extends State<DiscountCalculator> {
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _discountController = TextEditingController();
  double _discountedPrice = 0;

  void _calculateDiscount() {
    final price = double.tryParse(_priceController.text) ?? 0;
    final discount = double.tryParse(_discountController.text) ?? 0;
    setState(() => _discountedPrice = price - (price * discount / 100));
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalculatorBody(
      children: [
        _buildTextField(_priceController, 'Price'),
        _buildTextField(_discountController, 'Discount (%)'),
        _buildButton('Calculate Discount', _calculateDiscount),
        _buildResult('Discounted Price: ${_discountedPrice.toStringAsFixed(2)}'),
      ],
    );
  }
}

class FuelEfficiencyCalculator extends StatefulWidget {
  @override
  _FuelEfficiencyCalculatorState createState() => _FuelEfficiencyCalculatorState();
}

class _FuelEfficiencyCalculatorState extends State<FuelEfficiencyCalculator> {
  final TextEditingController _distanceController = TextEditingController();
  final TextEditingController _fuelController = TextEditingController();
  double _efficiency = 0;

  void _calculateEfficiency() {
    final distance = double.tryParse(_distanceController.text) ?? 0;
    final fuel = double.tryParse(_fuelController.text) ?? 0;
    setState(() => _efficiency = fuel > 0 ? distance / fuel : 0);
  }

  @override
  Widget build(BuildContext context) {
    return _buildCalculatorBody(
      children: [
        _buildTextField(_distanceController, 'Distance (km)'),
        _buildTextField(_fuelController, 'Fuel Consumed (liters)'),
        _buildButton('Calculate Efficiency', _calculateEfficiency),
        _buildResult('Efficiency: ${_efficiency.toStringAsFixed(2)} km/l'),
      ],
    );
  }
}

// --- Helper Widgets for Reusability --- //

Widget _buildCalculatorBody({required List<Widget> children}) {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(children: children),
  );
}

Widget _buildTextField(TextEditingController controller, String label) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: TextField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: TextInputType.number,
    ),
  );
}

Widget _buildButton(String text, VoidCallback onPressed) {
  return ElevatedButton(onPressed: onPressed, child: Text(text));
}

Widget _buildResult(String result) {
  return Padding(
    padding: const EdgeInsets.only(top: 16.0),
    child: Text(result, style: TextStyle(fontSize: 24, color: Colors.teal)),
  );
}
