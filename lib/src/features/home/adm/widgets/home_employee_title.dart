import 'package:flutter/material.dart';
import 'package:pj_barbershop_unifeob/src/core/ui/constants.dart';
import 'package:pj_barbershop_unifeob/src/models/user_model.dart';

class HomeEmployeeTitle extends StatelessWidget {
  final imageNetwork = false;
  final UserModel employee;

  const HomeEmployeeTitle({super.key, required this.employee});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 100,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 24,
      ),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorsConstants.grey),
      ),
      child: Row(
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: switch (imageNetwork) {
                  true => const NetworkImage('url'),
                  false => const AssetImage(ImageConstants.avatar)
                } as ImageProvider,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  employee.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12)),
                        onPressed: () {},
                        child: const Text('Agendar')),
                    OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15)),
                        onPressed: () {},
                        child: const Text('Ver Agenda')),
                    const Icon(
                      Icons.edit,
                      color: ColorsConstants.brow,
                      size: 24,
                    ),
                    const Icon(
                      Icons.delete,
                      color: ColorsConstants.red,
                      size: 24,
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
