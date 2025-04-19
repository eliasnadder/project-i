// booking_card.dart
import 'package:flutter/material.dart';

// بطاقة لعرض معلومات الحجز
class BookingInfoCard extends StatelessWidget {
  final String imageUrl; // رابط صورة المكان
  final String placeTitle; // عنوان المكان
  final String location; // موقع المكان
  final String bookingDates; // تواريخ الحجز
  final int numberOfGuests; // عدد الضيوف
  final String? status; // حالة الحجز (اختياري)
  final VoidCallback? onTap; // دالة تُستدعى عند الضغط على البطاقة

  const BookingInfoCard({
    Key? key,
    required this.imageUrl,
    required this.placeTitle,
    required this.location,
    required this.bookingDates,
    required this.numberOfGuests,
    this.status,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Card(
      // تحديد شكل البطاقة بحواف دائرية
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      // تحديد ارتفاع الظل للبطاقة
      elevation: 3.0,
      // إضافة هامش حول البطاقة
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      child: InkWell(
        onTap: onTap, // تحديد دالة الاستجابة للنقر
        borderRadius: BorderRadius.circular(12.0), // مطابقة حواف الاستجابة للنقر مع حواف البطاقة
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start, // محاذاة العناصر في بداية المحور الرأسي
          children: [
            // قص الصورة لتتوافق مع حواف البطاقة الدائرية اليسرى
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                bottomLeft: Radius.circular(12.0),
              ),
              child: Image.network(
                imageUrl,
                width: 110, // عرض الصورة
                height: 135, // ارتفاع الصورة (لضمان تغطية ارتفاع البطاقة بشكل أفضل)
                fit: BoxFit.cover, // كيفية احتواء الصورة داخل المساحة المخصصة

                // عنصر نائب يظهر أثناء تحميل الصورة
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child; // إذا اكتمل التحميل، اعرض الصورة
                  return Container(
                    width: 110,
                    height: 135,
                    color: Colors.grey[200], // لون خلفية رمادي فاتح
                    child: Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2.0,
                        // حساب قيمة التقدم إذا كانت متاحة
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes!
                            : null,
                      ),
                    ),
                  );
                },

                // عنصر نائب يظهر في حالة حدوث خطأ في تحميل الصورة
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: 110,
                    height: 135,
                    color: Colors.grey[200],
                    child: Icon(Icons.broken_image_outlined, color: Colors.grey[400], size: 40), // أيقونة صورة معطلة
                  );
                },
              ),
            ),

            // قسم النصوص والمعلومات بجانب الصورة
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0), // إضافة حشوة داخلية
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start, // محاذاة النصوص إلى اليسار
                  mainAxisAlignment: MainAxisAlignment.spaceBetween, // توزيع المساحة بين العناصر
                  children: [
                    // عنوان المكان
                    Text(
                      placeTitle,
                      style: textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold), // نمط النص للعنوان
                      maxLines: 2, // الحد الأقصى لعدد الأسطر
                      overflow: TextOverflow.ellipsis, // عرض نقاط (...) إذا تجاوز النص المساحة
                    ),
                    const SizedBox(height: 6), // مسافة فاصلة

                    // معلومات الموقع
                    _buildInfoRow(
                      context,
                      icon: Icons.location_on_outlined,
                      text: location,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4), // مسافة فاصلة

                    // تواريخ الحجز
                    _buildInfoRow(
                      context,
                      icon: Icons.calendar_today_outlined,
                      text: bookingDates,
                      style: textTheme.bodyMedium,
                    ),
                    const SizedBox(height: 4), // مسافة فاصلة

                    // عدد الضيوف
                    _buildInfoRow(
                      context,
                      icon: Icons.person_outline,
                      // ملاحظة: تم تعديل النص ليكون أكثر توافقًا مع الترجمة
                      text: '$numberOfGuests ${numberOfGuests == 1 ? "ضيف" : "ضيوف"}',
                      style: textTheme.bodyMedium,
                    ),

                    // عرض حالة الحجز إذا كانت متوفرة
                    if (status != null && status!.isNotEmpty) ...[
                      const SizedBox(height: 8), // مسافة إضافية قبل الحالة
                      Align( // محاذاة عنصر الحالة إلى اليمين (أو اليسار حسب اللغة)
                        alignment: AlignmentDirectional.centerStart,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            // تحديد لون الخلفية بناءً على الحالة (مثال)
                            color: _getStatusColor(status!).withOpacity(0.15),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            status!,
                            style: textTheme.bodySmall?.copyWith(
                              // تحديد لون النص بناءً على الحالة
                              color: _getStatusColor(status!),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ]
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // دالة مساعدة لإنشاء صف معلومات (أيقونة + نص)
  Widget _buildInfoRow(BuildContext context, {required IconData icon, required String text, TextStyle? style}) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Colors.grey[600]), // الأيقونة
        const SizedBox(width: 4), // مسافة بين الأيقونة والنص
        Expanded( // السماح للنص بالتمدد وشغل المساحة المتبقية
          child: Text(
            text,
            style: style ?? Theme.of(context).textTheme.bodyMedium, // استخدام النمط الافتراضي إذا لم يتم توفيره
            overflow: TextOverflow.ellipsis, // عرض نقاط (...) إذا تجاوز النص المساحة
            maxLines: 1, // الحد الأقصى لعدد الأسطر
          ),
        ),
      ],
    );
  }

  // دالة لتحديد لون الحالة (يمكن تخصيصها أكثر)
  Color _getStatusColor(String status) {
    // يمكنك إضافة المزيد من الحالات والألوان هنا
    if (status.toLowerCase() == 'مؤكد' || status.toLowerCase() == 'confirmed') {
      return Colors.green.shade700;
    } else if (status.toLowerCase() == 'ملغي' || status.toLowerCase() == 'cancelled') {
      return Colors.red.shade700;
    } else if (status.toLowerCase() == 'قيد الانتظار' || status.toLowerCase() == 'pending') {
      return Colors.orange.shade700;
    }
    return Colors.grey.shade700; // لون افتراضي
  }
}
