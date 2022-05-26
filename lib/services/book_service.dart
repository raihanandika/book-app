import 'package:easy_api/easy_api.dart';

class MyNetworkClass extends EasyApiHelper {
  MyNetworkClass({required String baseAPiUrl}) : super(baseApiUrl: "");

  Future fetchData() async {
    return sendGetRequest(route: "https://api.itbook.store/1.0/new");
  }
}
