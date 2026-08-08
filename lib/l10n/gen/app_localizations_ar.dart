// dart format off
// coverage:ignore-file

// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get dashboardMenu => 'لوحة التحكم';

  @override
  String get techniciansMenu => 'الفنيين';

  @override
  String get ordersMenu => 'الطلبات';

  @override
  String get fuelProvidersMenu => 'مزودي الوقود';

  @override
  String get usersMenu => 'المستخدمين';

  @override
  String get reportsMenu => 'التقارير';

  @override
  String get settingsMenu => 'الإعدادات';

  @override
  String get adminLabel => 'المدير';

  @override
  String get refresh => 'تحديث';

  @override
  String get techniciansPageTitle => 'إدارة الفنيين';

  @override
  String get statusAll => 'الكل';

  @override
  String get statusPending => 'قيد الانتظار';

  @override
  String get statusApproved => 'مقبول';

  @override
  String get statusRejected => 'مرفوض';

  @override
  String get statusSuspended => 'موقوف';

  @override
  String get columnTechnician => 'الفني';

  @override
  String get columnSpecialization => 'التخصص';

  @override
  String get columnCity => 'المدينة';

  @override
  String get columnExperience => 'سنوات الخبرة';

  @override
  String get columnHourlyRate => 'السعر بالساعة';

  @override
  String get columnStatus => 'الحالة';

  @override
  String get columnActions => 'الإجراءات';

  @override
  String get actionApprove => 'قبول';

  @override
  String get actionReject => 'رفض';

  @override
  String get actionSuspend => 'إيقاف';

  @override
  String get actionReactivate => 'إعادة تفعيل';

  @override
  String get actionDetails => 'التفاصيل';

  @override
  String get yearsSuffix => 'سنة';

  @override
  String get rejectDialogTitle => 'سبب رفض الفني';

  @override
  String get rejectDialogHint => 'اكتب سبب الرفض هون...';

  @override
  String get cancel => 'إلغاء';

  @override
  String get confirmReject => 'تأكيد الرفض';

  @override
  String get technicianDetailsTitle => 'بيانات الفني';

  @override
  String get detailsEmail => 'البريد الإلكتروني';

  @override
  String get detailsPhone => 'الهاتف';

  @override
  String get detailsSpecialization => 'التخصص';

  @override
  String get detailsCity => 'المدينة';

  @override
  String get detailsExperience => 'سنوات الخبرة';

  @override
  String get detailsHourlyRate => 'السعر بالساعة';

  @override
  String get detailsStatus => 'الحالة';

  @override
  String get detailsRejectionReason => 'سبب الرفض';

  @override
  String get detailsCertifications => 'الشهادات';

  @override
  String get close => 'إغلاق';

  @override
  String get detailsId => 'رقم الفني';

  @override
  String get detailsUserId => 'رقم المستخدم';

  @override
  String get detailsAvailable => 'متاح للعمل';

  @override
  String get detailsYes => 'نعم';

  @override
  String get detailsNo => 'لا';

  @override
  String get detailsApprovedAt => 'تاريخ القبول';

  @override
  String get detailsRejectedAt => 'تاريخ الرفض';

  @override
  String get detailsSuspendedAt => 'تاريخ الإيقاف';

  @override
  String get detailsCreatedAt => 'تاريخ الإنشاء';

  @override
  String get detailsUpdatedAt => 'آخر تحديث';

  @override
  String get noCertifications => 'لا توجد شهادات مرفوعة';

  @override
  String get carwashersPageTitle => 'مغاسل السيارات';

  @override
  String get carwasherDetailsTitle => 'تفاصيل المغسلة';

  @override
  String get fuelProvidersPageTitle => 'مزودو الوقود';

  @override
  String get fuelProviderDetailsTitle => 'تفاصيل مزود الوقود';

  @override
  String get shopsPageTitle => 'المتاجر';

  @override
  String get shopDetailsTitle => 'تفاصيل المتجر';

  @override
  String get columnShop => 'المتجر';

  @override
  String get columnPhone => 'الهاتف';

  @override
  String get detailsAddress => 'العنوان';

  @override
  String get detailsDescription => 'الوصف';

  @override
  String get detailsRating => 'التقييم';

  @override
  String get detailsServices => 'الخدمات';

  @override
  String get detailsServicePrices => 'أسعار الخدمات';

  @override
  String get detailsWorkingHours => 'ساعات العمل';

  @override
  String get detailsFuelTypes => 'أنواع الوقود';

  @override
  String get detailsPrices => 'الأسعار';

  @override
  String get detailsBusinessTypes => 'أنواع النشاط';

  @override
  String get detailsCarBrands => 'ماركات السيارات';

  @override
  String get detailsPartCategories => 'تصنيفات القطع';

  @override
  String get columnCompany => 'الشركة';

  @override
  String get dashboardPageTitle => 'لوحة التحكم';

  @override
  String get dashboardTotalUsers => 'إجمالي المستخدمين';

  @override
  String get dashboardTotalCustomers => 'إجمالي العملاء';

  @override
  String get dashboardCompletedOperations => 'عمليات مكتملة';

  @override
  String get dashboardPendingOperations => 'عمليات معلقة';

  @override
  String get dashboardProvidersOverview => 'نظرة عامة على مزودي الخدمة';

  @override
  String get dashboardOperationsStatus => 'حالة العمليات';

  @override
  String get dashboardOperationsOverTime => 'العمليات عبر الوقت';

  @override
  String get dashboardRevenue => 'الإيرادات';

  @override
  String get dashboardPeriodWeek => 'أسبوع';

  @override
  String get dashboardPeriodMonth => 'شهر';

  @override
  String get dashboardPeriodYear => 'سنة';

  @override
  String get detailsLocation => 'الموقع';

  @override
  String get carwashersMenu => 'مغاسل السيارات';

  @override
  String get shopsMenu => 'المتاجر';

  @override
  String get loginTitle => 'تسجيل الدخول';

  @override
  String get loginSubtitle => 'سجّل الدخول للوصول إلى لوحة تحكم الأدمن';

  @override
  String get loginEmailLabel => 'البريد الإلكتروني';

  @override
  String get loginPasswordLabel => 'كلمة المرور';

  @override
  String get loginButton => 'تسجيل الدخول';

  @override
  String get loginValidationRequired => 'هذا الحقل مطلوب';

  @override
  String get loginValidationEmail => 'الرجاء إدخال بريد إلكتروني صحيح';

  @override
  String get logoutButton => 'تسجيل الخروج';

  @override
  String get logoutConfirmTitle => 'تسجيل الخروج';

  @override
  String get logoutConfirmMessage => 'هل أنت متأكد من رغبتك بتسجيل الخروج؟';

  @override
  String get logoutConfirmButton => 'تسجيل الخروج';

  @override
  String get reportsPageTitle => 'التقارير';

  @override
  String get tabOverview => 'نظرة عامة';

  @override
  String get tabProviders => 'المزودون';

  @override
  String get tabFinancial => 'المالية';

  @override
  String get tabBilling => 'الفوترة';

  @override
  String get tabAdvertisements => 'الإعلانات';

  @override
  String get reportFilterClear => 'مسح';

  @override
  String get reportFilterApply => 'تطبيق';

  @override
  String get reportFilterAll => 'الكل';

  @override
  String get reportRetry => 'إعادة المحاولة';

  @override
  String get reportDateFrom => 'من';

  @override
  String get reportDateTo => 'إلى';

  @override
  String get filterProviderType => 'نوع المزود';

  @override
  String get filterProviderStatus => 'حالة المزود';

  @override
  String get filterBillingStatus => 'حالة الفوترة';

  @override
  String get filterInvoiceStatus => 'حالة الفاتورة';

  @override
  String get filterOperationType => 'نوع العملية';

  @override
  String get filterStatus => 'الحالة';

  @override
  String get filterGroupBy => 'التجميع حسب';

  @override
  String get filterPlacement => 'الموضع';

  @override
  String get providerTypeTechnician => 'فني';

  @override
  String get providerTypeFuelProvider => 'موزع وقود';

  @override
  String get providerTypeCarWasher => 'مغسلة';

  @override
  String get providerTypeShop => 'متجر';

  @override
  String get opStatusCompleted => 'مكتمل';

  @override
  String get opStatusInProgress => 'قيد التنفيذ';

  @override
  String get opStatusCancelled => 'ملغى';

  @override
  String get opStatusPending => 'قيد الانتظار';

  @override
  String get opTypeTotals => 'الإجمالي';

  @override
  String get opTypeMaintenance => 'صيانة';

  @override
  String get opTypeSos => 'طلبات الطوارئ';

  @override
  String get opTypeFuel => 'وقود';

  @override
  String get opTypeCarWash => 'غسيل سيارات';

  @override
  String get opTypeSpareParts => 'قطع غيار';

  @override
  String get groupByDay => 'يوم';

  @override
  String get groupByMonth => 'شهر';

  @override
  String get groupByYear => 'سنة';

  @override
  String get providerStatusPending => 'قيد الانتظار';

  @override
  String get providerStatusApproved => 'موافق عليه';

  @override
  String get providerStatusRejected => 'مرفوض';

  @override
  String get providerStatusSuspended => 'موقوف';

  @override
  String get back => 'رجوع';

  @override
  String get invoiceActionExportPdf => 'تصدير PDF';

  @override
  String get isActive => 'نشط';

  @override
  String get billingType => 'نوع الفوترة';

  @override
  String get invoicesPageTitle => 'فواتير مزوّدي الخدمة';

  @override
  String get invoiceDetailsTitle => 'تفاصيل الفاتورة';

  @override
  String get invoiceStatusAll => 'الكل';

  @override
  String get invoiceStatusDraft => 'مسودة';

  @override
  String get invoiceStatusIssued => 'صادرة';

  @override
  String get invoiceStatusPaid => 'مدفوعة';

  @override
  String get invoiceStatusOverdue => 'متأخرة';

  @override
  String get invoiceStatusCancelled => 'ملغاة';

  @override
  String get columnInvoiceNumber => 'رقم الفاتورة';

  @override
  String get columnProvider => 'المزوّد';

  @override
  String get columnPeriod => 'الفترة';

  @override
  String get columnTotalAmount => 'الإجمالي';

  @override
  String get columnDueAt => 'تاريخ الاستحقاق';

  @override
  String get invoiceFieldInvoiceNumber => 'رقم الفاتورة';

  @override
  String get invoiceFieldProviderType => 'نوع المزوّد';

  @override
  String get invoiceFieldProviderId => 'معرّف المزوّد';

  @override
  String get invoiceFieldPeriodStart => 'بداية الفترة';

  @override
  String get invoiceFieldPeriodEnd => 'نهاية الفترة';

  @override
  String get invoiceFieldIssuedAt => 'تاريخ الإصدار';

  @override
  String get invoiceFieldDueAt => 'تاريخ الاستحقاق';

  @override
  String get invoiceFieldSubtotal => 'المجموع الفرعي';

  @override
  String get invoiceFieldCommissionTotal => 'إجمالي العمولة';

  @override
  String get invoiceFieldSubscriptionTotal => 'إجمالي الاشتراك';

  @override
  String get invoiceFieldTotalAmount => 'المبلغ الإجمالي';

  @override
  String get invoiceFieldStatus => 'الحالة';

  @override
  String get invoiceFieldIsOverdue => 'متأخرة';

  @override
  String get invoiceFieldPaymentMethod => 'طريقة الدفع';

  @override
  String get invoiceFieldPaymentReference => 'مرجع الدفع';

  @override
  String get invoiceFieldPaidAt => 'تاريخ الدفع';

  @override
  String get invoiceFieldNotes => 'ملاحظات';

  @override
  String get invoiceFieldItems => 'بنود الفاتورة';

  @override
  String get invoiceActionIssue => 'إصدار';

  @override
  String get invoiceActionMarkPaid => 'تأكيد الدفع';

  @override
  String get invoiceActionCancel => 'إلغاء الفاتورة';

  @override
  String get invoiceActionGenerate => 'توليد الفواتير';

  @override
  String get invoiceActionGenerateForProvider => 'توليد فاتورة لمزوّد';

  @override
  String get invoiceGenerateDialogTitle => 'توليد الفواتير';

  @override
  String get invoiceMarkPaidDialogTitle => 'تأكيد الدفع';

  @override
  String get invoiceCancelDialogTitle => 'إلغاء الفاتورة';

  @override
  String get invoiceCancelDialogMessage => 'هل أنت متأكد من إلغاء هذه الفاتورة؟';

  @override
  String get invoiceGenerateResultTitle => 'نتيجة التوليد';

  @override
  String get invoiceGeneratedCount => 'تم التوليد';

  @override
  String get invoiceSkippedCount => 'تم التخطي';

  @override
  String get invoiceSkippedReasonAlreadyExists => 'الفاتورة موجودة مسبقاً';

  @override
  String get invoiceSkippedReasonWithinFreeTrial => 'ضمن فترة التجربة المجانية';

  @override
  String get noInvoices => 'لا توجد فواتير';

  @override
  String get invoiceViewInvoices => 'عرض الفواتير';

  @override
  String get billingStatusNotConfigured => 'غير مهيأ';

  @override
  String get billingStatusExempt => 'معفى';

  @override
  String get billingStatusFreeTrial => 'تجربة مجانية';

  @override
  String get billingStatusInvoiceDue => 'مستحق';

  @override
  String get billingStatusOverdue => 'متأخر';

  @override
  String get adStatusActive => 'مفعل';

  @override
  String get adStatusInactive => 'غير مفعل';

  @override
  String get adsTotal => 'إجمالي الإعلانات';

  @override
  String get adsActive => 'نشطة';

  @override
  String get adsInactive => 'غير نشطة';

  @override
  String get adsExpired => 'منتهية';

  @override
  String get adsScheduled => 'مجدولة';

  @override
  String get adsByPlacementTitle => 'حسب الموضع';

  @override
  String get adsLatestTitle => 'أحدث الإعلانات';

  @override
  String get adsEmpty => 'لا توجد إعلانات';

  @override
  String get billingInvoicesCount => 'عدد الفواتير';

  @override
  String get billingDraft => 'مسودة';

  @override
  String get billingIssued => 'صادرة';

  @override
  String get billingOverdueCount => 'متأخرة';

  @override
  String get billingPaidCount => 'مدفوعة';

  @override
  String get billingCancelled => 'ملغاة';

  @override
  String get billingFinancialTotalsTitle => 'الإجماليات المالية';

  @override
  String get billingPaidTotal => 'إجمالي المدفوع';

  @override
  String get billingUnpaidTotal => 'إجمالي غير المدفوع';

  @override
  String get billingOverdueTotal => 'إجمالي المتأخر';

  @override
  String get billingAvgInvoice => 'متوسط قيمة الفاتورة';

  @override
  String get billingProvidersOverdue => 'مزودون متأخرون';

  @override
  String get billingLatestInvoicesTitle => 'أحدث الفواتير';

  @override
  String get billingEmpty => 'لا توجد فواتير';

  @override
  String get billingStatusLabel => 'حالة';

  @override
  String get billingIssuedAtLabel => 'صدرت';

  @override
  String get financialGrossRevenueTitle => 'الإيرادات الإجمالية';

  @override
  String get financialBillingSummaryTitle => 'ملخص الفوترة';

  @override
  String get financialIssuedTotal => 'إجمالي الصادر';

  @override
  String get financialPaid => 'المدفوع';

  @override
  String get financialUnpaid => 'غير المدفوع';

  @override
  String get financialOverdue => 'المتأخر';

  @override
  String get financialCommissions => 'العمولات';

  @override
  String get financialSubscriptions => 'الاشتراكات';

  @override
  String get operationsTitle => 'العمليات';

  @override
  String operationsGroupedTitle(String group) {
    return 'العمليات (مجمعة حسب $group)';
  }

  @override
  String get operationsEmpty => 'لا توجد بيانات';

  @override
  String get overviewTotalUsers => 'إجمالي المستخدمين';

  @override
  String get overviewTotalCustomers => 'إجمالي العملاء';

  @override
  String get overviewTotalProviders => 'إجمالي المزودين';

  @override
  String get overviewProvidersByTypeStatusTitle => 'المزودون حسب النوع والحالة';

  @override
  String get overviewOperationsSummaryTitle => 'ملخص العمليات';

  @override
  String get overviewRevenueSummaryTitle => 'ملخص الإيرادات';

  @override
  String get providersPendingApproval => 'بانتظار الموافقة';

  @override
  String get providersOverdueBilling => 'فواتير متأخرة';

  @override
  String get providersBillingNotConfigured => 'فوترة غير مهيأة';

  @override
  String get providersCountByTypeTitle => 'عدد المزودين حسب النوع';

  @override
  String get providersStatusByTypeTitle => 'الحالة حسب النوع';

  @override
  String get providersTopByCompletedTitle => 'أفضل المزودين حسب العمليات المكتملة';

  @override
  String providersCompletedOpsLine(String name, String id, String count) {
    return '$name (#$id) — $count عملية مكتملة';
  }

  @override
  String get advertisementsMenu => 'الإعلانات';

  @override
  String get advertisementsPageTitle => 'الإعلانات';

  @override
  String get advertisementDetailsTitle => 'تفاصيل الإعلان';

  @override
  String get adColumnImage => 'الصورة';

  @override
  String get adColumnTitle => 'العنوان';

  @override
  String get adColumnPlacement => 'الموقع';

  @override
  String get adColumnPeriod => 'الفترة';

  @override
  String get adColumnStatus => 'الحالة';

  @override
  String get adColumnSortOrder => 'الترتيب';

  @override
  String get adColumnActions => 'الإجراءات';

  @override
  String get adFilterAll => 'الكل';

  @override
  String get adFilterHome => 'الرئيسية';

  @override
  String get adActionActivate => 'تفعيل';

  @override
  String get adActionDeactivate => 'إلغاء التفعيل';

  @override
  String get adActionEdit => 'تعديل';

  @override
  String get adActionDelete => 'حذف';

  @override
  String get adCreateNew => 'إعلان جديد';

  @override
  String get adFormTitleLabel => 'العنوان';

  @override
  String get adFormPlacementLabel => 'الموقع';

  @override
  String get adFormLinkLabel => 'رابط الإعلان';

  @override
  String get adFormStartsLabel => 'تاريخ البداية';

  @override
  String get adFormEndsLabel => 'تاريخ النهاية';

  @override
  String get adFormSortOrderLabel => 'ترتيب الظهور';

  @override
  String get adFormActiveLabel => 'مفعل';

  @override
  String get adFormImageLabel => 'الصورة';

  @override
  String get adFormImageHint => 'jpeg/jpg/png/webp، الحد الأقصى 2 ميجابايت';

  @override
  String get adFormChooseImage => 'اختيار صورة';

  @override
  String get adFormChangeImage => 'تغيير الصورة';

  @override
  String get adFormSave => 'حفظ';

  @override
  String get adFormRequiredField => 'هذا الحقل مطلوب';

  @override
  String get adFormImageRequired => 'يرجى اختيار صورة';

  @override
  String get adDeleteConfirmTitle => 'حذف الإعلان';

  @override
  String get adDeleteConfirmMessage => 'هل أنت متأكد من حذف هذا الإعلان؟';

  @override
  String get adCreatedSuccess => 'تم إنشاء الإعلان بنجاح';

  @override
  String get adUpdatedSuccess => 'تم تحديث الإعلان بنجاح';

  @override
  String get adDeletedSuccess => 'تم حذف الإعلان بنجاح';

  @override
  String get adActivatedSuccess => 'تم تفعيل الإعلان';

  @override
  String get adDeactivatedSuccess => 'تم إلغاء تفعيل الإعلان';

  @override
  String get noAdvertisements => 'لا يوجد إعلانات';

  @override
  String get adRankingExplanation => 'الترتيب يبدأ من 1، فمثلاً 1 يعني هاد أول إعلان بيظهر';

  @override
  String get billingSettingsPageTitle => 'إعدادات الفوترة';

  @override
  String get billingCreateNew => 'فاتورة جديد';

  @override
  String get billingSettingLinkButton => 'إعداد الفوترة';

  @override
  String get billingColumnProvider => 'المزوّد';

  @override
  String get billingColumnType => 'نوع الفوترة';

  @override
  String get billingColumnMonthlyFee => 'الاشتراك الشهري';

  @override
  String get billingColumnCommission => 'نسبة العمولة';

  @override
  String get billingColumnStartsAt => 'تاريخ البدء';

  @override
  String get billingStatusActive => 'نشط';

  @override
  String get billingStatusInactive => 'غير فعّال';

  @override
  String get billingDeleteTitle => 'حذف إعداد الفوترة';

  @override
  String get billingDeleteMessage => 'هل أنت متأكد من حذف هذا الإعداد؟';

  @override
  String get confirmDelete => 'حذف';

  @override
  String get billingFormTitleCreate => 'إنشاء إعداد فوترة';

  @override
  String get billingFormTitleEdit => 'تعديل إعداد الفوترة';

  @override
  String get billingFieldProviderType => 'نوع المزوّد';

  @override
  String get billingFieldProviderId => 'معرّف المزوّد';

  @override
  String get billingFieldBillingType => 'نوع الفوترة';

  @override
  String get billingFieldMonthlyFee => 'الاشتراك الشهري';

  @override
  String get billingFieldCommissionPercent => 'نسبة العمولة %';

  @override
  String get billingFieldFreeTrialDays => 'أيام التجربة المجانية';

  @override
  String get billingFieldPaymentDueDays => 'مهلة الدفع (أيام)';

  @override
  String get billingFieldStartsAt => 'تاريخ البدء';

  @override
  String get billingDetailsTitle => 'تفاصيل الفوترة';

  @override
  String get billingTypeSubscriptionPlusCommission => 'اشتراك + عمولة';

  @override
  String get billingTypeExempt => 'معفى';

  @override
  String get billingFieldExemptMethod => 'طريقة الإعفاء';

  @override
  String get billingTypeCommission => 'نوع الفوترة: عمولة';

  @override
  String get billingTypeMonthly => 'فوترة شهرية';

  @override
  String get billingFieldIsActive => 'فعّال؟';

  @override
  String get billingFieldNotes => 'ملاحظات';

  @override
  String get billingPickDate => 'اختر التاريخ';

  @override
  String get fieldRequired => 'هذا الحقل مطلوب';

  @override
  String get save => 'حفظ';

  @override
  String get actionEdit => 'تعديل';

  @override
  String get actionDelete => 'حذف';

  @override
  String get service => 'الخدمة';

  @override
  String get dashboard => 'لوحة التحكم';

  @override
  String get general => 'عام';

  @override
  String get paymentMethodCash => 'نقداً';

  @override
  String get paymentMethodBankTransfer => 'تحويل بنكي';

  @override
  String get paymentMethodShamCash => 'شام كاش';

  @override
  String get paymentMethodSyriatelCash => 'سيرياتيل كاش';

  @override
  String get paymentMethodOther => 'أخرى';

  @override
  String get settingsPageTitle => 'الإعدادات';

  @override
  String get settingsLanguageSection => 'اللغة';

  @override
  String get settingsThemeSection => 'المظهر';

  @override
  String get settingsLanguageArabic => 'العربية';

  @override
  String get settingsLanguageEnglish => 'الإنجليزية';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsThemeSystem => 'حسب النظام';
}
