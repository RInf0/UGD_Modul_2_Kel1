import 'package:flutter/material.dart';
import 'package:ugd_modul_2_kel1/utilities/constant.dart';

class KontakView extends StatefulWidget {
  const KontakView({Key? key}) : super(key: key);

  @override
  State<KontakView> createState() => KontakViewState();
}

class KontakViewState extends State<KontakView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Kontak',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: cAccentColor,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildContactItem(
                title: 'Kontak RS',
                subtitle: '021-423-7890',
              ),
              const SizedBox(height: 16),
              _buildContactItem(
                title: 'Kontak Emergency',
                subtitle: '112',
              ),
              const SizedBox(height: 16),
              _buildContactItem(
                title: 'IGD',
                subtitle: '021-762-3210',
              ),
              const SizedBox(height: 16),
              _buildContactItem(
                title: 'Poliklinik Umum',
                subtitle: '021-555-1234',
              ),
              const SizedBox(height: 16),
              _buildContactItem(
                title: 'Laboratorium',
                subtitle: '021-888-5678',
              ),
              const SizedBox(height: 16),
              _buildContactItem(
                title: 'Radiologi',
                subtitle: '021-999-0000',
              ),
              // Tambahkan kontak lainnya sesuai kebutuhan
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildContactItem({
    required String title,
    required String subtitle,
  }) {
    return Container(
      height: 100, // Atur tinggi sesuai kebutuhan Anda
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.phone, size: 16, color: Colors.grey),
                  SizedBox(width: 8),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
