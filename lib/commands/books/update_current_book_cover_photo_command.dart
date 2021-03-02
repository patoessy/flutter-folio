import 'package:flutter_folio/_utils/time_utils.dart';
import 'package:flutter_folio/commands/commands.dart';
import 'package:flutter_folio/data/book_data.dart';

class UpdateCurrentBookCoverPhotoCommand extends BaseAppCommand {
  Future<void> run(PlacedScrapItem item) async {
    // Guard against non-photo content types
    if (item.contentType != ContentType.Photo) return;
    // Protect against non-changes so the views don't need to check
    if (item.data == booksModel.currentBook.imageUrl) return;
    ScrapBookData book = booksModel.currentBook.copyWith(
      imageUrl: item.data,
      lastModifiedTime: TimeUtils.nowMillis,
    );
    // Update local
    booksModel.replaceBook(book);
    // Update db
    firebase.setBook(book);

    showToast("Cover photo changed!");
  }
}
