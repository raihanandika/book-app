import 'package:book_app/controllers/book_controller.dart';
import 'package:book_app/views/image_view_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailBookPage extends StatelessWidget {
  DetailBookPage({Key? key, required this.isbn}) : super(key: key);
  final String isbn;

  BookController? bookController;

  @override
  Widget build(BuildContext context) {
    bookController = Provider.of<BookController>(context, listen: false);
    return Scaffold(
        appBar: AppBar(title: const Text("Detail")),
        body: FutureBuilder(
            future: bookController!.fetchDetailBookApi(isbn),
            builder: (context, snapshot) {
              return Consumer<BookController>(
                child: const Center(child: CircularProgressIndicator()),
                builder: (context, controller, child) => Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ImageViewScreen(
                                    imageUrl:
                                        bookController!.detailResponse!.image!);
                              }));
                            },
                            child: Image.network(
                              bookController!.detailResponse!.image!,
                              height: 150,
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    bookController!.detailResponse!.title!,
                                    style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(bookController!.detailResponse!.authors!,
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.grey)),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: List.generate(
                                        5,
                                        (index) => Icon(Icons.star,
                                            color: index <
                                                    int.parse(bookController!
                                                        .detailResponse!
                                                        .rating!)
                                                ? Colors.yellow
                                                : Colors.grey)),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                      bookController!.detailResponse!.subtitle!,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 12,
                                          color: Colors.grey)),
                                  Text(bookController!.detailResponse!.price!,
                                      style: const TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.green)),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(),
                          onPressed: () async {
                            Uri uri =
                                Uri.parse(bookController!.detailResponse!.url!);
                            try {
                              (await canLaunchUrl(uri))
                                  ? launchUrl(uri)
                                  : print("tidak berhasil navigasi");
                            } catch (e) {
                              // print(e);
                            }
                          },
                          child: const Text("Buy"),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(bookController!.detailResponse!.desc!),
                      const SizedBox(
                        height: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text("Year:  " +
                              bookController!.detailResponse!.year!),
                          Text("ISBN " +
                              bookController!.detailResponse!.isbn13!),
                          Text(bookController!.detailResponse!.pages! +
                              " Pages"),
                          Text("Publisher " +
                              bookController!.detailResponse!.publisher!),
                          Text("Language " +
                              bookController!.detailResponse!.language!),
                        ],
                      ),
                      // Text(detailResponse!.isbn10!),
                      // Text(detailResponse!.isbn13!),
                      // Text(detailResponse!.subtitle!),
                      // Text(detailResponse!.rating!),
                      const Divider(),

                      bookController!.similiarBooks == null
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              height: 180,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: bookController!
                                    .similiarBooks!.books!.length,
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final current = bookController!
                                      .similiarBooks!.books![index];
                                  return SizedBox(
                                    width: 100,
                                    child: Column(
                                      children: [
                                        Image.network(
                                          current.image!,
                                          height: 100,
                                        ),
                                        Text(
                                          current.title!,
                                          style: const TextStyle(fontSize: 12),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  );
                                },
                              ),
                            )
                    ],
                  ),
                ),
              );
            }));
  }
}

// class DetailBookPage extends StatefulWidget {
//   const DetailBookPage({Key? key, required this.isbn}) : super(key: key);
//   final String isbn;

//   @override
//   State<DetailBookPage> createState() => _DetailBookPageState();
// }

// class _DetailBookPageState extends State<DetailBookPage> {
//   BookController bookController = BookController();

//   @override
//   void initState() {
//     super.initState();
//     bookController = Provider.of<BookController>(context, listen: false);
//     bookController.fetchDetailBookApi(widget.isbn);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(title: const Text("Detail")),
//         body: Consumer<BookController>(
//           child: const Center(child: CircularProgressIndicator()),
//           builder: (context, controller, child) => Padding(
//             padding: const EdgeInsets.all(10.0),
//             child: Column(
//               children: [
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     GestureDetector(
//                       onTap: () {
//                         Navigator.push(context,
//                             MaterialPageRoute(builder: (context) {
//                           return ImageViewScreen(
//                               imageUrl: bookController.detailResponse!.image!);
//                         }));
//                       },
//                       child: Image.network(
//                         bookController.detailResponse!.image!,
//                         height: 150,
//                       ),
//                     ),
//                     Expanded(
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 12),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               bookController.detailResponse!.title!,
//                               style: const TextStyle(
//                                   fontSize: 18, fontWeight: FontWeight.bold),
//                             ),
//                             Text(bookController.detailResponse!.authors!,
//                                 style: const TextStyle(
//                                     fontSize: 12, color: Colors.grey)),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               children: List.generate(
//                                   5,
//                                   (index) => Icon(Icons.star,
//                                       color: index <
//                                               int.parse(bookController
//                                                   .detailResponse!.rating!)
//                                           ? Colors.yellow
//                                           : Colors.grey)),
//                             ),
//                             const SizedBox(
//                               height: 10,
//                             ),
//                             Text(bookController.detailResponse!.subtitle!,
//                                 style: const TextStyle(
//                                     fontWeight: FontWeight.bold,
//                                     fontSize: 12,
//                                     color: Colors.grey)),
//                             Text(bookController.detailResponse!.price!,
//                                 style: const TextStyle(
//                                     fontSize: 14,
//                                     fontWeight: FontWeight.bold,
//                                     color: Colors.green)),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 SizedBox(
//                   width: double.infinity,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(),
//                     onPressed: () async {
//                       Uri uri = Uri.parse(bookController.detailResponse!.url!);
//                       try {
//                         (await canLaunchUrl(uri))
//                             ? launchUrl(uri)
//                             : print("tidak berhasil navigasi");
//                       } catch (e) {
//                         print(e);
//                       }
//                     },
//                     child: const Text("Buy"),
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Text(bookController.detailResponse!.desc!),
//                 const SizedBox(
//                   height: 20,
//                 ),
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.stretch,
//                   children: [
//                     Text("Year:  " + bookController.detailResponse!.year!),
//                     Text("ISBN " + bookController.detailResponse!.isbn13!),
//                     Text(bookController.detailResponse!.pages! + " Pages"),
//                     Text("Publisher " +
//                         bookController.detailResponse!.publisher!),
//                     Text(
//                         "Language " + bookController.detailResponse!.language!),
//                   ],
//                 ),
//                 // Text(detailResponse!.isbn10!),
//                 // Text(detailResponse!.isbn13!),
//                 // Text(detailResponse!.subtitle!),
//                 // Text(detailResponse!.rating!),
//                 const Divider(),

//                 bookController.similiarBooks == null
//                     ? const CircularProgressIndicator()
//                     : SizedBox(
//                         height: 180,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           shrinkWrap: true,
//                           itemCount:
//                               bookController.similiarBooks!.books!.length,
//                           physics: const BouncingScrollPhysics(),
//                           itemBuilder: (context, index) {
//                             final current =
//                                 bookController.similiarBooks!.books![index];
//                             return SizedBox(
//                               width: 100,
//                               child: Column(
//                                 children: [
//                                   Image.network(
//                                     current.image!,
//                                     height: 100,
//                                   ),
//                                   Text(
//                                     current.title!,
//                                     style: const TextStyle(fontSize: 12),
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     textAlign: TextAlign.center,
//                                   )
//                                 ],
//                               ),
//                             );
//                           },
//                         ),
//                       )
//               ],
//             ),
//           ),
//         ));
//   }
// }
