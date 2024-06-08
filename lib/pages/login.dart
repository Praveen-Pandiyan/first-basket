import 'package:first_basket/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _email = TextEditingController(text: 'client@vinnovatelabz.com'),
      _pass = TextEditingController(text: "123456");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () {},
                icon: const Icon(Icons.arrow_back_ios_new_rounded)),
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 12),
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                  color: Theme.of(context).dialogBackgroundColor,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        'asset/person.png',
                        color: Theme.of(context).scaffoldBackgroundColor,
                        colorBlendMode: BlendMode.multiply,
                        width: MediaQuery.sizeOf(context).width * 0.3,
                      )),
                  const SizedBox(height: 5),
                  Text(
                    "Log in",
                    style: Theme.of(context)
                        .textTheme
                        .headlineSmall!
                        .copyWith(fontWeight: FontWeight.w500),
                  ),
                  // form begin
                  Form(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Email",
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          controller: _email,
                          decoration: InputDecoration(
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              filled: true,
                              labelText: "Email"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text("Password",
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 5),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: TextFormField(
                          controller: _pass,
                          decoration: InputDecoration(
                              fillColor:
                                  Theme.of(context).scaffoldBackgroundColor,
                              prefixIcon: const Icon(
                                Icons.email_outlined,
                                color: Colors.grey,
                              ),
                              border: InputBorder.none,
                              filled: true,
                              labelText: "Password"),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700),
                        ),
                      ),
                      const SizedBox(height: 10),
                      if (context.watch<LoginRepo>().err != null) ...[
                        Container(
                          decoration: const BoxDecoration(color: Colors.red),
                          child: Text("${context.watch<LoginRepo>().err}", style: const  TextStyle(color: Colors.white),),
                        ),
                        const SizedBox(height: 10),
                      ],
                      InkWell(
                        onTap: (){
                          context.read<LoginRepo>().login(_email.text, _pass.text).then((e){
                            print(e);
                            if(e){
                              print("frfr");
                              Navigator.pushNamed(context, '/');
                            }
                          });
                        },
                        child: Container(
                            decoration: BoxDecoration(
                                color: Theme.of(context).primaryColor,
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            child: const Text(
                              "Log in",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white, fontSize: 18),
                            )),
                      )
                    ],
                  ))
                ],
              ),
            ),
            const SizedBox(height: 10),
            Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: "Do not have an account? ",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Colors.grey, fontWeight: FontWeight.w700),
                    children: [
                      TextSpan(
                          text: "Sign up",
                          style: Theme.of(context).textTheme.titleMedium)
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }
}
