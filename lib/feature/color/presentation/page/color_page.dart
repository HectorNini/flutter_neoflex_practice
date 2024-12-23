import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/feature/color/presentation/cubit/color_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CubitPage extends StatelessWidget {
  const CubitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ColorCubit>.value(
        value: GetIt.I(),
        child: Scaffold(
          appBar: AppBar(backgroundColor: const Color.fromARGB(255, 29, 15, 223),),
          body: SafeArea(
            child: Center(
              child: BlocConsumer<ColorCubit, ColorState>(
               listener: ( context,  state) { 
                print(state);
               },
               buildWhen: (previous, current) {
                 return true;
               },
                builder: (context, state) {
                  if (state.isLoading){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return Column(
                    children: [
                      if(state.error.isNotEmpty)Text('Ошибка! ${state.error}'),
                      Container(
                        width: 200,
                        height: 200,
                        color: state.color,
                        child: Column(
                          children: [
                            Text(state.color.toString()),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed('/second');
                              },
                              child: const Text('Вторая страница'),
                            ),
                          ],
                        ),
                      ),
                      ColorPicker(
                        color: state.color,
                        onColorChanged: (color) {
                          context.read<ColorCubit>().setColor(color);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ),
      );
  }
}