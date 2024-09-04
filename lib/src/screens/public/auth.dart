import 'package:flutter/material.dart';

class AuthScreen extends StatefulWidget {
  final Function(int) onChangedStep;
  const AuthScreen({
    super.key,
    required this.onChangedStep,
  });

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
                    text: 'connexion'.toUpperCase(),
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
                            value!.isEmpty ? 'Adresse mail incorrect' : null,
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
                      const Text('Entrez votre mot de passe'),
                      TextFormField(
                        obscureText: _isSecret,
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
                  onPressed: () => widget.onChangedStep(3),
                  child: const Text('Continuer'),
                ),
                GestureDetector(
                  onTap: () => widget.onChangedStep(1),
                  child: Text(
                    "S'inscrire",
                    style: TextStyle(
                      color: Colors.blue[900],
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
