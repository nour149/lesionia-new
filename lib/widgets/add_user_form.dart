import 'package:flutter/material.dart';

class AddUserForm extends StatefulWidget {
  final void Function(Map<String, dynamic>) onSave;
  final VoidCallback onCancel;

  const AddUserForm({
    required this.onSave,
    required this.onCancel,
    super.key,
  });

  @override
  State<AddUserForm> createState() => _AddUserFormState();
}

class _AddUserFormState extends State<AddUserForm> {
  final _formKey = GlobalKey<FormState>();

  // ── text controllers ─────────────────────────────────────────────────────
  final _loginCtl   = TextEditingController();
  final _emailCtl   = TextEditingController();
  final _passwdCtl  = TextEditingController();

  String _levelSecure = 'admin';   // dropdown initial value

  String? _required(String? v) => (v == null || v.trim().isEmpty) ? 'Required' : null;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _loginCtl,
                decoration: const InputDecoration(labelText: 'Login User'),
                validator: _required,
              ),
              TextFormField(
                controller: _emailCtl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
                validator: _required,
              ),
              DropdownButtonFormField<String>(
                value: _levelSecure,
                decoration: const InputDecoration(labelText: 'Level Secure'),
                items: const [
                  DropdownMenuItem(value: 'admin',   child: Text('Admin')),
                  DropdownMenuItem(value: 'secure',  child: Text('Secure')),
                  DropdownMenuItem(value: 'normal',  child: Text('Normal')),
                ],
                onChanged: (v) => setState(() => _levelSecure = v ?? 'admin'),
              ),
              TextFormField(
                controller: _passwdCtl,
                decoration: const InputDecoration(labelText: 'Password'),
                obscureText: true,
                validator: _required,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(onPressed: widget.onCancel, child: const Text('Cancel')),
                  const SizedBox(width: 8),
                  ElevatedButton(onPressed: _submit, child: const Text('Save')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      widget.onSave({
        'loginuser'   : _loginCtl.text.trim(),
        'email'       : _emailCtl.text.trim(),
        'levelsecure' : _levelSecure,
        'motdpass'    : _passwdCtl.text.trim(),
      });
    }
  }

  @override
  void dispose() {
    _loginCtl.dispose();
    _emailCtl.dispose();
    _passwdCtl.dispose();
    super.dispose();
  }
}
