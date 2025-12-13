import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:v1/models/user_model.dart';
import 'package:v1/prefs/theme.dart';
import 'package:v1/providers/user_provider.dart';
import 'package:v1/widgets/LineDivider.dart';
import 'package:v1/widgets/PrimaryButton.dart';
import 'package:v1/widgets/PrimaryIconDropdownMenu.dart';
import 'package:v1/widgets/SecondaryButton.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  final UserModel user;
  const ProfileScreen({super.key, required this.user});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final currentUser = ref.read(currentUserProvider).valueOrNull;

    final theme = Theme.of(context);
    final mqs = MediaQuery.of(context).size;
    return SizedBox(
      width: mqs.width,
      height: mqs.height,
      child: Scrollable(
        physics: const BouncingScrollPhysics(),
        viewportBuilder: (context, position) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Top Bar
              SizedBox(
                width: mqs.width,
                height: mqs.height * 0.4,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: 0,
                      child: Container(
                        width: mqs.width,
                        height: mqs.height * 0.3,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          image: DecorationImage(
                            image: NetworkImage(widget.user.coverPhotoUrl!),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: mqs.height * 0.015,
                      child: Container(
                        width: mqs.width * 0.4,
                        height: mqs.width * 0.4,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: theme.colorScheme.surface,
                            width: 4,
                          ),
                          image: DecorationImage(
                            image: NetworkImage(widget.user.avatarUrl ?? ""),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 12,
                      right: mqs.width * 0.3,
                      child: IconButton(
                        onPressed: () {},
                        icon: Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.colorScheme.surface,
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${widget.user.firstName} ${widget.user.lastName}",
                style: TextStyle(
                  color: theme.colorScheme.primary,
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  fontFamily: kEnglishPrimaryFont,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: mqs.width * 0.1),
                child: Text(
                  "${widget.user.bio}",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: theme.colorScheme.secondary,
                    fontSize: 16,
                    fontWeight: FontWeight.w300,
                    fontFamily: kEnglishPrimaryFont,
                  ),
                ),
              ),
              currentUser!.id != widget.user.id
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: mqs.height * 0.025,
                        horizontal: mqs.width * 0.015,
                      ),
                      child: SizedBox(
                        width: mqs.width,
                        height: mqs.height * 0.05,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            PrimaryButton(
                              title: "Follow",
                              onPressed: () {},
                              prefixIcon: Container(),
                              suffixIcon: Container(),
                              isActive: currentUser.followers!.contains(
                                widget.user.id!,
                              ),
                            ),
                            Gap(8),
                            SecondaryButton(
                              title: "Message",
                              onPressed: () {},
                              prefixIcon: Container(),
                              suffixIcon: Container(),
                            ),
                            Gap(8),
                            PrimaryIconDropdownMenu(
                              icon: SvgPicture.asset(
                                "assets/icons/more.svg",
                                width: 24,
                                height: 24,
                                colorFilter: ColorFilter.mode(
                                  kCreamLight,
                                  BlendMode.srcIn,
                                ),
                              ),
                              options: <DropdownOption>[
                                DropdownOption(
                                  label: "Report",
                                  onPressed: () {},
                                ),
                                DropdownOption(
                                  label: "Block",
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
              ...lineDivider(
                context: context,
                color: theme.colorScheme.primary,
              ),
            ],
          );
        },
      ),
    );
  }
}
