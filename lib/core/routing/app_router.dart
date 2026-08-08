import 'package:car_care/core/widgets/settings_page_web.dart';
import 'package:car_care/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:car_care/features/invoice/presentation/pages/invoice_details_page_web.dart';
import 'package:car_care/features/invoice/presentation/pages/invoice_page.dart';
import 'package:car_care/features/billing/presentation/pages/billing_setting_edit_page_web.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Core
import 'package:car_care/core/routing/routes.dart';

// Features - Auth & Home
import 'package:car_care/features/auth/presentation/pages/auth_page.dart';
import 'package:car_care/features/home/presentation/pages/home_page.dart';

// Features - Advertisement
import 'package:car_care/features/advertisement/presentation/pages/advertisement_details_page_web.dart';
import 'package:car_care/features/advertisement/presentation/pages/advertisement_form_page_web.dart';
import 'package:car_care/features/advertisement/presentation/pages/advertisement_page.dart'; // تأكد أن الكلاس اسمه AdvertisementsPageWeb داخل هذا الملف

// Features - Billing
import 'package:car_care/features/billing/presentation/pages/billing_setting_form_page_web.dart';
import 'package:car_care/features/billing/presentation/pages/billing_settings_page_web.dart';

import 'package:car_care/features/billing/presentation/pages/billing_setting_details_page_web.dart'; 

// Features - Management
import 'package:car_care/features/carwasher_management/presentation/pages/carwasher_details_page_web.dart';
import 'package:car_care/features/carwasher_management/presentation/pages/carwasher_management_page.dart';
import 'package:car_care/features/fuel_provider_management/presentation/pages/fuel_provider_details_page_web.dart';
import 'package:car_care/features/fuel_provider_management/presentation/pages/fuel_provider_management_page.dart';
import 'package:car_care/features/shop_management/presentation/pages/shop_details_page_web.dart';
import 'package:car_care/features/shop_management/presentation/pages/shop_management_page.dart';
import 'package:car_care/features/technician_management/presentation/pages/technician_details_page_web.dart';
import 'package:car_care/features/technician_management/presentation/pages/technicians_page.dart'; // تأكد أن الكلاس اسمه TechniciansPageWeb داخل هذا الملف

// Features - Reports
import 'package:car_care/features/reports/presentation/pages/reports_page.dart';

class AppRouter {
  static final GlobalKey<NavigatorState> rootNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'root');

  static final GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>(debugLabel: 'shell');

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.auth,
    debugLogDiagnostics: true,
    routes: [
      // Auth
      GoRoute(
        path: Routes.auth,
        name: '/auth',
        builder: (context, state) => const AuthPage(),
      ),

      // Home
      GoRoute(
        path: Routes.home,
        name: '/home',
        builder: (context, state) => const HomePage(),
      ),

      // Reports
      GoRoute(
        path: Routes.adminReports,
        name: 'adminReports',
        builder: (context, state) => const ReportsPage(),
      ),

      // Technicians
      GoRoute(
        path: Routes.adminTechnicians,
        name: 'adminTechnicians',
        builder: (context, state) => const TechniciansPageWeb(),
      ),
      GoRoute(
        path: '/admin/technicians/:id',
        name: 'adminTechnicianDetails',
        builder: (context, state) => TechnicianDetailsPageWeb(
          technicianId: int.parse(state.pathParameters['id']!),
        ),
      ),

      // Carwashers
      GoRoute(
        path: Routes.carwasher_management,
        name: 'adminCarwashers',
        builder: (context, state) => const CarwasherManagementPage(),
      ),
      GoRoute(
        path: '/admin/carwashers/:id',
        name: 'adminCarwasherDetails',
        builder: (context, state) => CarwasherDetailsPageWeb(
          carwasherId: int.parse(state.pathParameters['id']!),
        ),
      ),

      // Fuel Providers
      GoRoute(
        path: Routes.fuel_provider_management,
        name: 'adminFuelProviders',
        builder: (context, state) => const FuelProviderManagementPage(),
      ),
      GoRoute(
        path: '/admin/fuel-providers/:id',
        name: 'adminFuelProviderDetails',
        builder: (context, state) => FuelProviderDetailsPageWeb(
          fuelProviderId: int.parse(state.pathParameters['id']!),
        ),
      ),

      // Shops
      GoRoute(
        path: Routes.shop_management,
        name: 'adminShops',
        builder: (context, state) => const ShopManagementPage(),
      ),
      GoRoute(
        path: '/admin/shops/:id',
        name: 'adminShopDetails',
        builder: (context, state) => ShopDetailsPageWeb(
          shopId: int.parse(state.pathParameters['id']!),
        ),
      ),

      // Advertisements
      GoRoute(
        path: Routes.adminAdvertisements,
        name: 'adminAdvertisements',
        builder: (context, state) => const AdvertisementsPageWeb(),
      ),
      GoRoute(
        path: '${Routes.adminAdvertisements}/create',
        name: 'adminAdvertisementCreate',
        builder: (context, state) => const AdvertisementFormPageWeb(),
      ),
      GoRoute(
        path: '${Routes.adminAdvertisements}/:id/edit',
        name: 'adminAdvertisementEdit',
        builder: (context, state) => AdvertisementFormPageWeb(
          advertisementId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '${Routes.adminAdvertisements}/:id',
        name: 'adminAdvertisementDetails',
        builder: (context, state) => AdvertisementDetailsPageWeb(
          advertisementId: int.parse(state.pathParameters['id']!),
        ),
      ),

      // Billing Settings (تم دمج التكرار هنا والاعتماد على الـ Query Parameters)
      GoRoute(
        path: Routes.adminBillingSettings,
        name: 'adminBillingSettings',
        builder: (context, state) {
          final customerName = state.uri.queryParameters['customer_name'];
          final customerAddress = state.uri.queryParameters['customer_address'];
          final customerPhone = state.uri.queryParameters['customer_phone'];
          final providerType = state.uri.queryParameters['provider_type'];
          final providerIdStr = state.uri.queryParameters['provider_id'];
          return BillingSettingsPageWeb(
            initialProviderType: providerType,
            initialProviderId: providerIdStr != null ? int.tryParse(providerIdStr) : null,
            customerName: customerName,
            customerAddress: customerAddress,
            customerPhone: customerPhone,
          );
        },
      ),
      GoRoute(
        path: '${Routes.adminBillingSettings}/details',
        name: 'adminBillingSettingDetails',
        builder: (context, state) {
          final idStr = state.uri.queryParameters['id']!;
          return BillingSettingDetailsPageWeb(billingSettingId: int.parse(idStr));
        },
      ),
      GoRoute(
        path: '${Routes.adminBillingSettings}/form',
        name: 'adminBillingSettingForm',
        builder: (context, state) {
          final idStr = state.uri.queryParameters['id'];
          final providerType = state.uri.queryParameters['provider_type'];
          final providerIdStr = state.uri.queryParameters['provider_id'];
          return BillingSettingFormPageWeb(
            providerType: providerType,
            providerId: providerIdStr != null ? int.tryParse(providerIdStr) : null,
          );
        },
      ),
      GoRoute(
        name: 'adminBillingSettingEdit',
        path: '/admin/billing-settings/:id/edit',
        builder: (context, state) => BillingSettingEditPageWeb(
          billingSettingId: int.parse(state.pathParameters['id']!),
        ),
      ),
      GoRoute(
        path: '/admin/billing/invoices',
        name: 'adminInvoices',
        builder: (context, state) {
          final providerType = state.uri.queryParameters['provider_type'];
          final providerIdStr = state.uri.queryParameters['provider_id'];
          final status = state.uri.queryParameters['status'];
          final customerName = state.uri.queryParameters['customer_name'];
          final customerAddress = state.uri.queryParameters['customer_address'];
          final customerPhone = state.uri.queryParameters['customer_phone'];
          return InvoicesPageWeb(
            customerName: customerName,
            customerAddress: customerAddress,
            customerPhone: customerPhone,
            initialProviderType: providerType,
            initialProviderId: providerIdStr != null ? int.tryParse(providerIdStr) : null,
            initialStatus: status ?? 'all',
          );
        },
      ),
      GoRoute(
        path: '/admin/billing/invoices/:id',
        name: 'adminInvoiceDetails',
        builder: (context, state) {
          final customerName = state.uri.queryParameters['customer_name'];
          final customerAddress = state.uri.queryParameters['customer_address'];
          final customerPhone = state.uri.queryParameters['customer_phone'];
          return InvoiceDetailsPageWeb(
            invoiceId: int.parse(state.pathParameters['id']!),
            customerName: customerName,
            customerAddress: customerAddress,
            customerPhone: customerPhone,
          );
        },
      ),
    GoRoute(
  path: '/admin/dashboard',
  name: 'adminDashboard',
  builder: (context, state) => const DashboardPageWeb(),
),
 GoRoute(
  path: '/admin/Settings',
  name: 'adminSettings',
  builder: (context, state) => const SettingsPageWeb(),
),
      ],
  );
}