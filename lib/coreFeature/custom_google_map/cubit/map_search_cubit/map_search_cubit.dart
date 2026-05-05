/*
 * @Author: Km Muzahid
 * @Date: 2026-03-07 14:50:47
 * @Email: km.muzahid@gmail.com
 */
import 'dart:convert';

// ignore: depend_on_referenced_packages
import 'package:core_kit/utils/debouncer.dart';
import 'package:http/http.dart' as http;
import 'package:pinlink/config/bloc/safe_cubit.dart';
import 'package:pinlink/constant/constants.dart';
import 'package:pinlink/coreFeature/custom_google_map/cubit/map_search_cubit/map_search_state.dart';

class MapSearchCubit extends SafeCubit<MapSearchState> {
  // Replace with your API key

  MapSearchCubit() : super(const MapSearchState());

  final Debouncer debouncer = Debouncer(milliseconds: 300);

  // Method to fetch place suggestions with coordinates
  Future<void> getPlaceSuggestions(String searchTerm) async {
    debouncer.run(() async {
      try {
        emit(state.copyWith(isLoading: true, errorMessage: ''));

        final url =
            'https://maps.googleapis.com/maps/api/place/autocomplete/json?input=$searchTerm&key=${Constants.mapScretKey}';

        final response = await http.get(Uri.parse(url));

        if (response.statusCode == 200) {
          final data = json.decode(response.body);

          if (data['status'] == 'OK') {
            final suggestionsWithCoordinates = <String, String>{};
            for (final prediction in data['predictions']) {
              final String id = prediction['place_id'];
              final String address = prediction['description'];
              suggestionsWithCoordinates[id] = address;
            }

            emit(
              state.copyWith(
                isLoading: false,
                searchResults: suggestionsWithCoordinates,
              ),
            );
          } else {
            emit(
              state.copyWith(
                isLoading: false,
                errorMessage: 'Failed to load suggestions.',
              ),
            );
          }
        } else {
          emit(
            state.copyWith(
              isLoading: false,
              errorMessage: 'Failed to fetch data from API.',
            ),
          );
        }
      } catch (e) {
        emit(state.copyWith(isLoading: false, errorMessage: 'Error: $e'));
      }
    });
  }

  Future<void> onClear() async {
    emit(const MapSearchState());
  }
}
