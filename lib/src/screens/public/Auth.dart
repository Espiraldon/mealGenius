import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/data/data.dart';
import 'package:happly/src/screens/public/delayed_animated.dart';

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
    return Scaffold(
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
              DelayedAnimated(
                delay: 1500,
                child: SizedBox(
                  height: 200,
                  child: SizedBox(
                      height: 200,
                      child: Image.asset('lib/img/logoprincipaleblanc.png')),
                ),
              ),
              DelayedAnimated(
                delay: 1500,
                child: Text(
                  "Connexion with your email",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.lato(
                    color: primaryColor,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              DelayedAnimated(
                delay: 2500,
                child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Text(
                        "Your email",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          color: tipo,
                          fontSize: 16,
                        ),
                      ),
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
              ),
              const SizedBox(
                height: 20.0,
              ),
              DelayedAnimated(
                delay: 3500,
                child: Form(
                  child: Column(
                    children: [
                      Text(
                        "Password",
                        textAlign: TextAlign.center,
                        style: GoogleFonts.lato(
                          color: tipo,
                          fontSize: 16,
                        ),
                      ),
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
              ),
              const SizedBox(
                height: 20.0,
              ),
              DelayedAnimated(
                delay: 4500,
                child: Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => widget.onChangedStep(4),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.all(13),
                    ),
                    child: Text(
                      "Confirm",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.lato(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              DelayedAnimated(
                delay: 5500,
                child: GestureDetector(
                  onTap: () => widget.onChangedStep(2),
                  child: Text(
                    "Subscribe",
                    style: TextStyle(
                      color: neutral,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
