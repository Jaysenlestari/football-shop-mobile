import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = "";
  int _price = 0;
  String _brand = "";
  String _description = "";
  String _thumbnail = "";
  String _category = "jersey";
  int _stock = 0;
  String? _clothesSize;
  String? _shoeSize;
  bool _isFeatured = false;

  final List<String> _categories = [
    'jersey',
    'shoes',
    'socks',
    'accessories',
  ];

  final List<String> _clothesSizes = ['S', 'M', 'L', 'XL'];
  final List<String> _shoeSizes = ['38', '39', '40', '41', '42', '43'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Tambah Produk Baru')),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      drawer: const LeftDrawer(),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTextField(
                label: "Nama Produk",
                hint: "Masukkan nama produk",
                onChanged: (val) => _name = val!,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Nama tidak boleh kosong!";
                  if (val.length < 3) return "Nama minimal 3 karakter!";
                  return null;
                },
              ),
              _buildNumberField(
                label: "Harga Produk",
                hint: "Masukkan harga (Rp)",
                onChanged: (val) => _price = int.tryParse(val!) ?? 0,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Harga wajib diisi!";
                  final num? p = num.tryParse(val);
                  if (p == null || p < 0) return "Harga tidak valid!";
                  return null;
                },
              ),
              _buildTextField(
                label: "Brand",
                hint: "Masukkan brand produk",
                onChanged: (val) => _brand = val!,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Brand wajib diisi!";
                  return null;
                },
              ),
              _buildTextField(
                label: "Deskripsi Produk",
                hint: "Masukkan deskripsi produk",
                maxLines: 4,
                onChanged: (val) => _description = val!,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Deskripsi wajib diisi!";
                  if (val.length < 10) return "Deskripsi minimal 10 karakter!";
                  return null;
                },
              ),
              _buildDropdown(
                label: "Kategori",
                value: _category,
                items: _categories,
                onChanged: (val) => setState(() => _category = val!),
              ),
              if (_category == "jersey")
                _buildDropdown(
                  label: "Ukuran Baju",
                  value: _clothesSize,
                  items: _clothesSizes,
                  onChanged: (val) => setState(() => _clothesSize = val),
                ),
              if (_category == "shoes")
                _buildDropdown(
                  label: "Ukuran Sepatu",
                  value: _shoeSize,
                  items: _shoeSizes,
                  onChanged: (val) => setState(() => _shoeSize = val),
                ),
              _buildTextField(
                label: "URL Thumbnail",
                hint: "https://example.com/image.jpg",
                onChanged: (val) => _thumbnail = val!,
                validator: (val) {
                  if (val == null || val.isEmpty) return "URL thumbnail wajib diisi!";
                  if (!Uri.parse(val).isAbsolute) return "Masukkan URL yang valid!";
                  return null;
                },
              ),
              _buildNumberField(
                label: "Stok",
                hint: "Masukkan jumlah stok",
                onChanged: (val) => _stock = int.tryParse(val!) ?? 0,
                validator: (val) {
                  if (val == null || val.isEmpty) return "Stok wajib diisi!";
                  final num? s = num.tryParse(val);
                  if (s == null || s < 0) return "Stok tidak valid!";
                  return null;
                },
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SwitchListTile(
                  title: const Text("Tandai sebagai Produk Unggulan"),
                  value: _isFeatured,
                  onChanged: (bool value) {
                    setState(() => _isFeatured = value);
                  },
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.indigo),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: const Text('Produk berhasil disimpan!'),
                              content: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text('Nama: $_name'),
                                    Text('Harga: $_price'),
                                    Text('Brand: $_brand'),
                                    Text('Deskripsi: $_description'),
                                    Text('Kategori: $_category'),
                                    if (_clothesSize != null)
                                      Text('Ukuran Baju: $_clothesSize'),
                                    if (_shoeSize != null)
                                      Text('Ukuran Sepatu: $_shoeSize'),
                                    Text('Thumbnail: $_thumbnail'),
                                    Text('Stok: $_stock'),
                                    Text('Unggulan: ${_isFeatured ? "Ya" : "Tidak"}'),
                                  ],
                                ),
                              ),
                              actions: [
                                TextButton(
                                  child: const Text('OK'),
                                  onPressed: () {
                                    Navigator.pop(context);
                                    _formKey.currentState!.reset();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Save",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildTextField({
    required String label,
    required String hint,
    int maxLines = 1,
    required Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
        maxLines: maxLines,
      ),
    );
  }

  Padding _buildNumberField({
    required String label,
    required String hint,
    required Function(String?) onChanged,
    required String? Function(String?) validator,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Padding _buildDropdown({
    required String label,
    required dynamic value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButtonFormField<String>(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        value: value,
        items: items
            .map((item) => DropdownMenuItem(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
