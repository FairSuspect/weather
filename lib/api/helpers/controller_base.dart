part of "../api.dart";

abstract class ControllerBase<T> {
  Dio dio;

  /// Base version of api to call
  String v;
  String key;
  ControllerBase(this.dio, this.v, this.key);

  T withVersion(String version) {
    ControllerBase<T> tmp = this;
    tmp.v = version;
    return tmp as T;
  }
}
