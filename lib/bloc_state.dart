
/// [BlocStates] serves as a container of [dynamic] objects (usually bloc states).
/// It is part of the [MultiBlocProvider] package and therefore mainly used
/// to provide a varety of bloc states via the [MultiBlocBuilder._builder] function.
///
/// A bloc states can be retrieved via the [get] method and the wanted type like this:
/// ```
/// final exampeState = blocStates.get<ExampleState>();
/// ```
///
class BlocStates {
  final List _stats = [];

  BlocStates(List states)  {
    _stats.addAll(states);
  }

  /// Retrieves the first object that matches the generic or null if no machting object available.
  /// __NOTE:__ Please ensure that [BlocStates] doesn't contain multiple objects of the same type.
  ///
  /// How to use:
  /// ```
  /// final exampeState = blocStates.get<ExampleState>();
  /// ```
  T get<T>() => _stats.firstWhere(
          (entry) => (entry is T),
      orElse: () => null
  );

  /// if you have multiple objects of save type you can use this
  /// final state = states.getState<ExampleState>(0)
  T getState<T>(int index) {
    return _stats[index];
  }
}