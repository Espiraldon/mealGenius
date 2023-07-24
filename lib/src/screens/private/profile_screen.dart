import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happly/src/data/data.dart';
import 'package:happly/src/models/content.dart';
import 'package:happly/src/widget/custom_appbar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppbar(
        title: "Your Profile",
        leading: Icon(Icons.add),
      ),
      backgroundColor: backgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
                child: Text(
                  'Myriam Compan',
                  style: GoogleFonts.lato(
                      color: tipo, fontSize: 30, fontWeight: FontWeight.w900),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  bottom: 5,
                ),
                child: Text(
                  'myriam@gmail.com',
                  style: GoogleFonts.lato(
                      color: tipo, fontSize: 15, fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              ProfileSection(
                content: MyAccount,
                title: 'My account',
              ),
              ProfileSection(
                content: Application,
                title: 'Application',
              ),
              ProfileSection(
                content: Support,
                title: 'Support',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileSection extends StatelessWidget {
  final List<ProfileContent> content;
  final String title;
  ProfileSection({required this.title, required this.content, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10, bottom: 5, top: 5),
          child: Text(
            title,
            style: GoogleFonts.lato(
                color: tipo, fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ),
        ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.all(8),
            itemCount: content.length,
            itemBuilder: (BuildContext context, int index) {
              final ProfileContent info = content[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: backgroundColor2),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const SizedBox(
                            width: 10,
                          ),
                          info.contenticons,
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            info.contenttitle,
                            style: GoogleFonts.lato(
                                fontSize: 20, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 8.0),
                        child: Icon(
                          Icons.arrow_forward_ios_outlined,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
