import 'package:meta/meta.dart' show required;

class ModelLogConsole {
  final int cmd;
  final String log;
  final bool isResponse;
  final bool isResponseOk;
  final int cmdError;
  final bool showSnackBar;

  ModelLogConsole(
      {@required this.cmd,
      @required this.log,
      this.isResponse = true,
      this.isResponseOk = false,
      this.cmdError = 0x00,
      this.showSnackBar = true
      });
}
