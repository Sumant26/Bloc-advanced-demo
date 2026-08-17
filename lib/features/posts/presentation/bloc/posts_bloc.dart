import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../domain/entities/post.dart';
import '../../domain/repositories/post_repository.dart';

part 'posts_event.dart';
part 'posts_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> debounce<E>(Duration duration) {
  return (events, mapper) {
    return events.debounce(duration).switchMap(mapper);
  };
}

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final PostRepository postRepository;
  List<Post> _allPosts = [];

  PostsBloc({required this.postRepository}) : super(PostsInitial()) {
    on<GetPostsEvent>(_onGetPosts, transformer: droppable());
    on<SearchPostsEvent>(_onSearchPosts, transformer: debounce(const Duration(milliseconds: 500)));
  }

  Future<void> _onGetPosts(GetPostsEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    try {
      final posts = await postRepository.getPosts();
      _allPosts = posts;
      emit(PostsLoaded(posts));
    } catch (e) {
      emit(PostsError(e.toString()));
    }
  }

  Future<void> _onSearchPosts(SearchPostsEvent event, Emitter<PostsState> emit) async {
    if (event.query.isEmpty) {
      emit(PostsLoaded(_allPosts));
      return;
    }

    emit(PostsLoading());
    // Simulate some logic (could be API search)
    final filtered = _allPosts
        .where((post) => post.title.toLowerCase().contains(event.query.toLowerCase()))
        .toList();
    emit(PostsLoaded(filtered));
  }
}
