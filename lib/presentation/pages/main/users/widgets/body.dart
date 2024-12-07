import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_admin/core/services/di.dart';
import 'package:news_admin/presentation/dialogs/error.dart';
import 'package:news_admin/presentation/dialogs/yes_no_dialog.dart';
import 'package:news_admin/presentation/pages/main/users/data/delete/cubit/delete_user_cubit.dart';
import 'package:news_admin/presentation/pages/main/users/data/repository.dart';
import 'package:news_admin/presentation/pages/main/users/data/response.dart';
import 'package:news_admin/presentation/pages/main/users/widgets/edit_dialog.dart';
import '../../../../../core/constants/colors.dart';

class UsersBody extends StatefulWidget {
  const UsersBody({super.key});

  @override
  State<UsersBody> createState() => _UsersBodyState();
}

class _UsersBodyState extends State<UsersBody> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(defaultPadding),
      decoration: const BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: StreamBuilder(
        stream: getIt<IUserRepository>().usersStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final list = UserDetails.usersFromSnapshot(snapshot.data!.docs);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Users",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                SizedBox(
                  width: double.infinity,
                  child: DataTable(
                    columnSpacing: defaultPadding,
                    columns: const [
                      DataColumn(
                        label: Text("ID"),
                      ),
                      DataColumn(
                        label: Text("E-mail"),
                      ),
                      DataColumn(
                        label: Text("Username"),
                      ),
                      DataColumn(
                        label: Text("Role"),
                      ),
                      DataColumn(
                        label: Text("Action"),
                        headingRowAlignment: MainAxisAlignment.center,
                      ),
                    ],
                    rows: List.generate(
                      list.length,
                      (index) => _tableRow(context, list[index]),
                    ),
                  ),
                ),
              ],
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }

  DataRow _tableRow(BuildContext context, UserDetails user) {
    return DataRow(
      cells: [
        DataCell(Text(user.id.toString(), maxLines: 1)),
        DataCell(Text(user.email.toString(), maxLines: 1)),
        DataCell(Text(user.username.toString(), maxLines: 1)),
        DataCell(Text(user.role.title.toString(), maxLines: 1)),
        DataCell(
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () {
                  EditUserDialog.show(context, user);
                },
                icon: const Icon(Icons.edit, color: Colors.orange),
              ),
              BlocListener<DeleteUserCubit, DeleteUserState>(
                listener: (context, state) {
                  if (state is DeleteUserFailure) {
                    showErrorDialog(context, state.message);
                  }
                },
                child: IconButton(
                  onPressed: () => _handleDelete(user.id),
                  icon: const Icon(Icons.delete, color: Colors.red),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleDelete(String id) {
    showYesNoDialog(
      context,
      title: 'Do you want to delete user?',
      onYes: () {
        context.read<DeleteUserCubit>().delete(id);
        Navigator.pop(context);
      },
    );
  }
}
