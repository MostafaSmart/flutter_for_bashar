import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/util/input_validator.dart';
import '../../shared/l10n/app_localizations.dart';
import '../../shared/l10n/app_localizations_setup.dart';
import '../../shared/theme/app_colors.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/login/login_cubit.dart';
import '../bloc/login/login_state.dart';
import '../widgets/app_logo_header.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/gradient_button.dart';
import '../widgets/login_card.dart';
import '../widgets/page_background.dart';
import 'home_page.dart';

/// صفحة تسجيل الدخول
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _deviceIMEIController = TextEditingController();
  final _deviceNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // قيم افتراضية للتجربة
    _deviceIMEIController.text = '123456789012345';
    _deviceNameController.text = 'Android Device';
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _deviceIMEIController.dispose();
    _deviceNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final localizations = AppLocalizationsSetup.setup(context, locale);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      body: BlocListener<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state is LoginSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(localizations.loginSuccess),
                backgroundColor: AppColors.successColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
            context.read<AuthBloc>().add(CheckAuthStatusEvent());
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          } else if (state is LoginErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorColor,
                behavior: SnackBarBehavior.floating,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            );
          }
        },
        child: PageBackground(
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Directionality(
                  textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppLogoHeader(
                        title: localizations.appName,
                        subtitle: localizations.login,
                        spacing: 16,
                      ),
                      const SizedBox(height: 40),
                      LoginCard(
                        child: Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              CustomTextField(
                                controller: _usernameController,
                                label: localizations.username,
                                hint: localizations.username,
                                prefixIcon: const Icon(Icons.person_outline),
                                validator: context.read<InputValidator>().validateUsername,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: _passwordController,
                                label: localizations.password,
                                hint: localizations.password,
                                obscureText: true,
                                prefixIcon: const Icon(Icons.lock_outline),
                                validator: context.read<InputValidator>().validatePassword,
                                textInputAction: TextInputAction.next,
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.visibility_off_outlined),
                                  onPressed: () {
                                    // يمكن إضافة وظيفة إظهار/إخفاء كلمة المرور هنا
                                  },
                                ),
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: _deviceIMEIController,
                                label: localizations.deviceIMEI,
                                hint: localizations.deviceIMEI,
                                prefixIcon: const Icon(Icons.phone_android_outlined),
                                validator: context.read<InputValidator>().validateDeviceIMEI,
                                textInputAction: TextInputAction.next,
                              ),
                              const SizedBox(height: 20),
                              CustomTextField(
                                controller: _deviceNameController,
                                label: localizations.deviceName,
                                hint: localizations.deviceName,
                                prefixIcon: const Icon(Icons.devices_outlined),
                                validator: context.read<InputValidator>().validateDeviceName,
                                textInputAction: TextInputAction.done,
                              ),
                              const SizedBox(height: 32),
                              BlocBuilder<LoginCubit, LoginState>(
                                builder: (context, state) {
                                  return GradientButton(
                                    text: localizations.loginButton,
                                    isLoading: state is LoginLoadingState,
                                    onPressed: state is LoginLoadingState
                                        ? null
                                        : () {
                                            if (_formKey.currentState!.validate()) {
                                              context.read<LoginCubit>().login(
                                                    username: _usernameController.text,
                                                    password: _passwordController.text,
                                                    deviceIMEI: _deviceIMEIController.text,
                                                    deviceName: _deviceNameController.text,
                                                  );
                                            }
                                          },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              final localeCubit = context.read<LocaleCubit>();
                              final currentLocale = Localizations.localeOf(context);
                              final newLocale = currentLocale.languageCode == 'ar'
                                  ? 'en'
                                  : 'ar';
                              localeCubit.changeLocale(newLocale);
                            },
                            icon: const Icon(Icons.language),
                            label: Text(localizations.changeLanguage),
                            style: TextButton.styleFrom(
                              foregroundColor: AppColors.primaryColor,
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
