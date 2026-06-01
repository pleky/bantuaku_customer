import 'package:bantuaku_customer/features/common/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../constants/languages.dart';
import '../../../extensions/build_context_extension.dart';
import '../../../extensions/string_extension.dart';
import '../../../theme/app_theme.dart';
import '../../../utils/global_loading.dart';
import '../../common/ui/widgets/common_header.dart';
import '../../common/ui/widgets/common_text_form_field.dart';
import '../../common/ui/widgets/primary_button.dart';
import '../../common/ui/widgets/secondary_button.dart';
import '../model/profile.dart';
import 'view_model/profile_view_model.dart';
import 'widgets/avatar.dart';

class AccountInfoScreen extends ConsumerStatefulWidget {
  final UserModel originalProfile;
  const AccountInfoScreen({
    required this.originalProfile,
    super.key,
  });

  @override
  ConsumerState createState() => _AccountInfoScreenState();
}

class _AccountInfoScreenState extends ConsumerState<AccountInfoScreen> {
  final _formKey = GlobalKey<FormBuilderState>();
  bool _hasChanges = false;
  late Map<String, dynamic> _initialValues;

  @override
  void initState() {
    super.initState();
    _initialValues = {
      "username": widget.originalProfile.username,
      "phone": widget.originalProfile.phone,
      "email": widget.originalProfile.email,
      "address": widget.originalProfile.address,
    };
  }

  Future<void> _selectImage() async {
    // final result = await ref.read(profileViewModelProvider.notifier).selectImage(context);
    // setState(() => avatar = result);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _checkForChanges() {
    final currentState = _formKey.currentState;
    if (currentState != null) {
      final currentAddress = currentState.value['address']?.toString().trim() ?? "";
      final initialAddress = _initialValues['address']?.toString().trim() ?? "";

      setState(() {
        _hasChanges = currentAddress != initialAddress;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FormBuilder(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        initialValue: {
          "username": widget.originalProfile.username,
          "phone": widget.originalProfile.phone,
          "email": widget.originalProfile.email,
          "address": widget.originalProfile.address,
        },
        key: _formKey,
        child: Column(
          children: [
            CommonHeader(header: Languages.accountInformation),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
                children: [
                  Center(
                    child: Stack(
                      children: [
                        SizedBox(
                          width: 128,
                          height: 128,
                          child: Avatar(
                            url:
                                "https://ui-avatars.com/api/?name=${widget.originalProfile.username}&background=random&size=128",
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: _selectImage,
                            icon: const Icon(Icons.camera_alt),
                            style: IconButton.styleFrom(
                              backgroundColor: context.primaryBackgroundColor,
                              foregroundColor: context.primaryTextColor,
                              shape: StadiumBorder(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  FormBuilderTextField(
                    name: "username",
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: "Username",
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: "phone",
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: Languages.phoneNumber,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: "email",
                    enabled: false,
                    decoration: InputDecoration(
                      labelText: Languages.email,
                    ),
                  ),
                  const SizedBox(height: 16),
                  FormBuilderTextField(
                    name: "address",
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                      FormBuilderValidators.maxLength(255),
                    ]),
                    keyboardType: TextInputType.multiline,
                    onChanged: (_) => _checkForChanges(),
                    decoration: InputDecoration(
                      labelText: Languages.address,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 24,
                right: 24,
                bottom: 32,
              ),
              child: PrimaryButton(
                text: Languages.confirm,
                isEnable: _formKey.currentState?.isValid == true,
                onPressed: () async {
                  try {
                    Global.showLoading(context);
                    final address = _formKey.currentState?.fields['address']?.value?.toString().trim();
                    await ref.read(profileViewModelProvider.notifier).updateAddress(address!);
                    setState(() {
                      _hasChanges = false;
                    });

                    if (context.mounted) {
                      context.showSuccessSnackBar("Update successful");
                      FocusScope.of(context).unfocus();
                    }
                  } on PostgrestException catch (error) {
                    if (context.mounted) {
                      context.showErrorSnackBar(error.message);
                    }
                  } catch (error) {
                    if (context.mounted) {
                      context.showErrorSnackBar(Languages.unexpectedErrorOccurred);
                    }
                  } finally {
                    Global.hideLoading();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
