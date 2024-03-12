import 'package:capygotchi/pages/home.dart';
import 'package:capygotchi/pages/login.dart';
import 'package:flutter/material.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late String accountName ;
  late String capybaraType;
  TextEditingController accountNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    //get account info here
    accountName = "accounted";
    capybaraType = "brun";

    accountNameController = TextEditingController(text: accountName);
  }

  logoutButton(){
    //todo: put logout here.

    Navigator.push(context, MaterialPageRoute(builder: (context)=> const LoginPage()));
  }

  reskinButton(String pType){
    capybaraType = pType;
    print(capybaraType);
    //todo: implement reskin here
  }

  wantPremiumButton(){
    //todo: implement premium here
  }

  validateChangeButton(){
    accountName = accountNameController.text;
    print(accountName);
    //todo: implement database save.

    Navigator.push(context, MaterialPageRoute(builder: (context)=> const HomePage()));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4E6E4),
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(fontFamily: 'Capriola', color: Colors.white),
        ),
        backgroundColor: const Color(0xff8a6552),
        leading: const BackButton(
          color: Colors.white,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Change account name:",
                    style:
                        TextStyle(fontFamily: 'Capriola', color: Colors.black)),
                const SizedBox(height: 10),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color(0xff8a6552)),
                  child:
                  TextFormField(
                    style: const TextStyle(
                        fontFamily: 'Capriola', color: Colors.white),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50.0),
                      ),
                    ),
                    controller: accountNameController,
                    //decoration: const InputDecoration(labelText: 'Email'),
                  ),
                ),
                const SizedBox(height: 150),

                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () { reskinButton("mauve");},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8a6552),
                          ),
                          child: const Text(
                            "Reskin Capybara (premium only)",
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Capriola'),
                          )),
                    ),
                    const SizedBox(height: 100),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () { wantPremiumButton();},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff8a6552),
                          ),
                          child: const Text(
                            "Do you want premium?",
                            style: TextStyle(
                                color: Colors.white, fontFamily: 'Capriola'),
                          )),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: () { logoutButton(); } ,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffca2e55),
                            ),
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                  color: Colors.white, fontFamily: 'Capriola'),
                            )),
                        ElevatedButton(
                            onPressed: () { validateChangeButton();},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xffabff9f),
                            ),
                            child: const Text(
                              "Valid Change",
                              style: TextStyle(
                                  color: Colors.black, fontFamily: 'Capriola'),
                            )),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
