import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  final Function(int) onChangedStep;
  const Registration({required this.onChangedStep, super.key});

  @override
  State<Registration> createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  final RegExp emailRegex = RegExp(r'[a-z0-9\._-]+@[a-z0-9\.-]+\.[a-z]]+');
  bool _isSecret = true;
  String _email = '';
  String _password = '';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          leading: IconButton(
              icon: const Icon(
                Icons.close,
                color: Colors.black,
                size: 30,
              ),
              onPressed: () => widget.onChangedStep(1)),
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 30),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'subscription'.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      const Text('email'),
                      TextFormField(
                        onChanged: (value) => setState(() {
                          _email = value;
                        }),
                        validator: (value) =>
                            value!.isEmpty || !emailRegex.hasMatch(value)
                                ? 'wrong email'
                                : null,
                        decoration: InputDecoration(
                          hintText: 'Ex : example@mail.com',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Form(
                  child: Column(
                    children: [
                      const Text('Choose your password'),
                      TextFormField(
                        obscureText: _isSecret,
                        onChanged: (value) => setState(() {
                          _password = value;
                        }),
                        validator: (value) => value!.length < 6
                            ? "At least 6 char password"
                            : null,
                        decoration: InputDecoration(
                          suffixIcon: InkWell(
                              onTap: () => setState(() {
                                    _isSecret = !_isSecret;
                                  }),
                              child: Icon(!_isSecret
                                  ? Icons.visibility
                                  : Icons.visibility_off)),
                          hintText: '********',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(0.0),
                              borderSide: const BorderSide(color: Colors.grey)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                ElevatedButton(
                  onPressed:
                      !emailRegex.hasMatch(_email) && _password.length < 6
                          ? null
                          : () => {
                                if (_formkey.currentState!.validate())
                                  {print(_email), print(_password)}
                              },
                  child: const Text('Confirm'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
