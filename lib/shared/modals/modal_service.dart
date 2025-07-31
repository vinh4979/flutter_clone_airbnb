import 'package:airbnb_clone_flutter/features/auth/presentation/widgets/auth_switcher_modal_widget.dart';
import 'package:airbnb_clone_flutter/features/edit_profile/presentation/screens/edit_profile_screen.dart';
import 'package:airbnb_clone_flutter/features/room_detail/presentation/screens/room_detail_modal.dart';
import 'package:airbnb_clone_flutter/features/search_rooms/presentation/widgets/search_rooms_modal.dart';
import 'package:airbnb_clone_flutter/shared/modals/widgets/room_list_modal.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'modal_types.dart' as modal_types;
import 'modal_config.dart' as modal_config;

void showAppModal(
  BuildContext context,
  modal_types.AppModalType type, {
  dynamic data,
}) {
  final config =
      modal_config.modalConfigs[type] ?? const modal_config.ModalConfig();

  showCupertinoModalBottomSheet(
    context: context,
    expand: config.expand,
    useRootNavigator: config.useRootNavigator,
    barrierColor: Colors.black.withAlpha(75),
    backgroundColor: Colors.white, // ✅ dùng màu trắng rõ ràng
    topRadius: const Radius.circular(16), // ✅ bo góc đẹp
    builder: (context) {
      late Widget modal;

      switch (type) {
        case modal_types.AppModalType.auth:
          return const AuthSwitcherModalWidget();
        case modal_types.AppModalType.roomList:
          modal = RoomListModal(
            location: data['location'],
            rooms: data['rooms'],
          );
          break;
        case modal_types.AppModalType.roomDetail:
          modal = RoomDetailModal(roomId: data['roomId']);
          break;
        case modal_types.AppModalType.searchRooms:
          return const SearchRoomsModal();
        case modal_types.AppModalType.editProfile:
          modal = const EditProfileScreen();
          break;
      }

      return modal;
    },
  );
}
