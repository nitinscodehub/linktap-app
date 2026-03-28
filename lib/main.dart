import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/link_provider.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(const OneTapLinksApp());
}

class OneTapLinksApp extends StatelessWidget {
  const OneTapLinksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LinkProvider()..loadLinks(),
      child: MaterialApp(
        title: AppStrings.appName,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: AppColors.primary,
            primary: AppColors.primary,
            secondary: AppColors.accent,
            surface: AppColors.surface,
            error: AppColors.error,
          ),
          useMaterial3: true,
          appBarTheme: const AppBarTheme(centerTitle: true, elevation: 0),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            elevation: 4,
          ),
          cardTheme: CardThemeData(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        home: const MainScreen(),
      ),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [const HomeScreen(), const SettingsScreen()];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _screens),
      drawer: _buildDrawer(context),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: AppStrings.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            activeIcon: Icon(Icons.settings),
            label: AppStrings.settings,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.touch_app,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    AppStrings.appName,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    AppStrings.appDescription,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home, color: AppColors.primary),
            title: const Text(AppStrings.home),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings, color: AppColors.primary),
            title: const Text(AppStrings.settings),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(1);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.info_outline,
              color: AppColors.textSecondary,
            ),
            title: const Text(AppStrings.about),
            onTap: () {
              Navigator.pop(context);
              _onItemTapped(1);
            },
          ),
          const Spacer(),
          const Divider(),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              AppStrings.version,
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}
