class Post {
  final int id;
  final String userName;
  final String venueName;
  final String location;
  final String time;
  final bool isVerified;
  final bool hasPromo;
  final String? promoText;
  final String? imageSource;
  final String? profileImage;
  final String likes;
  final String comments;
  final String shares;
  final bool isVenue;
  final String? caption;
  final String? eventTitle;
  final String? eventDate;
  final bool hasFoodTag;
  final List<String>? multipleImages;

  const Post({
    required this.id,
    required this.userName,
    required this.venueName,
    required this.location,
    required this.time,
    required this.isVerified,
    required this.hasPromo,
    this.promoText,
    this.imageSource,
    this.profileImage,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.isVenue,
    this.caption,
    this.eventTitle,
    this.eventDate,
    this.hasFoodTag = false,
    this.multipleImages,
  });

  Post copyWith({
    int? id,
    String? userName,
    String? venueName,
    String? location,
    String? time,
    bool? isVerified,
    bool? hasPromo,
    String? promoText,
    String? imageSource,
    String? profileImage,
    String? likes,
    String? comments,
    String? shares,
    bool? isVenue,
    String? caption,
    String? eventTitle,
    String? eventDate,
    bool? hasFoodTag,
    List<String>? multipleImages,
  }) {
    return Post(
      id: id ?? this.id,
      userName: userName ?? this.userName,
      venueName: venueName ?? this.venueName,
      location: location ?? this.location,
      time: time ?? this.time,
      isVerified: isVerified ?? this.isVerified,
      hasPromo: hasPromo ?? this.hasPromo,
      promoText: promoText ?? this.promoText,
      imageSource: imageSource ?? this.imageSource,
      profileImage: profileImage ?? this.profileImage,
      likes: likes ?? this.likes,
      comments: comments ?? this.comments,
      shares: shares ?? this.shares,
      isVenue: isVenue ?? this.isVenue,
      caption: caption ?? this.caption,
      eventTitle: eventTitle ?? this.eventTitle,
      eventDate: eventDate ?? this.eventDate,
      hasFoodTag: hasFoodTag ?? this.hasFoodTag,
      multipleImages: multipleImages ?? this.multipleImages,
    );
  }
}

