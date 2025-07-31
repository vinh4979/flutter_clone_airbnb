import 'package:airbnb_clone_flutter/features/explore/data/datasources/explore_remote_datasource.dart';
import 'package:airbnb_clone_flutter/features/explore/data/models/location_model.dart';
import 'package:airbnb_clone_flutter/features/search_rooms/domain/entities/search_rooms_condition.dart';
import 'package:airbnb_clone_flutter/features/search_rooms/presentation/providers/search_rooms_provider.dart';
import 'package:airbnb_clone_flutter/features/search_rooms/presentation/screens/search_rooms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class SearchRoomsModal extends ConsumerStatefulWidget {
  const SearchRoomsModal({super.key});

  @override
  ConsumerState<SearchRoomsModal> createState() => _SearchRoomsModalState();
}

class _SearchRoomsModalState extends ConsumerState<SearchRoomsModal> {
  List<LocationModel> locations = [];
  LocationModel? selectedLocation;

  DateTimeRange? selectedDateRange;
  int guestCount = 1;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadLocations();
  }

  Future<void> _loadLocations() async {
    final rawLocations = await ExploreRemoteDataSource().fetchLocations();

    final uniqueMap = <String, LocationModel>{};
    for (final loc in rawLocations) {
      final key = "${loc.tinhThanh}, ${loc.quocGia}";
      uniqueMap[key] = loc; // tự động override nếu trùng, giữ 1 cái
    }

    locations = uniqueMap.values.toList();
    setState(() {
      isLoading = false;
    });
  }

  void _resetForm() {
    setState(() {
      selectedLocation = null;
      selectedDateRange = null;
      guestCount = 1;
    });
  }

  void _submitSearch() {
    if (selectedLocation == null) return;

    ref
        .read(searchRoomsConditionProvider.notifier)
        .state = SearchRoomsCondition(
      maViTri: selectedLocation!.id,
      ngayDen: selectedDateRange?.start,
      ngayDi: selectedDateRange?.end,
      soLuongKhach: guestCount,
    );

    Navigator.of(context).pop(); // đóng modal
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => const SearchRoomsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatter = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tìm kiếm chỗ ở"),
        actions: [
          TextButton(onPressed: _resetForm, child: const Text("Xoá tất cả")),
        ],
      ),
      body:
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  const Text(
                    "Địa điểm",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  DropdownButtonFormField<LocationModel>(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                    ),
                    isExpanded: true,
                    value: selectedLocation,
                    items:
                        locations.map((loc) {
                          final name = "${loc.tinhThanh}, ${loc.quocGia}";
                          return DropdownMenuItem(
                            value: loc,
                            child: Text(name),
                          );
                        }).toList(),
                    onChanged: (loc) => setState(() => selectedLocation = loc),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    "Thời gian",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  InkWell(
                    onTap: () async {
                      final now = DateTime.now();
                      final picked = await showDateRangePicker(
                        context: context,
                        firstDate: now,
                        lastDate: now.add(const Duration(days: 365)),
                      );
                      if (picked != null) {
                        setState(() {
                          selectedDateRange = picked;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade400),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        selectedDateRange == null
                            ? "Chọn khoảng thời gian"
                            : "${dateFormatter.format(selectedDateRange!.start)} → ${dateFormatter.format(selectedDateRange!.end)}",
                      ),
                    ),
                  ),

                  const SizedBox(height: 24),
                  const Text(
                    "Số khách",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed:
                            guestCount > 1
                                ? () => setState(() => guestCount--)
                                : null,
                      ),
                      Text('$guestCount khách'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () => setState(() => guestCount++),
                      ),
                    ],
                  ),

                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: selectedLocation == null ? null : _submitSearch,
                    child: const Text("Tìm kiếm"),
                  ),
                ],
              ),
    );
  }
}
