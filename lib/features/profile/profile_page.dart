import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:plotify/core/constatns/constants.dart';
import 'package:plotify/features/profile/widget/profile_option_item.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _image = File(picked.path);
      });
    }
  }

  void _showSnackbar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        duration: Duration(milliseconds: 1500),
        backgroundColor: Theme.of(context).colorScheme.onSurface,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Gap(82),
              Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : NetworkImage(
                            "https://www.jowhareh.com/images/Jowhareh/galleries_2/poster_c6e8ddff-e9f1-4a02-b9c4-4d08739bb239.jpeg",
                          ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(50),
                          border: BoxBorder.all(
                            color: AppColors.primary,
                            width: 4,
                          ),
                        ),
                        child: Icon(
                          Icons.edit_rounded,
                          size: 15,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(16),
              Text("Shervin Kazemian", style: theme.textTheme.titleMedium),
              const Gap(8),
              Text(
                "shervink.codes@gmail.com",
                style: theme.textTheme.titleSmall!.copyWith(
                  color: Colors.grey,
                ),
              ),
              const Gap(32),
              ProfileOptionItem(
                title: "Edit Profile",
                icon: Icons.person_outline,
                onTap: () =>
                    _showSnackbar(context, "Edit Your Profile"),
              ),
              ProfileOptionItem(
                title: "Notifications",
                icon: Icons.notifications_outlined,
                onTap: () => _showSnackbar(context, "See your notifications"),
              ),
              ProfileOptionItem(
                title: "Watchlist",
                icon: Icons.schedule_rounded,
                onTap: () =>
                    _showSnackbar(context, "See your watchlist"),
              ),
              ProfileOptionItem(
                title: "Settings",
                icon: Icons.settings_outlined,
                onTap: () => _showSnackbar(context, "Settings"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
