import 'dart:convert';

import 'package:book_app/controllers/book_controller.dart';

import 'package:book_app/views/detail_book_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookListPage extends StatelessWidget {
  BookListPage({Key? key}) : super(key: key);
  BookController? bookController;

  @override
  Widget build(BuildContext context) {
    bookController = Provider.of<BookController>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Catalogue"),
      ),
      body: FutureBuilder(
          future: bookController!.fetchBookApi(),
          builder: (contex, snapshot) {
            // if (snapshot.connectionState == ConnectionState.none &&
            //     snapshot.hasData == null) {
            //   print('Project snapshot data is: ${snapshot.data}');

            //   return SnackBar(
            //       content: Row(
            //     children: const [
            //       CircularProgressIndicator(),
            //       SizedBox(width: 15),
            //       Text("Anda sedang offline")
            //     ],
            //   ));
            // }
            // print("this is snapshot");
            // print(snapshot.connectionState);
            // print(snapshot.hashCode);
            return Consumer<BookController>(
              child: const Center(child: CircularProgressIndicator()),
              builder: (context, controller, child) => Container(
                child: bookController!.bookListResponse == null
                    ? child
                    : ListView.builder(
                        itemCount:
                            bookController!.bookListResponse!.books!.length,
                        itemBuilder: (context, index) {
                          final currentBook =
                              bookController!.bookListResponse!.books![index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (contex) => DetailBookPage(
                                        isbn: currentBook.isbn13!,
                                      )));
                            },
                            child: Row(
                              children: [
                                Image.network(
                                  currentBook.image!,
                                  height: 100,
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(currentBook.title!),
                                        Text(currentBook.subtitle!),
                                        Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(currentBook.price!))
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
              ),
            );
          }),
    );
  }
}

// class BookListPage extends StatefulWidget {
//   const BookListPage({Key? key}) : super(key: key);

//   @override
//   State<BookListPage> createState() => _BookListPageState();
// }

// class _BookListPageState extends State<BookListPage> {
//   BookController? bookController;
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     bookController = Provider.of<BookController>(context, listen: false);
//     bookController!.fetchBookApi();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Book Catalogue"),
//         ),
//         body: Consumer<BookController>(
//             child: const Center(
//               child: CircularProgressIndicator(),
//             ),
//             builder: (context, controller, child) => Container(
//                   child: bookController!.bookListResponse == null
//                       ? child
//                       : ListView.builder(
//                           itemCount:
//                               bookController!.bookListResponse!.books!.length,
//                           itemBuilder: (context, index) {
//                             final currentBook =
//                                 bookController!.bookListResponse!.books![index];
//                             return GestureDetector(
//                               onTap: () {
//                                 Navigator.of(context).push(MaterialPageRoute(
//                                     builder: (contex) => DetailBookPage(
//                                           isbn: currentBook.isbn13!,
//                                         )));
//                               },
//                               child: Row(
//                                 children: [
//                                   Image.network(
//                                     currentBook.image!,
//                                     height: 100,
//                                   ),
//                                   Expanded(
//                                     child: Padding(
//                                       padding: const EdgeInsets.symmetric(
//                                           horizontal: 12),
//                                       child: Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Text(currentBook.title!),
//                                           Text(currentBook.subtitle!),
//                                           Align(
//                                               alignment: Alignment.topLeft,
//                                               child: Text(currentBook.price!))
//                                         ],
//                                       ),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             );
//                           }),
//                 )));
//   }
// }
