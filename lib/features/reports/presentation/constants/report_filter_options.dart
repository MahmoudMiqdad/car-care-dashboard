
class ReportFilterOptions {
  const ReportFilterOptions._();

  static const List<String> providerTypes = [
    'technician',
    'fuel-provider',
    'car-washer',
    'shop',
  ];

  static const List<String> operationStatuses = [
    'total',
    'completed',
    'in_progress',
    'cancelled',
    'pending',
  ];

  static const List<String> operationTypes = [
    'totals',
    'maintenance',
    'sos',
    'fuel',
    'car_wash',
    'spare_parts',
  ];

  static const List<String> groupByOptions = ['day', 'month', 'year'];

  static const List<String> providerStatuses = [
    'pending',
    'approved',
    'rejected',
    'suspended',
  ];

  static const List<String> billingStatuses = [
    'not_configured',
    'exempt',
    'free_trial',
    'active',
    'invoice_due',
    'overdue',
  ];

  static const List<String> invoiceStatuses = [
    'draft',
    'issued',
    'overdue',
    'paid',
    'cancelled',
  ];
}