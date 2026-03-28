import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/link_model.dart';
import '../services/storage_service.dart';

class LinkProvider extends ChangeNotifier {
  final StorageService _storageService = StorageService();
  final Uuid _uuid = const Uuid();

  List<LinkModel> _links = [];
  bool _isLoading = true;

  // Getter for links
  List<LinkModel> get links => _links;

  // Getter for loading state
  bool get isLoading => _isLoading;

  // Initialize provider and load links from storage
  Future<void> loadLinks() async {
    _isLoading = true;
    notifyListeners();

    _links = await _storageService.getLinks();

    _isLoading = false;
    notifyListeners();
  }

  // Add a new link
  Future<bool> addLink(String name, String url) async {
    final link = LinkModel(
      id: _uuid.v4(),
      name: name,
      url: _normalizeUrl(url),
      createdAt: DateTime.now(),
    );

    final success = await _storageService.addLink(link);

    if (success) {
      _links.add(link);
      notifyListeners();
    }

    return success;
  }

  // Update an existing link
  Future<bool> updateLink(String id, String name, String url) async {
    final index = _links.indexWhere((link) => link.id == id);

    if (index != -1) {
      final updatedLink = _links[index].copyWith(
        name: name,
        url: _normalizeUrl(url),
      );

      final success = await _storageService.updateLink(updatedLink);

      if (success) {
        _links[index] = updatedLink;
        notifyListeners();
      }

      return success;
    }

    return false;
  }

  // Delete a link by ID
  Future<bool> deleteLink(String id) async {
    final success = await _storageService.deleteLink(id);

    if (success) {
      _links.removeWhere((link) => link.id == id);
      notifyListeners();
    }

    return success;
  }

  // Clear all links
  Future<bool> clearAllLinks() async {
    final success = await _storageService.clearAllLinks();

    if (success) {
      _links.clear();
      notifyListeners();
    }

    return success;
  }

  // Normalize URL to ensure it has proper format
  String _normalizeUrl(String url) {
    String normalizedUrl = url.trim();

    if (!normalizedUrl.startsWith('http://') &&
        !normalizedUrl.startsWith('https://')) {
      normalizedUrl = 'https://$normalizedUrl';
    }

    return normalizedUrl;
  }
}
