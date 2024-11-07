import 'dart:math';

List<String> generateRandomImages(int numberOfImages) {
  final List<String> urls = [
    'https://images.deccanherald.com/deccanherald%2F2024-10-02%2F4wcxs0z1%2F2024newsmlRC2F2AA3DGLK1301831661.jpeg?auto=format%2Ccompress&fmt=webp&fit=max&format=webp&q=70&w=400&dpr=2',
    'https://westernfinancialgroup.ca/get/files/image/galleries/Organ_donation_Blog_Image_1200x630.jpg',
    'https://www.themarkethink.com/wp-content/uploads/2021/04/ayudar-al-projimo.jpg',
    'https://www.mundounido.cl/wp-content/uploads/2018/05/AYUDA.jpg',
    'https://www.cinconoticias.com/wp-content/uploads/ayudar-a-los-dem%C3%A1s-1-1.jpg',
    'https://blogger.googleusercontent.com/img/b/R29vZ2xl/AVvXsEgpI21vKLN15Uf_VaWoXhsa4l5IA6oB8JoZAPYsmI-kzL0QQUPYb9afk6pI6VsS1g4CotRy8odXCFQtEJq2doLr6vU2hOJjXw0A4EmTiGA_IZddfsJhnFevcIYHfsTBDe_eeebZywBWS-xc/w1200-h630-p-k-no-nu/ayuda-help-fair-play-empatia-foul-solidaridad.jpg',
    'https://www.cinconoticias.com/wp-content/uploads/ayudar-a-los-dem%C3%A1s-9.jpg',
    'https://zonaj.net/imgupload/20-claves-para-caerle-bien-a-las-demas-personas_zSG4vO.jpg', // ojala salga este
  ];

  final int count = min(numberOfImages, urls.length);

  final Random random = Random();

  // creamos un set para almacenar las urls sin duplicados :O
  final Set<String> selectedUrls = {};

  while (selectedUrls.length < count) {
    int randomIndex = random.nextInt(urls.length);
    selectedUrls.add(urls[randomIndex]);
  }

  // retornamos una lista de strings con las urls generadas
  return selectedUrls.toList();
}
