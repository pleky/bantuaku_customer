import 'package:flutter/material.dart';
import 'package:bantuaku_customer/constants/languages.dart';
import 'package:bantuaku_customer/extensions/build_context_extension.dart';
import 'package:bantuaku_customer/features/authentication/model/signup_request.dart';
import 'package:bantuaku_customer/features/authentication/ui/view_model/authentication_view_model.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/common_text_form_field.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/secondary_button.dart';
import 'package:bantuaku_customer/routing/routes.dart';
import 'package:bantuaku_customer/theme/app_theme.dart';
import 'package:bantuaku_customer/utils/global_loading.dart';
import 'package:bantuaku_customer/utils/location_helper.dart';
import 'package:bantuaku_customer/utils/validator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_validation/form_validation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  late final TextEditingController _fullNameController;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  late final TextEditingController _confirmPasswordController;
  late final TextEditingController _phoneNumberController;
  late final TextEditingController _referralNumberController;
  late final TextEditingController _addressController;
  late final LocationHelper _locationHelper;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Position? _currentPosition;
  bool isAgreeToTerms = false;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _confirmPasswordController = TextEditingController();
    _phoneNumberController = TextEditingController();
    _referralNumberController = TextEditingController();
    _addressController = TextEditingController();
    _locationHelper = LocationHelper();

    _getCurrentLocation();
  }

  void _initListeners() {
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
  }

  void _getCurrentLocation() async {
    try {
      _currentPosition = await _locationHelper.getCurrentLocation();
    } catch (e) {
      debugPrint('Error getting current location: $e');

      if (!mounted) return;

      context.showErrorSnackBar('Error getting current location: $e');
      _currentPosition = null;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneNumberController.dispose();
    _referralNumberController.dispose();
    _fullNameController.removeListener(() {});
    super.dispose();
  }

  void _validateForm() {
    if (_formKey.currentState?.validate() ?? false) {
      if (!isAgreeToTerms) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(Languages.agreeToTermsError)),
        );
        return;
      }
      handleSignUp();
    } else {}
  }

  void handleSignUp() {
    final SignupRequest payload = SignupRequest(
      address: _addressController.text,
      email: _emailController.text,
      name: _fullNameController.text,
      password: _passwordController.text,
      phone: _phoneNumberController.text,
      referralCode: _referralNumberController.text,
      lat: _currentPosition!.latitude.toString(),
      long: _currentPosition!.longitude.toString(),
      passwordConfirmation: _confirmPasswordController.text,
      role: 'customer',
      terms: "accepted",
    );
    ref.read(authenticationViewModelProvider.notifier).signUp(payload);
  }

  @override
  Widget build(BuildContext context) {
    _initListeners();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(Languages.signUp),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  Languages.signupDescription,
                  style: AppTheme.subtitle14,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 24),
                CommonTextFormField(
                  label: Languages.fullName,
                  controller: _fullNameController,
                  validator: (value) {
                    final validator = Validator(validators: [
                      RequiredValidator(),
                    ]);
                    return validator.validate(
                      label: Languages.fullName,
                      value: value,
                    );
                  },
                ),
                SizedBox(height: 16),
                CommonTextFormField(
                  label: Languages.phoneNumber,
                  controller: _phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    final validator = Validator(validators: [
                      RequiredValidator(),
                      PhoneNumberValidator(),
                    ]);
                    return validator.validate(
                      label: Languages.phoneNumber,
                      value: value,
                    );
                  },
                ),
                SizedBox(height: 16),
                CommonTextFormField(
                  label: Languages.email,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    final validator = Validator(validators: [
                      RequiredValidator(),
                      EmailValidator(),
                    ]);
                    return validator.validate(
                      label: Languages.email,
                      value: value,
                    );
                  },
                ),
                SizedBox(height: 16),
                CommonTextFormField(
                  label: Languages.password,
                  controller: _passwordController,
                  validator: (value) {
                    final validator = Validator(validators: [
                      RequiredValidator(),
                    ]);
                    return validator.validate(
                      label: Languages.password,
                      value: value,
                    );
                  },
                  isPassword: true,
                ),
                SizedBox(height: 16),
                CommonTextFormField(
                  label: Languages.confrimPassword,
                  controller: _confirmPasswordController,
                  validator: (value) {
                    var validator = passwordMatchValidator(
                      confirmPassword: value,
                      originalPassword: _passwordController.text,
                    );
                    return validator;
                  },
                  isPassword: true,
                ),
                SizedBox(height: 16),
                CommonTextFormField(
                  label: Languages.refNumber,
                  controller: _referralNumberController,
                ),
                SizedBox(height: 16),
                CommonTextFormField(
                  label: Languages.address,
                  controller: _addressController,
                  validator: (value) {
                    final validator = Validator(validators: [
                      RequiredValidator(),
                    ]);
                    return validator.validate(
                      label: Languages.address,
                      value: value,
                    );
                  },
                  maxLines: 3,
                ),
                SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: isAgreeToTerms,
                      onChanged: (value) {
                        setState(() {
                          isAgreeToTerms = value!;
                        });
                      },
                    ),
                    Text(Languages.signUpAgreementSuffix, style: AppTheme.title12),
                  ],
                ),
                SizedBox(height: 16),
                SecondaryButton(
                  text: Languages.signUp,
                  onPressed: _validateForm,
                  isEnable: _formKey.currentState?.validate() ?? false,
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
