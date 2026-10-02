import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StudentForm(),
    ));

class StudentForm extends StatefulWidget {
  const StudentForm({super.key});

  @override
  State<StudentForm> createState() => _StudentFormState();
}

class _StudentFormState extends State<StudentForm> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _age = TextEditingController();
  final _address = TextEditingController();
  final _contact = TextEditingController();
  final _email = TextEditingController();
  String? _gender;
  Map<String, String>? _result;

  void _submit() {
    if (_formKey.currentState!.validate() && _gender != null) {
      setState(() {
        _result = {
          'Name': _name.text,
          'Age': _age.text,
          'Gender': _gender!,
          'Address': _address.text,
          'Contact': _contact.text,
          'Email': _email.text,
        };
      });
    }
  }

  void _clear() {
    _formKey.currentState!.reset();
    _name.clear();
    _age.clear();
    _address.clear();
    _contact.clear();
    _email.clear();
    setState(() {
      _gender = null;
      _result = null;
    });
  }

  Widget _field(TextEditingController c, String label, IconData icon,
      {TextInputType type = TextInputType.text}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: TextFormField(
        controller: c,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon),
          border: const OutlineInputBorder(),
        ),
        validator: (v) =>
            (v == null || v.trim().isEmpty) ? '$label is required' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile Form')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(_name, 'Full Name', Icons.person),
              _field(_age, 'Age', Icons.cake, type: TextInputType.number),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: DropdownButtonFormField<String>(
                  value: _gender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    prefixIcon: Icon(Icons.wc),
                    border: OutlineInputBorder(),
                  ),
                  items: ['Male', 'Female', 'Other']
                      .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                      .toList(),
                  onChanged: (v) => setState(() => _gender = v),
                  validator: (v) => v == null ? 'Gender is required' : null,
                ),
              ),
              _field(_address, 'Address', Icons.home),
              _field(_contact, 'Contact Number', Icons.phone,
                  type: TextInputType.phone),
              _field(_email, 'Email', Icons.email,
                  type: TextInputType.emailAddress),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submit,
                      child: const Text('Submit'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: _clear,
                      child: const Text('Clear'),
                    ),
                  ),
                ],
              ),
              if (_result != null) ...[
                const SizedBox(height: 20),
                const Divider(),
                const Text('Submitted Information',
                    style: TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                ..._result!.entries.map((e) => Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 100,
                            child: Text('${e.key}:',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold)),
                          ),
                          Expanded(child: Text(e.value)),
                        ],
                      ),
                    )),
              ],
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _name.dispose();
    _age.dispose();
    _address.dispose();
    _contact.dispose();
    _email.dispose();
    super.dispose();
  }
}