# Multi Bloc Builder
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)


This plugin relies on the [flutter_multi_bloc_builder](https://pub.dev/packages/flutter_multi_bloc_builder) package. It was developed to address issues encountered with its functionality and extends support for additional features.



#### Developer account on LinkedIn [Link](https://www.linkedin.com/in/zoualfkar-haydar).

A Flutter package that helps implement the [BLoC pattern]
It is best used as an extension with the [flutter_bloc](https://pub.dev/packages/flutter_bloc) package which already provides `MultiBlocProvider` , `MultiBlocListenerX` and `MultiBlocConsumer`.

This package is built to work with [bloc](https://pub.dev/packages/bloc).

## MultiBlocBuilder

__MultiBlocBuilder__ is a Flutter widget which requires minimum one `Bloc` and a `builder` function.
`MultiBlocBuilder` handles building the widget in response to new states.

The `MultiBlocBuilder` requires two parameters.
* `blocs`: Specify which bloc states the `MultiBlocBuilder` should observe for building the widget
* `builder`: Anonymous function which returnes your custom widget tree that rebuilds on each state change.

### How to use:
```dart
final bloc1 = BlocProvider.of<MyBloc1>(context);
final bloc2 = BlocProvider.of<MyBloc2>(context);
final bloc3 = BlocProvider.of<MyBloc2>(context);

MultiBlocBuilder(
    blocs: [bloc1, bloc2, bloc3],
    builder: (context, states) {
        final state1 = states.get<MyBloc1State>();
        final state2 = states.get<MyBloc2State>();
        final state3 = states.get<MyBloc3State>();
        
        if (state1 is Loading || state2 is Loading || state3 is Loading) {
            return Text("Loading");
        } else {
            return Text("SHow some content");
        }
    }
);
```



## MultiBlocListenerX

__MultiBlocListenerX__ is a Flutter widget which requires minimum one `Bloc` and a `listener` function.
`MultiBlocListner` handles building the widget in response to new states.

The `MultiBlocListenerX` requires three parameters.
* `blocs`: Specify which bloc states the `MultiBlocListner` should observe for building the widget

* `listner`: An anonymous function that contains your code to listen for state changes in the BLoC. This function is triggered every time the state changes.

* `builder`: Anonymous function which returnes your custom widget tree that rebuilds on each state change.

### How to use:
```dart
final bloc1 = BlocProvider.of<MyBloc1>(context);
final bloc2 = BlocProvider.of<MyBloc2>(context);
final bloc3 = BlocProvider.of<MyBloc2>(context);

MultiBlocListenerX(
    blocs: [bloc1, bloc2, bloc3],
    listener: (context, states) {
        final state1 = states.get<MyBloc1State>();
        final state2 = states.get<MyBloc2State>();
        final state3 = states.get<MyBloc3State>();
        
        if (state1 is Loading || state2 is Loading || state3 is Loading) {
            // ... Do Something
        } else {
             // ... Do Something
        }
    },
    child: SizedBox.shrink()
);
```


## MultiBlocConsumer

__MultiBlocConsumer__ is a Flutter widget which requires minimum one `Bloc` , a `listener` function.
`MultiBlocConsumer` handles building the widget in response to new states.

The `MultiBlocConsumer` requires three parameters.
* `blocs`: Specify which bloc states the `MultiBlocListner` should observe for building the widget
* `listener`: Anonymous function which have your code that listen on each state change.
* `builder`: Anonymous function which returnes your custom widget tree that rebuilds on each state change.

### How to use:
```dart
final bloc1 = BlocProvider.of<MyBloc1>(context);
final bloc2 = BlocProvider.of<MyBloc2>(context);
final bloc3 = BlocProvider.of<MyBloc2>(context);

MultiBlocListner(
blocs: [bloc1, bloc2, bloc3],
listener: (context, states) {
final state1 = states.get<MyBloc1State>();
final state2 = states.get<MyBloc2State>();
final state3 = states.get<MyBloc3State>();

if (state1 is Loading || state2 is Loading || state3 is Loading) {
// ... Do Something
} else {
// ... Do Something
}
},
builder: (context, states) {
final state1 = states.get<MyBloc1State>();
final state2 = states.get<MyBloc2State>();
final state3 = states.get<MyBloc3State>();

if (state1 is Loading || state2 is Loading || state3 is Loading) {
return Text("Loading");
} else {
return Text("SHow some content");
}
}
);
```