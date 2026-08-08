class ApiEndpoints {
  ApiEndpoints._();
  // Auth
  static const String login = '/auth/login';
  static const String refresh = '/auth/refresh';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';

 static const String adminTechnicianApprovals = '/admin/provider-approvals/technician';
static const String adminCarWasherApprovals = '/admin/provider-approvals/car-washer';
static const String adminFuelProviderApprovals = '/admin/provider-approvals/fuel-provider';
static const String adminShopApprovals = '/admin/provider-approvals/shop';
static const String adminLogin = '/auth/login';
static const String adminMe = '/auth/me';
static const String adminLogout = '/auth/logout';
static const String adminBillingInvoices = '/admin/billing/invoices';
static const String adminBillingInvoicesGenerate = '/admin/billing/invoices/generate';
 static const String healthCheck = '/health';
  static const String activeAdvertisements = '/advertisements/active';
  static const String dashboardSummary = '/admin/dashboard/summary';
  static const String dashboardOperations = '/admin/dashboard/operations';
  static const String dashboardRevenue = '/admin/dashboard/revenue';
static const String adminDashboardSummary = '/admin/dashboard/summary';
static const String adminDashboardOperations = '/admin/dashboard/operations';
static const String adminDashboardRevenue = '/admin/dashboard/revenue';
static const String reportsOverview = '/admin/reports/overview';
static const String reportsOperations = '/admin/reports/operations';
static const String reportsProviders = '/admin/reports/providers';
static const String reportsFinancial = '/admin/reports/financial';
static const String reportsBilling = '/admin/reports/billing';
static const String adminAdvertisements = '/admin/advertisements';
static const String reportsAdvertisements = '/admin/reports/advertisements';
static const String adminBillingSettings = '/admin/billing/settings';

}
