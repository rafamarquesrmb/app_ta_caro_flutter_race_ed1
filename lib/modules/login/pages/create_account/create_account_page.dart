import 'package:flutter/material.dart';
import 'package:meuapp/modules/login/pages/create_account/create_account_controller.dart';
import 'package:meuapp/modules/login/repositories/login_repository_impl.dart';
import 'package:meuapp/shared/services/app_database.dart';
import 'package:meuapp/shared/theme/app_theme.dart';
import 'package:meuapp/shared/widgets/button/button.dart';
import 'package:meuapp/shared/widgets/input_text/input_text.dart';
import 'package:validators/validators.dart';

class CreateAccountPage extends StatefulWidget {
  const CreateAccountPage({Key? key}) : super(key: key);

  @override
  State<CreateAccountPage> createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  void toLoginPage() {
    Navigator.pushNamed(context, "/login");
  }

  late final CreateAccountController controller;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    controller = CreateAccountController(
        repository: LoginRepositoryImpl(database: AppDatabase.instance));
    controller.addListener(() {
      controller.state.when(
        success: (value) =>
            Navigator.pushNamed(context, "/home", arguments: value),
        error: (message, _) =>
            scaffoldKey.currentState!.showBottomSheet((context) => BottomSheet(
                onClosing: () {},
                builder: (context) => Container(
                      child: Text(message),
                    ))),
        loading: () => print("Loading..."),
        empty: () => print("Empty"),
        orElse: () {},
      );
    });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.background,
      appBar: AppBar(
        leading: BackButton(
          color: AppTheme.colors.backButton,
        ),
        backgroundColor: AppTheme.colors.background,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Criando uma conta",
                  style: AppTheme.textStyles.title,
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Mantenha seus gastos em dia",
                  style: AppTheme.textStyles.subtitle,
                ),
                SizedBox(
                  height: 38,
                ),
                InputText(
                  label: "Nome",
                  hint: "Digite seu nome completo",
                  onChanged: (value) => controller.onChange(name: value),
                  validator: (value) => (value ?? "").length >= 3
                      ? null
                      : "Digite um nome válido",
                ),
                SizedBox(
                  height: 18,
                ),
                InputText(
                  label: "E-mail",
                  hint: "Digite seu e-mail",
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) => controller.onChange(email: value),
                  validator: (value) => isEmail(value ?? "")
                      ? null
                      : "Digite uma senha mais forte",
                ),
                SizedBox(
                  height: 18,
                ),
                InputText(
                  label: "Senha",
                  hint: "Digite sua senha",
                  obscure: true,
                  onChanged: (value) => controller.onChange(password: value),
                  validator: (value) => (value ?? "").length >= 6
                      ? null
                      : "Digite uma senha mais forte",
                ),
                SizedBox(
                  height: 14,
                ),
                AnimatedBuilder(
                  animation: controller,
                  builder: (_, __) => controller.state.when(
                    orElse: () => Button(
                      label: "Criar Conta",
                      type: ButtonType.fill,
                      onTap: () {
                        controller.create();
                      },
                    ),
                    loading: () => Center(child: CircularProgressIndicator()),
                    empty: () => Button(
                      label: "Criar Conta",
                      type: ButtonType.fill,
                      onTap: () {
                        controller.create();
                      },
                    ),
                    error: (_, __) => Container(),
                    success: (_) => Text('Conta criada'),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                TextButton(
                  onPressed: toLoginPage,
                  child: Text(
                    "Já tem uma Conta? Faça o login.",
                    style: AppTheme.textStyles.subtitle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
