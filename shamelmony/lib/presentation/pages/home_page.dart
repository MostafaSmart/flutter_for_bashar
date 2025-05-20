import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/l10n/app_localizations.dart';
import '../../shared/l10n/app_localizations_setup.dart';
import '../bloc/auth/auth_bloc.dart';
import '../bloc/auth/auth_event.dart';
import '../bloc/auth/auth_state.dart';
import 'login_page.dart';

/// الصفحة الرئيسية
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context);
    final localizations = AppLocalizationsSetup.setup(context, locale);
    final isArabic = locale.languageCode == 'ar';

    return Scaffold(
      appBar: AppBar(
        title: Text(localizations.home),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              context.read<AuthBloc>().add(LogoutEvent());
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Directionality(
        textDirection: isArabic ? TextDirection.rtl : TextDirection.ltr,
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoadingState) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const CircularProgressIndicator(),
                    const SizedBox(height: 16),
                    Text(localizations.loading),
                  ],
                ),
              );
            } else if (state is AuthAuthenticatedState) {
              final user = state.user;
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        '${localizations.welcome}, ${user?.username ?? ""}',
                        style: Theme.of(context).textTheme.headlineMedium,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      if (user != null) ...[
                        ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(localizations.username),
                          subtitle: Text(user.username),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.email),
                          title: Text('Email'),
                          subtitle: Text(user.email),
                        ),
                        const Divider(),
                        ListTile(
                          leading: const Icon(Icons.numbers),
                          title: Text('ID'),
                          subtitle: Text('${user.id}'),
                        ),
                      ],
                      const SizedBox(height: 32),
                      ElevatedButton.icon(
                        onPressed: () {
                          final localeCubit = context.read<LocaleCubit>();
                          final currentLocale = Localizations.localeOf(context);
                          final newLocale = currentLocale.languageCode == 'ar'
                              ? 'en'
                              : 'ar';
                          localeCubit.changeLocale(newLocale);
                        },
                        icon: const Icon(Icons.language),
                        label: Text(localizations.changeLanguage),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizations.error,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<AuthBloc>().add(CheckAuthStatusEvent());
                      },
                      child: Text(localizations.retry),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
