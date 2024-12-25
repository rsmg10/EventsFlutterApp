import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCounter extends StatelessWidget {
  const BlocCounter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const CounterView(),
    );
  }
}
class CounterView extends StatelessWidget {
  const CounterView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocBuilder<CounterBloc, int>(
          builder: (context, count) {
            return Text(
              '$count',
              style: Theme.of(context).textTheme.displayLarge,
            );          },
        ),
      ),
      floatingActionButton: Column(

        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            heroTag: "addbtn",
            child: const Icon(Icons.add),
            onPressed: () {
              context.read<CounterBloc>().increment();
            },
          ),
          const SizedBox(height: 4),
          FloatingActionButton(
            heroTag: "decbtn",
            child: const Icon(Icons.remove),
            onPressed: () {
              context.read<CounterBloc>().decrement();
            },
          ),
        ],
      ),
    );
  }
}

class CounterBloc extends Cubit<int> {
  CounterBloc() : super(0);
  void increment(){
    emit(state + 1);
  }
  void decrement(){
    emit(state - 1);
  }
}




