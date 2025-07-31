import 'package:flutter/material.dart';
import 'package:airbnb_clone_flutter/core/utils/host_info_util.dart';
import 'package:airbnb_clone_flutter/core/utils/host_feature_util.dart';

class HostSection extends StatefulWidget {
  const HostSection({super.key});

  @override
  State<HostSection> createState() => _HostSectionState();
}

class _HostSectionState extends State<HostSection> {
  late final HostInfo host;

  @override
  void initState() {
    super.initState();
    host = HostInfoUtil.getRandomHost(); // ✅ chỉ gọi 1 lần
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final features = HostFeatureUtil.getDefaultFeatures();

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 🔹 Host Info
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundImage: NetworkImage(host.avatarUrl),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Chủ nhà: ${host.name}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      host.tagline,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // 🔹 Feature List
          ...features.map((feature) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(feature.icon, size: 28, color: Colors.black87),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feature.title,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          feature.description,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
