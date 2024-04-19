import 'package:flutter/material.dart';

class BMICalculator extends StatefulWidget {
  @override
  _BMICalculatorState createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  int feet = 5; // Initial height in feet
  int inches = 6; // Initial height in inches
  String weight = '70'; // Initial weight in kilograms
  int age = 25; // Initial age

  double bmi = 0;

  void calculateBMI() {
    setState(() {
      double totalInches = feet.toDouble() * 12 + inches;
      double heightInMeters = totalInches * 0.0254; // Convert inches to meters
      double weightInKg = double.tryParse(weight) ?? 0;
      if (weightInKg != 0) {
        bmi = weightInKg / (heightInMeters * heightInMeters);
      } else {
        bmi = 0;
      }
    });
  }

  String getBMIStatus(double bmi) {
    if (bmi < 18.5) {
      return 'Underweight';
    } else if (bmi < 24.9) {
      return 'Normal weight';
    } else if (bmi < 29.9) {
      return 'Overweight';
    } else {
      return 'Obesity';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'BMI Calculator',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Height ',
                textAlign: TextAlign.start,

                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Feet
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Feet',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<int>(
                          value: feet,
                          onChanged: (value) {
                            setState(() {
                              feet = value ?? 0;
                              bmi = 0; // Reset BMI
                            });
                          },
                          items: List.generate(
                            9,
                                (index) => DropdownMenuItem<int>(
                              value: index + 1,
                              child: Text((index + 1).toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Inches
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Inches',
                          style: TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 8),
                        DropdownButton<int>(
                          value: inches,
                          onChanged: (value) {
                            setState(() {
                              inches = value ?? 0;
                              bmi = 0; // Reset BMI
                            });
                          },
                          items: List.generate(
                            12,
                                (index) => DropdownMenuItem<int>(
                              value: index,
                              child: Text(index.toString()),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                'Weight (KG)',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: weight,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    weight = value;
                    bmi = 0; // Reset BMI
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter weight in kg',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Age',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              TextFormField(
                initialValue: age.toString(),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    age = int.tryParse(value) ?? 0;
                  });
                },
                decoration: const InputDecoration(
                  hintText: 'Enter your age',
                  border: OutlineInputBorder(),
                  contentPadding: EdgeInsets.symmetric(horizontal: 16),
                ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: calculateBMI,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Calculate BMI',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              bmi != 0
                  ? Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Your BMI: ${bmi.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Status: ${getBMIStatus(bmi)}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}