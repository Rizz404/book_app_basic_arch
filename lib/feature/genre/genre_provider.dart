import 'package:book_app_basic_arch/feature/genre/genre_model.dart';
import 'package:book_app_basic_arch/feature/genre/genre_services.dart';
import 'package:flutter/material.dart';

class GenreProvider with ChangeNotifier {
  final GenreServices _genreServices = GenreServices();

  List<GenreModel> _genres = [];
  List<GenreModel> get genres => _genres;
  GenreModel? _genre;
  GenreModel? get genre => _genre;

  // * State untuk loading dan error per operasi
  bool _isLoadingCreateGenre = false;
  bool get isLoadingCreateGenre => _isLoadingCreateGenre;
  String? _errorMessageCreateGenre;
  String? get errorMessageCreateGenre => _errorMessageCreateGenre;

  bool _isLoadingGetGenres = false;
  bool get isLoadingGetGenres => _isLoadingGetGenres;
  String? _errorMessageGetGenres;
  String? get errorMessageGetGenres => _errorMessageGetGenres;

  bool _isLoadingGetGenreById = false;
  bool get isLoadingGetGenreById => _isLoadingGetGenreById;
  String? _errorMessageGetGenreById;
  String? get errorMessageGetGenreById => _errorMessageGetGenreById;

  bool _isLoadingUpdateGenre = false;
  bool get isLoadingUpdateGenre => _isLoadingUpdateGenre;
  String? _errorMessageUpdateGenre;
  String? get errorMessageUpdateGenre => _errorMessageUpdateGenre;

  bool _isLoadingDeleteGenre = false;
  bool get isLoadingDeleteGenre => _isLoadingDeleteGenre;
  String? _errorMessageDeleteGenre;
  String? get errorMessageDeleteGenre => _errorMessageDeleteGenre;

  Future<void> createGenre(CreateGenreModel genre) async {
    _isLoadingCreateGenre = true;
    _errorMessageCreateGenre = null;
    notifyListeners();
    try {
      await _genreServices.createGenre(genre);

      await getGenres();
    } catch (e) {
      _errorMessageCreateGenre = 'Error fetching genres: $e';
      debugPrint('Error fetching genres: $e');
    } finally {
      _isLoadingCreateGenre = false;
      notifyListeners();
    }
  }

  Future<void> getGenres() async {
    _isLoadingGetGenres = true;
    _errorMessageGetGenres = null;
    notifyListeners();
    try {
      final response = await _genreServices.getGenres();

      _genres = response.data!;
    } catch (e) {
      _errorMessageGetGenres = 'Error fetching genres: $e';
      debugPrint('Error fetching genres: $e');
    } finally {
      _isLoadingGetGenres = false;
      notifyListeners();
    }
  }

  Future<void> getGenreById(String id) async {
    _isLoadingGetGenreById = true;
    _errorMessageGetGenreById = null;
    notifyListeners();
    try {
      final response = await _genreServices.getGenreById(id);

      _genre = response.data!;
    } catch (e) {
      _errorMessageGetGenreById = 'Error fetching genres: $e';
      debugPrint('Error fetching genres: $e');
    } finally {
      _isLoadingGetGenreById = false;
      notifyListeners();
    }
  }

  Future<void> updateGenre(UpdateGenreModel genre) async {
    _isLoadingUpdateGenre = true; // Gunakan state loading yang sama
    _errorMessageUpdateGenre = null;
    notifyListeners();

    try {
      await _genreServices.updateGenreById(genre);
      await getGenreById(genre.id); // Perbarui daftar genre
      await getGenres(); // Perbarui daftar genre
    } catch (e) {
      _errorMessageUpdateGenre = 'Error updating genre: $e';
      debugPrint('Error updating genre: $e');
    } finally {
      _isLoadingUpdateGenre = false;
      notifyListeners();
    }
  }

  Future<void> deleteGenre(String id) async {
    _isLoadingDeleteGenre = true; // Gunakan state loading yang sama
    _errorMessageDeleteGenre = null;
    notifyListeners();

    try {
      await _genreServices.deleteGenreById(id);
      await getGenres(); // Perbarui daftar genre
    } catch (e) {
      _errorMessageDeleteGenre = 'Error updating genre: $e';
      debugPrint('Error updating genre: $e');
    } finally {
      _isLoadingDeleteGenre = false;
      notifyListeners();
    }
  }
}
