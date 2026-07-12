import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:movie_recommendation_app/main.dart';
import 'package:movie_recommendation_app/services/api_service.dart';

class Backgroundimageprovider extends ChangeNotifier {
  final ApiService api = ApiService();

  final List<String> _backgroundImages = [];
  List<String> get backgroundImages => _backgroundImages;

  Timer? _timer;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  bool loading = false;

  Future<void> fetchBackgroundImages () async {
    showLoading(true);
    try {
      _backgroundImages.clear();
      _backgroundImages.addAll(await api.getWelcomeBackgroundImages());
      notifyListeners();
    } on DioException catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.message ?? e.toString()),
      ));
    } catch (e) {
      scaffoldMessenger.currentState?.showSnackBar(SnackBar(
        content: Text(e.toString()),
      ));
    } finally {
      showLoading(false);
    }
  }

  void startAutoSlide () {
    if (_backgroundImages.isEmpty) return; 

    _timer?.cancel(); 

    _timer = Timer.periodic(
      const Duration(seconds: 4),
      (timer) {
        _currentIndex = (_currentIndex + 1) % _backgroundImages.length; 
        notifyListeners();
      }
    );
  }

  void stopAutoSlide () {
    _timer?.cancel();
    _timer = null;
    _currentIndex = 0;
  }

  @override
  void dispose () {  
    _timer?.cancel();  
    super.dispose();
  }

  void showLoading (bool value) {
    loading = value;
    notifyListeners();
  }
}