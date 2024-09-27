import 'package:flutter/material.dart';

class PostsScreen extends StatelessWidget {
  static const String name = "posts_screen";

  const PostsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Navigator(
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (context) => const PostsContent(),
        );
      },
    );
  }
}

class PostsContent extends StatelessWidget {
  const PostsContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPostSomethingSection(),
            const SizedBox(height: 16),
            _buildPostsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPostSomethingSection() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 15,),
          const Text(
            'Post Something NEW',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 10),
          Container(
            height: 50,
            decoration: BoxDecoration(
              color: const Color(0xFFB3C6C7), // Greenish background
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Center(
              child: Icon(
                Icons.add,
                size: 40,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsSection() {
    return Column(
      children: List.generate(3, (index) => _buildPostCard()),
    );
  }

  Widget _buildPostCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildPostHeader(),
              const SizedBox(height: 8),
              const Text(
                'Esperando el 20. lorem ipsum lorem ipsum...',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              const Text(
                '...See More',
                style: TextStyle(color: Colors.green),
              ),
              const SizedBox(height: 8),
              _buildPostImages(),
              const SizedBox(height: 8),
              _buildPostFooter(),
              const SizedBox(height: 8),
              const Text(
                'Clean Carpayo Beach',
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPostHeader() {
    return Row(
      children: [
        const CircleAvatar(
          backgroundImage: NetworkImage(
              'https://randomuser.me/api/portraits/men/4.jpg'), // Placeholder avatar
          radius: 20,
        ),
        const SizedBox(width: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              'Waldir Blanco',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Text(
              'u2022123981@upc.edu.pe',
              style: TextStyle(color: Colors.grey),
            ),
          ],
        )
      ],
    );
  }

  Widget _buildPostImages() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: _buildImagePost(
            'https://media.gettyimages.com/id/1199706321/es/foto/organizador-de-eventos-ben%C3%A9ficos-saluda-al-voluntario-durante-el-evento-de-limpieza-comunitaria.jpg?s=612x612&w=gi&k=20&c=4Lr54UHi9T8twbhxH7aJyFJUtriXlZBKWTD2yQUNpvk=',
          ),
        ),
        const SizedBox(width: 15,),
        Expanded(
          child: _buildImagePost(
            'https://img.freepik.com/fotos-premium/trabajador-masculino-ong-entrega-caja-alimentos-basicos-articulos-tocador-familia-tres-personas-frontera-que-huye-conflicto-ucrania_341862-14800.jpg',
          ),
        ),
        const SizedBox(width: 15,),
        Expanded(
          child: _buildImagePost(
            'https://media.istockphoto.com/id/1367146074/es/foto/grupo-de-personas-que-trabajan-en-fundaciones-ben%C3%A9ficas.jpg?s=612x612&w=0&k=20&c=08eLUgDgeNivZZRptcs9Ronq2qFJ5rfWfEO7eDTsmTs=',
          ),
        ),
      ],
    );
  }

  Widget _buildImagePost(String imageUrl) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _buildPostFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: const [
            Icon(Icons.star_border, color: Colors.green),
            SizedBox(width: 5),
            Text('20'),
          ],
        ),
        Row(
          children: const [
            Icon(Icons.comment, color: Colors.green),
            SizedBox(width: 5),
            Text('12 Comments'),
          ],
        ),
      ],
    );
  }
}
