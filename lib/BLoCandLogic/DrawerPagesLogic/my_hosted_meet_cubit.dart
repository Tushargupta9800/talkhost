import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:talkhost/models/post.dart';

part 'my_hosted_meets_state.dart';

class MyHostedMeetCubit extends Cubit<MyHostedMeetState>{
  MyHostedMeetCubit() : super(MyHostedMeetState());

}