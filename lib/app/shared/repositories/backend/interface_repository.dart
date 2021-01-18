abstract class IRepository {
  Map<String, String> data = {};
  String router = "";

  Future store();
  Future index();
  Future show();
  Future delete();
  Future update();
}
