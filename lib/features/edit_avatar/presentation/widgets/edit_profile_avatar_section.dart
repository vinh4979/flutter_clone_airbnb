import 'dart:io';
import 'package:airbnb_clone_flutter/features/edit_avatar/presentation/providers/upload_avatar_provider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditProfileAvatarSection extends ConsumerStatefulWidget {
  final String? currentAvatarUrl;

  const EditProfileAvatarSection({super.key, required this.currentAvatarUrl});

  @override
  ConsumerState<EditProfileAvatarSection> createState() =>
      _EditProfileAvatarSectionState();
}

class _EditProfileAvatarSectionState
    extends ConsumerState<EditProfileAvatarSection> {
  File? _pickedFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Bạn chưa chọn ảnh nào')));
      return;
    }

    setState(() => _pickedFile = File(image.path));

    try {
      await ref.read(uploadAvatarControllerProvider(_pickedFile!).future);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Cập nhật ảnh đại diện thành công')),
      );
    } catch (e) {
      debugPrint('❌ Upload avatar error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lỗi khi upload ảnh: ${e.toString()}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[300],
              backgroundImage:
                  widget.currentAvatarUrl != null &&
                          widget.currentAvatarUrl!.isNotEmpty
                      ? NetworkImage(widget.currentAvatarUrl!)
                      : null,
              child:
                  (widget.currentAvatarUrl == null ||
                          widget.currentAvatarUrl!.isEmpty)
                      ? const Icon(Icons.person, size: 48, color: Colors.white)
                      : null,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black.withOpacity(0.7),
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    size: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}
