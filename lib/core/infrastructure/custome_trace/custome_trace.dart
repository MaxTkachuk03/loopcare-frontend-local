class CustomTrace {
  final StackTrace _trace;

  String? fileName;
  String? functionName;
  late String callerFunctionName;
  late int lineNumber;
  late int columnNumber;

  CustomTrace(this._trace) {
    _parseTrace();
  }

  String _getFunctionNameFromFrame(String frame) {
    /* Just giving another nickname to the frame */
    final currentTrace = frame;

    /* To get rid off the #number thing, get the index of the first whitespace */
    var indexOfWhiteSpace = currentTrace.indexOf(' ');

    /* Create a substring from the first whitespace index till the end of the string */
    var subStr = currentTrace.substring(indexOfWhiteSpace);

    /* Grab the function name using reg expr */
    final indexOfFunction = subStr.indexOf(RegExp('[A-Za-z0-9]'));

    /* Create a new substring from the function name index till the end of string */
    subStr = subStr.substring(indexOfFunction);

    indexOfWhiteSpace = subStr.indexOf(' ');

    return subStr.substring(0, indexOfWhiteSpace);
  }

  void _parseTrace() {
    /* The trace comes with multiple lines of strings, (each line is also known as a frame), so split the trace's string by lines to get all the frames */
    final frames = _trace.toString().split('\n');

    /* The first frame is the current function */
    functionName = _getFunctionNameFromFrame(frames.first).split('<').first;

    /* The second frame is the caller function */

    callerFunctionName = _getFunctionNameFromFrame(frames[2]);

    /* The first frame has all the information we need */
    final traceString = frames.first;

    /* Search through the string and find the index of the file name by looking for the '.dart' regex */
    final indexOfFileName = traceString.indexOf(RegExp('[A-Za-z]+.dart'));

    final fileInfo = traceString.substring(indexOfFileName);

    final listOfInfos = fileInfo.split(':');

    /* Splitting fileInfo by the character ":" separates the file name, the line number and the column counter nicely.
      Example: main.dart:5:12
      To get the file name, we split with ":" and get the first index
      To get the line number, we would have to get the second index
      To get the column number, we would have to get the third index
    */

    fileName = listOfInfos.first;
    lineNumber = int.parse(listOfInfos[1]);
    var columnStr = listOfInfos[2];
    columnStr = columnStr.replaceFirst(')', '');
    columnNumber = int.parse(columnStr);
  }
}
