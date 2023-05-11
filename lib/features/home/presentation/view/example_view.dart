import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/config.dart';
import '../../../../core/injection/injection.dart';
import '../../../../core/manager/loading_manager.dart';
import '../../../../shared/sliver/sliver_multiline_appbar.dart';
import '../../data/model/category_model.dart';
import '../bloc/home_bloc.dart';

class ExampleScreen extends StatefulWidget {
  final int id;
  const ExampleScreen({
    super.key,
    required this.id,
  });

  @override
  State<ExampleScreen> createState() => _ExampleScreenState();
}

class _ExampleScreenState extends State<ExampleScreen> {
  var bloc = getIt.get<HomeBloc>();

  List<JobGroup> jobGroupList = [];

  @override
  void initState() {
    super.initState();
    bloc.add(
      HomeEventInit(
        categoryId: widget.id,
        page: 1,
      ),
    );
  }

  get _primaryColor => App.theme.colors.primary;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (context) => bloc,
      child: Scaffold(
        backgroundColor: _primaryColor.yellow,
        body: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Container(
                color: _primaryColor.white,
              ),
              CustomScrollView(
                slivers: [
                  const SliverMultilineAppBar(
                    title: 'Example',
                    showLeading: true,
                  ),
                  BlocConsumer<HomeBloc, HomeState>(
                    listener: (context, state) {
                      LoadingManager.setLoading(
                        context,
                        loading: state is GetAllCareerLoading,
                      );
                      if (state is HomeJobGroupListLoaded) {
                        jobGroupList = state.jobGroupList;
                      }
                    },
                    builder: (context, state) {
                      if (state is HomeJobGroupListLoaded) {
                        return SliverList(
                          delegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return Text(jobGroupList[index].major);
                            },
                            childCount: jobGroupList.length,
                          ),
                        );
                      }
                      return const SliverToBoxAdapter();
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
