import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_mvvm_riverpod/constants/languages.dart';
import 'package:flutter_mvvm_riverpod/extensions/build_context_extension.dart';
import 'package:flutter_mvvm_riverpod/features/common/ui/widgets/FormBuilderDurationPicker.dart';
import 'package:flutter_mvvm_riverpod/features/common/ui/widgets/primary_button.dart';
import 'package:flutter_mvvm_riverpod/features/job/model/create_job_dto.dart';
import 'package:flutter_mvvm_riverpod/features/job/model/skill_response.dart';
import 'package:flutter_mvvm_riverpod/features/job/ui/view_model/create_job_view_model.dart';
import 'package:flutter_mvvm_riverpod/misc/tile_provider.dart';
import 'package:flutter_mvvm_riverpod/routing/routes.dart';
import 'package:flutter_mvvm_riverpod/theme/app_colors.dart';
import 'package:flutter_mvvm_riverpod/theme/app_theme.dart';
import 'package:flutter_mvvm_riverpod/utils/global_loading.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            child: Column(
              spacing: 4,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.3,
                  child: FlutterMap(
                    options: MapOptions(
                      initialCenter: LatLng(-6.200000, 106.816666), // jakarta
                      initialZoom: 5,
                    ),
                    children: [
                      openStreetMapTileLayer,
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Visibility(
                        visible: widget.isSkillActive,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Languages.qualifications,
                              style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                            ),
                            FormBuilderSearchableDropdown<SkillResponse>(
                              name: "qualification",
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
                      SizedBox(height: 8),
                      Text(
                        Languages.jobLocation,
                        style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                      ),
                      SizedBox(height: 4),
                      FormBuilderTextField(
                        maxLines: 3,
                        name: "address",
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        Languages.title,
                        style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                      ),
                      FormBuilderTextField(
                        name: 'title',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        Languages.description,
                        style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                      ),
                      FormBuilderTextField(
                        name: "description",
                        maxLines: 3,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        Languages.photo,
                        style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                      ),
                      FormBuilderImagePicker(
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
                      SizedBox(height: 8),
                      Text(
                        "Budget (IDR)",
                        style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                      ),
                      FormBuilderTextField(
                        name: "budget",
                        keyboardType: TextInputType.number,
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.minLength(1),
                        ]),
                      ),
                      SizedBox(height: 8),
                      Text(
                        Languages.duration,
                        style: AppTheme.body14.copyWith(color: context.primaryTextColor),
                      ),
                      FormBuilderDurationPicker(
                        name: 'job_duration',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                        ]),
                      ),
                      SizedBox(height: 24),
                      PrimaryButton(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
