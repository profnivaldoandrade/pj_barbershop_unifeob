import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pj_barbershop_unifeob/src/core/ui/constants.dart';
import 'package:pj_barbershop_unifeob/src/core/ui/widgets/barbarshop_loader.dart';
import 'package:pj_barbershop_unifeob/src/features/home/adm/home_adm_state.dart';
import 'package:pj_barbershop_unifeob/src/features/home/adm/home_adm_vm.dart';
import 'package:pj_barbershop_unifeob/src/features/home/adm/widgets/home_employee_title.dart';
import 'package:pj_barbershop_unifeob/src/features/home/widgets/home_header.dart';

class HomeAdmPage extends ConsumerWidget {
  const HomeAdmPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeAdmVmProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorsConstants.brow,
        onPressed: () {},
        child: const CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 12,
          child: Icon(
            Icons.add,
            color: ColorsConstants.brow,
          ),
        ),
      ),
      body: homeState.when(
        data: (HomeAdmState data) {
          return CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(
                child: HomeHeader(),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) =>
                      HomeEmployeeTitle(employee: data.employees[index]),
                  childCount: data.employees.length,
                ),
              ),
            ],
          );
        },
        error: (error, stackTrace) {
          log('Erro ao carregar colaboradores',
              error: error, stackTrace: stackTrace);
          return const Center(child: Text('Erro ao carregar página'));
        },
        loading: () {
          return const BarberShopLoader();
        },
      ),
    );
  }

  void log(String s, {required Object error, required StackTrace stackTrace}) {}
}
