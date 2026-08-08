import 'package:car_care/core/constants/app_assets.dart';
import 'package:car_care/core/service_locator/service_locator.dart';
import 'package:car_care/core/theme/app_colors.dart';
import 'package:car_care/core/utils/responsive.dart';
import 'package:car_care/features/auth/domain/entities/auth_entity.dart';

import 'package:car_care/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:car_care/features/auth/presentation/cubit/auth_state.dart';
import 'package:car_care/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AdminMenuItem {
  final String Function(BuildContext context) label;
  final IconData icon;
  final String routeName;
  final List<Object?>? pathParameters;

  const AdminMenuItem({
    required this.label,
    required this.icon,
    required this.routeName,
    this.pathParameters,
  });
}

List<AdminMenuItem> buildAdminMenuItems(BuildContext context) {
  return [ 
    AdminMenuItem(
      label: (c) => c.l10n.dashboardMenu,
      icon: Icons.dashboard,
      routeName: 'adminDashboard',
    ),
  
    AdminMenuItem(
      label: (c) => c.l10n.techniciansMenu,
      icon: Icons.build_rounded,
      routeName: 'adminTechnicians',
    ),
    AdminMenuItem(
      label: (c) => c.l10n.carwashersMenu,
      icon: Icons.local_car_wash_rounded,
      routeName: 'adminCarwashers',
    ),
    AdminMenuItem(
      label: (c) => c.l10n.fuelProvidersMenu,
      icon: Icons.local_gas_station_rounded,
      routeName: 'adminFuelProviders',
    ),
    AdminMenuItem(
      label: (c) => c.l10n.shopsMenu,
      icon: Icons.store_rounded,
      routeName: 'adminShops',
    ),
   
   
    AdminMenuItem(
      label: (c) => c.l10n.reportsMenu,
      icon: Icons.bar_chart_rounded,
      routeName: 'adminReports',
    ),
    AdminMenuItem(
      icon: Icons.receipt_long_rounded,
      label: (c) => c.l10n.invoicesPageTitle,
      routeName: 'adminInvoices',
    ),
    AdminMenuItem(
      label: (c) => c.l10n.advertisementsMenu,
      icon: Icons.bar_chart_rounded,
      routeName: 'adminAdvertisements',
    ),
    AdminMenuItem(
      label: (c) => c.l10n.settingsMenu,
      icon: Icons.settings_rounded,
      routeName: 'adminSettings',
    ),
  ];
}

class AdminLayout extends StatelessWidget {
  final Widget child;
  final String currentRoute;
  final String title;
  final List<Widget>? actions;

  const AdminLayout({
    super.key,
    required this.child,
    required this.currentRoute,
    this.title = '',
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final menuItems = buildAdminMenuItems(context);
    final isMobile = Responsive.isMobile(context);

    return BlocProvider<AuthCubit>(
      create: (_) => getIt<AuthCubit>()..checkAuthStatus(),
      child: Builder(
        builder: (context) {
          return Directionality(
            textDirection: TextDirection.ltr,
            child: Scaffold(
              backgroundColor: AppColors.lightScaffold,
              // على الموبايل: Drawer بيتفتح بزر بالـ TopBar
              drawer: isMobile
                  ? Drawer(
                      width: 260,
                      child: _AdminSidebarContent(
                        menuItems: menuItems,
                        currentRoute: currentRoute,
                      ),
                    )
                  : null,
              body: Row(
                children: [
                  // على الديسكتوب/التابلت: Sidebar ثابت
                  if (!isMobile)
                    SizedBox(
                      width: 240,
                      child: _AdminSidebarContent(
                        menuItems: menuItems,
                        currentRoute: currentRoute,
                      ),
                    ),
                  Expanded(
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          AppAssets.artboardBackground,
                          fit: BoxFit.cover,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _AdminTopBar(
                              title: title,
                              actions: actions,
                              showMenuButton: isMobile,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(
                                  isMobile ? 12 : 24,
                                  16,
                                  isMobile ? 12 : 24,
                                  24,
                                ),
                                child: Directionality(
                                  textDirection: TextDirection.rtl,
                                  child: child,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AdminSidebarContent extends StatelessWidget {
  final List<AdminMenuItem> menuItems;
  final String currentRoute;

  const _AdminSidebarContent({
    required this.menuItems,
    required this.currentRoute,
  });

  Future<void> _confirmLogout(BuildContext context) async {
    final strings = context.l10n;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(strings.logoutConfirmTitle,   style: const TextStyle(fontSize: 20),),
        content: Text(strings.logoutConfirmMessage,   style: const TextStyle(fontSize: 19),),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(strings.cancel,   style: const TextStyle(fontSize: 13),),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: const Color(0xFFC62828),
            ),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(strings.logoutConfirmButton  ,  style: const TextStyle(fontSize: 15),),
            ),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      await context.read<AuthCubit>().logout();
      if (context.mounted) {
        context.goNamed('/auth');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = context.l10n;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.accent, AppColors.primary.withOpacity(0.85)],
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 24),
            _buildLogo(context),
            const SizedBox(height: 8),
            const Divider(
              color: Colors.white24,
              height: 24,
              indent: 20,
              endIndent: 20,
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                itemCount: menuItems.length,
                itemBuilder: (context, index) {
                  final item = menuItems[index];
                  final isSelected = item.routeName == currentRoute;
                  return _SidebarTile(
                    item: item,
                    isSelected: isSelected,
                    onTap: () {
                 
                      if (Scaffold.of(context).isDrawerOpen) {
                        Navigator.pop(context);
                      }
                      if (!isSelected) {
                        context.goNamed(item.routeName);
                      }
                    },
                  );
                },
              ),
            ),
            const Divider(
              color: Colors.white24,
              height: 1,
              indent: 20,
              endIndent: 20,
            ),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                AdminEntity? admin;
                if (state is AuthAuthenticated) admin = state.admin;

                return Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 12,
                  ),
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: Row(
                      children: [
                        const CircleAvatar(
                          radius: 18,
                          backgroundColor: Colors.white24,
                          child: Icon(
                            Icons.person,
                            color: Colors.white,
                            size: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                admin?.name ?? strings.adminLabel,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              if (admin?.email != null)
                                Text(
                                  admin!.email!,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 11,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 14, left: 14, right: 14),
              child: SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _confirmLogout(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white,
                    side: const BorderSide(color: Colors.white54),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  icon: const Icon(Icons.logout_rounded, size: 16),
                  label: Text(
                    strings.logoutButton,
                    style: const TextStyle(fontSize: 13),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage(AppAssets.logoImg),
          maxRadius: 25,
          backgroundColor: AppColors.primary,
        ),
        const SizedBox(width: 6),
        const Text(
          "Car Care",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _SidebarTile extends StatelessWidget {
  final AdminMenuItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _SidebarTile({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Material(
        color: isSelected ? Colors.white.withOpacity(0.18) : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Row(
                children: [
                  Icon(item.icon, color: Colors.white, size: 18),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      item.label(context),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: isSelected
                            ? FontWeight.bold
                            : FontWeight.w500,
                      ),
                    ),
                  ),
                  if (isSelected)
                    Container(
                      width: 5,
                      height: 5,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AdminTopBar extends StatelessWidget {
  final String title;
  final List<Widget>? actions;
  final bool showMenuButton;

  const _AdminTopBar({
    required this.title,
    this.actions,
    this.showMenuButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.symmetric(horizontal: showMenuButton ? 8 : 24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerRight,
          end: Alignment.centerLeft,
          colors: [AppColors.accent, AppColors.primary.withOpacity(0.85)],
        ),
        color: AppColors.primary,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          if (showMenuButton)
            IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu_rounded, color: Colors.white),
            ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                right: showMenuButton ? 4 : 30,
                left: showMenuButton ? 4 : 0,
              ),
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: showMenuButton ? TextAlign.center : TextAlign.right,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
          if (actions != null) ...actions!,
          if (showMenuButton) const SizedBox(width: 8),
        ],
      ),
    );
  }
}
