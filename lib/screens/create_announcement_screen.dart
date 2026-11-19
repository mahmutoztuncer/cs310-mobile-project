import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/announcement.dart';
import '../utils/date_utils.dart';
import '../utils/spacing.dart';
import '../utils/text_styles.dart';
import '../widgets/announcement_type_selector.dart';
import '../widgets/date_time_form_field.dart';
import '../widgets/labeled_text_field.dart';

/// Create Announcement form.
/// Opened with Navigator.pushNamed(context, AppRoutes.create).
/// On success the new announcement is added to [sampleAnnouncements]
/// (placeholder data until Firebase in Step 3) and also returned via pop.
class CreateAnnouncementScreen extends StatefulWidget {
  const CreateAnnouncementScreen({super.key});

  @override
  State<CreateAnnouncementScreen> createState() =>
      _CreateAnnouncementScreenState();
}

class _CreateAnnouncementScreenState extends State<CreateAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();
  final _courseCtrl = TextEditingController();
  final _titleCtrl = TextEditingController();
  final _descCtrl = TextEditingController();
  final _locationCtrl = TextEditingController();
  final _capacityCtrl = TextEditingController();
  final _dateKey = GlobalKey<FormFieldState<DateTime>>();

  // The wireframe shows "Study Session" selected by default.
  AnnouncementType _type = AnnouncementType.studySession;

  bool get _isStudy => _type == AnnouncementType.studySession;

  @override
  void dispose() {
    _courseCtrl.dispose();
    _titleCtrl.dispose();
    _descCtrl.dispose();
    _locationCtrl.dispose();
    _capacityCtrl.dispose();
    super.dispose();
  }

  // ---- validators ---------------------------------------------------------

  String? _validateCourse(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Course code is required';
    if (!RegExp(r'^[A-Za-z]{2,5}\s?\d{3}$').hasMatch(value)) {
      return 'Use a format like CS310 or MATH 204';
    }
    return null;
  }

  String? _validateTitle(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Title is required';
    if (value.length < 3) return 'Title must be at least 3 characters';
    return null;
  }

  String? _validateDescription(String? v) {
    final value = (v ?? '').trim();
    if (value.isEmpty) return 'Description is required';
    if (value.length < 10) return 'Description must be at least 10 characters';
    return null;
  }

  String? _validateLocation(String? v) {
    if ((v ?? '').trim().isEmpty) return 'Location is required';
    return null;
  }

  String? _validateCapacity(String? v) {
    final n = int.tryParse((v ?? '').trim());
    if (n == null) return 'Enter a number';
    if (n < 2 || n > 50) return 'Must be between 2 and 50';
    return null;
  }

  // ---- submit -------------------------------------------------------------

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    // TODO (Step 3): replace with the signed-in user's name and photo.
    final announcement = Announcement(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      type: _type,
      courseCode: _courseCtrl.text.trim().toUpperCase().replaceAll(' ', ''),
      title: _titleCtrl.text.trim(),
      description: _descCtrl.text.trim(),
      capacity: int.parse(_capacityCtrl.text.trim()),
      joinedCount: 1, // the creator is the first participant
      location: _isStudy ? _locationCtrl.text.trim() : null,
      dateTime: _isStudy ? _dateKey.currentState!.value : null,
      creatorName: 'Ayşe Yılmaz',
      creatorPhotoUrl: 'https://i.pravatar.cc/100?img=5',
    );

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Announcement created'),
        content: Text(
          announcement.dateTime != null
              ? '${announcement.courseCode} · ${announcement.title}\n'
                  '${announcement.location} · '
                  '${AppDateUtils.formatDateTime(announcement.dateTime!)}'
              : '${announcement.courseCode} · ${announcement.title}',
          style: AppTextStyles.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('OK'),
          ),
        ],
      ),
    );

    if (!mounted) return;
    sampleAnnouncements.insert(0, announcement);
    Navigator.pop(context, announcement);
  }

  // ---- UI -----------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Announcement')),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LabeledTextField(
                    label: 'Course Code',
                    hint: 'e.g. CS310',
                    controller: _courseCtrl,
                    validator: _validateCourse,
                    textCapitalization: TextCapitalization.characters,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  AnnouncementTypeSelector(
                    initialValue: _type,
                    onChanged: (t) => setState(() => _type = t),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LabeledTextField(
                    label: 'Announcement Title',
                    hint: 'e.g. Flutter widgets review',
                    controller: _titleCtrl,
                    validator: _validateTitle,
                    textCapitalization: TextCapitalization.sentences,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  LabeledTextField(
                    label: 'Description',
                    hint: 'Describe your study session or project team...',
                    controller: _descCtrl,
                    validator: _validateDescription,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    textCapitalization: TextCapitalization.sentences,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  // Location (study sessions only) + capacity side by side.
                  // Expanded keeps this overflow-safe on narrow phones.
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_isStudy) ...[
                        Expanded(
                          flex: 3,
                          child: LabeledTextField(
                            label: 'Location',
                            hint: 'e.g. IC Library',
                            controller: _locationCtrl,
                            validator: _validateLocation,
                            textCapitalization: TextCapitalization.words,
                            textInputAction: TextInputAction.next,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                      ],
                      Expanded(
                        flex: 2,
                        child: LabeledTextField(
                          label: 'Max Participants',
                          hint: 'e.g. 4',
                          controller: _capacityCtrl,
                          validator: _validateCapacity,
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(2),
                          ],
                        ),
                      ),
                    ],
                  ),
                  if (_isStudy) ...[
                    const SizedBox(height: AppSpacing.md),
                    DateTimeFormField(key: _dateKey),
                  ],
                  const SizedBox(height: AppSpacing.md * 1.5),
                  SizedBox(
                    height: 44,
                    child: FilledButton(
                      onPressed: _submit,
                      style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Create Announcement'),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
