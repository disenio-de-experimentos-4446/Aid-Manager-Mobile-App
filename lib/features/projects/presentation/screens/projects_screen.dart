import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProjectsScreen extends StatelessWidget {
  static const String name = "projects_screen";

  const ProjectsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const ProjectsContent(),
        );
      },
    );
  }
}

class ProjectsContent extends StatelessWidget {
  const ProjectsContent({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 13),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(62),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: const Color(0xFF98CFD7),
                shadowColor: const Color(0xFF000000),
                elevation: 10,
              ),
              child: Text(
                'Hope Heaven',
                style: GoogleFonts.lora(
                    fontSize: 36, color: const Color(0xFFFFFFFF)),
              ),
            ),
            const SizedBox(height: 13),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text(
                  'Projects',
                  style: GoogleFonts.poppins(fontSize: 27),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                    ),
                    backgroundColor: const Color(0xFF02513D),
                  ),
                  child: Text(
                    'A-Z',
                    style: GoogleFonts.poppins(
                        fontSize: 17, color: const Color(0xFFFFFFFF)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 13),
            Expanded(
              child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    if (index == 9) {
                      return Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: NetworkImage(
                                'https://www.8inspain.com/wp-content/uploads/2023/09/beach-cleanup_orig.jpg'),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(120),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: const Color(0xFF9ABAB1),
                            shadowColor: const Color(0xFF000000),
                            elevation: 5,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Color(0xFF02513D),
                            size: 36,
                          ),
                        ),
                      );
                    }
                    return Container(
                      margin: const EdgeInsets.symmetric(vertical: 13),
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: NetworkImage(
                              "https://www.8inspain.com/wp-content/uploads/2023/09/beach-cleanup_orig.jpg"),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Stack(children: [
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size.fromHeight(120),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            backgroundColor: Colors.transparent,
                            shadowColor: const Color(0xFF000000),
                            elevation: 5,
                          ),
                          child: Container(),
                        ),
                        Positioned(
                          bottom: 8,
                          left: 8,
                          child: Text(
                            'Project ${index + 1}',
                            style: GoogleFonts.poppins(
                              fontSize: 30,
                              color: const Color(0xFFFFFFFF),
                            ),
                          ),
                        ),
                        ]
                      ),
                    );
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
