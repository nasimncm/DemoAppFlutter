import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:share_plus/share_plus.dart';
import 'constants/fonts.dart';

class _ProfileImageWithFallback extends StatefulWidget {
  final String pngPath;
  final String svgPath;
  final double width;
  final double height;
  final BoxFit fit;
  final Widget placeholder;

  const _ProfileImageWithFallback({
    required this.pngPath,
    required this.svgPath,
    required this.width,
    required this.height,
    required this.fit,
    required this.placeholder,
  });

  @override
  State<_ProfileImageWithFallback> createState() => _ProfileImageWithFallbackState();
}

class _ProfileImageWithFallbackState extends State<_ProfileImageWithFallback> {
  bool _pngFailed = false;

  @override
  Widget build(BuildContext context) {
    if (_pngFailed) {
      return SvgPicture.asset(
        widget.svgPath,
        width: widget.width,
        height: widget.height,
        fit: widget.fit,
        placeholderBuilder: (context) => widget.placeholder,
        semanticsLabel: widget.svgPath,
      );
    }

    return Image.asset(
      widget.pngPath,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      errorBuilder: (context, error, stackTrace) {
        if (!_pngFailed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {
                _pngFailed = true;
              });
            }
          });
        }
        return SvgPicture.asset(
          widget.svgPath,
          width: widget.width,
          height: widget.height,
          fit: widget.fit,
          placeholderBuilder: (context) => widget.placeholder,
          semanticsLabel: widget.svgPath,
        );
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
    
    return MaterialApp(
      title: 'Demo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

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

  Post({
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
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  static const String _location = 'Vasant Kunj';
  static const String _locationSubtext = 'Vasant Kunj Comes Under..';
  static const String _assetsPath = 'assets/images';
  static const Duration _animationDuration = Duration(milliseconds: 300);
  static const double _imageHeight = 500.0;
  static const double _profileImageSize = 48.0;
  static const double _iconSize = 24.0;
  static const double _sidebarWidth = 50.0;
  static const Color _backgroundColor = Color(0xFFE4E8D0);
  static const Color _postBackgroundColor = Color(0xFFECEDDF);
  static const Color _textPrimary = Color(0xFF1A1A1A);
  static const Color _textSecondary = Color(0xFF4A4A4A);
  static const Color _textTertiary = Color(0xFF9B9B9B);
  static const Color _promoColor = Color(0xFFCCEE29);
  static const Color _reserveColor = Color(0xFF7464E4);
  static const Color _followColor = Color(0xFF8B5CF6);
  static const Color _foodTagColor = Color(0xFF4CAF50);

  final Map<int, int> slideIndices = {};
  final Map<int, PageController> _pageControllers = {};
  final Map<int, bool> _likedPosts = {};
  final Map<int, bool> _bookmarkedPosts = {};
  final Map<int, bool> _starredPosts = {};
  final Map<int, AnimationController> _heartAnimationControllers = {};
  final Map<int, AnimationController> _bookmarkAnimationControllers = {};
  final Map<int, AnimationController> _starAnimationControllers = {};

  final List<Post> posts = [
    Post(
      id: 3,
      userName: 'Zeeshan Ahmad',
      venueName: 'Zeeshan Ahmad',
      location: 'Check in',
      time: '22 h',
      isVerified: true,
      hasPromo: false,
      imageSource: 'party-video',
      profileImage: 'zeeshan',
      likes: '100k',
      comments: '250',
      shares: '100k',
      isVenue: false,
      caption:
          "As we celebrate you today my love, I'm reminiscing, each of the wonderful September 16th's I've been so lucky to spend...",
    ),
    Post(
      id: 1,
      userName: 'User Name',
      venueName: 'The Dark Room',
      location: 'Sapphire Plaza, Greater Noida, 0 Kms',
      time: '22 h',
      isVerified: true,
      hasPromo: true,
      promoText: 'Add On up to 50% Extra on Food & Beverages',
      imageSource: 'party',
      likes: '100k',
      comments: '250',
      shares: '100k',
      isVenue: true,
      eventTitle: 'The Live Edit Connaught Club House 25 July 2025',
      eventDate: '12 Oct25, 8:00 PM - 11:30 PM',
    ),
    Post(
      id: 2,
      userName: 'User Name',
      venueName: 'The Dark Room',
      location: 'Sapphire Plaza, Greater Noida, 0 Kms',
      time: '22 h',
      isVerified: true,
      hasPromo: true,
      promoText: 'Add On up to 50% Extra on Food & Beverages',
      imageSource: 'last-image',
      eventTitle: 'The Live Edit Connaught Club House 25 July 2025',
      eventDate: '12 Oct25, 8:00 PM - 11:30 PM',
      likes: '100k',
      comments: '250',
      shares: '100k',
      isVenue: true,
      hasFoodTag: true,
    ),
    Post(
      id: 4,
      userName: 'Partywitty',
      venueName: 'Partywitty',
      location: 'Sapphire Plaza, Greater Noida, 0 Kms',
      time: '22 h',
      isVerified: true,
      hasPromo: false,
      imageSource: 'group',
      profileImage: 'app-icon',
      likes: '100k',
      comments: '250',
      shares: '100k',
      isVenue: true,
      eventTitle: 'The Live Edit Connaught Club House 25 July 2025',
      eventDate: '12 Oct25, 8:00 PM - 11:30 PM',
    ),
    Post(
      id: 5,
      userName: 'Zeeshan Ahmad',
      venueName: 'Zeeshan Ahmad',
      location: 'Check in',
      time: '22 h',
      isVerified: true,
      hasPromo: false,
      profileImage: 'zeeshan',
      multipleImages: ['party-2', 'party', 'group', 'party-video'],
      likes: '100k',
      comments: '250',
      shares: '100k',
      isVenue: false,
      caption:
          "As we celebrate you today my love, I'm reminiscing, each of the wonderful September 16th's I've been so lucky to spend...",
    ),
  ];

  Widget _getDummyImage(String? imageName) {
    if (imageName == null) {
      return Container(
        color: Colors.grey[300],
        child: const Center(
          child: Icon(Icons.image, size: 100, color: Colors.grey),
        ),
      );
    }
    
    final imagePathPng = _getImagePathPng(imageName);
    final imagePathJpg = _getImagePathJpg(imageName);
    
    return Image.asset(
      imagePathPng,
      width: double.infinity,
      height: double.infinity,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        return Image.asset(
          imagePathJpg,
          width: double.infinity,
          height: double.infinity,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              color: Colors.grey[300],
              child: const Center(
                child: Icon(Icons.image, size: 100, color: Colors.grey),
              ),
            );
          },
        );
      },
    );
  }

  String _getImagePath(String imageName) => '$_assetsPath/$imageName.svg';
  String _getImagePathPng(String imageName) => '$_assetsPath/$imageName.png';
  String _getImagePathJpg(String imageName) => '$_assetsPath/$imageName.jpg';

  Widget _getProfileImage(String? profileImage) {
    final imageName = profileImage ?? 'dark';
    return ClipOval(
      child: _ProfileImageWithFallback(
        pngPath: _getImagePathPng(imageName),
        svgPath: _getImagePath(imageName),
        width: _profileImageSize,
        height: _profileImageSize,
        fit: BoxFit.cover,
        placeholder: _buildPlaceholder(),
      ),
    );
  }
  
  Widget _buildPlaceholder() {
    return Container(
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: const Icon(Icons.person, size: _profileImageSize, color: Colors.white),
    );
  }

  Future<void> _sharePost(Post post) async {
    try {
      String title = post.eventTitle ?? post.venueName;
      String description = '';
      
      if (post.caption != null) {
        description = post.caption!;
      } else if (post.eventDate != null) {
        description = post.eventDate!;
      }
      
      if (post.location.isNotEmpty && post.location != 'Check in') {
        description += description.isNotEmpty ? '\n📍 ${post.location}' : '📍 ${post.location}';
      }
      
      String shareText = title;
      if (description.isNotEmpty) {
        shareText += '\n\n$description';
      }
      shareText += '\n\nwww.google.com';
      
      await Share.share(shareText, subject: title);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Unable to share. Please try again.'),
            duration: Duration(seconds: 2),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final slideWidth = screenWidth - 32 - 8 - _sidebarWidth;

    return Scaffold(
      backgroundColor: _backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => _buildPost(posts[index], slideWidth),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: _backgroundColor,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.transparent,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SvgPicture.asset(
                _getImagePath('app-icon'),
                width: 40,
                height: 40,
                fit: BoxFit.contain,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEDEEE5),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        _getImagePath('location'),
                        width: 16,
                        height: 16,
                        colorFilter: const ColorFilter.mode(_textSecondary, BlendMode.srcIn),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        _location,
                        style: TextStyle(
                          fontFamily: Fonts.fontFamily,
                          fontSize: 14,
                          fontWeight: Fonts.semiBold,
                          color: _textSecondary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Icon(Icons.keyboard_arrow_down, size: 16, color: _textSecondary),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _locationSubtext,
                  style: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    fontSize: 11,
                    fontWeight: Fonts.regular,
                    color: _textTertiary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF2F3E6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              icon: SvgPicture.asset(
                _getImagePath('bell'),
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(Colors.grey[600]!, BlendMode.srcIn),
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPost(Post post, double slideWidth) {
    return Container(
      color: _postBackgroundColor,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPostHeader(post),
          _buildContentFrame(post, slideWidth),
          if (post.caption != null) _buildCaption(post),
          if (post.eventTitle != null) _buildEventDetails(post),
        ],
      ),
    );
  }

  Widget _buildPostHeader(Post post) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _getProfileImage(post.profileImage),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            post.venueName,
                            style: TextStyle(
                              fontFamily: Fonts.fontFamily,
                              fontSize: 16,
                              fontWeight: Fonts.semiBold,
                              color: _textPrimary,
                            ),
                          ),
                          if (post.isVerified) ...[
                            const SizedBox(width: 2),
                            SvgPicture.asset(
                              _getImagePath('verified'),
                              width: 16,
                              height: 16,
                            ),
                          ],
                          const SizedBox(width: 6),
                          Text(
                            '◆ ${post.time}',
                            style: const TextStyle(
                              fontFamily: Fonts.fontFamily,
                              fontSize: 12,
                              fontWeight: Fonts.regular,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        post.location,
                        style: TextStyle(
                          fontFamily: Fonts.fontFamily,
                          fontSize: 12,
                          fontWeight: Fonts.regular,
                          color: _textTertiary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: post.isVenue ? _reserveColor : _followColor,
                  borderRadius: BorderRadius.circular(18),
                ),
                child: Text(
                  post.isVenue ? 'Reserve' : 'Follow',
                  style: const TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: Fonts.regular,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Icon(Icons.more_horiz, size: 20, color: _textSecondary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContentFrame(Post post, double slideWidth) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (post.hasPromo)
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          color: _promoColor,
                          child: Text(
                            post.promoText ?? '',
                            style: const TextStyle(
                              fontFamily: Fonts.fontFamily,
                              fontSize: 12,
                              fontWeight: Fonts.regular,
                              color: Colors.black,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      post.multipleImages != null
                          ? _buildImageCarousel(post, slideWidth)
                          : _buildSingleImage(post),
                    ],
                  ),
                ),
              ),
              _buildSocialSidebar(post, post.hasPromo ? _imageHeight + 40 : _imageHeight),
            ],
          ),
          if (post.isVenue)
            Transform.translate(
              offset: const Offset(0, -4),
              child: _buildBookNowButton(),
            ),
        ],
      ),
    );
  }

  Widget _buildSingleImage(Post post) {
    return Container(
      width: double.infinity,
      height: _imageHeight,
      child: Stack(
        children: [
          _getDummyImage(post.imageSource),
          if (post.hasFoodTag)
            Positioned(
              top: 50,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: const BoxDecoration(
                  color: _foodTagColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    bottomLeft: Radius.circular(30),
                  ),
                ),
                child: const Text(
                  'Food',
                  style: TextStyle(
                    fontFamily: Fonts.fontFamily,
                    color: Colors.white,
                    fontSize: 13,
                    fontWeight: Fonts.semiBold,
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildImageCarousel(Post post, double slideWidth) {
    if (!_pageControllers.containsKey(post.id)) {
      _pageControllers[post.id] = PageController(initialPage: slideIndices[post.id] ?? 0);
    }
    final pageController = _pageControllers[post.id]!;

    return Container(
      width: double.infinity,
      height: _imageHeight,
      child: Stack(
        children: [
          PageView.builder(
            controller: pageController,
            itemCount: post.multipleImages?.length ?? 0,
            onPageChanged: (index) {
              setState(() {
                slideIndices[post.id] = index;
              });
            },
            itemBuilder: (context, index) {
              return SizedBox(
                width: slideWidth,
                child: _getDummyImage(post.multipleImages?[index]),
              );
            },
          ),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    post.multipleImages?.length ?? 0,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: (slideIndices[post.id] ?? 0) == index ? 28 : 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: (slideIndices[post.id] ?? 0) == index
                            ? _followColor
                            : Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSocialSidebar(Post post, double containerHeight) {
    return SizedBox(
      width: _sidebarWidth,
      height: containerHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              IconButton(
                icon: _buildAnimatedStar(post),
                onPressed: () => _toggleStar(post),
              ),
              const SizedBox(height: 0),
              IconButton(
                icon: _buildAnimatedBookmark(post),
                onPressed: () => _toggleBookmark(post),
              ),
            ],
          ),
          Column(
            children: [
              _buildSocialIcon(
                icon: _buildAnimatedHeart(post),
                label: post.likes,
                onPressed: () => _toggleLike(post),
              ),
              const SizedBox(height: 8),
              _buildSocialIcon(
                icon: SvgPicture.asset(
                  _getImagePath('comment'),
                  width: _iconSize,
                  height: _iconSize,
                  colorFilter: const ColorFilter.mode(_textSecondary, BlendMode.srcIn),
                ),
                label: post.comments,
                onPressed: () {},
              ),
              const SizedBox(height: 8),
              _buildSocialIcon(
                icon: SvgPicture.asset(
                  _getImagePath('paper-plane'),
                  width: _iconSize,
                  height: _iconSize,
                  colorFilter: const ColorFilter.mode(_textSecondary, BlendMode.srcIn),
                ),
                label: post.shares,
                onPressed: () => _sharePost(post),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialIcon({required Widget icon, required String label, required VoidCallback onPressed}) {
    return Column(
      children: [
        IconButton(icon: icon, onPressed: onPressed),
        Text(
          label,
          style: TextStyle(
            fontFamily: Fonts.fontFamily,
            fontSize: 10,
            fontWeight: Fonts.medium,
            color: _textSecondary,
          ),
        ),
      ],
    );
  }

  Widget _buildBookNowButton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(right: 8),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: _followColor,
                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Book Now',
                    style: TextStyle(
                      fontFamily: Fonts.fontFamily,
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: Fonts.medium,
                    ),
                  ),
                  Icon(Icons.arrow_forward, color: Colors.white, size: 20),
                ],
              ),
            ),
          ),
        ),
        SizedBox(width: _sidebarWidth),
      ],
    );
  }

  Widget _buildCaption(Post post) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                post.userName.replaceAll(' ', '.'),
                style: TextStyle(
                  fontFamily: Fonts.fontFamily,
                  fontSize: 14,
                  fontWeight: Fonts.semiBold,
                  color: _textPrimary,
                ),
              ),
              if (post.isVerified) ...[
                const SizedBox(width: 4),
                SvgPicture.asset(_getImagePath('verified'), width: 14, height: 14),
              ],
            ],
          ),
          const SizedBox(height: 4),
          Text(
            post.caption ?? '',
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 14,
              fontWeight: Fonts.regular,
              color: _textPrimary,
              height: 1.43,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventDetails(Post post) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            post.eventTitle ?? '',
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 14,
              fontWeight: Fonts.semiBold,
              color: _textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            post.eventDate ?? '',
            style: TextStyle(
              fontFamily: Fonts.fontFamily,
              fontSize: 12,
              fontWeight: Fonts.regular,
              color: _textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  void _toggleLike(Post post) {
    final postId = post.id;
    final isLiked = _likedPosts[postId] ?? false;
    
    setState(() {
      _likedPosts[postId] = !isLiked;
    });
    
    if (!_heartAnimationControllers.containsKey(postId)) {
      _heartAnimationControllers[postId] = AnimationController(
        vsync: this,
        duration: _animationDuration,
      );
    }
    
    final controller = _heartAnimationControllers[postId]!;
    
    if (!isLiked) {
      controller.forward().then((_) => controller.reverse());
    }
  }

  Widget _buildAnimatedHeart(Post post) {
    final postId = post.id;
    final isLiked = _likedPosts[postId] ?? false;
    
    if (!_heartAnimationControllers.containsKey(postId)) {
      _heartAnimationControllers[postId] = AnimationController(
        vsync: this,
        duration: _animationDuration,
      );
    }
    
    final controller = _heartAnimationControllers[postId]!;
    final scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.3), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.3, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: SvgPicture.asset(
            _getImagePath('heart'),
            width: _iconSize,
            height: _iconSize,
            colorFilter: ColorFilter.mode(
              isLiked ? Colors.red : _textSecondary,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }

  void _toggleBookmark(Post post) {
    final postId = post.id;
    final isBookmarked = _bookmarkedPosts[postId] ?? false;
    
    setState(() {
      _bookmarkedPosts[postId] = !isBookmarked;
    });
    
    if (!_bookmarkAnimationControllers.containsKey(postId)) {
      _bookmarkAnimationControllers[postId] = AnimationController(
        vsync: this,
        duration: _animationDuration,
      );
    }
    
    final controller = _bookmarkAnimationControllers[postId]!;
    
    if (!isBookmarked) {
      controller.forward().then((_) => controller.reverse());
    }
  }

  Widget _buildAnimatedBookmark(Post post) {
    final postId = post.id;
    final isBookmarked = _bookmarkedPosts[postId] ?? false;
    
    if (!_bookmarkAnimationControllers.containsKey(postId)) {
      _bookmarkAnimationControllers[postId] = AnimationController(
        vsync: this,
        duration: _animationDuration,
      );
    }
    
    final controller = _bookmarkAnimationControllers[postId]!;
    final scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.3), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.3, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: SvgPicture.asset(
            _getImagePath('bookmark'),
            width: _iconSize,
            height: _iconSize,
            colorFilter: ColorFilter.mode(
              isBookmarked ? Colors.green : _textSecondary,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }

  void _toggleStar(Post post) {
    final postId = post.id;
    final isStarred = _starredPosts[postId] ?? false;
    
    setState(() {
      _starredPosts[postId] = !isStarred;
    });
    
    if (!_starAnimationControllers.containsKey(postId)) {
      _starAnimationControllers[postId] = AnimationController(
        vsync: this,
        duration: _animationDuration,
      );
    }
    
    final controller = _starAnimationControllers[postId]!;
    
    if (!isStarred) {
      controller.forward().then((_) => controller.reverse());
    }
  }

  Widget _buildAnimatedStar(Post post) {
    final postId = post.id;
    final isStarred = _starredPosts[postId] ?? false;
    
    if (!_starAnimationControllers.containsKey(postId)) {
      _starAnimationControllers[postId] = AnimationController(
        vsync: this,
        duration: _animationDuration,
      );
    }
    
    final controller = _starAnimationControllers[postId]!;
    final scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween<double>(begin: 1.0, end: 1.3), weight: 1),
      TweenSequenceItem(tween: Tween<double>(begin: 1.3, end: 1.0), weight: 1),
    ]).animate(CurvedAnimation(parent: controller, curve: Curves.easeOut));
    
    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        return Transform.scale(
          scale: scaleAnimation.value,
          child: SvgPicture.asset(
            _getImagePath('star'),
            width: _iconSize,
            height: _iconSize,
            colorFilter: ColorFilter.mode(
              isStarred ? Colors.amber : _textSecondary,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    for (var controller in _pageControllers.values) {
      controller.dispose();
    }
    _pageControllers.clear();
    
    for (var controller in _heartAnimationControllers.values) {
      controller.dispose();
    }
    _heartAnimationControllers.clear();
    
    for (var controller in _bookmarkAnimationControllers.values) {
      controller.dispose();
    }
    _bookmarkAnimationControllers.clear();
    
    for (var controller in _starAnimationControllers.values) {
      controller.dispose();
    }
    _starAnimationControllers.clear();
    
    super.dispose();
  }
}
