import 'package:flutter/material.dart';

class TenantSelectionScreen extends StatelessWidget {
  const TenantSelectionScreen({super.key});

  static const String routePath = '/tenant-selection';
  static const String routeName = 'tenantSelection';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text('Tenant Selection / Creation (TODO: implement)'),
      ),
    );
  }
}
