import 'package:flutter/material.dart';

class SimplePrivacyPolicy extends StatelessWidget {
  const SimplePrivacyPolicy({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            Center(
              child: Text(
                'FOODDELIGHT PRIVACY POLICY',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 20),
            Divider(color: colors.outline),
            const SizedBox(height: 20),

            Text(
              'Last Updated: December 5, 2023',
              style: theme.textTheme.bodySmall?.copyWith(
                color: colors.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 30),

            _buildSection(
              context,
              '1. Information We Collect',
              '''
We collect the following information when you use our app:
- Name and contact details
- Delivery address
- Order history
- Payment information (processed securely)
- Device information for app functionality
''',
            ),

            const SizedBox(height: 25),

            _buildSection(
              context,
              '2. How We Use Your Information',
              '''
Your information is used for:
- Processing your food orders
- Delivering orders to your address
- Customer support
- Improving our services
- Sending order updates (if you opt-in)
''',
            ),

            const SizedBox(height: 25),

            _buildSection(
              context,
              '3. Data Sharing',
              '''
We may share your information with:
- Restaurants to prepare your orders
- Delivery partners for order delivery
- Payment processors for transactions
- Legal authorities if required by law

We do NOT sell your personal data.
''',
            ),

            const SizedBox(height: 25),

            _buildSection(
              context,
              '4. Data Security',
              '''
We take reasonable measures to protect your data:
- Secure payment processing
- Encrypted data transmission
- Limited access to personal information
- Regular security updates
''',
            ),

            const SizedBox(height: 25),

            _buildSection(
              context,
              '5. Your Rights',
              '''
You have the right to:
- Access your personal data
- Correct inaccurate information
- Delete your account
- Opt-out of marketing emails
- Export your data
''',
            ),

            const SizedBox(height: 25),

            _buildSection(
              context,
              '6. Contact Us',
              '''
For privacy-related questions:
Email: privacy@fooddelight.com
Phone: +92 300 123 4567

Address: FoodDelight HQ, Karachi, Pakistan
''',
            ),

            const SizedBox(height: 25),

            _buildSection(
              context,
              '7. Policy Changes',
              '''
We may update this policy periodically.
Continued use of our app means you accept
the updated policy.
''',
            ),

            const SizedBox(height: 40),

            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: colors.surfaceVariant,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'By using FoodDelight app, you agree to this Privacy Policy.',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        child: const Icon(Icons.arrow_back),
      ),
    );
  }

  Widget _buildSection(
      BuildContext context,
      String title,
      String content,
      ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: colors.primary,
          ),
        ),

        const SizedBox(height: 8),

        Text(
          content,
          style: theme.textTheme.bodyMedium?.copyWith(
            height: 1.5,
          ),
        ),
      ],
    );
  }
}
