import 'package:airbnb_clone_flutter/features/edit_profile/domain/entities/update_user_info.dart';
import 'package:airbnb_clone_flutter/features/edit_profile/presentation/providers/edit_profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../profile_reactive/presentation/providers/user_profile_provider.dart';

class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProfileProvider);

    Future<void> _showEditFieldModal({
      required BuildContext context,
      required String title,
      required String initialValue,
      required Function(String) onSubmitted,
    }) async {
      final controller = TextEditingController(text: initialValue);

      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.white,
        builder: (context) {
          return Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              top: 24,
              left: 20,
              right: 20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Nhập thông tin mới',
                  ),
                ),
                const SizedBox(height: 16),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      onSubmitted(controller.text.trim());
                    },
                    child: const Text('Lưu'),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin cá nhân'),
        leading: const BackButton(),
      ),
      body: userAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Lỗi: $err')),
        data:
            (user) => ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                _buildSectionItem(
                  context,
                  label: 'Tên pháp lý',
                  value: user.name,
                  onEdit:
                      () => _showEditFieldModal(
                        context: context,
                        title: 'Chỉnh sửa tên pháp lý',
                        initialValue: user.name,
                        onSubmitted: (newValue) async {
                          await _updateUser(
                            ref,
                            user.id,
                            user.copyWith(name: newValue),
                          );
                        },
                      ),
                ),
                const Divider(height: 32),

                _buildSectionItem(
                  context,
                  label: 'Số điện thoại',
                  value: user.phone,
                  onEdit: () {
                    _showEditFieldModal(
                      context: context,
                      title: 'Chỉnh sửa số điện thoại',
                      initialValue: user.phone,
                      onSubmitted: (newValue) async {
                        await _updateUser(
                          ref,
                          user.id,
                          user.copyWith(phone: newValue),
                        );
                      },
                    );
                  },
                ),
                const Divider(height: 32),

                _buildSectionItem(
                  context,
                  label: 'Email',
                  value: user.email,
                  onEdit: () {
                    _showEditFieldModal(
                      context: context,
                      title: 'Chỉnh sửa email',
                      initialValue: user.email,
                      onSubmitted: (newValue) async {
                        await _updateUser(
                          ref,
                          user.id,
                          user.copyWith(email: newValue),
                        );
                      },
                    );
                  },
                ),
                const Divider(height: 32),

                _buildSectionItem(
                  context,
                  label: 'Ngày sinh',
                  value: user.birthday,
                  onEdit: () async {
                    final picked = await showDatePicker(
                      context: context,
                      initialDate:
                          DateTime.tryParse(user.birthday) ??
                          DateTime(2000, 1, 1),
                      firstDate: DateTime(1900),
                      lastDate: DateTime.now(),
                    );

                    if (picked != null) {
                      final formatted =
                          "${picked.year.toString().padLeft(4, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
                      await _updateUser(
                        ref,
                        user.id,
                        user.copyWith(birthday: formatted),
                      );
                    }
                  },
                ),
                const Divider(height: 32),

                _buildSectionItem(
                  context,
                  label: 'Giới tính',
                  value: user.gender == true ? 'Nam' : 'Nữ',
                  onEdit: () async {
                    final gender = await showModalBottomSheet<bool>(
                      context: context,
                      builder: (context) {
                        return Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              title: const Text('Nam'),
                              onTap: () => Navigator.pop(context, true),
                            ),
                            ListTile(
                              title: const Text('Nữ'),
                              onTap: () => Navigator.pop(context, false),
                            ),
                          ],
                        );
                      },
                    );

                    if (gender != null) {
                      await _updateUser(
                        ref,
                        user.id,
                        user.copyWith(gender: gender),
                      );
                    }
                  },
                ),
                const Divider(height: 32),

                _buildSectionItem(
                  context,
                  label: 'Vai trò',
                  value: user.role.toUpperCase(),
                  onEdit: null,
                ),
              ],
            ),
      ),
    );
  }

  Widget _buildSectionItem(
    BuildContext context, {
    required String label,
    required String? value,
    VoidCallback? onEdit,
  }) {
    final isEditable = onEdit != null;
    final actionLabel = (value == null || value.isEmpty) ? 'Thêm' : 'Chỉnh sửa';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Nội dung bên trái
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 4),
                Text(
                  (value == null || value.isEmpty)
                      ? 'Chưa được cung cấp'
                      : value,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),

          // Hành động bên phải
          if (isEditable)
            TextButton(
              onPressed: onEdit,
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                actionLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _updateUser(WidgetRef ref, int id, dynamic user) async {
    final updateInfo = UpdateUserInfo(
      name: user.name,
      email: user.email,
      phone: user.phone,
      birthday: user.birthday,
      gender: user.gender,
      role: user.role,
    );
    await ref.read(updateUserInfoProvider((id, updateInfo)).future);
    ref.invalidate(userProfileProvider);
  }
}
