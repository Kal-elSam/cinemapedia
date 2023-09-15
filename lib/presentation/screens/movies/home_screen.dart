import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomButtonNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextpage();
    ref.read(popularMoviesProvider.notifier).loadNextpage();
    ref.read(topMoviesProvider.notifier).loadNextpage();
    ref.read(upcomingMoviesProvider.notifier).loadNextpage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();


    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final topMovies = ref.watch(topMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(slivers: [
      const SliverAppBar(
        floating: true,
        flexibleSpace: FlexibleSpaceBar(
          title: CustomAppBar(),
        ),
      ),
      SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
        return Column(
          children: [
            MoviesSlidesshow(movies: slideShowMovies),
            MovieHorizontalListview(
              movie: nowPlayingMovies,
              title: 'En Cines',
              subtitle: 'Fecha',
              loadNextPage: () =>
                  ref.read(nowPlayingMoviesProvider.notifier).loadNextpage(),
            ),
            MovieHorizontalListview(
              movie: upcomingMovies,
              title: 'Proximamente',
              subtitle: 'Fecha',
              loadNextPage: () =>
                  ref.read(upcomingMoviesProvider.notifier).loadNextpage(),
            ),
            MovieHorizontalListview(
              movie: popularMovies,
              title: 'Populares',
              // subtitle: 'Fecha',
              loadNextPage: () =>
                  ref.read(popularMoviesProvider.notifier).loadNextpage(),
            ),
            MovieHorizontalListview(
              movie: topMovies,
              title: 'Mejor calificadas',
              subtitle: 'Lo mejor de lo mejor',
              loadNextPage: () =>
                  ref.read(topMoviesProvider.notifier).loadNextpage(),
            ),
            const SizedBox(height: 10),
          ],
        );
      }, childCount: 1))
    ]);
  }
}
