library multi_bloc_builder;

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:multi_bloc_builder_widget/bloc_state.dart';

class MultiBlocConsumer extends StatefulWidget {
  final Function(BuildContext, BlocStates) _listener;
  final Widget Function(BuildContext, BlocStates) _builder;
  final List<BlocBase> _blocs;
  final bool Function(BuildContext, BlocStates)? _buildWhen;
  final bool Function(BuildContext, BlocStates)? _listenWhen;


  /// [MultiBlocConsumer] handles building a widget by observing state of variouse [Bloc]s
  /// and should be used in combination with the [flutter_bloc](https://pub.dev/packages/flutter_bloc) package.
  /// Specify the bloc to observed via the [blocs] parameter.
  /// The [builder] rebuilds each time a state change occurs and provides a context ([BuildContext]) and the states ([BlocStates]).
  /// The [listener] listen each time change occurs and provides a context ([BuildContext]) and the states ([BlocStates]).
  ///
  /// How to use:
  /// ```
  /// final bloc1 = BlocProvider.of<MyBloc1>(context);
  /// final bloc2 = BlocProvider.of<MyBloc2>(context);
  /// final bloc3 = BlocProvider.of<MyBloc2>(context);
  ///
  /// MultiBlocConsumer(
  ///   blocs: [bloc1, bloc2, bloc3],
  ///   listener: (context, states) {
  ///     final state1 = states.get<MyBloc1State>();
  ///     final state2 = states.get<MyBloc2State>();
  ///     final state3 = states.get<MyBloc3State>();
  ///
  ///     if (state1 is Loading || state2 is Loading || state3 is Loading) {
  ///        ... Do something
  ///     } else {
  ///       ... Do something
  ///     }
  ///   }
  ///   builder: (context, states) {
  ///     final state1 = states.get<MyBloc1State>();
  ///     final state2 = states.get<MyBloc2State>();
  ///     final state3 = states.get<MyBloc3State>();
  ///
  ///     if (state1 is Loading || state2 is Loading || state3 is Loading) {
  ///       return Text("Loading");
  ///     } else {
  ///       return Text("SHow some content");
  ///     }
  ///   }
  /// );
  /// ```
  const MultiBlocConsumer({super.key,
    required List<BlocBase> blocs,
    required Function(BuildContext, BlocStates) listener,
    required Widget Function(BuildContext, BlocStates) builder,
    bool Function(BuildContext, BlocStates)? buildWhen,
    bool Function(BuildContext, BlocStates)? listenWhen

  }) :
        _blocs = blocs,
        _listener = listener,
        _builder = builder,
        _buildWhen = buildWhen,
        _listenWhen = listenWhen;


  @override
  State<StatefulWidget> createState() => _MultiBlocState();
}

/// Serves as the state of the [MultiBlocBuilder].
class _MultiBlocState extends State<MultiBlocConsumer> {
  final List<StreamSubscription> _stateSubscriptions = [];


  /// [states] Retrieves a list of current states
  /// from all blocs managed by the widget.
  get states=>widget._blocs.map( (bloc) => bloc.state).toList();


  @override
  void initState() {
    super.initState();

    // Loop through each bloc managed by the widget
    for (var bloc in widget._blocs) {
      // Create a subscription to listen to the bloc's stream
      final subscription = bloc.stream.listen((state) {
        // When a state change occurs:

        listenToBlocs();

        buildBlocs();
      });

      // Store the subscription for later disposal
      _stateSubscriptions.add(subscription);
    }

  }

  /// [listenToBlocs] Listens to bloc states and triggers
  /// the listener callback based on conditions.
  listenToBlocs(){
    if(widget._listenWhen!=null){
      bool listen = widget._listenWhen!(context, BlocStates(states));

      if(listen) widget._listener(context, BlocStates(states));
    }else{
      widget._listener(context, BlocStates(states));
    }
  }


  /// [buildBlocs] Triggers a rebuild based
  /// on conditions or unconditionally rebuilds.
  buildBlocs(){
    if(widget._buildWhen!=null){
      bool build = widget._buildWhen!(context, BlocStates(states));

      if(build)  setState(() {});
    }else{
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget._builder(context, BlocStates(states));
  }


  @override
  void dispose() {
    super.dispose();
    for (var subscription in _stateSubscriptions) {
      subscription.cancel();
    }
  }
}
