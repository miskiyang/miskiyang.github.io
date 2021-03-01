/// 返回给前端ui的dto
class ResultDto<T> {
  bool success;
  int code;
  String msg;
  T data;
  int from;
  int count;

  ResultDto.success(int code, String msg, T data, {int from, int count}) {
    this.success = true;
    this.code = code;
    this.msg = msg;
    this.data = data;
    this.from = from;
    this.count = count;
  }

  ResultDto.failure(int code, String msg, {int from, int count}) {
    this.success = false;
    this.code = code;
    this.msg = msg;
    this.data = null;
    this.from = from;
    this.count = count;
  }

  @override
  String toString() {
    return 'ResultDto{success: $success, code: $code, msg: $msg, data: $data, from: $from, count: $count}';
  }
}
