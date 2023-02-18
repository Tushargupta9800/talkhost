part of 'drawer_cubit.dart';

class DrawerState {
  static String _openedPageKey = (debugDrawerPagesEnabled)
      ? drawerPageCreateMeetKey
      : drawerPageDashBoardKey;
  static bool loading = false;

  void changePage(String key) {
    _openedPageKey = key;
  }

  void changeLoading() {
    loading = !loading;
  }

  bool getLoadingStatus() {
    return loading;
  }

  Widget drawerPageBodyOption() {
    if (_openedPageKey == drawerPageDashBoardKey) {
      return const DashBoardPage();
    } else if (_openedPageKey == drawerPageAboutKey) {
      return const AboutPage();
    } else if (_openedPageKey == drawerPageConferencesKey) {
      return const ConferencesPage();
    } else if (_openedPageKey == drawerPageMessageKey) {
      return const MessagePage();
    } else if (_openedPageKey == drawerPageSearchPersonKey) {
      return const SearchPersonPage();
    } else if (_openedPageKey == drawerPageCreateMeetKey) {
      return const CreateMeetPage();
    } else if (_openedPageKey == drawerPageMyHostedMeetKey) {
      return const MyMeetPage();
    } else if (_openedPageKey == drawerEditPageKey) {
      return const EditProfile();
    } else if (_openedPageKey == drawerNotificationsPageKey) {
      return const NotificationsPage();
    }
    return const DashBoardPage();
  }
}
