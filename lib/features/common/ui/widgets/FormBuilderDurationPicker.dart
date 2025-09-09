import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:bantuaku_customer/theme/app_colors.dart';

class FormBuilderDurationPicker extends FormBuilderField<Duration> {
  FormBuilderDurationPicker({
    super.key,
    required super.name,
    super.validator,
    super.initialValue,
    super.enabled = true,
    this.decoration = const InputDecoration(),
  }) : super(
          builder: (FormFieldState<Duration?> field) {
            final state = field as _FormBuilderDurationPickerState;

            return InputDecorator(
              decoration: state.decoration.copyWith(
                errorText: state.errorText,
              ),
              child: InkWell(
                onTap: state.enabled ? state._selectDuration : null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      state.value != null ? _formatDuration(state.value!) : '00:00',
                      style: TextStyle(
                        color: state.value != null ? Colors.black : Colors.grey.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Icon(Icons.timer, color: AppColors.mono90),
                  ],
                ),
              ),
            );
          },
        );

  final InputDecoration decoration;

  @override
  FormBuilderFieldState<FormBuilderDurationPicker, Duration> createState() => _FormBuilderDurationPickerState();
}

class _FormBuilderDurationPickerState extends FormBuilderFieldState<FormBuilderDurationPicker, Duration> {
  InputDecoration get decoration => widget.decoration;

  Future<void> _selectDuration() async {
    Duration initial = value ?? Duration.zero;

    final Duration? result = await showModalBottomSheet<Duration>(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => _DurationPickerModal(initialDuration: initial),
    );

    if (result != null) {
      didChange(result);
    }
  }
}

class _DurationPickerModal extends StatefulWidget {
  final Duration initialDuration;

  const _DurationPickerModal({required this.initialDuration});

  @override
  State<_DurationPickerModal> createState() => _DurationPickerModalState();
}

class _DurationPickerModalState extends State<_DurationPickerModal> {
  late int selectedHour;
  late int selectedMinute;

  @override
  void initState() {
    super.initState();
    selectedHour = widget.initialDuration.inHours;
    selectedMinute = widget.initialDuration.inMinutes.remainder(60);
  }

  @override
  Widget build(BuildContext context) {
    final red = Colors.red.shade900;

    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(16, 12, 16, 24),
        height: 350,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Expanded(
                //   child: Text(
                //     "Set Batasan Waktu",
                //     style: TextStyle(
                //       fontWeight: FontWeight.bold,
                //       fontSize: 16,
                //     ),
                //   ),
                // ),
                IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: Row(
                children: [
                  _buildPickerColumn(
                    context,
                    label: "Jam",
                    initial: selectedHour,
                    max: 23,
                    onChanged: (val) => setState(() => selectedHour = val),
                  ),
                  _buildPickerColumn(
                    context,
                    label: "Menit",
                    initial: selectedMinute,
                    max: 59,
                    onChanged: (val) => setState(() => selectedMinute = val),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: red,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(
                    Duration(hours: selectedHour, minutes: selectedMinute),
                  );
                },
                child: Text("Simpan", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildPickerColumn(
    BuildContext context, {
    required String label,
    required int initial,
    required int max,
    required ValueChanged<int> onChanged,
  }) {
    final red = Colors.red.shade900;
    return Expanded(
      child: Column(
        children: [
          Text(label, style: TextStyle(color: red, fontWeight: FontWeight.bold)),
          Expanded(
            child: CupertinoPicker(
              scrollController: FixedExtentScrollController(initialItem: initial),
              itemExtent: 40,
              magnification: 1.2,
              useMagnifier: true,
              onSelectedItemChanged: onChanged,
              backgroundColor: Colors.grey.shade200,
              children: List.generate(max + 1, (index) {
                return Center(
                  child: Text(index.toString().padLeft(2, '0'), style: TextStyle(fontSize: 20)),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatDuration(Duration duration) {
  return "${duration.inHours.toString().padLeft(2, '0')}:${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}";
}
