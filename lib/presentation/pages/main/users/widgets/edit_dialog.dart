import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_admin/core/extension.dart';
import 'package:news_admin/core/services/di.dart';
import 'package:news_admin/presentation/dialogs/error.dart';
import 'package:news_admin/presentation/pages/main/users/data/response.dart';
import 'package:news_admin/presentation/pages/main/users/data/update/cubit/update_user_cubit.dart';
import 'package:news_admin/presentation/pages/main/users/data/update/request.dart';
import 'package:news_admin/presentation/widgets/custom_button.dart';
import 'package:news_admin/presentation/widgets/custom_dropdown.dart';

class EditUserDialog extends StatefulWidget {
  const EditUserDialog({super.key, required this.userDetails});
  final UserDetails userDetails;
  static Future show(BuildContext context, UserDetails userDetails) {
    return showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        insetPadding: EdgeInsets.zero,
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        children: [
          BlocProvider(
            create: (context) => UpdateUserCubit(getIt()),
            child: EditUserDialog(userDetails: userDetails),
          ),
        ],
      ),
    );
  }

  @override
  State<EditUserDialog> createState() => _EditUserDialogState();
}

class _EditUserDialogState extends State<EditUserDialog> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  late final ValueNotifier<Role> _roleNotifier;

  @override
  void initState() {
    super.initState();
    _roleNotifier = ValueNotifier(widget.userDetails.role);
  }

  @override
  void dispose() {
    _roleNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Select role',
                style: context.style.bodyLarge?.copyWith(color: Colors.black),
              ),
              const SizedBox(height: 8),
              CustomDropdown(
                list: Role.values.map((role) => role.title).toList(),
                initiValue: _roleNotifier.value.title,
                onTap: (value) {
                  _roleNotifier.value = Role.values.firstWhere(
                    (element) => element.title == value,
                    orElse: () => Role.user,
                  );
                },
              ),
              const SizedBox(height: 12),
              BlocConsumer<UpdateUserCubit, UpdateUserState>(
                listener: (context, state) {
                  if (state is UpdateUserFailure) {
                    showErrorDialog(context, state.message);
                  }
                  if (state is UpdateUserSuccess) {
                    Navigator.pop(context);
                  }
                },
                builder: (context, state) {
                  return CustomButton(
                    title: 'Submit',
                    onTap: () => _onSubmit(widget.userDetails),
                    backgroundColor: Colors.green,
                    isLoading: state is UpdateUserLoading,
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  void _onSubmit(UserDetails userDetails) {
    final request =
        UpdateUserRequest(id: userDetails.id, role: _roleNotifier.value);
    context.read<UpdateUserCubit>().update(request);
  }
}
