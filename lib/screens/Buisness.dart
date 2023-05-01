import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/newscubit.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/shared/components/components.dart';

class BusinessScreen extends StatelessWidget {
  const BusinessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var list = NewsCubit.get(context).business;
        return ConditionalBuilder(
          condition: list.isNotEmpty,
          builder: (context) => ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) =>
                  buildArtcileItem(list[index], context),
              separatorBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      width: double.infinity,
                      height: 1.0,
                      color: Colors.grey[300],
                    ),
                  ),
              itemCount: 10),
          fallback: (context) =>
              const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}
