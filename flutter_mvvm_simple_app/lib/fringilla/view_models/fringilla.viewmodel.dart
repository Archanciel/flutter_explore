import 'package:flutter/material.dart';

import 'package:flutter_mvvm_simple_app/fringilla/model/fringilla.model.dart';
import 'package:flutter_mvvm_simple_app/fringilla/repository/fringilla_repo.dart';

import 'package:flutter_mvvm_simple_app/shared/view_models/loading.viewmodel.dart';

class FringillaViewModel extends LoadingViewModel {
  FringillaViewModel({
    required this.repo,
  });

  final FringillaRepo repo;

  FringillaModel get model => _model;

  Future<void> fetchData() async {
    try {
      isLoading = true;

      model = await repo.fetchData();
    } catch (exc) {
      debugPrint('Error in _fetchData : ${exc.toString()}');
    }

    isLoading = false;
  }

  set model(FringillaModel model) {
    _model = model;
    notifyListeners();
  }

  // INTERNALS

  FringillaModel _model = FringillaModel();
}
