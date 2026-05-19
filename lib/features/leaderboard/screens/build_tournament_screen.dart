import 'package:auto_route/auto_route.dart';
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/common_widgets/simple_background.dart';
import 'package:pinlink/config/bloc/cubit_scope.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/features/course_comparision/entity/tournament_entity.dart';
import 'package:pinlink/features/leaderboard/cubit/friend_cubit.dart';
import 'package:pinlink/features/leaderboard/cubit/friend_state.dart';
import 'package:pinlink/features/leaderboard/widgets/friend_list_item_widget.dart';

@RoutePage()
class BuildTournamentScreen extends StatelessWidget {
  const BuildTournamentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleBackground(
      appBar: const CommonAppBar(),
      body: FormBuilder(
        scrollPhysics: const NeverScrollableScrollPhysics(),
        entity: TournamentEntity(),
        builder: (context, formKey, entity) {
          return CubitScope(
            create: () => FriendCubit()..getAllFrendList(isTournament: true),
            builder: (context, cubit, state) {
              return Column(
                children: [
                  Expanded(
                    child: SmartListLoader(
                      isLoading: state.isFrendListLoading,
                      onLoadMore: (page) {
                        cubit.getAllFrendList(page: page, isTournament: true);
                      },
                      onRefresh: () {
                        cubit.getAllFrendList(
                          page: 1,
                          isRefresh: true,
                          isTournament: true,
                        );
                      },
                      padding: Constants.bodyPadding,
                      itemCount: state.frendList.length,
                      appbar: _appBar(context, cubit, state, entity),
                      onColapsAppbar: Container(
                        padding: Constants.bodyPadding,
                        color: context.colors.background,
                        child: _onColupse(context, cubit, state),
                      ),
                      itemBuilder: (context, index) {
                        final friend = state.frendList[index];
                        final isSelected = state.selectedFriends.any(
                          (e) => e.id == friend.id,
                        );
                        return GestureDetector(
                          onTap: () => cubit.toggleFriendSelection(friend),
                          child: FriendListItemWidget(
                            friend: friend,
                            isSelected: isSelected,
                          ),
                        );
                      },
                    ),
                  ),

                  _bottomSections(context, formKey, entity, cubit),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Widget _bottomSections(
    BuildContext context,
    GlobalKey<FormState> formKey,
    TournamentEntity entity,
    FriendCubit cubit,
  ) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      const BuildLabel('Start Date'),
                      CommonDateInputTextField(
                        isValidationRequired: true,
                        validation: (val) {
                          final startDate = DateTime.tryParse(val ?? '');
                          if (val == null || val.isEmpty) {
                            return 'Start date is required';
                          }
                          if (startDate != null) {
                            final now = DateTime.now();
                            final today = DateTime(
                              now.year,
                              now.month,
                              now.day,
                            );
                            final start = DateTime(
                              startDate.year,
                              startDate.month,
                              startDate.day,
                            );
                            if (start.isBefore(today)) {
                              return 'Start date must be today or in the future';
                            }
                          }
                          return null;
                        },
                        borderRadius: 40,
                        onChanged: (date) => entity.startDate = date,
                        onSave: (date) => entity.startDate = date,
                      ),
                    ],
                  ),
                ),
                10.width,
                Expanded(
                  child: Column(
                    children: [
                      const BuildLabel('End Date'),
                      CommonDateInputTextField(
                        borderRadius: 40,
                        validation: (val) {
                          if (val == null || val.isEmpty) {
                            return 'End date is required';
                          }
                          if (entity.startDate == null) {
                            return 'Start date is required';
                          }
                          final endDate = DateTime.tryParse(val);
                          if (endDate != null) {
                            final start = DateTime(
                              entity.startDate!.year,
                              entity.startDate!.month,
                              entity.startDate!.day,
                            );
                            final end = DateTime(
                              endDate.year,
                              endDate.month,
                              endDate.day,
                            );
                            if (end.isBefore(start)) {
                              return 'End date must be on or after start date';
                            }
                          }
                          return null;
                        },
                        isValidationRequired: true,
                        onChanged: (date) => entity.endDate = date,
                        onSave: (date) => entity.endDate = date,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            8.height,
            CommonButton(
              buttonWidth: .infinity,
              titleText: 'Create Tournament',
              onTap: () {
                if (formKey.validate()) {
                  formKey.save();
                  if (cubit.state.selectedFriends.isEmpty) {
                    showSnackBar('No Friends Selected', type: .warning);
                    return;
                  }
                  cubit.createTournament(entity: entity);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _appBar(
    BuildContext context,
    FriendCubit cubit,
    FriendState state,
    TournamentEntity entity,
  ) {
    return Padding(
      padding: Constants.bodyPadding,
      child: Column(
        children: [
          20.height,
          CommonText(
            text: 'Build a Tournament',
            fontSize: 24,
            fontWeight: .w500,
            textColor: context.colors.tEXT_white,
          ).center,
          CommonText(
            text: 'Create a private points competition with your friends',
            fontSize: 14,
            maxLines: 2,
            textAlign: .center,
            textColor: context.colors.tEXT_subDark,
          ).center,
          10.height,
          const BuildLabel('Tournament Name'),
          CommonTextField(
            validationType: .validateRequired,
            borderColor: context.colors.bACKGROUND_darkCardBoarder,
            backgroundColor: Colors.transparent,
            hintText: 'e.g., Summer Golf Challenge',
            onSaved: (value, controller) => entity.tournamentName = value,
          ),
          _onColupse(context, cubit, state),
        ],
      ),
    );
  }

  Widget _onColupse(
    BuildContext context,
    FriendCubit cubit,
    FriendState state,
  ) {
    return Column(
      children: [
        8.height,
        Row(
          children: [
            const BuildLabel('Select Friend'),
            const Spacer(),
            GestureDetector(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (dialogContext) {
                    return Dialog(
                      insetPadding: const .symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                      backgroundColor: Colors.transparent,
                      child: BlocProvider.value(
                        value: cubit,
                        child: BlocBuilder<FriendCubit, FriendState>(
                          builder: (context, state) {
                            return Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: context.colors.bACKGROUND_darkCard,
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color:
                                      context.colors.bACKGROUND_darkCardBoarder,
                                  width: 1.4,
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CommonText(
                                        text:
                                            'Selected Friends (${state.selectedFriends.length})',
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        textColor: context.colors.tEXT_white,
                                      ),
                                      GestureDetector(
                                        onTap: () =>
                                            Navigator.pop(dialogContext),
                                        child: Icon(
                                          Icons.close,
                                          color: context.colors.tEXT_white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  16.height,
                                  if (state.selectedFriends.isEmpty)
                                    CommonText(
                                      text: 'No friends selected yet.',
                                      textColor: context.colors.tEXT_subDark,
                                    ).center
                                  else
                                    Flexible(
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: state.selectedFriends.length,
                                        itemBuilder: (context, index) {
                                          final friend =
                                              state.selectedFriends[index];
                                          final isSelected = state
                                              .selectedFriends
                                              .any((e) => e.id == friend.id);
                                          return Padding(
                                            padding: const EdgeInsets.symmetric(
                                              vertical: 4,
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                cubit.toggleFriendSelection(
                                                  friend,
                                                );
                                              },
                                              child: FriendListItemWidget(
                                                friend: friend,
                                                isSelected: isSelected,
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  },
                );
              },
              child: CommonText(
                text: '${state.selectedFriends.length} friends selected',
                fontSize: 12,
                textColor: context.colors.tEXT_subDark,
              ),
            ),
          ],
        ),
        CommonTextField(
          validationType: .notRequired,
          backgroundColor: Colors.transparent,
          borderColor: context.colors.bACKGROUND_darkCardBoarder,
          hintText: 'Search',
          onChanged: (value) {
            cubit.search(value, isTournament: true);
          },
        ),
        4.height,
      ],
    );
  }
}
