class SearchRoomsCondition {
  final int maViTri;
  final DateTime? ngayDen;
  final DateTime? ngayDi;
  final int soLuongKhach;

  const SearchRoomsCondition({
    required this.maViTri,
    this.ngayDen,
    this.ngayDi,
    this.soLuongKhach = 1,
  });

  SearchRoomsCondition copyWith({
    int? maViTri,
    DateTime? ngayDen,
    DateTime? ngayDi,
    int? soLuongKhach,
  }) {
    return SearchRoomsCondition(
      maViTri: maViTri ?? this.maViTri,
      ngayDen: ngayDen ?? this.ngayDen,
      ngayDi: ngayDi ?? this.ngayDi,
      soLuongKhach: soLuongKhach ?? this.soLuongKhach,
    );
  }
}
