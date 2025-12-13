import 'package:flutter/material.dart';
import 'package:mid_project/main.dart';
import 'package:mid_project/privacy_policy.dart';
import 'package:mid_project/screen/dark_theme.dart';
import 'package:mid_project/services/auth_service.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final AuthService _authService = AuthService();

  String userName = 'User';
  String userEmail = '';
  String profileImage = '';
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    try {
      final user = _authService.currentUser;
      if (user != null) {
        userName = user.displayName ?? 'User';
        userEmail = user.email ?? '';
        profileImage = user.photoURL ?? '';

        final userData = await _authService.getUserData(user.uid);
        if (userData != null) {
          userName = userData['name'] ?? userName;
          userEmail = userData['email'] ?? userEmail;
          profileImage = userData['profileImage'] ?? profileImage;
        }
      }
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> _logout() async {
    final colors = Theme.of(context).colorScheme;

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);

              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => Center(
                  child: CircularProgressIndicator(color: colors.primary),
                ),
              );

              await _authService.signOut();

              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const GetStarted()),
                    (_) => false,
              );
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),

      body: isLoading
          ? Center(
        child: CircularProgressIndicator(color: colors.primary),
      )
          : SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            // Profile Card
            _card(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: colors.primary.withOpacity(0.1),
                    backgroundImage:
                    profileImage.isNotEmpty ? NetworkImage(profileImage) : null,
                    child: profileImage.isEmpty
                        ? Icon(Icons.person, size: 50, color: colors.primary)
                        : null,
                  ),
                  const SizedBox(height: 15),
                  Text(
                    userName,
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    userEmail,
                    style: theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Settings Card
            _card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),

                  _settingTile(
                    icon: Icons.privacy_tip,
                    title: 'Privacy Policy',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const SimplePrivacyPolicy(),
                      ),
                    ),
                    color: colors.primary,
                  ),

                  const Divider(),

                  _settingTile(
                    icon: Icons.dark_mode,
                    title: 'Theme Settings',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => const ThemeSettings(),
                      ),
                    ),
                    color: colors.secondary,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Logout Card
            _card(
              child: ListTile(
                leading: Icon(Icons.logout, color: colors.error),
                title: Text(
                  'Log Out',
                  style: TextStyle(
                    color: colors.error,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 16),
                onTap: _logout,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _card({required Widget child}) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outline),
        boxShadow: [
          BoxShadow(
            color: colors.shadow.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }

  Widget _settingTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    required Color color,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: color),
      ),
      title: Text(title),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }
}
