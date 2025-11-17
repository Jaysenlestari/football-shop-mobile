import 'package:flutter/material.dart';
import 'package:football_shop/widgets/left_drawer.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:pbp_django_auth/pbp_django_auth.dart';
import 'package:football_shop/screens/menu.dart';
import 'package:football_shop/theme/app_theme.dart';

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
    final request = context.watch<CookieRequest>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Tambah Produk Baru'),
      ),
      drawer: const LeftDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 650),
            child: Card(
              color: AppColors.surface,
              elevation: 12,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: const BorderSide(color: AppColors.border),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        "Create New Product",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        "Lengkapi detail perlengkapan sepak bola kamu.",
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                      const SizedBox(height: 24),
                      _buildTextField(
                        label: "Nama Produk",
                        hint: "Masukkan nama produk",
                        onChanged: (val) => _name = val!,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Nama tidak boleh kosong!";
                          }
                          if (val.length < 3) {
                            return "Nama minimal 3 karakter!";
                          }
                          return null;
                        },
                      ),
                      _buildNumberField(
                        label: "Harga Produk",
                        hint: "Masukkan harga (Rp)",
                        onChanged: (val) => _price = int.tryParse(val!) ?? 0,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Harga wajib diisi!";
                          }
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
                          if (val == null || val.isEmpty) {
                            return "Brand wajib diisi!";
                          }
                          return null;
                        },
                      ),
                      _buildTextField(
                        label: "Deskripsi Produk",
                        hint: "Masukkan deskripsi produk",
                        maxLines: 4,
                        onChanged: (val) => _description = val!,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Deskripsi wajib diisi!";
                          }
                          if (val.length < 10) {
                            return "Deskripsi minimal 10 karakter!";
                          }
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
                          if (val == null || val.isEmpty) {
                            return "URL thumbnail wajib diisi!";
                          }
                          if (!Uri.parse(val).isAbsolute) {
                            return "Masukkan URL yang valid!";
                          }
                          return null;
                        },
                      ),
                      _buildNumberField(
                        label: "Stok",
                        hint: "Masukkan jumlah stok",
                        onChanged: (val) => _stock = int.tryParse(val!) ?? 0,
                        validator: (val) {
                          if (val == null || val.isEmpty) {
                            return "Stok wajib diisi!";
                          }
                          final num? s = num.tryParse(val);
                          if (s == null || s < 0) return "Stok tidak valid!";
                          return null;
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: SwitchListTile(
                          contentPadding: EdgeInsets.zero,
                          activeColor: AppColors.primary,
                          title: const Text(
                            "Tandai sebagai Produk Unggulan",
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                          subtitle: const Text(
                            "Produk akan ditampilkan sebagai highlight.",
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                          value: _isFeatured,
                          onChanged: (value) {
                            setState(() => _isFeatured = value);
                          },
                        ),
                      ),
                      const SizedBox(height: 18),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            final response = await request.postJson(
                              "http://localhost:8000/create-flutter/",
                              jsonEncode({
                                "name": _name,
                                "price": _price,
                                "brand": _brand,
                                "description": _description,
                                "thumbnail": _thumbnail,
                                "category": _category,
                                "stock": _stock,
                                "clothes_size": _clothesSize,
                                "shoe_size": _shoeSize,
                                "is_featured": _isFeatured,
                              }),
                            );

                            if (context.mounted) {
                              if (response['status'] == 'success') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Product saved!"),
                                  ),
                                );
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MyHomePage(),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      response['message'] ??
                                          "Something went wrong, please try again.",
                                    ),
                                  ),
                                );
                              }
                            }
                          }
                        },
                        child: const Text("Save"),
                      ),
                    ],
                  ),
                ),
              ),
            ),
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
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
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        keyboardType: TextInputType.number,
        style: const TextStyle(color: AppColors.textPrimary),
        decoration: InputDecoration(
          hintText: hint,
          labelText: label,
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  Padding _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required Function(String?) onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        dropdownColor: AppColors.card,
        decoration: InputDecoration(
          labelText: label,
        ),
        value: value,
        hint: Text(
          "Pilih $label",
          style: const TextStyle(color: AppColors.textSecondary),
        ),
        items: items
            .map(
              (item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
