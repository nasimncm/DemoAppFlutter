import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';
import '../models/post.dart';
import '../widgets/app_header.dart';
import '../widgets/post/post_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Post> posts = [
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

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final slideWidth = screenWidth -
        (AppDimensions.paddingLarge * 2) -
        AppDimensions.paddingSmall -
        AppDimensions.sidebarWidth;

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            const AppHeader(),
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                padding: EdgeInsets.zero,
                itemBuilder: (context, index) => PostItem(
                  post: posts[index],
                  slideWidth: slideWidth,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

