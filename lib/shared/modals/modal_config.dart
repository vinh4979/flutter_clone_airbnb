// /// Định nghĩa các cấu hình cho từng loại modal.
// /// Giúp quản lý tập trung hành vi của từng modal: full screen, drag, dismissible...

// class ModalConfig {
//   final bool expand; // Modal full screen hay không
//   final bool useRootNavigator;
//   final bool enableDrag;
//   final bool isDismissible;

//   const ModalConfig({
//     this.expand = true,
//     this.useRootNavigator = true,
//     this.enableDrag = true,
//     this.isDismissible = true,
//   });
// }

// /// Enum định danh các loại modal trong app
// enum AppModalType {
//   auth,
//   filter,
//   datePicker,
//   detail,
//   review,
//   confirmLogout,
//   // bạn có thể thêm các modal khác ở đây
// }

// /// Map giữa từng modal và cấu hình cụ thể của nó
// final modalConfigs = <AppModalType, ModalConfig>{
//   AppModalType.auth: ModalConfig(
//     expand: true,
//     useRootNavigator: true,
//     enableDrag: false,
//     isDismissible: true,
//   ),
//   AppModalType.filter: ModalConfig(
//     expand: false,
//     useRootNavigator: true,
//     enableDrag: true,
//     isDismissible: true,
//   ),
//   AppModalType.datePicker: ModalConfig(
//     expand: false,
//     enableDrag: true,
//     isDismissible: true,
//   ),
//   AppModalType.detail: ModalConfig(
//     expand: true,
//     enableDrag: true,
//     isDismissible: false,
//   ),
//   AppModalType.confirmLogout: ModalConfig(
//     expand: false,
//     enableDrag: false,
//     isDismissible: false,
//   ),
// };

import 'modal_types.dart';

class ModalConfig {
  final bool expand;
  final bool useRootNavigator;

  const ModalConfig({this.expand = true, this.useRootNavigator = true});
}

final Map<AppModalType, ModalConfig> modalConfigs = {
  AppModalType.auth: ModalConfig(expand: true, useRootNavigator: true),
  //  AppModalType.searchRooms: ModalConfig(expand: true),
  AppModalType.editProfile: ModalConfig(expand: true), // ✅ Thêm config nếu cần
};
