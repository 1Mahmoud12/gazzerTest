class ShareGenerateRequest {
  final String type; // vendor, store_items, restaurant_plates, restaurant_items, offer, cart
  final String shareableType; // vendor, store_items, restaurant_plates, restaurant_items, offer
  final String shareableId;
  final String channel; // copy_link, etc.

  ShareGenerateRequest({required this.type, required this.shareableType, required this.shareableId, this.channel = 'copy_link'});

  Map<String, dynamic> toJson() => {
    'type': type,
    'shareable_type': shareableType,
    if (shareableId != '') 'shareable_id': shareableId,
    'channel': channel,
  };
}

class SharePreview {
  final String? title;
  final String? description;
  final String? image;

  SharePreview({this.title, this.description, this.image});

  factory SharePreview.fromJson(Map<String, dynamic> json) =>
      SharePreview(title: json['title']?.toString(), description: json['description']?.toString(), image: json['image']?.toString());
}

class ShareGenerateResponse {
  final bool success;
  final String token;
  final String shareLink;
  final String expiresAt;
  final SharePreview preview;

  ShareGenerateResponse({required this.success, required this.token, required this.shareLink, required this.expiresAt, required this.preview});

  factory ShareGenerateResponse.fromJson(Map<String, dynamic> json) => ShareGenerateResponse(
    success: json['success'] as bool? ?? false,
    token: json['token']?.toString() ?? '',
    shareLink: json['share_link']?.toString() ?? '',
    expiresAt: json['expires_at']?.toString() ?? '',
    preview: SharePreview.fromJson(json['preview'] as Map<String, dynamic>? ?? {}),
  );
}

class ShareOpenData {
  final int? id;
  final String? type;
  final int? itemId;
  final int? storeId;
  final String? itemName;

  ShareOpenData({this.id, this.type, this.itemId, this.storeId, this.itemName});

  factory ShareOpenData.fromJson(Map<String, dynamic> json) => ShareOpenData(
    id: json['id'] as int?,
    type: json['type']?.toString(),
    itemId: json['item_id'] as int?,
    storeId: json['store_id'] as int?,
    itemName: json['item_name']?.toString(),
  );
}

class ShareOpenResponse {
  final bool success;
  final String shareType; // store_items, vendor, restaurant_plates, etc.
  final int shareableId;
  final String shareableType;
  final String storeCategoryType;
  final ShareOpenData data;
  final bool requiresLogin;

  ShareOpenResponse({
    required this.success,
    required this.shareType,
    required this.storeCategoryType,
    required this.shareableId,
    required this.shareableType,
    required this.data,
    required this.requiresLogin,
  });

  factory ShareOpenResponse.fromJson(Map<String, dynamic> json) => ShareOpenResponse(
    success: json['success'] as bool? ?? false,
    shareType: json['share_type']?.toString() ?? '',
    shareableId: json['shareable_id'] as int? ?? 0,
    shareableType: json['shareable_type']?.toString() ?? '',
    storeCategoryType: json['store_category_type']?.toString() ?? '',
    data: ShareOpenData.fromJson(json['data'] as Map<String, dynamic>? ?? {}),
    requiresLogin: json['requires_login'] as bool? ?? false,
  );
}
