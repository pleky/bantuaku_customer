import 'package:bantuaku_customer/features/common/ui/widgets/google_maps_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:bantuaku_customer/constants/languages.dart';
import 'package:bantuaku_customer/extensions/build_context_extension.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/FormBuilderDurationPicker.dart';
import 'package:bantuaku_customer/features/common/ui/widgets/primary_button.dart';
import 'package:bantuaku_customer/features/job/model/create_job_dto.dart';
import 'package:bantuaku_customer/features/job/model/skill_response.dart';
import 'package:bantuaku_customer/features/job/ui/view_model/create_job_view_model.dart';
import 'package:bantuaku_customer/misc/tile_provider.dart';
import 'package:bantuaku_customer/routing/routes.dart';
import 'package:bantuaku_customer/theme/app_colors.dart';
import 'package:bantuaku_customer/theme/app_theme.dart';
import 'package:bantuaku_customer/utils/global_loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_extra_fields/form_builder_extra_fields.dart';
import 'package:form_builder_image_picker/form_builder_image_picker.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

class CreateJobScreen extends ConsumerStatefulWidget {
  const CreateJobScreen({super.key, required this.isSkillActive});

  final bool isSkillActive;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _State();
}

class _State extends ConsumerState<CreateJobScreen> {
  final _formKey = GlobalKey<FormBuilderState>();

  void _handleSubmit(Map<String, dynamic>? value) async {
    if (value == null) return;

    final state = ref.watch(createJobViewModelProvider).value;

    Map<String, dynamic> val = {
      'title': value['title'],
      'description': value['description'],
      'latitude': state?.currentLocation?.latitude.toString(),
      'longitude': state?.currentLocation?.longitude.toString(),
      'latitude_customer': state?.currentLocation?.latitude.toString(),
      'longitude_customer': state?.currentLocation?.longitude.toString(),
      'address': value['address'],
      'budget': value['budget'],
      'skill': widget.isSkillActive ? value['qualification']?.id.toString() : null,
    };

    if (value['image_path[]'] != null && value['image_path[]'] is List) {
      val['files'] = value['image_path[]'].map((file) => file.path).toList();
    } else {
      val['files'] = [];
    }
    final payload = CreateJobDto.fromJson(val);
    ref.read(createJobViewModelProvider.notifier).handleCreateJob(payload);
  }

  void _initListeners() {
    ref.listen(createJobViewModelProvider, (previous, next) {
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
        if (next.value?.isSuccess == true) {
          context.showSuccessSnackBar("Job posting created successfully");
          context.pushNamed(Routes.findWorker);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _initListeners();
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: GoogleMapsWidget(
                    onLocationSelected: (location, address) {
                      _formKey.currentState?.fields['address']?.didChange(address);
                      _formKey.currentState?.fields['latitude']?.didChange(location.latitude);
                      _formKey.currentState?.fields['longitude']?.didChange(location.longitude);
                    },
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        spacing: 16,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Visibility(
                            visible: widget.isSkillActive,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FormBuilderSearchableDropdown<SkillResponse>(
                                  name: "qualification",
                                  decoration: InputDecoration(
                                    label: Text(
                                      Languages.qualifications,
                                      style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                                    ),
                                  ),
                                  compareFn: (item1, item2) => item1.id == item2.id,
                                  asyncItems: (filter, loadProps) async {
                                    final result = await ref.read(createJobViewModelProvider.notifier).fetchSkills();
                                    return result;
                                  },
                                  itemAsString: (item) => item.namaSkill,
                                  validator: widget.isSkillActive
                                      ? FormBuilderValidators.compose([
                                          FormBuilderValidators.required(),
                                        ])
                                      : null,
                                ),
                              ],
                            ),
                          ),
                          FormBuilderTextField(
                            decoration: InputDecoration(
                              label: Text(
                                Languages.address,
                                style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                              ),
                              helperText: Languages.addressHelper,
                              helperStyle: AppTheme.body12.copyWith(color: context.secondaryTextColor),
                            ),
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            name: "address",
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          FormBuilderTextField(
                            decoration: InputDecoration(
                              label: Text(
                                Languages.title,
                                style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                              ),
                            ),
                            name: 'title',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          FormBuilderTextField(
                            decoration: InputDecoration(
                              label: Text(
                                Languages.description,
                                style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                              ),
                            ),
                            name: "description",
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          FormBuilderImagePicker(
                            decoration: InputDecoration(
                              label: Text(
                                Languages.photo,
                                style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                              ),
                            ),
                            name: "image_path[]",
                            maxImages: 3,
                            icon: Icons.image,
                            iconColor: AppColors.mono60,
                            backgroundColor: AppColors.mono40,
                            transformImageWidget: (context, image) {
                              return Padding(
                                padding: const EdgeInsets.all(8.0), // 👈 Add spacing between images
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: image,
                                ),
                              );
                            },
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          FormBuilderTextField(
                            name: "budget",
                            decoration: InputDecoration(
                              label: Text(
                                Languages.budget,
                                style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                              FormBuilderValidators.minLength(1),
                            ]),
                          ),
                          FormBuilderDurationPicker(
                            decoration: InputDecoration(
                              label: Text(
                                Languages.duration,
                                style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                              ),
                            ),
                            name: 'job_duration',
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(),
                            ]),
                          ),
                          PrimaryButton(
                            borderRadius: 8,
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState?.saveAndValidate() ?? false) {
                                final value = _formKey.currentState?.value;

                                _handleSubmit(value);
                              }
                            },
                            text: Languages.createJob,
                          ),
                        ],
                      ),
                    ),
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
