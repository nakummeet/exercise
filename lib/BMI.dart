import 'package:flutter/material.dart';

class Bmi extends StatefulWidget {
  const Bmi({super.key});

  @override
  State<Bmi> createState() => _BmiState();
}

class _BmiState extends State<Bmi> {
  double _height = 172;
  double _weight = 60;
  int _age = 25;
  String _gender = 'Male';
  double _bmi = 0;
  String _bmiResult = "";

  void _calculateBMI() {
  double height = _height / 100; // Convert cm to meters
  setState(() {
  _bmi = _weight / (height * height);
  if (_bmi < 18.5) {
  _bmiResult = "Underweight";
  } else if (_bmi >= 18.5 && _bmi < 24.9) {
  _bmiResult = "Normal weight";
  } else if (_bmi >= 25 && _bmi < 29.9) {
  _bmiResult = "Overweight";
  } else {
  _bmiResult = "Obesity";
  }
  });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Calculator'),
        backgroundColor: Color(0xffb50B498),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
        Image.asset(
        'assets/image/back3.jpg',
        fit: BoxFit.cover,
      ),
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GenderButton(
                      label: 'Male',
                      isSelected: _gender == 'Male',
                      onTap: () {
                        setState(() {
                          _gender = 'Male';
                        });
                      },
                    ),
                    GenderButton(
                      label: 'Female',
                      isSelected: _gender == 'Female',
                      onTap: () {
                        setState(() {
                          _gender = 'Female';
                        });
                      },
                    ),
          
                  ],
                ),
                SizedBox(height: 30),
                Text(
                  'Height (in cm)',
                  style: TextStyle(fontSize: 18, color: Color(0xffbF1F8E8) ),
                  textAlign: TextAlign.center,
                ),
                Slider(
                  value: _height,
                  min: 100,
                  max: 220,
                  divisions: 120,
                  label: _height.round().toString(),
                  activeColor: Color(0xffb468585),
                  inactiveColor: Color(0XFFBE7F0DC),
                  onChanged: (double value) {
                    setState(() {
                      _height = value;
                    });
                  },
                ),
                Text(
                  _height.round().toString(),
                  style: TextStyle(fontSize: 24,color: Color(0xffbF1F8E8) ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Weight (in kg)',
                  style: TextStyle(fontSize: 18,color: Color(0xffbF1F8E8) ),
                  textAlign: TextAlign.center,
                ),
                Slider(
                  value: _weight,
                  min: 30,
                  max: 150,
                  divisions: 120,
                  label: _weight.round().toString(),
                  activeColor: Color(0xffb468585),
                  inactiveColor: Color(0XFFBE7F0DC),
                  onChanged: (double value) {
                    setState(() {
                      _weight = value;
                    });
                  },
                ),
                Text(
                  _weight.round().toString(),
                  style: TextStyle(fontSize: 24,color: Color(0xffbF1F8E8) ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                Text(
                  'Age',
                  style: TextStyle(fontSize: 18,color: Color(0xffbF1F8E8) ),
                  textAlign: TextAlign.center,
                ),
                Slider(
                  value: _age.toDouble(),
                  min: 10,
                  max: 100,
                  divisions: 90,
                  label: _age.toString(),
                  activeColor: Color(0xffb468585),
                  inactiveColor: Color(0XFFBE7F0DC),
                  onChanged: (double value) {
                    setState(() {
                      _age = value.round();
                    });
                  },
                ),
                Text(
                  _age.toString(),
                  style: TextStyle(fontSize: 24,color: Color(0xffbF1F8E8) ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _calculateBMI,
                  child: Text('Calculate BMI'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Color(0xffbF1F8E8),
                    backgroundColor: Colors.teal, // Text color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30), // Rounded corners
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20), // Padding
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  _bmi == 0 ? "" : "BMI: ${_bmi.toStringAsFixed(2)}",
                  style: TextStyle(fontSize: 24, color: Color(0xffbF1F8E8)),
                  textAlign: TextAlign.center,
                ),
                Text(
                  _bmiResult,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,
                      color: Color(0xffbF1F8E8)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
  ]
      ),
    );
  }
}

class GenderButton extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function onTap;

  GenderButton({required this.label, required this.isSelected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        decoration: BoxDecoration(
          color: isSelected ? Colors.teal : Color(0xffDEF9C4),
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.all(8),
        child: Column(
          children: <Widget>[
            Icon(
              label == 'Male'
                  ? Icons.male
                  : label == 'Female'
                  ? Icons.female
                  : Icons.transgender,
              size: 80,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
            SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


