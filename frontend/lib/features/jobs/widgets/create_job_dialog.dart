import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';

import '../../../core/theme/app_spacing.dart';

class CreateJobDialog extends StatefulWidget {
  final Future<void> Function({
    required String company,
    required String position,
    required String location,
    required String status,
  })
  onCreate;

  const CreateJobDialog({super.key, required this.onCreate});

  @override
  State<CreateJobDialog> createState() => _CreateJobDialogState();
}

class _CreateJobDialogState extends State<CreateJobDialog> {
  final companyController = TextEditingController();

  final positionController = TextEditingController();

  final locationController = TextEditingController();

  String selectedStatus = "wishlist";

  bool isLoading = false;

  Future<void> handleCreate() async {
    if (companyController.text.isEmpty ||
        positionController.text.isEmpty ||
        locationController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Please fill all fields")));

      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      await widget.onCreate(
        company: companyController.text,

        position: positionController.text,

        location: locationController.text,

        status: selectedStatus,
      );

      if (!mounted) return;

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.sidebar,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),

      child: Container(
        width: 500,

        padding: const EdgeInsets.all(AppSpacing.xl),

        child: Column(
          mainAxisSize: MainAxisSize.min,

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            const Text(
              "Create Job",

              style: TextStyle(
                color: Colors.white,

                fontSize: 28,

                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: AppSpacing.xl),

            buildInput("Company", companyController),

            const SizedBox(height: AppSpacing.lg),

            buildInput("Position", positionController),

            const SizedBox(height: AppSpacing.lg),

            buildInput("Location", locationController),

            const SizedBox(height: AppSpacing.lg),

            DropdownButtonFormField(
              value: selectedStatus,

              dropdownColor: AppColors.card,

              style: const TextStyle(color: Colors.white),

              decoration: inputDecoration(),

              items: const [
                DropdownMenuItem(value: "wishlist", child: Text("Wishlist")),

                DropdownMenuItem(value: "applied", child: Text("Applied")),

                DropdownMenuItem(
                  value: "interviewing",
                  child: Text("Interviewing"),
                ),

                DropdownMenuItem(value: "offer", child: Text("Offer")),
              ],

              onChanged: (value) {
                setState(() {
                  selectedStatus = value!;
                });
              },
            ),

            const SizedBox(height: AppSpacing.xl),

            SizedBox(
              width: double.infinity,

              child: ElevatedButton(
                onPressed: isLoading ? null : handleCreate,

                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,

                  padding: const EdgeInsets.symmetric(vertical: 18),

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),

                child: isLoading
                    ? const SizedBox(
                        width: 24,
                        height: 24,

                        child: CircularProgressIndicator(color: Colors.white),
                      )
                    : const Text(
                        "Create Job",

                        style: TextStyle(
                          color: Colors.white,

                          fontSize: 16,

                          fontWeight: FontWeight.bold,
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildInput(String label, TextEditingController controller) {
    return TextField(
      controller: controller,

      style: const TextStyle(color: Colors.white),

      decoration: inputDecoration(label: label),
    );
  }

  InputDecoration inputDecoration({String? label}) {
    return InputDecoration(
      labelText: label,

      labelStyle: const TextStyle(color: AppColors.textSecondary),

      filled: true,

      fillColor: AppColors.card,

      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),

        borderSide: BorderSide.none,
      ),
    );
  }
}
