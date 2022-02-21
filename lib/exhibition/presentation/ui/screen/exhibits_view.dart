import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_test/exhibition/presentation/logic/cubit/exhibit_cubit.dart';
import 'package:in_test/exhibition/presentation/ui/widget/exhibit_widget.dart';

class Exhibits extends StatefulWidget {
  const Exhibits({Key? key}) : super(key: key);

  @override
  State<Exhibits> createState() => _ExhibitsState();
}

class _ExhibitsState extends State<Exhibits> {
  ExhibitCubit? cubit;

  @override
  void initState() {
    super.initState();
    cubit = BlocProvider.of<ExhibitCubit>(context, listen: false);
    cubit?.getExhibits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Exhibit Items'),
      ),
      body: SafeArea(
        child:
            BlocBuilder<ExhibitCubit, ExhibitState>(builder: (context, state) {
          if (state is Loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is Loaded) {
            return ListView.builder(
                padding: EdgeInsets.all(10),
                itemCount: state.exhibits.length,
                itemBuilder: (context, index) {
                  final exhibit = state.exhibits[index];
                  final PageController _controller =
                      PageController(initialPage: 0);
                  return exhibitWidget(
                      exhibit: exhibit, controller: _controller);
                });
          }
          if (state is Error) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(state.error.toString()),
                  ElevatedButton(
                      onPressed: () {
                        cubit?.getExhibits();
                      },
                      child: Text('Try Again'))
                ],
              ),
            );
          }
          return SizedBox.shrink();
        }),
      ),
    );
  }
}
