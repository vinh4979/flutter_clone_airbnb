import 'dart:convert';

import 'package:airbnb_clone_flutter/core/storage/secure_storage.dart';
import 'package:airbnb_clone_flutter/features/booking/presentation/providers/book_room_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class BookingConfirmModal extends ConsumerStatefulWidget {
  final int roomId;
  final String? roomName;
  final String? roomImageUrl;
  final int? roomPrice;
  final DateTime? initialCheckIn;
  final DateTime? initialCheckOut;
  final int? initialGuests;

  const BookingConfirmModal({
    super.key,
    required this.roomId,
    this.roomName,
    this.roomImageUrl,
    this.roomPrice,
    this.initialCheckIn,
    this.initialCheckOut,
    this.initialGuests,
  });

  @override
  ConsumerState<BookingConfirmModal> createState() =>
      _BookingConfirmModalState();
}

class _BookingConfirmModalState extends ConsumerState<BookingConfirmModal> {
  late DateTime? checkInDate = widget.initialCheckIn;
  late DateTime? checkOutDate = widget.initialCheckOut;
  late int guestCount = widget.initialGuests ?? 1;

  void _selectDateRange() async {
    final now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: now.add(const Duration(days: 365)),
      initialDateRange:
          checkInDate != null && checkOutDate != null
              ? DateTimeRange(start: checkInDate!, end: checkOutDate!)
              : null,
    );
    if (picked != null) {
      setState(() {
        checkInDate = picked.start;
        checkOutDate = picked.end;
      });
    }
  }

  int _calculateNights(DateTime? from, DateTime? to) {
    if (from == null || to == null) return 0;
    return to.difference(from).inDays;
  }

  String _formatDate(DateTime? date) {
    if (date == null) return "-";
    return DateFormat('dd/MM/yyyy').format(date);
  }

  String _formatCurrency(int amount) {
    final formatter = NumberFormat("#,###", "vi_VN");
    return "${formatter.format(amount)}₫";
  }

  int? _decodeUserId(String? token) {
    if (token == null) return null;
    try {
      final payload = token.split('.')[1];
      final normalized = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(normalized));
      final data = json.decode(decoded);
      return int.tryParse(data['id'].toString());
    } catch (_) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final nights = _calculateNights(checkInDate, checkOutDate);
    final totalPrice = (widget.roomPrice ?? 0) * nights;

    final bookingState = ref.watch(bookRoomProvider);
    final bookingController = ref.read(bookRoomProvider.notifier);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  "Xác nhận đặt phòng",
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 24),

              if (widget.roomImageUrl != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    widget.roomImageUrl!,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),

              if (widget.roomName != null) ...[
                const SizedBox(height: 12),
                Text(
                  widget.roomName!,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],

              const SizedBox(height: 20),

              _EditableInfoRow(
                icon: Icons.date_range,
                label: "Ngày",
                value:
                    "${_formatDate(checkInDate)} → ${_formatDate(checkOutDate)}",
                onTap: _selectDateRange,
              ),
              const SizedBox(height: 12),
              _EditableInfoRow(
                icon: Icons.people,
                label: "Khách",
                value: "$guestCount người",
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder:
                        (_) => _GuestPicker(
                          initialValue: guestCount,
                          onChanged: (val) {
                            setState(() => guestCount = val);
                            Navigator.pop(context);
                          },
                        ),
                  );
                },
              ),

              const SizedBox(height: 24),
              const Divider(),
              const SizedBox(height: 12),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Tổng cộng",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "${_formatCurrency(totalPrice)} / $nights đêm",
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),

              const SizedBox(height: 28),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed:
                      bookingState.isLoading
                          ? null
                          : () async {
                            final token = await SecureStorage().readToken();
                            final userId = _decodeUserId(token);

                            if (checkInDate == null ||
                                checkOutDate == null ||
                                userId == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text("Thiếu thông tin đặt phòng"),
                                ),
                              );
                              return;
                            }

                            await bookingController.bookRoom(
                              maPhong: widget.roomId,
                              ngayDen: checkInDate!,
                              ngayDi: checkOutDate!,
                              soLuongKhach: guestCount,
                              maNguoiDung: userId,
                            );

                            bookingState.whenOrNull(
                              data: (_) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Đặt phòng thành công!"),
                                  ),
                                );
                                Navigator.of(context).pop();
                              },
                              error: (err, _) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Đặt phòng thất bại: $err"),
                                  ),
                                );
                              },
                            );
                          },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pink,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                  child:
                      bookingState.isLoading
                          ? const CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          )
                          : const Text("Xác nhận đặt phòng"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EditableInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  const _EditableInfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          const SizedBox(width: 12),
          Text("$label: ", style: const TextStyle(fontWeight: FontWeight.w500)),
          Expanded(child: Text(value, style: const TextStyle(fontSize: 15))),
          const Icon(Icons.edit, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}

class _GuestPicker extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int> onChanged;

  const _GuestPicker({required this.initialValue, required this.onChanged});

  @override
  State<_GuestPicker> createState() => _GuestPickerState();
}

class _GuestPickerState extends State<_GuestPicker> {
  late int value;

  @override
  void initState() {
    super.initState();
    value = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "Chọn số khách",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: value > 1 ? () => setState(() => value--) : null,
                icon: const Icon(Icons.remove_circle_outline),
              ),
              Text("$value", style: const TextStyle(fontSize: 20)),
              IconButton(
                onPressed: () => setState(() => value++),
                icon: const Icon(Icons.add_circle_outline),
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => widget.onChanged(value),
            child: const Text("Xong"),
          ),
        ],
      ),
    );
  }
}
