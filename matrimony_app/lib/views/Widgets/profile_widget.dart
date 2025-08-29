import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/controller/partner_controller.dart';
import 'package:matrimony_app/models/user.dart';
import 'package:matrimony_app/provider/user_provider.dart';
import 'package:matrimony_app/service/manage_http_request.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ProfileWidget extends ConsumerStatefulWidget {
  final User user;
  const ProfileWidget({super.key, required this.user});

  @override
  ConsumerState<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends ConsumerState<ProfileWidget> {
  List<User> users = [];
  late MatchEngine _matchEngine;
  final PartnerController partnerController = PartnerController();
  List<SwipeItem> swipeItems = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _matchEngine = MatchEngine(swipeItems: []); // initialize early
    _fetchSuggestions();
  }

  bool _isLoading = true;
  void _fetchSuggestions() async {
    final user = ref.read(userProvider);
    final fetchedUser = await partnerController.fetchPartners(
      userId: widget.user.id,
      context: context,
    );

    if (!mounted) return;

    swipeItems =
        fetchedUser
            .map(
              (people) => SwipeItem(
                content: people,
                likeAction:
                    () => partnerController.sendRequest(
                      senderId: user!.id,
                      receiverId: people.id,
                    ),
                nopeAction: () => partnerController.rejectSuggetion(userId: user!.id, targetId: people.id),
                superlikeAction: () => print("SuperLiked ${people.fullname}"),
              ),
            )
            .toList();

    setState(() {
      users = fetchedUser;
      _matchEngine = MatchEngine(swipeItems: swipeItems);
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SwipeCards(
      matchEngine: _matchEngine,
      onStackFinished: () {
        showSnackBar(text: "No More Profiles", context: context);
      },
      itemBuilder: (context, index) {
        final user = users[index];
        return Card(
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  user.image ?? "No images found",
                  fit: BoxFit.fill,
                  width: double.infinity,
                  height: double.infinity,
                ),
              ),
              Positioned(
                bottom: 1,
                left: 5,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Text(
                        user.fullname ?? " ",
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(user.work ?? " "),
                      Text(user.workRole ?? " "),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
