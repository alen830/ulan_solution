import 'package:flutter/material.dart';

class DaftarHadirPage extends StatefulWidget {
  const DaftarHadirPage({super.key});

  @override
  State<DaftarHadirPage> createState() => _DaftarHadirPageState();
}

class _DaftarHadirPageState extends State<DaftarHadirPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _keteranganController = TextEditingController();

  String _statusKehadiran = 'Hadir';

  // Daftar sampel riwayat hadir
  final List<Map<String, String>> _riwayatHadir = [
    {
      'nama': 'Ahmad',
      'status': 'Hadir',
      'waktu': '08:00 WIB',
      'keterangan': 'Tepat waktu',
    },
    {
      'nama': 'Siti',
      'status': 'Izin',
      'waktu': '08:15 WIB',
      'keterangan': 'Acara keluarga',
    },
  ];

  void _simpanKehadiran() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _riwayatHadir.add({
          'nama': _namaController.text,
          'status': _statusKehadiran,
          'waktu': '${TimeOfDay.now().format(context)}',
          'keterangan': _keteranganController.text.isEmpty
              ? '-'
              : _keteranganController.text,
        });
      });

      _namaController.clear();
      _keteranganController.clear();

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Daftar hadir berhasil disimpan!'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Hadir'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Card Form Presensi
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'ABSEN PEGAWAI',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _namaController,
                        decoration: const InputDecoration(
                          labelText: 'Nama Lengkap',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama tidak boleh kosong';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      DropdownButtonFormField<String>(
                        value: _statusKehadiran,
                        decoration: const InputDecoration(
                          labelText: 'Status Kehadiran',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.check_circle_outline),
                        ),
                        items: ['Hadir', 'Izin', 'Sakit', 'Alfa']
                            .map(
                              (status) => DropdownMenuItem(
                                value: status,
                                child: Text(status),
                              ),
                            )
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _statusKehadiran = value!;
                          });
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _keteranganController,
                        decoration: const InputDecoration(
                          labelText: 'Keterangan (Opsional)',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.note),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        width: double.infinity,
                        height: 45,
                        child: ElevatedButton(
                          onPressed: _simpanKehadiran,
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'Kirim',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'Riwayat Kehadiran',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            // List Riwayat Kehadiran
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: _riwayatHadir.length,
              itemBuilder: (context, index) {
                final item = _riwayatHadir[index];
                Color statusColor;

                switch (item['status']) {
                  case 'Hadir':
                    statusColor = Colors.green;
                    break;
                  case 'Izin':
                    statusColor = Colors.orange;
                    break;
                  case 'Sakit':
                    statusColor = Colors.blue;
                    break;
                  default:
                    statusColor = Colors.red;
                }

                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: statusColor.withOpacity(0.2),
                      child: Icon(
                        item['status'] == 'Hadir'
                            ? Icons.check
                            : Icons.info_outline,
                        color: statusColor,
                      ),
                    ),
                    title: Text(
                      item['nama'] ?? '',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Status: ${item['status']} | Ket: ${item['keterangan']}',
                    ),
                    trailing: Text(
                      item['waktu'] ?? '',
                      style: const TextStyle(color: Colors.grey, fontSize: 12),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _keteranganController.dispose();
    super.dispose();
  }
}
