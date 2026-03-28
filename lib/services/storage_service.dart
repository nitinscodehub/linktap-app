import 'package:shared_preferences/shared_preferences.dart';
import '../models/link_model.dart';

class StorageService {
  static const String _linksKey = 'saved_links';

  // Get all saved links from local storage
  Future<List<LinkModel>> getLinks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? linksJson = prefs.getString(_linksKey);

    if (linksJson == null || linksJson.isEmpty) {
      return [];
    }

    return LinkModel.decodeList(linksJson);
  }

  // Save all links to local storage
  Future<bool> saveLinks(List<LinkModel> links) async {
    final prefs = await SharedPreferences.getInstance();
    final String linksJson = LinkModel.encodeList(links);
    return prefs.setString(_linksKey, linksJson);
  }

  // Add a single link
  Future<bool> addLink(LinkModel link) async {
    final links = await getLinks();
    links.add(link);
    return saveLinks(links);
  }

  // Update an existing link
  Future<bool> updateLink(LinkModel updatedLink) async {
    final links = await getLinks();
    final index = links.indexWhere((link) => link.id == updatedLink.id);

    if (index != -1) {
      links[index] = updatedLink;
      return saveLinks(links);
    }
    return false;
  }

  // Delete a link by ID
  Future<bool> deleteLink(String linkId) async {
    final links = await getLinks();
    links.removeWhere((link) => link.id == linkId);
    return saveLinks(links);
  }

  // Clear all links
  Future<bool> clearAllLinks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(_linksKey);
  }
}
