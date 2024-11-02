import 'package:aidmanager_mobile/features/posts/domain/entities/post.dart';
import 'package:aidmanager_mobile/features/posts/presentation/providers/post_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class PostCard extends StatefulWidget {
  final Post post;

  const PostCard({super.key, required this.post});



  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  bool isExpanded = false;

  bool _isValidUrl(String url) {
    print("Is valid image? " + url);
    return Uri.tryParse(url)?.hasAbsolutePath ?? false;
  }


  @override
  Widget build(BuildContext context) {
    final postProvider = Provider.of<PostProvider>(context, listen: false);
  final double screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Card(
        elevation: 20,
        color: Color(0xFFE6EEEC),
        child: Container(
          width: screenWidth * 0.9,
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                children: [
                  CircleAvatar(
                    radius: 25.0,
                    backgroundImage:
                    widget.post.userImage.isNotEmpty == true
                        ? NetworkImage(widget.post.userImage)
                        : AssetImage('assets/images/defaultavatar.jpg'),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //Aqui va el nombre del usuario y el TITULO del post
                        Text(widget.post.title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                        Text(widget.post.userName, style: TextStyle(fontSize: 14, color: Colors.grey)),
                      ],
                    ),
                  ),
                  PopupMenuButton<String>(
                    onSelected: (String result) async {
                      if (result == 'delete') {
                        await postProvider.deletePostById(widget.post.id!);
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      const PopupMenuItem<String>(
                        value: 'delete',
                        child: Text('Delete Post'),
                      ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 8),

              Row(
                children: [

                  //Aqui va el asunto del post
                  Text(widget.post.subject ,style: TextStyle(fontSize: 13, fontWeight: FontWeight.w200, )),
                ],
              ),
              //TEXTO DEL POST
              Text(
                widget.post.description,
                maxLines: isExpanded ? null : 2,
                overflow: isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
              ),
              TextButton(

                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(Color(0xFF008A66)),

                ),

                onPressed: () {
                  setState(() {
                    isExpanded = !isExpanded;
                  });
                },
                child: Text(isExpanded ? 'See Less' : 'See More'),
              ),

            SizedBox(
                height: 225,
                child: CarouselView(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        20.0), // Ajusta el radio del borde según sea necesario
                  ),
                  itemExtent: MediaQuery.sizeOf(context).width - 96,
                  padding: const EdgeInsets.only(right: 10),
                  itemSnapping: true,
                  elevation: 4.0,
                  //Aqui va la lista de imagenes del post
                  children: widget.post.images.map((image) {
                    return _isValidUrl(image)
                        ? Image.network(image, fit: BoxFit.cover, errorBuilder: (context, error, stackTrace) {
                      return Image.asset('assets/images/defaultavatar.jpg', fit: BoxFit.cover);
                    })
                        : Image.asset('assets/images/defaultavatar.jpg', fit: BoxFit.cover);
                  }).toList(),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        icon: Icon(Icons.favorite),
                        onPressed: () {
                          // Acción del botón
                        },
                      ),
                      Text(widget.post.rating.toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Text(widget.post.commentsList.length.toString()),
                      IconButton(
                        icon: Icon(Icons.comment),
                        onPressed: () {
                          GoRouter.of(context).go('/posts/${widget.post.id}');
                        },
                      ),

                    ],
                  ),
                ],
              ),
              Row(
                children: [
                  //Aqui va la fecha y la hora del post
                  Text('${widget.post.postTime?.toLocal().toString().split(' ')[0]} - ${widget.post.postTime?.toLocal().toString().split(' ')[1]}'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}