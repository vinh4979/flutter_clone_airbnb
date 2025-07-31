// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:airbnb_clone_flutter/features/room_detail/presentation/providers/room_detail_provider.dart';
// import 'package:airbnb_clone_flutter/features/booking/presentation/widgets/booking_confirm_modal.dart';

// class RoomDetailModal extends ConsumerStatefulWidget {
//   final int roomId;
//   const RoomDetailModal({super.key, required this.roomId});

//   @override
//   ConsumerState<RoomDetailModal> createState() => _RoomDetailModalState();
// }

// class _RoomDetailModalState extends ConsumerState<RoomDetailModal> {
//   final ScrollController _scrollController = ScrollController();
//   double _offset = 0.0;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController.addListener(() {
//       setState(() {
//         _offset = _scrollController.offset;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final roomDetailAsync = ref.watch(roomDetailProvider(widget.roomId));
//     final commentsAsync = ref.watch(roomCommentsProvider(widget.roomId));

//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: roomDetailAsync.when(
//         data: (room) {
//           final locationAsync = ref.watch(roomLocationProvider(room.maViTri));

//           return Stack(
//             children: [
//               /// NỀN TRẮNG
//               Positioned.fill(child: Container(color: Colors.white)),

//               /// ẢNH PARALLAX
//               Positioned(
//                 top: -_offset * 0.4,
//                 left: 0,
//                 right: 0,
//                 child: Image.network(
//                   room.hinhAnh,
//                   height: 300 + _offset * 0.2,
//                   fit: BoxFit.cover,
//                   loadingBuilder: (context, child, progress) {
//                     if (progress == null) return child;
//                     return Container(
//                       height: 300,
//                       color: Colors.grey.shade300,
//                       alignment: Alignment.center,
//                       child: const CircularProgressIndicator(),
//                     );
//                   },
//                   errorBuilder: (context, error, stackTrace) {
//                     return Container(
//                       height: 300,
//                       color: Colors.grey.shade300,
//                       alignment: Alignment.center,
//                       child: const Icon(
//                         Icons.broken_image,
//                         size: 50,
//                         color: Colors.grey,
//                       ),
//                     );
//                   },
//                 ),
//               ),

//               /// NỘI DUNG CUỘN
//               SingleChildScrollView(
//                 controller: _scrollController,
//                 physics: const BouncingScrollPhysics(),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     const SizedBox(height: 280),
//                     Container(
//                       decoration: const BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.only(
//                           topLeft: Radius.circular(24),
//                           topRight: Radius.circular(24),
//                         ),
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           _buildRoomTitle(room.tenPhong, room.moTa),
//                           _buildRoomFeatures(room),
//                           const SizedBox(height: 16),
//                           _buildLocation(locationAsync),
//                           const Divider(height: 32),
//                           const Padding(
//                             padding: EdgeInsets.symmetric(horizontal: 16),
//                             child: Text(
//                               'Bình luận',
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.bold,
//                               ),
//                             ),
//                           ),
//                           _buildComments(commentsAsync),
//                           const SizedBox(height: 100),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               /// APPBAR MỜ DẦN (CÓ BACK + LIKE)
//               Positioned(
//                 top: 0,
//                 left: 0,
//                 right: 0,
//                 child: AnimatedContainer(
//                   duration: const Duration(milliseconds: 250),
//                   height: MediaQuery.of(context).padding.top + 60,
//                   color: Colors.white.withOpacity((_offset / 150).clamp(0, 1)),
//                   padding: EdgeInsets.only(
//                     top: MediaQuery.of(context).padding.top,
//                     left: 8,
//                     right: 8,
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                         icon: const Icon(Icons.arrow_back, color: Colors.black),
//                         onPressed: () => Navigator.of(context).pop(),
//                       ),
//                       Expanded(
//                         child: AnimatedOpacity(
//                           opacity: (_offset > 100) ? 1.0 : 0.0,
//                           duration: const Duration(milliseconds: 250),
//                           child: Text(
//                             room.tenPhong,
//                             textAlign: TextAlign.center,
//                             overflow: TextOverflow.ellipsis,
//                             style: const TextStyle(
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                               color: Colors.black,
//                             ),
//                           ),
//                         ),
//                       ),
//                       IconButton(
//                         icon: const Icon(
//                           Icons.favorite_border,
//                           color: Colors.black,
//                         ),
//                         onPressed: () {
//                           // Gọi provider hoặc API like chung
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//         loading: () => const Center(child: CircularProgressIndicator()),
//         error: (e, _) => Center(child: Text("Lỗi khi tải dữ liệu phòng: $e")),
//       ),
//       bottomNavigationBar: _buildBookingButton(context),
//     );
//   }

//   /// -------------------- UI Components --------------------

//   Widget _buildRoomTitle(String title, String description) {
//     return Padding(
//       padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             title,
//             style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//           ),
//           const SizedBox(height: 8),
//           Text(description),
//         ],
//       ),
//     );
//   }

//   Widget _buildRoomFeatures(dynamic room) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16),
//       child: Wrap(
//         spacing: 10,
//         children: [
//           if (room.wifi) const Chip(label: Text("Wi-Fi")),
//           if (room.dieuHoa) const Chip(label: Text("Điều hoà")),
//           if (room.hoBoi) const Chip(label: Text("Hồ bơi")),
//           if (room.doXe) const Chip(label: Text("Bãi đỗ xe")),
//           if (room.banLa) const Chip(label: Text("Bàn ủi")),
//         ],
//       ),
//     );
//   }

//   Widget _buildLocation(AsyncValue locationAsync) {
//     return locationAsync.when(
//       data:
//           (location) => Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16),
//             child: Row(
//               children: [
//                 const Icon(Icons.location_on, color: Colors.red),
//                 const SizedBox(width: 4),
//                 Text(
//                   '${location.tenViTri}, ${location.tinhThanh}, ${location.quocGia}',
//                   style: const TextStyle(fontSize: 16),
//                 ),
//               ],
//             ),
//           ),
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error: (e, _) => Text("Lỗi vị trí: $e"),
//     );
//   }

//   Widget _buildComments(AsyncValue commentsAsync) {
//     return commentsAsync.when(
//       data:
//           (comments) => Column(
//             children:
//                 comments.map<Widget>((comment) {
//                   return ListTile(
//                     leading: CircleAvatar(
//                       child: Text(comment.tenNguoiBinhLuan[0]),
//                     ),
//                     title: Text(comment.tenNguoiBinhLuan),
//                     subtitle: Text(comment.noiDung),
//                     trailing: Row(
//                       mainAxisSize: MainAxisSize.min,
//                       children: List.generate(
//                         comment.saoBinhLuan,
//                         (index) => const Icon(
//                           Icons.star,
//                           color: Colors.amber,
//                           size: 16,
//                         ),
//                       ),
//                     ),
//                   );
//                 }).toList(),
//           ),
//       loading: () => const Center(child: CircularProgressIndicator()),
//       error:
//           (e, _) => Padding(
//             padding: const EdgeInsets.all(16),
//             child: Text("Lỗi bình luận: $e"),
//           ),
//     );
//   }

//   Widget _buildBookingButton(BuildContext context) {
//     return SafeArea(
//       top: false,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: ElevatedButton(
//           onPressed: () {
//             showModalBottomSheet(
//               context: context,
//               isScrollControlled: true,
//               builder: (_) => BookingConfirmModal(roomId: widget.roomId),
//             );
//           },
//           style: ElevatedButton.styleFrom(
//             backgroundColor: Colors.pinkAccent,
//             padding: const EdgeInsets.symmetric(vertical: 14),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(12),
//             ),
//           ),
//           child: const Text(
//             "Đặt phòng",
//             style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
// }
