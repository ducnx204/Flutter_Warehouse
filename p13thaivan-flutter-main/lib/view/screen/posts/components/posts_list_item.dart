// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:template/data/model/body/post.dart';
// import 'package:template/data/model/body/region.dart';

// class PostsListItem extends StatelessWidget {
//   final Region? region;

//   const PostsListItem({Key? key, this.region}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.only(top: 20, right: 20, bottom: 15, left: 20),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withAlpha(15),
//             blurRadius: 1,
//             spreadRadius: 1,
//             offset: const Offset(0, 1),
//           )
//         ],
//       ),
//       child: Column(
//         children: [
//           Row(
//             children: [
//               ClipOval(
//                 child: Image.network(
//                   "https://picsum.photos/50/50?random=${region!.id}",
//                   height: 40,
//                   width: 40,
//                 ),
//               ),
//               const SizedBox(width: 15),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       region!.name.toString(),
//                       overflow: TextOverflow.ellipsis,
//                       maxLines: 1,
//                       softWrap: false,
//                       style: const TextStyle(fontSize: 17),
//                     ),
//                     const SizedBox(height: 5),
//                     const Text(
//                       '2 days ago',
//                       style: TextStyle(
//                         fontSize: 12,
//                         color: Colors.black38,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//           const SizedBox(height: 15),
//           Text(
//             region!.name.toString(),
//             style: const TextStyle(color: Colors.black87),
//           ),
//           Row(
//             children: [
//               IconButton(
//                 icon: const Icon(
//                   CupertinoIcons.heart,
//                   color: Colors.redAccent,
//                 ),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: const Icon(
//                   CupertinoIcons.bookmark,
//                   color: Colors.black54,
//                 ),
//                 onPressed: () {},
//               ),
//               const Spacer(),
//               IconButton(
//                 icon: const Icon(
//                   CupertinoIcons.hand_thumbsdown,
//                   color: Colors.blueAccent,
//                 ),
//                 onPressed: () {},
//               ),
//               IconButton(
//                 icon: const Icon(
//                   CupertinoIcons.hand_thumbsup,
//                   color: Colors.blueAccent,
//                 ),
//                 onPressed: () {},
//               ),
//             ],
//           )
//         ],
//       ),
//     );
//   }
// }
