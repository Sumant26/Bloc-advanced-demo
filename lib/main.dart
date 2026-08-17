import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/bloc_observer.dart';
import 'core/theme/theme_cubit.dart';
import 'features/posts/presentation/bloc/posts_bloc.dart';
import 'features/posts/presentation/pages/posts_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Dependency Injection
  await di.init();
  
  // Set Global BLoC Observer
  Bloc.observer = AppBlocObserver();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => ThemeBloc()),
        BlocProvider(create: (_) => di.sl<PostsBloc>()),
      ],
      child: BlocBuilder<ThemeBloc, ThemeData>(
        builder: (context, theme) {
          return MaterialApp(
            title: 'Advanced BLoC Demo',
            debugShowCheckedModeBanner: false,
            theme: theme,
            home: const PostsPage(),
          );
        },
      ),
    );
  }
}
