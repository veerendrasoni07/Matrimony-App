import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:matrimony_app/controller/partner_controller.dart';
import 'package:matrimony_app/models/user.dart';
import 'package:matrimony_app/service/managa_http_request.dart';
import 'package:swipe_cards/swipe_cards.dart';

class ProfileWidget extends StatefulWidget {
  final User user;
  const ProfileWidget({super.key,required this.user});

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {

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
    final fetchedUser = await partnerController.fetchPartners(
      userId: widget.user.id,
      context: context,
    );

    if (!mounted) return;

    swipeItems = fetchedUser.map((user) => SwipeItem(
      content: user,
      likeAction: () => print("Request Sent to ${user.fullname}"),
      nopeAction: () => print("Rejected ${user.fullname}"),
      superlikeAction: () => print("SuperLiked ${user.fullname}"),
    )).toList();

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
        onStackFinished: (){
          showSnackBar(text: "No More Profiles", context: context);
        },
        itemBuilder: (context,index){
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
                    child:Container(
                      margin: EdgeInsets.symmetric(vertical: 10),
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.white70,
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Column(
                        children: [
                          Text(user.fullname ?? " ",style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                          ),),
                          Text(user.work ?? " "),
                          Text(user.workRole ?? " "),
                        ],
                      ),
                    )
                )
              ],
            ),
          );
        }
    );
  }
}
