import 'dart:math' as math;

/// true  = العرض من الأحدث للأقدم (السيرفر بيرجّع الأقدم أولاً بالـ id).
/// false = نرجع لترتيب السيرفر زي ما هو (لو السيرفر بقى بيرجّع الأحدث أولاً).
const bool kNewestFirst = true;

/// فشل جلب صفحة (الرسالة جاهزة للعرض).
class PageFetchError implements Exception {
  final String message;
  PageFetchError(this.message);
  @override
  String toString() => message;
}

class NewestFirstPage<T> {
  final List<T> items;
  final int total;
  const NewestFirstPage(this.items, this.total);

  int totalPages(int size) => total == 0 ? 0 : (total + size - 1) ~/ size;
}

/// الـ API ما فيهوش باراميتر ترتيب، والسيرفر بيرجّع الأقدم الأول، فبنجيب
/// الصفحات من الآخر ونعكسها عشان صفحة 1 = الأحدث.
///
/// [fetch] بتجيب صفحة من السيرفر (1-based) وبترجّع عناصرها وإجمالي العدد،
/// ولو فشلت ترمي [PageFetchError].
///
/// بيتعمل طلب إضافي (الصفحة الأولى) عشان نعرف الإجمالي، وممكن صفحتين من
/// السيرفر للصفحة الواحدة لو الحدود مش متطابقة.
Future<NewestFirstPage<T>> fetchNewestFirst<T>({
  required int page,
  required int size,
  required Future<({List<T> items, int total})> Function(int serverPage) fetch,

  /// مفتاح الوقت/الـ id للعنصر: لو اتبعت، بنكتشف ترتيب السيرفر تلقائياً
  /// (تصاعدي أو تنازلي) وبنرتّب الصفحة من الأحدث للأقدم في الحالتين.
  Comparable Function(T item)? sortKey,
}) async {
  if (!kNewestFirst) {
    final r = await fetch(page);
    return NewestFirstPage(r.items, r.total);
  }

  final first = await fetch(1);
  final n = first.total;
  if (n == 0) return const NewestFirstPage([], 0);

  // السيرفر أصلاً بيرجّع الأحدث أولاً -> ترقيم عادي + ترتيب تنازلي للصفحة
  if (sortKey != null && first.items.length >= 2) {
    final a = sortKey(first.items.first);
    final b = sortKey(first.items.last);
    if (a.compareTo(b) > 0) {
      final r = page == 1 ? first : await fetch(page);
      final items = [...r.items]
        ..sort((x, y) => sortKey(y).compareTo(sortKey(x)));
      return NewestFirstPage(items, n);
    }
  }

  // مواضع العناصر (0-based) بترتيب السيرفر التصاعدي اللي بتقابل الصفحة دي
  final hi = n - 1 - (page - 1) * size;
  if (hi < 0) return NewestFirstPage(const [], n); // صفحة بعد الآخر
  final lo = math.max(0, hi - size + 1);

  final fromPage = lo ~/ size + 1;
  final toPage = hi ~/ size + 1;

  final all = <T>[];
  for (var p = fromPage; p <= toPage; p++) {
    all.addAll(p == 1 ? first.items : (await fetch(p)).items);
  }

  final offset = (fromPage - 1) * size;
  final start = lo - offset;
  final end = math.min(hi - offset + 1, all.length);
  if (start >= end) return NewestFirstPage(const [], n);

  final items = all.sublist(start, end).reversed.toList();
  if (sortKey != null) {
    items.sort((x, y) => sortKey(y).compareTo(sortKey(x)));
  }
  return NewestFirstPage(items, n);
}
