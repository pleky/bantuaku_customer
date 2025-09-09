import 'package:flutter/material.dart';
import 'package:flutter_mvvm_riverpod/constants/languages.dart';
import 'package:flutter_mvvm_riverpod/features/authentication/model/signin_request.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validation/form_validation.dart';
import 'package:go_router/go_router.dart';
import '/constants/assets.dart';
import '/extensions/build_context_extension.dart';
import '/routing/routes.dart';
import '/theme/app_theme.dart';
import '/utils/global_loading.dart';
import '../../common/ui/widgets/common_text_form_field.dart';
import '../../common/ui/widgets/primary_button.dart';
import 'view_model/authentication_view_model.dart';
import 'widgets/horizontal_divider.dart';
import 'widgets/sign_in_agreement.dart';
import 'widgets/social_sign_in.dart';

class WelcomeScreen extends ConsumerStatefulWidget {
  const WelcomeScreen({super.key});

  @override
  ConsumerState<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends ConsumerState<WelcomeScreen> {
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      final payload = SigninRequest(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
          role: 'customer',
          fcmToken: 'your_fcm_token');
      ref.read(authenticationViewModelProvider.notifier).signIn(payload);
    }
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(authenticationViewModelProvider, (previous, next) {
      if (next.isLoading != previous?.isLoading) {
        if (next.isLoading) {
          Global.showLoading(context);
        } else {
          Global.hideLoading();
        }
      }

      if (next is AsyncError && next != previous) {
        context.showErrorSnackBar(next.error.toString());
      }

      if (next is AsyncData) {
        if (next.value?.isAuthenticated == true) {
          context.pushReplacement(Routes.main);
        }
      }
    });

    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Image(
                    image: AssetImage(Assets.appLogo),
                    width: MediaQuery.of(context).size.width * 0.5,
                    height: MediaQuery.of(context).size.width * 0.5,
                  ),
                ),
                Text(
                  Languages.signIn,
                  style: AppTheme.title32,
                ),
                const SizedBox(height: 24),
                CommonTextFormField(
                  label: Languages.email,
                  controller: _emailController,
                  validator: (value) {
                    final validator = Validator(
                      validators: [
                        RequiredValidator(),
                        EmailValidator(),
                      ],
                    );
                    return validator.validate(
                      label: Languages.email,
                      value: value,
                    );
                  },
                ),
                const SizedBox(height: 24),
                CommonTextFormField(
                  label: Languages.password,
                  controller: _passwordController,
                  isPassword: true,
                  validator: (values) {
                    final validator = Validator(validators: [RequiredValidator()]);
                    return validator.validate(
                      label: Languages.password,
                      value: values,
                    );
                  },
                ),
                const SizedBox(height: 32),
                PrimaryButton(
                  text: Languages.signIn,
                  onPressed: _validateForm,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      Languages.dontHaveAccount,
                      style: AppTheme.body14,
                    ),
                    const SizedBox(width: 4),
                    TextButton(
                      onPressed: () {
                        context.push(Routes.signup);
                      },
                      child: Text(
                        Languages.signUp,
                        style: AppTheme.title14,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                const HorizontalDivider(),
                const SizedBox(height: 16),
                const SocialSignIn(),
                const SizedBox(height: 16),
                const SignInAgreement(),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
