import 'dart:typed_data';

import 'package:arabic_reshaper/arabic_reshaper.dart';
import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/features/invoice/domain/entities/invoice_entity.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoicePdfGenerator {
  /// يعيد تشكيل النص العربي (يوصل الحروف ببعضها) — لازم خط يدعم
  /// Arabic Presentation Forms متل Amiri منشان يشتغل صح.
  static String _ar(String? text) {
    if (text == null || text.isEmpty) return text ?? '';
    final hasArabic = RegExp(r'[\u0600-\u06FF]').hasMatch(text);
    if (!hasArabic) return text;
    return ArabicReshaper.instance.reshape(text);
  }

  static Future<Uint8List> generate(
    InvoiceEntity invoice, {
    String? customerName,
    String? customerCity,
    String? customerPhone,
    String languageCode = 'ar', // 👈 الافتراضي عربي دايماً
  }) async {
    final isRtl = languageCode.toLowerCase() == 'ar';
    final t = _InvoiceTexts(isRtl);
    final direction = isRtl ? pw.TextDirection.rtl : pw.TextDirection.ltr;

    final doc = pw.Document();

    // ===== تحميل الشعار =====
    final logoBytes = await rootBundle.load(AppAssets.logo);
    final logoImage = pw.MemoryImage(logoBytes.buffer.asUint8List());

    // ===== تحميل الخط حسب اللغة =====
    // Amiri للعربي (يدعم Arabic Presentation Forms بشكل صحيح مع reshaper)
    // Cairo للإنجليزي (أنظف بصرياً للأرقام واللاتيني)
    final pw.Font regularFont;
    final pw.Font boldFont;

    if (isRtl) {
      final regularFontData = await rootBundle.load('assets/fonts/Amiri-Regular.ttf');
      final boldFontData = await rootBundle.load('assets/fonts/Amiri-Bold.ttf');
      regularFont = pw.Font.ttf(regularFontData);
      boldFont = pw.Font.ttf(boldFontData);
    } else {
      final regularFontData = await rootBundle.load('assets/fonts/Cairo-Regular.ttf');
      final boldFontData = await rootBundle.load('assets/fonts/Cairo-Bold.ttf');
      regularFont = pw.Font.ttf(regularFontData);
      boldFont = pw.Font.ttf(boldFontData);
    }

    final theme = pw.ThemeData.withFont(
      base: regularFont,
      bold: boldFont,
    );

    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(32),
        theme: theme,
        textDirection: direction,
        build: (context) {
          return pw.Directionality(
            textDirection: direction,
            child: pw.Stack(
              children: [
                pw.Positioned.fill(
                  child: pw.Center(
                    child: pw.Opacity(
                      opacity: 0.08,
                      child: pw.Image(logoImage, width: 320, height: 320, fit: pw.BoxFit.contain),
                    ),
                  ),
                ),
                pw.Column(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Row(
                          crossAxisAlignment: pw.CrossAxisAlignment.center,
                          children: [
                            pw.Container(
                              width: 44,
                              height: 44,
                              child: pw.Image(logoImage, fit: pw.BoxFit.contain),
                            ),
                            pw.SizedBox(width: 10),
                            pw.Column(
                              crossAxisAlignment: pw.CrossAxisAlignment.start,
                              children: [
                                pw.Text('Car Care', style: pw.TextStyle(fontSize: 20, fontWeight: pw.FontWeight.bold)),
                                pw.Text(t.invoiceLabel, style: pw.TextStyle(fontSize: 11, color: PdfColors.grey600, letterSpacing: 1.5)),
                              ],
                            ),
                          ],
                        ),
                        pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.end,
                          children: [
                            pw.Text(invoice.invoiceNumber ?? '-', style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                            pw.SizedBox(height: 6),
                            pw.Container(
                              padding: const pw.EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                              decoration: pw.BoxDecoration(
                                color: _statusColor(invoice.effectiveStatus ?? invoice.status),
                                borderRadius: pw.BorderRadius.circular(6),
                              ),
                              child: pw.Text(
                                t.status(invoice.effectiveStatus ?? invoice.status),
                                style: pw.TextStyle(color: PdfColors.white, fontSize: 11, fontWeight: pw.FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    pw.SizedBox(height: 20),
                    pw.Divider(color: PdfColors.grey300),
                    pw.SizedBox(height: 16),

                    pw.Container(
                      padding: const pw.EdgeInsets.all(14),
                      decoration: pw.BoxDecoration(
                        color: PdfColors.grey50,
                        borderRadius: pw.BorderRadius.circular(8),
                        border: pw.Border.all(color: PdfColors.grey200),
                      ),
                      child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.Text(t.billTo, style: _labelStyle),
                          pw.SizedBox(height: 6),
                          pw.Builder(builder: (context) {
                            final shapedName = _ar(customerName);
                            return pw.Text(
                              shapedName.isNotEmpty
                                  ? shapedName
                                  : '${invoice.providerType ?? '-'} ${invoice.providerId ?? '-'}',
                              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold),
                            );
                          }),
                          if (customerCity != null && customerCity.isNotEmpty) ...[
                            pw.SizedBox(height: 5),
                            pw.Row(
                              children: [
                                pw.Text('${t.city}: ', style: _labelStyle),
                                pw.Text(_ar(customerCity), style: _valueStyle),
                              ],
                            ),
                          ],
                          if (customerPhone != null && customerPhone.isNotEmpty) ...[
                            pw.SizedBox(height: 5),
                            pw.Row(
                              children: [
                                pw.Text('${t.phone}: ', style: _labelStyle),
                                pw.Text(customerPhone, style: _valueStyle),
                              ],
                            ),
                          ],
                        ],
                      ),
                    ),

                    pw.SizedBox(height: 20),

                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(t.providerType, style: _labelStyle),
                              pw.SizedBox(height: 4),
                              pw.Text(
                                _ar(invoice.providerType).isNotEmpty ? _ar(invoice.providerType) : '-',
                                style: _valueStyle,
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(t.period, style: _labelStyle),
                              pw.SizedBox(height: 4),
                              pw.Text('${invoice.periodStart ?? '-'}  ${t.to}  ${invoice.periodEnd ?? '-'}', style: _valueStyle),
                            ],
                          ),
                        ),
                      ],
                    ),
                    pw.SizedBox(height: 14),
                    pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(t.issuedAt, style: _labelStyle),
                              pw.SizedBox(height: 4),
                              pw.Text(_shortDate(invoice.issuedAt), style: _valueStyle),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.Text(t.dueAt, style: _labelStyle),
                              pw.SizedBox(height: 4),
                              pw.Text(_shortDate(invoice.dueAt), style: _valueStyle),
                            ],
                          ),
                        ),
                      ],
                    ),

                    pw.SizedBox(height: 28),

                    pw.Text(t.items, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                    pw.SizedBox(height: 8),
                    _buildItemsTable(invoice, t, isRtl),

                    pw.SizedBox(height: 24),

                    pw.Align(
                      alignment: isRtl ? pw.Alignment.centerLeft : pw.Alignment.centerRight,
                      child: pw.Container(
                        width: 240,
                        child: pw.Column(
                          crossAxisAlignment: pw.CrossAxisAlignment.stretch,
                          children: [
                            _totalRow(t.subtotal, invoice.subtotal),
                            _totalRow(t.commission, invoice.commissionTotal),
                            _totalRow(t.subscription, invoice.subscriptionTotal),
                            pw.Divider(color: PdfColors.grey400),
                            _totalRow(t.totalAmount, invoice.totalAmount, bold: true),
                          ],
                        ),
                      ),
                    ),

                    if ((invoice.status ?? '') == 'paid') ...[
                      pw.SizedBox(height: 24),
                      pw.Divider(color: PdfColors.grey300),
                      pw.SizedBox(height: 12),
                      pw.Text(t.paymentDetails, style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 8),
                      if (invoice.externalPaymentMethod != null)
                        pw.Text('${t.method}: ${_ar(invoice.externalPaymentMethod)}', style: _valueStyle),
                      if (invoice.externalPaymentReference != null)
                        pw.Text('${t.reference}: ${invoice.externalPaymentReference}', style: _valueStyle),
                      pw.Text('${t.paidAt}: ${_shortDate(invoice.paidAt)}', style: _valueStyle),
                    ],

                    if (invoice.notes != null && invoice.notes!.isNotEmpty) ...[
                      pw.SizedBox(height: 20),
                      pw.Text(t.notes, style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
                      pw.SizedBox(height: 4),
                      pw.Text(_ar(invoice.notes), style: _valueStyle),
                    ],

                    pw.Spacer(),
                    pw.Divider(color: PdfColors.grey300),
                    pw.SizedBox(height: 8),
                    pw.Center(
                      child: pw.Text(
                        t.footer,
                        style: pw.TextStyle(fontSize: 10, color: PdfColors.grey500),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    return doc.save();
  }

  static pw.Widget _buildItemsTable(InvoiceEntity invoice, _InvoiceTexts t, bool isRtl) {
    final columnWidths = isRtl
        ? const {0: pw.FlexColumnWidth(1), 1: pw.FlexColumnWidth(3)}
        : const {0: pw.FlexColumnWidth(3), 1: pw.FlexColumnWidth(1)};

    List<pw.Widget> rowCells(String descText, String amountText, {bool bold = false}) {
      final descCell = _tableCell(descText, bold: bold, alignRight: isRtl);
      final amountCell = _tableCell(amountText, bold: bold, alignRight: true);
      return isRtl ? [amountCell, descCell] : [descCell, amountCell];
    }

    return pw.Table(
      border: pw.TableBorder.all(color: PdfColors.grey300, width: 0.5),
      columnWidths: columnWidths,
      children: [
        pw.TableRow(
          decoration: const pw.BoxDecoration(color: PdfColors.grey100),
          children: rowCells(t.description, t.amount, bold: true),
        ),
        ...invoice.items.map((item) {
          final desc = _ar(item.description ?? item.itemType);
          return pw.TableRow(
            children: rowCells(
              desc.isNotEmpty ? desc : '-',
              item.amount?.toString() ?? '0',
            ),
          );
        }),
      ],
    );
  }

  static pw.TextStyle get _labelStyle =>
      pw.TextStyle(fontSize: 10, color: PdfColors.grey600, fontWeight: pw.FontWeight.bold);

  static pw.TextStyle get _valueStyle => const pw.TextStyle(fontSize: 12);

  static pw.Widget _tableCell(String text, {bool bold = false, bool alignRight = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: pw.Align(
        alignment: alignRight ? pw.Alignment.centerRight : pw.Alignment.centerLeft,
        child: pw.Text(
          text,
          style: pw.TextStyle(fontSize: 11, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal),
        ),
      ),
    );
  }

  static pw.Widget _totalRow(String label, num? value, {bool bold = false}) {
    return pw.Padding(
      padding: const pw.EdgeInsets.symmetric(vertical: 4),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(label, style: pw.TextStyle(fontSize: bold ? 13 : 11, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal)),
          pw.Text(
            value?.toString() ?? '0',
            style: pw.TextStyle(fontSize: bold ? 13 : 11, fontWeight: bold ? pw.FontWeight.bold : pw.FontWeight.normal),
          ),
        ],
      ),
    );
  }

  static PdfColor _statusColor(String? status) {
    switch (status) {
      case 'paid':
        return PdfColors.green700;
      case 'issued':
        return PdfColors.blue700;
      case 'overdue':
        return PdfColors.red700;
      case 'cancelled':
        return PdfColors.grey600;
      case 'draft':
      default:
        return PdfColors.orange700;
    }
  }

  static String _shortDate(String? iso) {
    if (iso == null || iso.isEmpty) return '-';
    try {
      final d = DateTime.parse(iso);
      return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
    } catch (_) {
      return iso;
    }
  }
}

/// نصوص الفاتورة بالإنجليزي/العربي حسب لغة النظام
class _InvoiceTexts {
  final bool isRtl;
  const _InvoiceTexts(this.isRtl);

  String get invoiceLabel => isRtl ? 'فاتورة' : 'INVOICE';
  String get billTo => isRtl ? 'إلى' : 'Bill To';
  String get city => isRtl ? 'المدينة' : 'City';
  String get phone => isRtl ? 'الهاتف' : 'Phone';
  String get providerType => isRtl ? 'نوع المزوّد' : 'Provider Type';
  String get period => isRtl ? 'الفترة' : 'Period';
  String get to => isRtl ? 'إلى' : 'to';
  String get issuedAt => isRtl ? 'تاريخ الإصدار' : 'Issued At';
  String get dueAt => isRtl ? 'تاريخ الاستحقاق' : 'Due At';
  String get items => isRtl ? 'البنود' : 'Items';
  String get description => isRtl ? 'الوصف' : 'Description';
  String get amount => isRtl ? 'المبلغ' : 'Amount';
  String get subtotal => isRtl ? 'المجموع الفرعي' : 'Subtotal';
  String get commission => isRtl ? 'العمولة' : 'Commission';
  String get subscription => isRtl ? 'الاشتراك' : 'Subscription';
  String get totalAmount => isRtl ? 'المبلغ الإجمالي' : 'Total Amount';
  String get paymentDetails => isRtl ? 'تفاصيل الدفع' : 'Payment Details';
  String get method => isRtl ? 'طريقة الدفع' : 'Method';
  String get reference => isRtl ? 'المرجع' : 'Reference';
  String get paidAt => isRtl ? 'تاريخ الدفع' : 'Paid At';
  String get notes => isRtl ? 'ملاحظات' : 'Notes';
  String get footer => isRtl ? 'كار كير - شكراً لتعاملكم معنا' : 'Car Care - Thank you for your business';

  String status(String? raw) {
    if (!isRtl) {
      switch (raw) {
        case 'paid':
          return 'PAID';
        case 'issued':
          return 'ISSUED';
        case 'overdue':
          return 'OVERDUE';
        case 'cancelled':
          return 'CANCELLED';
        case 'draft':
          return 'DRAFT';
        default:
          return (raw ?? '-').toUpperCase();
      }
    }
    String result;
    switch (raw) {
      case 'paid':
        result = 'مدفوعة';
        break;
      case 'issued':
        result = 'صادرة';
        break;
      case 'overdue':
        result = 'متأخرة';
        break;
      case 'cancelled':
        result = 'ملغاة';
        break;
      case 'draft':
        result = 'مسودة';
        break;
      default:
        result = raw ?? '-';
    }
    return ArabicReshaper.instance.reshape(result);
  }
}