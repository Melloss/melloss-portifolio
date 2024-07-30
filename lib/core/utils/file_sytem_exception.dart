class FileSystemException implements Exception {
  final String message;
  FileSystemException(this.message);
  @override
  String toString() {
    return "Terminal Exception: $message";
  }
}
