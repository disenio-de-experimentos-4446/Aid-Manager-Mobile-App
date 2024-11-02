import 'package:aidmanager_mobile/features/profile/domain/entities/user.dart';
import 'package:flutter/material.dart';

class MembersCarousel extends StatelessWidget {
  final List<User> members;

  const MembersCarousel({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(
          members.length,
          (int index) {
            final member = members[index];
            return _MemberShape(
              imagePath: member.profileImg ??
                  'https://static.vecteezy.com/system/resources/thumbnails/004/511/281/small/default-avatar-photo-placeholder-profile-picture-vector.jpg',
              name: member.name,
            );
          },
        ),
      ),
    );
  }
}

class _MemberShape extends StatelessWidget {
  final String imagePath;
  final String name;

  const _MemberShape({
    required this.imagePath,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20.0),
      child: Column(
        children: [
          Container(
            width: 80.0,
            height: 80.0,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey, // Borde gris
                width: 2.0,
              ),
            ),
            child: ClipOval(
              child: ColorFiltered(
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.05), // Fondo opaco
                  BlendMode.darken,
                ),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Image.asset(
                      'assets/images/profile-placeholder.jpg',
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            name.split(' ')[0],
            style: const TextStyle(
              fontSize: 14.0,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
