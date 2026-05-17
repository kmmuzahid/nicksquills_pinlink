/*
 * @Author: Km Muzahid
 * @Date: 2026-02-23 15:16:43
 * @Email: km.muzahid@gmail.com
 */
import 'package:core_kit/core_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pinlink/common_widgets/common_widget.dart';
import 'package:pinlink/config/bloc/cubit_scope_value.dart';
import 'package:pinlink/config/color/app_color.dart';
import 'package:pinlink/config/route/app_router.dart';
import 'package:pinlink/config/route/app_router.gr.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_flow_cubit.dart';
import 'package:pinlink/coreFeature/auth/cubit/auth_flow_state.dart';
import 'package:pinlink/coreFeature/auth/entity/signup_entity.dart';
import 'package:pinlink/coreFeature/custom_google_map/model/place_details.dart';

class SignupFormTwo extends StatelessWidget {
  const SignupFormTwo({
    super.key,
    required this.formKey,
    required this.entity,
    required this.authFlowCubit,
  });
  final GlobalKey<FormState> formKey;
  final SignUpEntity entity;
  final AuthFlowCubit authFlowCubit;

  @override
  Widget build(BuildContext context) {
    return CubitScopeValue(
      cubit: authFlowCubit,
      builder: (context, cubit, state) {
        final selectedCourseName =
            state.selectedCourse?.name ?? entity.homeCourse;

        return BlocListener<AuthFlowCubit, AuthFlowState>(
          bloc: cubit,
          listenWhen: (previous, current) =>
              previous.searchResults != current.searchResults ||
              previous.isSearching != current.isSearching ||
              previous.selectedCourse != current.selectedCourse,
          listener: (context, state) {
            if (state.selectedCourse != null) {
              entity.homeCourse = state.selectedCourse?.name;
              cubit.hideOverlay();
            } else {
              entity.homeCourse = null;
            }

            if (state.searchResults.isNotEmpty || state.searchText.isNotEmpty) {
              cubit.showOverlay(
                context,
                state.searchResults,
                state.isSearching,
              );
            } else {
              cubit.hideOverlay();
            }
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Hometown Field
              const BuildLabel('Hometown'),
              StatefulBuilder(
                key: const Key('City, country'),
                builder: (context, setState) {
                  return CommonTextField(
                    initialText: entity.hometown ?? '',
                    key: ValueKey(entity.hometown ?? ''),
                    hintText: 'City, Country',
                    isReadOnly: true,
                    onTap: () {
                      appRouter.push(CustomMapRoute()).then((value) {
                        if (value is PlaceDetails) {
                          entity.hometown = value.address;
                          entity.latitude = value.coordinate.latitude;
                          entity.longitude = value.coordinate.longitude;
                          setState(() {});
                        }
                      });
                    },
                    validationType: ValidationType.validateRequired,
                    prefixIcon: const Icon(Icons.location_city),
                    onSaved: (value, controller) => entity.hometown = value,
                  );
                },
              ),

              20.height,
              const BuildLabel('Home Course'),
              if (selectedCourseName != null && selectedCourseName.isNotEmpty)
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: Chip(
                      label: Text(
                        selectedCourseName,
                        style: TextStyle(color: context.colors.tEXT_white),
                      ),
                      backgroundColor: context.colors.pRIMARY_brandClr
                          .withValues(alpha: 0.1),
                      deleteIcon: const Icon(Icons.close, size: 18),
                      onDeleted: () {
                        cubit.removeSelectedCourse();
                        cubit.searchCourses('');
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: context.colors.pRIMARY_brandClr.withValues(
                            alpha: 0.2,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

              CompositedTransformTarget(
                link: cubit.layerLink,
                child: CommonTextField(
                  key: const ValueKey('search_course_field'),
                  initialText: state.searchText,
                  prefixBuilder: (controller, focusNode) {
                    cubit.initOverlay(focusNode);
                    return null;
                  },
                  hintText: 'e.g., Pebble Beach Golf Links',
                  validationType: ValidationType.validateRequired,
                  prefixIcon: const Icon(Icons.golf_course),
                  onChanged: (value) {
                    cubit.searchCourses(value);
                  },
                  onSaved: (value, controller) =>
                      entity.homeCourse = state.selectedCourse?.name,
                ),
              ),
              10.height,
              CommonText(
                text:
                    'Choose the course you play most frequently. If you do not have a home course, choose the course closest to you',
                isDescription: true,
                left: 5,
                textColor: context.colors.tEXT_subDark,
                textAlign: TextAlign.left,
                maxLines: 5,
              ),
              20.height,
            ],
          ),
        );
      },
    );
  }
}
