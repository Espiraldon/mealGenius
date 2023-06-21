import 'package:flutter/material.dart';

class Registration extends StatefulWidget {
  const Registration({super.key});

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
        appBar: AppBar(
          titleSpacing: 125,
          title: const Text('FriendMatch'),
          backgroundColor: Colors.cyan,
          elevation: 0,
        ),
        body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsetsDirectional.symmetric(horizontal: 30),
            child: Column(
              children: [
                RichText(
                  text: TextSpan(
                    text: 'inscription'.toUpperCase(),
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
                      const Text('Entrez votre adresse email'),
                      TextFormField(
                        onChanged: (value) => setState(() {
                          _email = value;
                        }),
                        validator: (value) =>
                            value!.isEmpty || !emailRegex.hasMatch(value)
                                ? 'Adresse mail incorrect'
                                : null,
                        decoration: InputDecoration(
                          hintText: 'Ex : exemple@mail.com',
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
                      const Text('choisissez votre mot de passe'),
                      TextFormField(
                        obscureText: _isSecret,
                        onChanged: (value) => setState(() {
                          _password = value;
                        }),
                        validator: (value) => value!.length < 6
                            ? "Entrer un mots de passe d'au moins 6 charactère"
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
                  child: const Text('Continuer'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
