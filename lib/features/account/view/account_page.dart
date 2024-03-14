import 'package:capygotchi/core/domain/entities/user.dart';
import 'package:capygotchi/core/infrastructure/auth_api.dart';
import 'package:capygotchi/features/account/widgets/account_text_field.dart';
import 'package:capygotchi/shared/utils.dart';
import 'package:capygotchi/shared/widgets/capy_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late String accountName;
  late String capybaraType;
  TextEditingController accountNameController = TextEditingController();

  @override
  void initState() {
    accountNameController.text = context.read<User>().userName;
    super.initState();
  }

  checkPremiumStatus() {
    context.read<User>().checkPremium();
  }

  logoutButton(){
    context.read<AuthAPI>().signOut();
  }

  reskinButton(String pType){
    capybaraType = pType;
    print(capybaraType);
    //todo: implement reskin here
  }

  wantPremiumButton() async {
    final isPremium = context.read<User>().isPremium;
    print(isPremium);
    if(isPremium){
      Utils.showAlertOK(context: context, title: "You are premium already!", text: "🎉 You have already subscribed! Thanks for your support", okBtnText: "Awesome!");
    }else{
      await context.read<User>().addPremium().then((addedPremium) => displayPopup(addedPremium));
    }
  }

  displayPopup(bool addedPremium){
    if(addedPremium){
      Utils.showAlertPremium(context: context, title: "Thank you for your purchase!", text: "🎉 You have successfully bought premium for 30 days!", OKBtnText: "Yeah!");
    }
    else{
      Utils.showAlertOK(context: context, title: "An error has occured!", text: "We couldn't process your purchase. Sorry about that!", okBtnText: "OK");

    }
  }

  validateChangeButton(){
    accountName = accountNameController.text;
    print(accountName);
    //todo: implement database save.
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF4E6E4),
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(color: Colors.white),
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
                    TextStyle(color: Colors.black)),
                const SizedBox(height: 10),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color(0xff8a6552)),
                  child:
                  AccountTextField(controller: accountNameController),
                ),
                const SizedBox(height: 150),

                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CapyButton(
                        onPressed: () => reskinButton("mauve"),
                        label: "Reskin Capybara (premium only)",
                        backgroundColor: const Color(0xff8a6552),
                      )
                    ),
                    const SizedBox(height: 100),

                    SizedBox(
                      width: double.infinity,
                      child: CapyButton(
                        onPressed: () => wantPremiumButton(),
                        label: "Premium",
                        backgroundColor: const Color(0xff8a6552),
                      )
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CapyButton(
                            onPressed: () => logoutButton(),
                            label: 'Logout',
                            backgroundColor: const Color(0xffca2e55),
                        ),
                        CapyButton(
                            onPressed: () => validateChangeButton(),
                            label: 'Save my changes',
                            backgroundColor: const Color(0xffA8C69F),
                        ),
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