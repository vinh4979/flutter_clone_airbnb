import 'package:airbnb_clone_flutter/shared/models/host_feature.dart';
import 'package:flutter/material.dart';

class HostFeatureUtil {
  static List<HostFeature> getDefaultFeatures() {
    return [
      HostFeature(
        icon: Icons.ac_unit_rounded,
        title: 'Thoáng mát quanh năm',
        description: 'Phòng có máy lạnh và quạt trần giúp bạn luôn dễ chịu.',
      ),
      HostFeature(
        icon: Icons.hot_tub_rounded,
        title: 'Bồn tắm thư giãn',
        description: 'Một trong số ít chỗ nghỉ có bồn tắm trong khu vực.',
      ),
      HostFeature(
        icon: Icons.meeting_room_rounded,
        title: 'Tự check-in dễ dàng',
        description: 'Tự nhận phòng bằng hộp khóa an toàn.',
      ),
      HostFeature(
        icon: Icons.security_rounded,
        title: 'Chủ nhà đáng tin 🌟',
        description: 'Luôn phản hồi nhanh và hỗ trợ tận tình.',
      ),
      HostFeature(
        icon: Icons.cleaning_services_rounded,
        title: 'Sạch sẽ tuyệt đối',
        description: 'Phòng được vệ sinh kỹ lưỡng trước mỗi lượt khách.',
      ),
    ];
  }
}
