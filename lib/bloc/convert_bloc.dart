import 'convert_event.dart';
import 'convert_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConvertBloc extends Bloc<ConvertEvent, ConvertState> {
  ConvertBloc() : super(const ConvertState()) {
    on<ConvertEvent>((event, emit) async {
      if (event is PNGformat) {
        await setPNGFormat(event, state, emit);
      } else if (event is Wordformat) {
        await setWordformat(event, state, emit);
      } else if (event is Txtformat) {
        await setTxtformat(event, state, emit);
      }
    });
  }

  Future setPNGFormat(
      PNGformat event, ConvertState state, Emitter<ConvertState> emit) async {
    String newFormat = 'PNG';

    emit(state.copyWith(format: newFormat));
  }

  Future setWordformat(
      Wordformat event, ConvertState state, Emitter<ConvertState> emit) async {
    String newFormat = 'Word';

    emit(state.copyWith(format: newFormat));
  }

  Future setTxtformat(
      Txtformat event, ConvertState state, Emitter<ConvertState> emit) async {
    String newFormat = 'Txt';

    emit(state.copyWith(format: newFormat));
  }
}
