import 'dart:math';

List<String> generateRandomImages(int numberOfImages) {
  final List<String> urls = [
    'https://as1.ftcdn.net/v2/jpg/01/99/15/88/500_F_199158864_YOFv3JeMK7ey64xKmLZ9Ltazkaf2rZTG.jpg',
    'https://westernfinancialgroup.ca/get/files/image/galleries/Organ_donation_Blog_Image_1200x630.jpg',
    'https://www.themarkethink.com/wp-content/uploads/2021/04/ayudar-al-projimo.jpg',
    'https://www.mundounido.cl/wp-content/uploads/2018/05/AYUDA.jpg',
    'https://www.cinconoticias.com/wp-content/uploads/ayudar-a-los-dem%C3%A1s-1-1.jpg',
    'https://st3.depositphotos.com/1017986/18755/i/450/depositphotos_187558964-stock-photo-volunteers-with-garbage-bags-cleaning.jpg',
    'https://www.cinconoticias.com/wp-content/uploads/ayudar-a-los-dem%C3%A1s-9.jpg',
    'https://zonaj.net/imgupload/20-claves-para-caerle-bien-a-las-demas-personas_zSG4vO.jpg',
    'https://img.freepik.com/premium-photo/volunteers-planting-trees-cleaning-up-park-highlighting-spirit-giving-back_837074-51334.jpg',
    'https://img.freepik.com/fotos-premium/agricultor-cientifico-examinan-suelo-rico-plantas-jovenes-campo_837074-48066.jpg'
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
