import 'package:capygotchi/core/domain/entities/capybara.dart';
import 'package:capygotchi/core/domain/entities/user.dart';
import 'package:capygotchi/core/infrastructure/auth_api.dart';
import 'package:capygotchi/features/account/widgets/account_text_field.dart';
import 'package:capygotchi/shared/utils.dart';
import 'package:capygotchi/shared/widgets/capy_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/infrastructure/database_api.dart';


class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late String accountName;
  late String capybaraName;
  late Capybara capybara;
  TextEditingController accountNameController = TextEditingController();
  TextEditingController capybaraNameController = TextEditingController();

  @override
  void initState() {
    accountNameController.text = context.read<User?>()?.userName ?? 'null';
    capybaraNameController.text = context.read<Capybara?>()?.name ?? 'null';
    super.initState();
  }

  checkPremiumStatus() {
    context.read<User?>()?.checkPremium();
  }

  logoutButton(){
    context.read<AuthAPI>().signOut();
  }

  reskinButton(){
    Utils.logDebug(message: context.read<User>().isPremium.toString());
    var capyColor = context.read<Capybara?>()?.color;
    switch(capyColor){
      case CapyColor.brown:
        capyColor = CapyColor.brownWithHat;
        break;
      case CapyColor.brownWithHat:
        capyColor = CapyColor.rainbow;
        break;
      case CapyColor.rainbow:
        capyColor = CapyColor.blue;
        break;
      case CapyColor.blue:
        capyColor = CapyColor.black;
        break;
      case CapyColor.black:
        capyColor = CapyColor.white;
        break;
      case CapyColor.white:
        capyColor = CapyColor.vomi;
        break;
      case CapyColor.vomi:
        capyColor = CapyColor.outline;
        break;
      case CapyColor.outline:
        capyColor = CapyColor.brown;
        break;

      case null:
        capyColor = CapyColor.brown;
    }
    context.read<Capybara>().changeColor(capyColor);
  }

  wantPremiumButton() async {
    final isPremium = context.read<User?>()?.isPremium;
    if(isPremium == null) return;
    if(isPremium){
      Utils.showAlertOK(context: context, title: "You are premium already!", text: "🎉 You have already subscribed! Thanks for your support", okBtnText: "Awesome!");
    }else{
      if(!context.mounted) return;
      await context.read<User?>()?.addPremium().then((addedPremium) => displayPopup(addedPremium));
    }
  }

  displayPopup(bool addedPremium){
    if(addedPremium){
      Utils.showAlertPremium(context: context, onPressed: () {
        context.read<User?>()?.checkPremium();
        Navigator.pop(context);
      }, title: "Thank you for your purchase!", text: "🎉 You have successfully bought premium for 30 days!", okBtnText: "Yeah!");
    }
    else{
      Utils.showAlertOK(context: context, title: "An error has occured!", text: "We couldn't process your purchase. Sorry about that!", okBtnText: "OK");

    }
  }

  validateChangeButton(){
    accountName = accountNameController.text;
    capybaraName = capybaraNameController.text;
    capybara = context.read<Capybara>();
    if(accountName.isNotEmpty && capybaraName.isNotEmpty) {
      Utils.showAlertPremium(context: context, onPressed: () async {
        context.read<User?>()?.updateUserName(name: accountName);
        context.read<Capybara?>()?.updateName(name: capybaraName);
        await context.read<DatabaseAPI?>()?.updateMonster(
            capybara: capybara,
            userId: context.read<User>().userId
        );
        if(!mounted) return;
        Navigator.pop(context);
      }, title: "Updated !", text: "🎉 You have successfully updated your account!", okBtnText: "Ok");
    } else {
      Utils.showAlertOK(context: context, title: "Error", text: "Please give a name to your account or capybara", okBtnText: "ok");
    }
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
                const SizedBox(height: 50),

                const Text("Change capybara's name:",
                    style:
                    TextStyle(color: Colors.black)),
                const SizedBox(height: 10),
                Container(
                  decoration: const BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(40)),
                      color: Color(0xff8a6552)),
                  child:
                  AccountTextField(controller: capybaraNameController),
                ),
                const SizedBox(height: 100),

                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      child: CapyButton(
                        disabled: context.watch<User?>()?.isPremium!=true,
                        onPressed: () => reskinButton(),
                        label: "*Premium* Change skin : ${(context.watch<Capybara?>()?.color.name ?? CapyColor.brown.name)}",
                        backgroundColor: const Color(0xff8a6552),
                      )
                    ),
                    const SizedBox(height: 50),

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
                            backgroundColor: const Color(0xffca2e55),
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