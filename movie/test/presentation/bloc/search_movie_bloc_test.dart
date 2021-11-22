import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecase/search_movies.dart';
import 'package:movie/presentation/bloc/search_movie_bloc/search_bloc.dart';

import 'search_movie_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late SearchMovieBloc searchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    searchBloc = SearchMovieBloc(mockSearchMovies);
  });

  final tMovieModel = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );
  final tMovieList = <Movie>[tMovieModel];

  const tQuery = 'spiderman';

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  blocTest<SearchMovieBloc, SearchState>(
    'Should emit [Loading, HasData] when data movies is gotten successfully',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => Right(tMovieList));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      SearchHasDataMovies(tMovieList),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );

  blocTest<SearchMovieBloc, SearchState>(
    'Should emit [Loading, Error] when get search movies is unsuccessful',
    build: () {
      when(mockSearchMovies.execute(tQuery))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return searchBloc;
    },
    act: (bloc) => bloc.add(const OnQueryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SearchLoading(),
      const SearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchMovies.execute(tQuery));
    },
  );
}
