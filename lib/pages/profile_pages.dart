import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  // 1. Tambahkan variabel untuk menerima data
  final String nama;
  final String email;
  final String nomorTelepon;

  // 2. Buat constructor dengan data default (opsional)
  const ProfilePage({
    super.key,
    this.nama = 'Alen',
    this.email = 'ale@gmail.com',
    this.nomorTelepon = '+62 812-3456-7890',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('PROFIL'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Foto Profil Placeholder
            const Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Teks Nama di bawah foto
            Text(
              nama, // <-- Menggunakan variabel nama
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              email, // <-- Menggunakan variabel email
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // Card Nama Lengkap
            _buildProfileItem(
              icon: Icons.person_outline,
              label: 'Nama Lengkap',
              value: nama, // <-- Menggunakan variabel nama
            ),
            const SizedBox(height: 12),
            // Panggil fungsi ini di dalam Column/ListView tempat Anda menampilkan daftar profil:

            _buildProfileItem(
              icon: Icons.alternate_email, // AtauIcons.person_outline
              label: 'Username',
              value: '@alen_solution', // Ganti dengan variabel username Anda (contoh: user.username)
            ),
            const SizedBox(height: 12),

            // Card Email
            _buildProfileItem(
              icon: Icons.email_outlined,
              label: 'Email',
              value: email, // <-- Menggunakan variabel email
            ),
            const SizedBox(height: 12),

            // Card Nomor Telepon
            _buildProfileItem(
              icon: Icons.phone_outlined,
              label: 'Nomor Telepon',
              value: nomorTelepon, // <-- Menggunakan variabel nomorTelepon
            ),
            const SizedBox(height: 30),

            // Tombol Keluar / Masuk
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.logout),
                label: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget untuk membuat tampilan list item profil
  Widget _buildProfileItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
