import 'dart:async';

import 'package:event_bus/event_bus.dart';

abstract class AppBus {
  late EventBus _eventBus;
  EventBus get eventBus => _eventBus;
  AppBus() {
    _eventBus = EventBus();
  }

  Stream<T> getStream<T extends AppEvent>() {
    return _eventBus.on<T>();
  }

  StreamSubscription<T> sunscribe<T extends AppEvent>(Function(T e) todo) {
    return _eventBus.on<T>().listen(todo);
  }

  void unSubscribe<T extends AppEvent>(StreamSubscription<T> stream) {
    stream.cancel();
  }

  void fire(AppEvent event) {
    _eventBus.fire(event);
  }

  void close() {
    _eventBus.destroy();
  }
}

abstract class AppEvent {}
