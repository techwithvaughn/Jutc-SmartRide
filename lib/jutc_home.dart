import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'jutc_data.dart';

class JutcHomePage extends StatefulWidget {
  const JutcHomePage({super.key});

  @override
  State<JutcHomePage> createState() => _JutcHomePageState();
}

class _JutcHomePageState extends State<JutcHomePage> {
  int _currentIndex = 0;
  String _routeFilter = 'all';
  String _query = '';

  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<RouteInfo> get _filteredRoutes {
    final query = _query.trim().toLowerCase();
    return kJutcRoutes.where((route) {
      final type = _classifyRoute(route.route);
      if (_routeFilter != 'all' && type != _routeFilter) {
        return false;
      }
      if (query.isEmpty) {
        return true;
      }
      final haystack =
          '${route.route} ${route.origin} ${route.destination} ${route.via}'
              .toLowerCase();
      return haystack.contains(query);
    }).toList();
  }

  String _classifyRoute(String value) {
    final number = int.tryParse(value);
    if (number == null) {
      return 'standard';
    }
    if ((number >= 100 && number < 200) || (number >= 300 && number < 400)) {
      return 'premium';
    }
    if (number >= 400) {
      return 'rural';
    }
    return 'standard';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFF07101D),
              Color(0xFF060A12),
              Color(0xFF070C15),
            ],
          ),
        ),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              final width = math.min(420.0, constraints.maxWidth - 24);
              final height = math.min(860.0, constraints.maxHeight - 24);

              return Container(
                width: width,
                height: height,
                decoration: BoxDecoration(
                  color: const Color(0xFF0B1220),
                  borderRadius: BorderRadius.circular(34),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.12),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 40,
                      offset: Offset(0, 20),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _TopBar(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() {
                          _query = value;
                        });
                      },
                    ),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(34),
                        ),
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                const Color(0xFF0B1220),
                                const Color(0xFF0B1220)
                                    .withOpacity(0.9),
                              ],
                            ),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.all(16),
                                  child: _buildPage(context),
                                ),
                              ),
                              _BottomNav(
                                currentIndex: _currentIndex,
                                onTap: (index) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPage(BuildContext context) {
    switch (_currentIndex) {
      case 0:
        return _HomeContent(
          onOpenRoutes: () => setState(() => _currentIndex = 1),
          onOpenTrack: () => setState(() => _currentIndex = 2),
          onOpenSaved: () => setState(() => _currentIndex = 3),
          onOpenTerms: () => _showTerms(context),
        );
      case 1:
        return _RoutesContent(
          routes: _filteredRoutes,
          filter: _routeFilter,
          onFilterChanged: (value) {
            setState(() {
              _routeFilter = value;
            });
          },
          onOpenTerms: () => _showTerms(context),
        );
      case 2:
        return const _TrackContent();
      case 3:
        return const _SavedContent();
      case 4:
        return _SettingsContent(onOpenTerms: () => _showTerms(context));
      default:
        return const SizedBox.shrink();
    }
  }

  void _showTerms(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF141A28),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Terms and Credits',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 12),
              Text(
                'Schedule links are based on official JUTC timetable PDFs. Live '
                'tracking is a mock experience and requires device location '
                'permissions in a production build.',
                style: TextStyle(color: Color(0xFFB6C1D6), height: 1.4),
              ),
              SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}

class _TopBar extends StatelessWidget {
  const _TopBar({required this.controller, required this.onChanged});

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 18, 16, 12),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            const Color(0xFF121A2A),
            const Color(0xFF0B1220).withOpacity(0.95),
          ],
        ),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(34)),
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.12)),
        ),
      ),
      child: Row(
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 34,
                decoration: BoxDecoration(
                  color: const Color(0xFF1B7D3A).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.directions_bus, size: 20),
              ),
              const SizedBox(width: 10),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'JUTC SmartRide',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'Schedules, routes, and tracking',
                    style: TextStyle(color: Color(0xFFB6C1D6), fontSize: 11),
                  ),
                ],
              ),
            ],
          ),
          const Spacer(),
          SizedBox(
            width: 160,
            child: TextField(
              controller: controller,
              onChanged: onChanged,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Search routes',
                hintStyle: const TextStyle(color: Color(0xFF9AA6BF)),
                filled: true,
                fillColor: Colors.white.withOpacity(0.06),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.14)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: BorderSide(color: Colors.white.withOpacity(0.14)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(999),
                  borderSide: const BorderSide(color: Color(0xFF1B7D3A)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.currentIndex, required this.onTap});

  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    final items = const [
      _NavItem(icon: Icons.home_outlined, label: 'Home'),
      _NavItem(icon: Icons.route_outlined, label: 'Routes'),
      _NavItem(icon: Icons.location_on_outlined, label: 'Track'),
      _NavItem(icon: Icons.bookmark_border, label: 'Saved'),
      _NavItem(icon: Icons.settings_outlined, label: 'Settings'),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        border: Border(top: BorderSide(color: Colors.white.withOpacity(0.12))),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(
          items.length,
          (index) {
            final selected = index == currentIndex;
            final item = items[index];
            return Expanded(
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => onTap(index),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      item.icon,
                      size: 22,
                      color: selected
                          ? Colors.white
                          : const Color(0xFF9AA6BF),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 11,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF9AA6BF),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _NavItem {
  const _NavItem({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

class _HomeContent extends StatelessWidget {
  const _HomeContent({
    required this.onOpenRoutes,
    required this.onOpenTrack,
    required this.onOpenSaved,
    required this.onOpenTerms,
  });

  final VoidCallback onOpenRoutes;
  final VoidCallback onOpenTrack;
  final VoidCallback onOpenSaved;
  final VoidCallback onOpenTerms;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF203A1C), Color(0xFF0B1220)],
                  ),
                ),
                child: Center(
                  child: Icon(
                    Icons.directions_bus,
                    size: 72,
                    color: Colors.white.withOpacity(0.85),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Find routes, view schedules, and track your trip',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              const Text(
                'Schedule links are based on official JUTC timetable PDFs. Use '
                'Track for your live location and a demo bus marker.',
                style: TextStyle(color: Color(0xFFB6C1D6), height: 1.4),
              ),
              const SizedBox(height: 16),
              _PrimaryButton(
                label: 'Browse routes',
                subtitle: 'Search and filter',
                onPressed: onOpenRoutes,
              ),
              const SizedBox(height: 10),
              _TonalButton(
                label: 'Premium combined schedule',
                subtitle: 'Open PDF',
                onPressed: () {},
              ),
              const SizedBox(height: 10),
              _TonalButton(
                label: 'Where is my bus?',
                subtitle: 'Map view',
                onPressed: onOpenTrack,
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        _CardContainer(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Saved',
                        style: TextStyle(
                          fontSize: 12,
                          letterSpacing: 1.5,
                          color: Color(0xFF9AA6BF),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Quick access',
                        style:
                            TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  _Badge(label: '0 saved'),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Save routes you use often. Open a route and tap Save.',
                style: TextStyle(color: Color(0xFFB6C1D6)),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _GhostButton(label: 'Open saved routes', onPressed: onOpenSaved),
                  _GhostButton(label: 'Terms and credits', onPressed: onOpenTerms),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _RoutesContent extends StatelessWidget {
  const _RoutesContent({
    required this.routes,
    required this.filter,
    required this.onFilterChanged,
    required this.onOpenTerms,
  });

  final List<RouteInfo> routes;
  final String filter;
  final ValueChanged<String> onFilterChanged;
  final VoidCallback onOpenTerms;

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Routes',
                    style: TextStyle(
                      fontSize: 12,
                      letterSpacing: 1.5,
                      color: Color(0xFF9AA6BF),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Search and open schedules',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              _Badge(label: '${routes.length} results'),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              _FilterChip(
                label: 'All',
                selected: filter == 'all',
                onTap: () => onFilterChanged('all'),
              ),
              _FilterChip(
                label: 'Standard',
                selected: filter == 'standard',
                onTap: () => onFilterChanged('standard'),
              ),
              _FilterChip(
                label: 'Premium',
                selected: filter == 'premium',
                onTap: () => onFilterChanged('premium'),
              ),
              _FilterChip(
                label: 'Rural/Express',
                selected: filter == 'rural',
                onTap: () => onFilterChanged('rural'),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: routes.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (context, index) {
              final route = routes[index];
              return _RouteTile(route: route);
            },
          ),
          const SizedBox(height: 12),
          const Text(
            'If a route PDF fails to display in-app, use Open in new tab.',
            style: TextStyle(color: Color(0xFF9AA6BF), fontSize: 12),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _TonalButton(label: 'Open premium combined schedule', onPressed: () {}),
              _GhostButton(label: 'Terms and credits', onPressed: onOpenTerms),
            ],
          ),
        ],
      ),
    );
  }
}

class _TrackContent extends StatelessWidget {
  const _TrackContent();

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Track your trip',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'View your live location and a demo bus marker on a map preview.',
            style: TextStyle(color: Color(0xFFB6C1D6)),
          ),
          const SizedBox(height: 16),
          Container(
            height: 240,
            decoration: BoxDecoration(
              color: const Color(0xFF0F1624),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.12)),
            ),
            child: const Center(
              child: Icon(Icons.map_outlined, size: 48, color: Color(0xFF9AA6BF)),
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            children: const [
              _GhostButton(label: 'Enable location', onPressed: null),
              _GhostButton(label: 'Center on bus', onPressed: null),
            ],
          ),
        ],
      ),
    );
  }
}

class _SavedContent extends StatelessWidget {
  const _SavedContent();

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            'Saved routes',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          SizedBox(height: 8),
          Text(
            'You have no saved routes yet. Open a route and tap Save to pin it here.',
            style: TextStyle(color: Color(0xFFB6C1D6)),
          ),
        ],
      ),
    );
  }
}

class _SettingsContent extends StatelessWidget {
  const _SettingsContent({required this.onOpenTerms});

  final VoidCallback onOpenTerms;

  @override
  Widget build(BuildContext context) {
    return _CardContainer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Preferences',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          const Text(
            'Customize theme, motion, and text scaling.',
            style: TextStyle(color: Color(0xFFB6C1D6)),
          ),
          const SizedBox(height: 12),
          _SettingTile(
            icon: Icons.brightness_6_outlined,
            title: 'Theme',
            subtitle: 'System default',
            onTap: () {},
          ),
          _SettingTile(
            icon: Icons.motion_photos_on_outlined,
            title: 'Motion',
            subtitle: 'Bouncy',
            onTap: () {},
          ),
          _SettingTile(
            icon: Icons.text_fields,
            title: 'Text size',
            subtitle: 'Normal',
            onTap: () {},
          ),
          const SizedBox(height: 12),
          _GhostButton(label: 'Terms and credits', onPressed: onOpenTerms),
        ],
      ),
    );
  }
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        backgroundColor: const Color(0xFF1B7D3A).withOpacity(0.2),
        child: Icon(icon, color: const Color(0xFFB6C1D6)),
      ),
      title: Text(title),
      subtitle: Text(subtitle, style: const TextStyle(color: Color(0xFF9AA6BF))),
      trailing: const Icon(Icons.chevron_right, color: Color(0xFF9AA6BF)),
      onTap: onTap,
    );
  }
}

class _RouteTile extends StatelessWidget {
  const _RouteTile({required this.route});

  final RouteInfo route;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        color: Colors.white.withOpacity(0.05),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 44,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                colors: [Color(0xFFFFE066), Color(0xFFFFD43B)],
              ),
            ),
            child: Center(
              child: Text(
                route.route,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  color: Color(0xFF1A1F2B),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Route ${route.route} • ${route.origin} → ${route.destination}',
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 4),
                Text(
                  route.via,
                  style: const TextStyle(color: Color(0xFF9AA6BF), fontSize: 12),
                ),
                const SizedBox(height: 8),
                _GhostButton(label: 'Open schedule PDF', onPressed: () {}),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CardContainer extends StatelessWidget {
  const _CardContainer({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: Colors.white.withOpacity(0.06),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 30,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(999),
        color: const Color(0xFF1B7D3A).withOpacity(0.2),
        border: Border.all(color: const Color(0xFF1B7D3A).withOpacity(0.4)),
      ),
      child: Text(label, style: const TextStyle(fontSize: 12)),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: selected
              ? const Color(0xFF1B7D3A).withOpacity(0.2)
              : Colors.white.withOpacity(0.04),
          border: Border.all(
            color: selected
                ? const Color(0xFF1B7D3A).withOpacity(0.4)
                : Colors.white.withOpacity(0.12),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.white : const Color(0xFF9AA6BF),
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.label,
    required this.subtitle,
    required this.onPressed,
  });

  final String label;
  final String subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1B7D3A),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(label),
            ],
          ),
          Text(
            subtitle,
            style: const TextStyle(color: Color(0xFFB6C1D6), fontSize: 12),
          ),
        ],
      ),
    );
  }
}

class _TonalButton extends StatelessWidget {
  const _TonalButton({required this.label, required this.onPressed, this.subtitle});

  final String label;
  final String? subtitle;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1B7D3A).withOpacity(0.2),
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 10,
                height: 10,
                decoration: const BoxDecoration(
                  color: Color(0xFFFFD43B),
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(label),
            ],
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: const TextStyle(color: Color(0xFFB6C1D6), fontSize: 12),
            ),
        ],
      ),
    );
  }
}

class _GhostButton extends StatelessWidget {
  const _GhostButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: Colors.white,
        side: BorderSide(color: Colors.white.withOpacity(0.2)),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      ),
      onPressed: onPressed,
      child: Text(label),
    );
  }
}
