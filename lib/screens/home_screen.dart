import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/link_provider.dart';
import '../widgets/link_card.dart';
import '../widgets/add_link_dialog.dart';
import '../widgets/edit_link_dialog.dart';
import '../widgets/delete_dialog.dart';
import '../utils/constants.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

Future<void> _openUrl(String url, BuildContext context) async {
  final Uri uri = Uri.parse(
    url.startsWith('http') ? url : 'https://$url',
  );

  await launchUrl(
    uri,
    mode: LaunchMode.externalApplication,
  );
}

  void _showAddLinkDialog(BuildContext context) async {
    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => const AddLinkDialog(),
    );

    if (result != null && context.mounted) {
      final provider = Provider.of<LinkProvider>(context, listen: false);
      final success = await provider.addLink(result['name']!, result['url']!);

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(AppStrings.linkAdded),
            backgroundColor: Colors.green,
            duration: AppDurations.snackbarDuration,
          ),
        );
      }
    }
  }

  void _showEditLinkDialog(BuildContext context, String linkId) async {
    final provider = Provider.of<LinkProvider>(context, listen: false);
    final link = provider.links.firstWhere((l) => l.id == linkId);

    final result = await showDialog<Map<String, String>>(
      context: context,
      builder: (context) => EditLinkDialog(link: link),
    );

    if (result != null && context.mounted) {
      final success = await provider.updateLink(
        linkId,
        result['name']!,
        result['url']!,
      );

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(AppStrings.linkUpdated),
            backgroundColor: Colors.green,
            duration: AppDurations.snackbarDuration,
          ),
        );
      }
    }
  }

  void _showDeleteDialog(BuildContext context, String linkId) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => const DeleteDialog(),
    );

    if (result == true && context.mounted) {
      final provider = Provider.of<LinkProvider>(context, listen: false);
      final success = await provider.deleteLink(linkId);

      if (success && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(AppStrings.linkDeleted),
            backgroundColor: Colors.orange,
            duration: AppDurations.snackbarDuration,
          ),
        );
      }
    }
  }

  void _showOptionsMenu(BuildContext context, String linkId) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 8),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              ListTile(
                leading: Icon(Icons.edit, color: AppColors.primary),
                title: const Text(AppStrings.editLink),
                onTap: () {
                  Navigator.pop(context);
                  _showEditLinkDialog(context, linkId);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: AppColors.error),
                title: const Text(AppStrings.delete),
                onTap: () {
                  Navigator.pop(context);
                  _showDeleteDialog(context, linkId);
                },
              ),
              const SizedBox(height: 8),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Consumer<LinkProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primary),
                );
              }

              if (provider.links.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.link_off, size: 80, color: Colors.grey[400]),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.noLinksYet,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                );
              }

              return Padding(
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: provider.links.length,
                  itemBuilder: (context, index) {
                    final link = provider.links[index];
                    return LinkCard(
                      link: link,
                      onTap: () => _openUrl(link.url, context),
                      onLongPress: () => _showOptionsMenu(context, link.id),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddLinkDialog(context),
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
