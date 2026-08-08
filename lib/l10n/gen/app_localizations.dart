// dart format off
// coverage:ignore-file
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  /// Menu item: Dashboard
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardMenu;

  /// Menu item: Technicians
  ///
  /// In en, this message translates to:
  /// **'Technicians'**
  String get techniciansMenu;

  /// Menu item: Orders
  ///
  /// In en, this message translates to:
  /// **'Orders'**
  String get ordersMenu;

  /// Menu item: Fuel Providers
  ///
  /// In en, this message translates to:
  /// **'Fuel Providers'**
  String get fuelProvidersMenu;

  /// Menu item: Users
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usersMenu;

  /// Menu item: Reports
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsMenu;

  /// Menu item: Settings
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsMenu;

  /// Label shown next to the user avatar at the top bar
  ///
  /// In en, this message translates to:
  /// **'Admin'**
  String get adminLabel;

  /// Tooltip for the refresh list button
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// Title of the technicians management page
  ///
  /// In en, this message translates to:
  /// **'Technicians Management'**
  String get techniciansPageTitle;

  /// Filter: all technicians
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get statusAll;

  /// Technician status: pending
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get statusPending;

  /// Technician status: approved
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get statusApproved;

  /// Technician status: rejected
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get statusRejected;

  /// Technician status: suspended
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get statusSuspended;

  /// Technicians table column header
  ///
  /// In en, this message translates to:
  /// **'Technician'**
  String get columnTechnician;

  /// Technicians table column header
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get columnSpecialization;

  /// Technicians table column header
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get columnCity;

  /// Technicians table column header
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get columnExperience;

  /// Technicians table column header
  ///
  /// In en, this message translates to:
  /// **'Hourly Rate'**
  String get columnHourlyRate;

  /// Technicians table column header
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get columnStatus;

  /// Technicians table column header
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get columnActions;

  /// Approve technician button
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get actionApprove;

  /// Reject technician button
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get actionReject;

  /// Suspend technician button
  ///
  /// In en, this message translates to:
  /// **'Suspend'**
  String get actionSuspend;

  /// Reactivate technician button
  ///
  /// In en, this message translates to:
  /// **'Reactivate'**
  String get actionReactivate;

  /// View technician details button
  ///
  /// In en, this message translates to:
  /// **'Details'**
  String get actionDetails;

  /// Word appended after the years of experience number
  ///
  /// In en, this message translates to:
  /// **'yrs'**
  String get yearsSuffix;

  /// Title of the rejection reason dialog
  ///
  /// In en, this message translates to:
  /// **'Reject Technician'**
  String get rejectDialogTitle;

  /// Hint text for the rejection reason field
  ///
  /// In en, this message translates to:
  /// **'Type the rejection reason here...'**
  String get rejectDialogHint;

  /// Generic cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Confirm rejecting the technician
  ///
  /// In en, this message translates to:
  /// **'Confirm Reject'**
  String get confirmReject;

  /// Fallback title for technician details dialog when name is missing
  ///
  /// In en, this message translates to:
  /// **'Technician Details'**
  String get technicianDetailsTitle;

  /// Field label in technician details dialog
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get detailsEmail;

  /// Field label in technician details dialog
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get detailsPhone;

  /// Field label in technician details dialog
  ///
  /// In en, this message translates to:
  /// **'Specialization'**
  String get detailsSpecialization;

  /// Field label in technician details dialog
  ///
  /// In en, this message translates to:
  /// **'City'**
  String get detailsCity;

  /// Field label in technician details dialog
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get detailsExperience;

  /// Field label in technician details dialog
  ///
  /// In en, this message translates to:
  /// **'Hourly Rate'**
  String get detailsHourlyRate;

  /// Field label in technician details dialog
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get detailsStatus;

  /// Field label in technician details dialog
  ///
  /// In en, this message translates to:
  /// **'Rejection Reason'**
  String get detailsRejectionReason;

  /// Field label in technician details dialog
  ///
  /// In en, this message translates to:
  /// **'Certifications'**
  String get detailsCertifications;

  /// Generic close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// Field label in technician details page
  ///
  /// In en, this message translates to:
  /// **'Technician ID'**
  String get detailsId;

  /// Field label in technician details page
  ///
  /// In en, this message translates to:
  /// **'User ID'**
  String get detailsUserId;

  /// Field label in technician details page
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get detailsAvailable;

  /// Yes value
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get detailsYes;

  /// No value
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get detailsNo;

  /// Field label in technician details page
  ///
  /// In en, this message translates to:
  /// **'Approved At'**
  String get detailsApprovedAt;

  /// Field label in technician details page
  ///
  /// In en, this message translates to:
  /// **'Rejected At'**
  String get detailsRejectedAt;

  /// Field label in technician details page
  ///
  /// In en, this message translates to:
  /// **'Suspended At'**
  String get detailsSuspendedAt;

  /// Field label in technician details page
  ///
  /// In en, this message translates to:
  /// **'Created At'**
  String get detailsCreatedAt;

  /// Field label in technician details page
  ///
  /// In en, this message translates to:
  /// **'Updated At'**
  String get detailsUpdatedAt;

  /// Shown when the technician has no uploaded certifications
  ///
  /// In en, this message translates to:
  /// **'No certifications uploaded'**
  String get noCertifications;

  /// Car washers list page title
  ///
  /// In en, this message translates to:
  /// **'Car Washers'**
  String get carwashersPageTitle;

  /// Car washer details page title
  ///
  /// In en, this message translates to:
  /// **'Car Washer Details'**
  String get carwasherDetailsTitle;

  /// Fuel providers list page title
  ///
  /// In en, this message translates to:
  /// **'Fuel Providers'**
  String get fuelProvidersPageTitle;

  /// Fuel provider details page title
  ///
  /// In en, this message translates to:
  /// **'Fuel Provider Details'**
  String get fuelProviderDetailsTitle;

  /// Shops list page title
  ///
  /// In en, this message translates to:
  /// **'Shops'**
  String get shopsPageTitle;

  /// Shop details page title
  ///
  /// In en, this message translates to:
  /// **'Shop Details'**
  String get shopDetailsTitle;

  /// Column header for shop/washer name
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get columnShop;

  /// Column header for phone number
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get columnPhone;

  /// Label for address field
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get detailsAddress;

  /// Label for description field
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get detailsDescription;

  /// Label for rating field
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get detailsRating;

  /// Services card title
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get detailsServices;

  /// Service prices title
  ///
  /// In en, this message translates to:
  /// **'Service Prices'**
  String get detailsServicePrices;

  /// Working hours title
  ///
  /// In en, this message translates to:
  /// **'Working Hours'**
  String get detailsWorkingHours;

  /// Fuel types card title
  ///
  /// In en, this message translates to:
  /// **'Fuel Types'**
  String get detailsFuelTypes;

  /// Prices title
  ///
  /// In en, this message translates to:
  /// **'Prices'**
  String get detailsPrices;

  /// Business types title
  ///
  /// In en, this message translates to:
  /// **'Business Types'**
  String get detailsBusinessTypes;

  /// Supported car brands title
  ///
  /// In en, this message translates to:
  /// **'Car Brands'**
  String get detailsCarBrands;

  /// Part categories title
  ///
  /// In en, this message translates to:
  /// **'Part Categories'**
  String get detailsPartCategories;

  /// Column header for company name
  ///
  /// In en, this message translates to:
  /// **'Company'**
  String get columnCompany;

  /// Main title for the dashboard page
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboardPageTitle;

  /// Card showing the total number of users
  ///
  /// In en, this message translates to:
  /// **'Total Users'**
  String get dashboardTotalUsers;

  /// Card showing the total number of customers
  ///
  /// In en, this message translates to:
  /// **'Total Customers'**
  String get dashboardTotalCustomers;

  /// Statistic for successfully completed operations
  ///
  /// In en, this message translates to:
  /// **'Completed Operations'**
  String get dashboardCompletedOperations;

  /// Statistic for operations that are waiting or pending
  ///
  /// In en, this message translates to:
  /// **'Pending Operations'**
  String get dashboardPendingOperations;

  /// Header for the service providers statistics section
  ///
  /// In en, this message translates to:
  /// **'Providers Overview'**
  String get dashboardProvidersOverview;

  /// Chart title showing the status distribution of operations
  ///
  /// In en, this message translates to:
  /// **'Operations Status'**
  String get dashboardOperationsStatus;

  /// Chart title tracking operations across a time period
  ///
  /// In en, this message translates to:
  /// **'Operations Over Time'**
  String get dashboardOperationsOverTime;

  /// Total financial earnings
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get dashboardRevenue;

  /// Time filter to display data for a full week
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get dashboardPeriodWeek;

  /// Time filter to display data for a full month
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get dashboardPeriodMonth;

  /// Time filter to display data for a full year
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get dashboardPeriodYear;

  /// Label for latitude/longitude field
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get detailsLocation;

  /// Menu item: Car Washers
  ///
  /// In en, this message translates to:
  /// **'Car Washers'**
  String get carwashersMenu;

  /// Menu item: Shops
  ///
  /// In en, this message translates to:
  /// **'Shops'**
  String get shopsMenu;

  /// Login page title
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginTitle;

  /// Login page subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign in to access the admin dashboard'**
  String get loginSubtitle;

  /// Email field label
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get loginEmailLabel;

  /// Password field label
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get loginPasswordLabel;

  /// Login button text
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get loginButton;

  /// Validation error for empty field
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get loginValidationRequired;

  /// Validation error for invalid email
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get loginValidationEmail;

  /// Logout button text in sidebar
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutButton;

  /// Logout confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutConfirmTitle;

  /// Logout confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirmMessage;

  /// Confirm button text inside logout dialog
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logoutConfirmButton;

  /// Reports page title
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsPageTitle;

  /// Overview tab in the reports page
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get tabOverview;

  /// Providers tab in the reports page
  ///
  /// In en, this message translates to:
  /// **'Providers'**
  String get tabProviders;

  /// Financial tab in the reports page
  ///
  /// In en, this message translates to:
  /// **'Financial'**
  String get tabFinancial;

  /// Billing tab in the reports page
  ///
  /// In en, this message translates to:
  /// **'Billing'**
  String get tabBilling;

  /// Advertisements tab in the reports page
  ///
  /// In en, this message translates to:
  /// **'Advertisements'**
  String get tabAdvertisements;

  /// Clear filters button in reports
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get reportFilterClear;

  /// Apply filters button in reports
  ///
  /// In en, this message translates to:
  /// **'Apply'**
  String get reportFilterApply;

  /// All option in report filter dropdowns
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get reportFilterAll;

  /// Retry button when a report fails to load
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get reportRetry;

  /// From date field label in report filters
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get reportDateFrom;

  /// To date field label in report filters
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get reportDateTo;

  /// Provider type filter label
  ///
  /// In en, this message translates to:
  /// **'Provider Type'**
  String get filterProviderType;

  /// Provider status filter label
  ///
  /// In en, this message translates to:
  /// **'Provider Status'**
  String get filterProviderStatus;

  /// Billing status filter/section label
  ///
  /// In en, this message translates to:
  /// **'Billing Status'**
  String get filterBillingStatus;

  /// Invoice status filter label in the billing tab
  ///
  /// In en, this message translates to:
  /// **'Invoice Status'**
  String get filterInvoiceStatus;

  /// Operation type filter label
  ///
  /// In en, this message translates to:
  /// **'Operation Type'**
  String get filterOperationType;

  /// Generic status filter label
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get filterStatus;

  /// Group by filter label
  ///
  /// In en, this message translates to:
  /// **'Group By'**
  String get filterGroupBy;

  /// Ad placement filter label
  ///
  /// In en, this message translates to:
  /// **'Placement'**
  String get filterPlacement;

  /// Provider type: technician
  ///
  /// In en, this message translates to:
  /// **'Technician'**
  String get providerTypeTechnician;

  /// Provider type: fuel provider
  ///
  /// In en, this message translates to:
  /// **'Fuel Provider'**
  String get providerTypeFuelProvider;

  /// Provider type: car washer
  ///
  /// In en, this message translates to:
  /// **'Car Washer'**
  String get providerTypeCarWasher;

  /// Provider type: shop
  ///
  /// In en, this message translates to:
  /// **'Shop'**
  String get providerTypeShop;

  /// Operation status: completed
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get opStatusCompleted;

  /// Operation status: in progress
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get opStatusInProgress;

  /// Operation status: cancelled
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get opStatusCancelled;

  /// Operation status: pending
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get opStatusPending;

  /// Operation type: total
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get opTypeTotals;

  /// Operation type: maintenance
  ///
  /// In en, this message translates to:
  /// **'Maintenance'**
  String get opTypeMaintenance;

  /// Operation type: SOS
  ///
  /// In en, this message translates to:
  /// **'SOS'**
  String get opTypeSos;

  /// Operation type: fuel
  ///
  /// In en, this message translates to:
  /// **'Fuel'**
  String get opTypeFuel;

  /// Operation type: car wash
  ///
  /// In en, this message translates to:
  /// **'Car Wash'**
  String get opTypeCarWash;

  /// Operation type: spare parts
  ///
  /// In en, this message translates to:
  /// **'Spare Parts'**
  String get opTypeSpareParts;

  /// Group by day
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get groupByDay;

  /// Group by month
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get groupByMonth;

  /// Group by year
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get groupByYear;

  /// Provider status: pending
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get providerStatusPending;

  /// Provider status: approved
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get providerStatusApproved;

  /// Provider status: rejected
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get providerStatusRejected;

  /// Provider status: suspended
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get providerStatusSuspended;

  /// Button to go back to the previous step
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// Button: export invoice as PDF
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get invoiceActionExportPdf;

  /// Status indicating that the account or server is currently active
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get isActive;

  /// The method or type of billing applied
  ///
  /// In en, this message translates to:
  /// **'Billing Type'**
  String get billingType;

  /// Invoices list page title
  ///
  /// In en, this message translates to:
  /// **'Provider Invoices'**
  String get invoicesPageTitle;

  /// Invoice details page title
  ///
  /// In en, this message translates to:
  /// **'Invoice Details'**
  String get invoiceDetailsTitle;

  /// Invoice status filter: all
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get invoiceStatusAll;

  /// Invoice status: draft
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get invoiceStatusDraft;

  /// Invoice status: issued
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get invoiceStatusIssued;

  /// Invoice status: paid
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get invoiceStatusPaid;

  /// Invoice status: overdue
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get invoiceStatusOverdue;

  /// Invoice status: cancelled
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get invoiceStatusCancelled;

  /// Table column: invoice number
  ///
  /// In en, this message translates to:
  /// **'Invoice #'**
  String get columnInvoiceNumber;

  /// Table column: provider
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get columnProvider;

  /// Table column: period
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get columnPeriod;

  /// Table column: total amount
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get columnTotalAmount;

  /// Table column: due date
  ///
  /// In en, this message translates to:
  /// **'Due At'**
  String get columnDueAt;

  /// Invoice field: invoice number
  ///
  /// In en, this message translates to:
  /// **'Invoice Number'**
  String get invoiceFieldInvoiceNumber;

  /// Invoice field: provider type
  ///
  /// In en, this message translates to:
  /// **'Provider Type'**
  String get invoiceFieldProviderType;

  /// Invoice field: provider id
  ///
  /// In en, this message translates to:
  /// **'Provider ID'**
  String get invoiceFieldProviderId;

  /// Invoice field: period start
  ///
  /// In en, this message translates to:
  /// **'Period Start'**
  String get invoiceFieldPeriodStart;

  /// Invoice field: period end
  ///
  /// In en, this message translates to:
  /// **'Period End'**
  String get invoiceFieldPeriodEnd;

  /// Invoice field: issued at
  ///
  /// In en, this message translates to:
  /// **'Issued At'**
  String get invoiceFieldIssuedAt;

  /// Invoice field: due at
  ///
  /// In en, this message translates to:
  /// **'Due At'**
  String get invoiceFieldDueAt;

  /// Invoice field: subtotal
  ///
  /// In en, this message translates to:
  /// **'Subtotal'**
  String get invoiceFieldSubtotal;

  /// Invoice field: commission total
  ///
  /// In en, this message translates to:
  /// **'Commission Total'**
  String get invoiceFieldCommissionTotal;

  /// Invoice field: subscription total
  ///
  /// In en, this message translates to:
  /// **'Subscription Total'**
  String get invoiceFieldSubscriptionTotal;

  /// Invoice field: total amount
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get invoiceFieldTotalAmount;

  /// Invoice field: status
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get invoiceFieldStatus;

  /// Invoice field: is overdue
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get invoiceFieldIsOverdue;

  /// Invoice field: external payment method
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get invoiceFieldPaymentMethod;

  /// Invoice field: external payment reference
  ///
  /// In en, this message translates to:
  /// **'Payment Reference'**
  String get invoiceFieldPaymentReference;

  /// Invoice field: paid at
  ///
  /// In en, this message translates to:
  /// **'Paid At'**
  String get invoiceFieldPaidAt;

  /// Invoice field: notes
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get invoiceFieldNotes;

  /// Invoice items section title
  ///
  /// In en, this message translates to:
  /// **'Items'**
  String get invoiceFieldItems;

  /// Action button: issue invoice
  ///
  /// In en, this message translates to:
  /// **'Issue'**
  String get invoiceActionIssue;

  /// Action button: mark invoice as paid
  ///
  /// In en, this message translates to:
  /// **'Mark as Paid'**
  String get invoiceActionMarkPaid;

  /// Action button: cancel invoice
  ///
  /// In en, this message translates to:
  /// **'Cancel Invoice'**
  String get invoiceActionCancel;

  /// Action button: generate invoices
  ///
  /// In en, this message translates to:
  /// **'Generate Invoices'**
  String get invoiceActionGenerate;

  /// Action button: generate invoice for a single provider
  ///
  /// In en, this message translates to:
  /// **'Generate for Provider'**
  String get invoiceActionGenerateForProvider;

  /// Generate invoices dialog title
  ///
  /// In en, this message translates to:
  /// **'Generate Invoices'**
  String get invoiceGenerateDialogTitle;

  /// Mark invoice paid dialog title
  ///
  /// In en, this message translates to:
  /// **'Confirm Payment'**
  String get invoiceMarkPaidDialogTitle;

  /// Cancel invoice confirmation dialog title
  ///
  /// In en, this message translates to:
  /// **'Cancel Invoice'**
  String get invoiceCancelDialogTitle;

  /// Cancel invoice confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to cancel this invoice?'**
  String get invoiceCancelDialogMessage;

  /// Generate invoices result title
  ///
  /// In en, this message translates to:
  /// **'Generation Result'**
  String get invoiceGenerateResultTitle;

  /// Generated invoices count label
  ///
  /// In en, this message translates to:
  /// **'Generated'**
  String get invoiceGeneratedCount;

  /// Skipped invoices count label
  ///
  /// In en, this message translates to:
  /// **'Skipped'**
  String get invoiceSkippedCount;

  /// Skip reason: already_exists
  ///
  /// In en, this message translates to:
  /// **'Invoice already exists'**
  String get invoiceSkippedReasonAlreadyExists;

  /// Skip reason: within_free_trial
  ///
  /// In en, this message translates to:
  /// **'Within free trial period'**
  String get invoiceSkippedReasonWithinFreeTrial;

  /// Empty state for invoices list
  ///
  /// In en, this message translates to:
  /// **'No invoices found'**
  String get noInvoices;

  /// Button: navigate from billing setting to that provider's invoices
  ///
  /// In en, this message translates to:
  /// **'View Invoices'**
  String get invoiceViewInvoices;

  /// Billing status: not configured
  ///
  /// In en, this message translates to:
  /// **'Not Configured'**
  String get billingStatusNotConfigured;

  /// Billing status: exempt
  ///
  /// In en, this message translates to:
  /// **'Exempt'**
  String get billingStatusExempt;

  /// Billing status: free trial
  ///
  /// In en, this message translates to:
  /// **'Free Trial'**
  String get billingStatusFreeTrial;

  /// Billing status: invoice due
  ///
  /// In en, this message translates to:
  /// **'Invoice Due'**
  String get billingStatusInvoiceDue;

  /// Billing status: overdue
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get billingStatusOverdue;

  /// Advertisement status: active
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adStatusActive;

  /// Advertisement status: inactive
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adStatusInactive;

  /// Stat card: total ads
  ///
  /// In en, this message translates to:
  /// **'Total Ads'**
  String get adsTotal;

  /// Stat card: active ads
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adsActive;

  /// Stat card: inactive ads
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get adsInactive;

  /// Stat card: expired ads
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get adsExpired;

  /// Stat card: scheduled ads
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get adsScheduled;

  /// Section title: ads by placement
  ///
  /// In en, this message translates to:
  /// **'By Placement'**
  String get adsByPlacementTitle;

  /// Section title: latest ads
  ///
  /// In en, this message translates to:
  /// **'Latest Ads'**
  String get adsLatestTitle;

  /// Empty state text when there are no ads
  ///
  /// In en, this message translates to:
  /// **'No ads found'**
  String get adsEmpty;

  /// Stat card: invoices count
  ///
  /// In en, this message translates to:
  /// **'Invoices Count'**
  String get billingInvoicesCount;

  /// Stat card: draft invoices
  ///
  /// In en, this message translates to:
  /// **'Draft'**
  String get billingDraft;

  /// Stat card: issued invoices
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get billingIssued;

  /// Stat card: overdue invoices
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get billingOverdueCount;

  /// Stat card: paid invoices
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get billingPaidCount;

  /// Stat card: cancelled invoices
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get billingCancelled;

  /// Section title: financial totals in the billing tab
  ///
  /// In en, this message translates to:
  /// **'Financial Totals'**
  String get billingFinancialTotalsTitle;

  /// Stat card: total paid
  ///
  /// In en, this message translates to:
  /// **'Total Paid'**
  String get billingPaidTotal;

  /// Stat card: total unpaid
  ///
  /// In en, this message translates to:
  /// **'Total Unpaid'**
  String get billingUnpaidTotal;

  /// Stat card: total overdue
  ///
  /// In en, this message translates to:
  /// **'Total Overdue'**
  String get billingOverdueTotal;

  /// Stat card: average invoice amount
  ///
  /// In en, this message translates to:
  /// **'Average Invoice Amount'**
  String get billingAvgInvoice;

  /// Stat card: count of providers with overdue billing
  ///
  /// In en, this message translates to:
  /// **'Providers with Overdue Bills'**
  String get billingProvidersOverdue;

  /// Section title: latest invoices
  ///
  /// In en, this message translates to:
  /// **'Latest Invoices'**
  String get billingLatestInvoicesTitle;

  /// Empty state text when there are no invoices
  ///
  /// In en, this message translates to:
  /// **'No invoices found'**
  String get billingEmpty;

  /// Invoice status label within an invoice row
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get billingStatusLabel;

  /// Invoice issued-at label within an invoice row
  ///
  /// In en, this message translates to:
  /// **'Issued'**
  String get billingIssuedAtLabel;

  /// Section title: gross revenue
  ///
  /// In en, this message translates to:
  /// **'Gross Revenue'**
  String get financialGrossRevenueTitle;

  /// Section title: billing summary in the financial tab
  ///
  /// In en, this message translates to:
  /// **'Billing Summary'**
  String get financialBillingSummaryTitle;

  /// Stat card: issued total
  ///
  /// In en, this message translates to:
  /// **'Issued Total'**
  String get financialIssuedTotal;

  /// Stat card: paid
  ///
  /// In en, this message translates to:
  /// **'Paid'**
  String get financialPaid;

  /// Stat card: unpaid
  ///
  /// In en, this message translates to:
  /// **'Unpaid'**
  String get financialUnpaid;

  /// Stat card: overdue
  ///
  /// In en, this message translates to:
  /// **'Overdue'**
  String get financialOverdue;

  /// Stat card: commissions
  ///
  /// In en, this message translates to:
  /// **'Commissions'**
  String get financialCommissions;

  /// Stat card: subscriptions
  ///
  /// In en, this message translates to:
  /// **'Subscriptions'**
  String get financialSubscriptions;

  /// Section/tab title: operations
  ///
  /// In en, this message translates to:
  /// **'Operations'**
  String get operationsTitle;

  /// Section title for operations when grouped by a period
  ///
  /// In en, this message translates to:
  /// **'Operations (grouped by {group})'**
  String operationsGroupedTitle(String group);

  /// Empty state text when there is no operations data
  ///
  /// In en, this message translates to:
  /// **'No data found'**
  String get operationsEmpty;

  /// Stat card: total users
  ///
  /// In en, this message translates to:
  /// **'Total Users'**
  String get overviewTotalUsers;

  /// Stat card: total customers
  ///
  /// In en, this message translates to:
  /// **'Total Customers'**
  String get overviewTotalCustomers;

  /// Stat card: total providers
  ///
  /// In en, this message translates to:
  /// **'Total Providers'**
  String get overviewTotalProviders;

  /// Section title: providers by type and status
  ///
  /// In en, this message translates to:
  /// **'Providers by Type & Status'**
  String get overviewProvidersByTypeStatusTitle;

  /// Section title: operations summary in overview
  ///
  /// In en, this message translates to:
  /// **'Operations Summary'**
  String get overviewOperationsSummaryTitle;

  /// Section title: revenue summary in overview
  ///
  /// In en, this message translates to:
  /// **'Revenue Summary'**
  String get overviewRevenueSummaryTitle;

  /// Stat card: providers pending approval
  ///
  /// In en, this message translates to:
  /// **'Pending Approval'**
  String get providersPendingApproval;

  /// Stat card: providers with overdue invoices
  ///
  /// In en, this message translates to:
  /// **'Overdue Invoices'**
  String get providersOverdueBilling;

  /// Stat card: providers with billing not configured
  ///
  /// In en, this message translates to:
  /// **'Billing Not Configured'**
  String get providersBillingNotConfigured;

  /// Section title: provider count by type
  ///
  /// In en, this message translates to:
  /// **'Provider Count by Type'**
  String get providersCountByTypeTitle;

  /// Section title: provider status by type
  ///
  /// In en, this message translates to:
  /// **'Status by Type'**
  String get providersStatusByTypeTitle;

  /// Section title: top providers by completed operations
  ///
  /// In en, this message translates to:
  /// **'Top Providers by Completed Operations'**
  String get providersTopByCompletedTitle;

  /// Line showing a provider's name, id and completed operations count
  ///
  /// In en, this message translates to:
  /// **'{name} (#{id}) — {count} completed operations'**
  String providersCompletedOpsLine(String name, String id, String count);

  /// Sidebar menu: Advertisements
  ///
  /// In en, this message translates to:
  /// **'Advertisements'**
  String get advertisementsMenu;

  /// Page title: advertisements list
  ///
  /// In en, this message translates to:
  /// **'Advertisements'**
  String get advertisementsPageTitle;

  /// Page title: advertisement details/edit
  ///
  /// In en, this message translates to:
  /// **'Advertisement Details'**
  String get advertisementDetailsTitle;

  /// Column: image
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get adColumnImage;

  /// Column: title
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get adColumnTitle;

  /// Column: placement
  ///
  /// In en, this message translates to:
  /// **'Placement'**
  String get adColumnPlacement;

  /// Column: starts/ends period
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get adColumnPeriod;

  /// Column: status
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adColumnStatus;

  /// Column: sort order
  ///
  /// In en, this message translates to:
  /// **'Order'**
  String get adColumnSortOrder;

  /// Column: actions
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get adColumnActions;

  /// Filter chip: all placements
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get adFilterAll;

  /// Filter chip: home placement
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get adFilterHome;

  /// Action: activate ad
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get adActionActivate;

  /// Action: deactivate ad
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get adActionDeactivate;

  /// Action: edit ad
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get adActionEdit;

  /// Action: delete ad
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get adActionDelete;

  /// Button: create new advertisement
  ///
  /// In en, this message translates to:
  /// **'New Advertisement'**
  String get adCreateNew;

  /// Form field: title
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get adFormTitleLabel;

  /// Form field: placement
  ///
  /// In en, this message translates to:
  /// **'Placement'**
  String get adFormPlacementLabel;

  /// Form field: link url
  ///
  /// In en, this message translates to:
  /// **'Link URL'**
  String get adFormLinkLabel;

  /// Form field: starts at
  ///
  /// In en, this message translates to:
  /// **'Starts At'**
  String get adFormStartsLabel;

  /// Form field: ends at
  ///
  /// In en, this message translates to:
  /// **'Ends At'**
  String get adFormEndsLabel;

  /// Form field: sort order
  ///
  /// In en, this message translates to:
  /// **'Sort Order'**
  String get adFormSortOrderLabel;

  /// Form field: is active
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adFormActiveLabel;

  /// Form field: image
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get adFormImageLabel;

  /// Hint: image upload constraints
  ///
  /// In en, this message translates to:
  /// **'jpeg/jpg/png/webp, max 2MB'**
  String get adFormImageHint;

  /// Button: choose image
  ///
  /// In en, this message translates to:
  /// **'Choose Image'**
  String get adFormChooseImage;

  /// Button: change image
  ///
  /// In en, this message translates to:
  /// **'Change Image'**
  String get adFormChangeImage;

  /// Button: save advertisement
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get adFormSave;

  /// Validation: required field
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get adFormRequiredField;

  /// Validation: image required
  ///
  /// In en, this message translates to:
  /// **'Please select an image'**
  String get adFormImageRequired;

  /// Dialog title: delete confirm
  ///
  /// In en, this message translates to:
  /// **'Delete Advertisement'**
  String get adDeleteConfirmTitle;

  /// Dialog message: delete confirm
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this advertisement?'**
  String get adDeleteConfirmMessage;

  /// Snackbar: create success
  ///
  /// In en, this message translates to:
  /// **'Advertisement created successfully'**
  String get adCreatedSuccess;

  /// Snackbar: update success
  ///
  /// In en, this message translates to:
  /// **'Advertisement updated successfully'**
  String get adUpdatedSuccess;

  /// Snackbar: delete success
  ///
  /// In en, this message translates to:
  /// **'Advertisement deleted successfully'**
  String get adDeletedSuccess;

  /// Snackbar: activate success
  ///
  /// In en, this message translates to:
  /// **'Advertisement activated'**
  String get adActivatedSuccess;

  /// Snackbar: deactivate success
  ///
  /// In en, this message translates to:
  /// **'Advertisement deactivated'**
  String get adDeactivatedSuccess;

  /// Empty state: no advertisements
  ///
  /// In en, this message translates to:
  /// **'No advertisements found'**
  String get noAdvertisements;

  /// Explanation for the user showing that ranking starts from number 1 for the first ad
  ///
  /// In en, this message translates to:
  /// **'The ranking starts from 1, for example, 1 means this is the first advertisement to appear'**
  String get adRankingExplanation;

  /// Title of the billing settings page
  ///
  /// In en, this message translates to:
  /// **'Billing Settings'**
  String get billingSettingsPageTitle;

  /// Button to create a new billing configuration
  ///
  /// In en, this message translates to:
  /// **'New Setting'**
  String get billingCreateNew;

  /// Link button to navigate to billing setup
  ///
  /// In en, this message translates to:
  /// **'Billing Setup'**
  String get billingSettingLinkButton;

  /// Column header for provider in the billing table
  ///
  /// In en, this message translates to:
  /// **'Provider'**
  String get billingColumnProvider;

  /// Column header for billing type in the table
  ///
  /// In en, this message translates to:
  /// **'Billing Type'**
  String get billingColumnType;

  /// Column header for the monthly subscription fee
  ///
  /// In en, this message translates to:
  /// **'Monthly Subscription'**
  String get billingColumnMonthlyFee;

  /// Column header for the commission percentage
  ///
  /// In en, this message translates to:
  /// **'Commission Rate'**
  String get billingColumnCommission;

  /// Column header for the activation start date
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get billingColumnStartsAt;

  /// Status indicating the setting is currently active
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get billingStatusActive;

  /// Status indicating the setting is currently disabled
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get billingStatusInactive;

  /// Title of the confirmation dialog for deleting a billing setting
  ///
  /// In en, this message translates to:
  /// **'Delete Billing Setting'**
  String get billingDeleteTitle;

  /// Confirmation message shown before completing deletion
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this setting?'**
  String get billingDeleteMessage;

  /// Final confirmation button to execute deletion
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get confirmDelete;

  /// Title of the form for creating a new billing setup
  ///
  /// In en, this message translates to:
  /// **'Create Billing Setting'**
  String get billingFormTitleCreate;

  /// Title of the form for modifying an existing billing setup
  ///
  /// In en, this message translates to:
  /// **'Edit Billing Setting'**
  String get billingFormTitleEdit;

  /// Label for the provider type input field
  ///
  /// In en, this message translates to:
  /// **'Provider Type'**
  String get billingFieldProviderType;

  /// Label for the provider ID input field
  ///
  /// In en, this message translates to:
  /// **'Provider ID'**
  String get billingFieldProviderId;

  /// Label for the billing type selection field
  ///
  /// In en, this message translates to:
  /// **'Billing Type'**
  String get billingFieldBillingType;

  /// Label for the monthly subscription fee input field
  ///
  /// In en, this message translates to:
  /// **'Monthly Subscription'**
  String get billingFieldMonthlyFee;

  /// Label for the commission percentage input field
  ///
  /// In en, this message translates to:
  /// **'Commission Rate %'**
  String get billingFieldCommissionPercent;

  /// Label for the number of free trial days field
  ///
  /// In en, this message translates to:
  /// **'Free Trial Days'**
  String get billingFieldFreeTrialDays;

  /// Label for the payment terms/grace period in days field
  ///
  /// In en, this message translates to:
  /// **'Payment Due (Days)'**
  String get billingFieldPaymentDueDays;

  /// Label for selecting the billing start date
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get billingFieldStartsAt;

  /// Title for the billing details section
  ///
  /// In en, this message translates to:
  /// **'Billing Details'**
  String get billingDetailsTitle;

  /// Billing type combining a fixed subscription fee and a commission percentage
  ///
  /// In en, this message translates to:
  /// **'Subscription + Commission'**
  String get billingTypeSubscriptionPlusCommission;

  /// Billing type for accounts or operations exempt from fees
  ///
  /// In en, this message translates to:
  /// **'Exempt'**
  String get billingTypeExempt;

  /// Field label for specifying the method or reason for financial exemption
  ///
  /// In en, this message translates to:
  /// **'Exempt Method'**
  String get billingFieldExemptMethod;

  /// Option indicating that the billing is commission-based
  ///
  /// In en, this message translates to:
  /// **'Billing Type: Commission'**
  String get billingTypeCommission;

  /// Option indicating that the billing occurs on a monthly basis
  ///
  /// In en, this message translates to:
  /// **'Monthly Billing'**
  String get billingTypeMonthly;

  /// Label for the switch determining if the record is active
  ///
  /// In en, this message translates to:
  /// **'Active?'**
  String get billingFieldIsActive;

  /// Label for the additional notes input field
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get billingFieldNotes;

  /// Text prompting the user to open the date picker
  ///
  /// In en, this message translates to:
  /// **'Pick Date'**
  String get billingPickDate;

  /// Validation error message for mandatory fields left blank
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get fieldRequired;

  /// Button to save form data
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// General text for edit action
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get actionEdit;

  /// General text for delete action
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// عنوان أو نص يرمز للخدمة في التطبيق
  ///
  /// In en, this message translates to:
  /// **'الخدمة'**
  String get service;

  /// عنوان شاشة لوحة التحكم الرئيسية
  ///
  /// In en, this message translates to:
  /// **'لوحة التحكم'**
  String get dashboard;

  /// تبويب أو إعدادات عامة داخل التطبيق
  ///
  /// In en, this message translates to:
  /// **'عام'**
  String get general;

  /// Option for cash payment
  ///
  /// In en, this message translates to:
  /// **'Cash'**
  String get paymentMethodCash;

  /// Option for bank transfer payment
  ///
  /// In en, this message translates to:
  /// **'Bank Transfer'**
  String get paymentMethodBankTransfer;

  /// Option for Sham Cash electronic payment
  ///
  /// In en, this message translates to:
  /// **'Sham Cash'**
  String get paymentMethodShamCash;

  /// Option for Syriatel Cash electronic payment
  ///
  /// In en, this message translates to:
  /// **'Syriatel Cash'**
  String get paymentMethodSyriatelCash;

  /// Option for other unlisted payment methods
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get paymentMethodOther;

  /// Main title for the settings page
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// Header for the application language selection section
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguageSection;

  /// Header for the application theme or appearance section
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsThemeSection;

  /// Option to select Arabic language
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get settingsLanguageArabic;

  /// Option to select English language
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLanguageEnglish;

  /// Option to enable light mode
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// Option to enable dark mode
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// Option to make the theme follow the device system settings
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'en': return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
