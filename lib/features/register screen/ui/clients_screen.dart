import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymsystem/core/helper/responsive.dart';
import 'package:gymsystem/core/helper/spacer.dart';
import 'package:gymsystem/core/theme/app_colors.dart';
import 'package:gymsystem/core/theme/app_text_style.dart';
import 'package:gymsystem/features/register%20screen/logic/clients/clients_table_cubit.dart';
import 'package:gymsystem/features/register%20screen/ui/widgets/clients_header.dart';
import 'package:gymsystem/features/register%20screen/ui/widgets/clients_table.dart';

/// الـ ClientsTableCubit لازم يتوفر فوق الشاشة دي (BlocProvider بره).
/// ما تنادي loadPage في create بتاع الـ BlocProvider، الشاشة بتناديها بنفسها.
class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  final _searchCtrl = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<ClientsTableCubit>().loadPage(1);
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  void _refresh() {
    _searchCtrl.clear();
    context.read<ClientsTableCubit>().loadPage(1);
  }

  @override
  Widget build(BuildContext context) {
    final scale = context.scale;
    final pad = Responsive.value(
      context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    );

    return Padding(
      padding: EdgeInsets.all(pad),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: _searchCtrl,
                      onChanged: context.read<ClientsTableCubit>().search,
                      style: AppTextStyle.inputText.copyWith(
                        fontSize: 18 * scale,
                      ),
                      decoration: InputDecoration(
                        hintText: 'بحث برقم العضو او الاسم',
                        hintStyle: AppTextStyle.inputHint.copyWith(
                          fontSize: 16 * scale,
                        ),
                        fillColor: AppColors.surfaceContainerLow,
                        filled: true,
                        prefixIcon: const Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  horizontalSpace(12),
                  Material(
                    color: AppColors.surfaceContainerLow,
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: _refresh,
                      child: Padding(
                        padding: EdgeInsets.all(14 * scale),
                        child: Icon(
                          Icons.refresh_rounded,
                          size: 24 * scale,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              verticalSpace(20),
              ClientsHeader(),
              verticalSpace(20),
              const SizedBox(
                width: double.infinity,
                child: TablWithPagenation(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
