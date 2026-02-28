import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '/auth/base_auth_user_provider.dart';

import '/main.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/lat_lng.dart';
import '/flutter_flow/place.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'serialization_util.dart';

import '/index.dart';

export 'package:go_router/go_router.dart';
export 'serialization_util.dart';
import '/pagesss/pin_access_page.dart';
const kTransitionInfoKey = '__transition_info__';

GlobalKey<NavigatorState> appNavigatorKey = GlobalKey<NavigatorState>();

class AppStateNotifier extends ChangeNotifier {
  AppStateNotifier._();

  static AppStateNotifier? _instance;
  static AppStateNotifier get instance => _instance ??= AppStateNotifier._();

  BaseAuthUser? initialUser;
  BaseAuthUser? user;
  bool showSplashImage = true;
  String? _redirectLocation;

  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    updateNotifyOnAuthChange(true);
  }

  void stopShowingSplashImage() {
    showSplashImage = false;
    notifyListeners();
  }
}

GoRouter createRouter(AppStateNotifier appStateNotifier) => GoRouter(
      initialLocation: '/',
      debugLogDiagnostics: true,
      refreshListenable: appStateNotifier,
      navigatorKey: appNavigatorKey,
      errorBuilder: (context, state) =>
          appStateNotifier.loggedIn ? NavBarPage() : const ChooseLanguageWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : const ChooseLanguageWidget(),
        ),
        FFRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => const LoginWidget(),
        ),
        FFRoute(
          name: ResultWidget.routeName,
          path: ResultWidget.routePath,
          builder: (context, params) => const ResultWidget(),
        ),
        FFRoute(
          name: Result2Widget.routeName,
          path: Result2Widget.routePath,
          builder: (context, params) => const Result2Widget(),
        ),
        FFRoute(
          name: 'quickAccessPin',
          path: '/quickAccessPin',
          builder: (context, params) => const QuickAccessPinWidget(),
        ),
        FFRoute(
          name: AboutWidget.routeName,
          path: AboutWidget.routePath,
          builder: (context, params) => const AboutWidget(),
        ),
        FFRoute(
          name: TestWidget.routeName,
          path: TestWidget.routePath,
          builder: (context, params) => const TestWidget(),
        ),
        FFRoute(
          name: CaleanderWidget.routeName,
          path: CaleanderWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'caleander')
              : const CaleanderWidget(),
        ),
        FFRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          builder: (context, params) =>
              params.isEmpty ? NavBarPage(initialPage: 'home') : const HomeWidget(),
        ),
        FFRoute(
          name: SetiingWidget.routeName,
          path: SetiingWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'setiing')
              : const SetiingWidget(),
        ),
        FFRoute(
          name: AdminWidget.routeName,
          path: AdminWidget.routePath,
          builder: (context, params) => const AdminWidget(),
        ),
        FFRoute(
          name: ChatWidget.routeName,
          path: ChatWidget.routePath,
          builder: (context, params) =>
              params.isEmpty ? NavBarPage(initialPage: 'chat') : const ChatWidget(),
        ),
        FFRoute(
          name: ProfileWidget.routeName,
          path: ProfileWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'profile')
              : const ProfileWidget(),
        ),
        FFRoute(
          name: RemindersWidget.routeName,
          path: RemindersWidget.routePath,
          builder: (context, params) => const RemindersWidget(),
        ),
        FFRoute(
          name: AppearnceWidget.routeName,
          path: AppearnceWidget.routePath,
          builder: (context, params) => const AppearnceWidget(),
        ),
        FFRoute(
          name: SignoutWidget.routeName,
          path: SignoutWidget.routePath,
          builder: (context, params) => const SignoutWidget(),
        ),
        FFRoute(
          name: SignosuccessfulWidget.routeName,
          path: SignosuccessfulWidget.routePath,
          builder: (context, params) => const SignosuccessfulWidget(),
        ),
        FFRoute(
          name: CameraWidget.routeName,
          path: CameraWidget.routePath,
          builder: (context, params) => const CameraWidget(),
        ),
        FFRoute(
          name: DrawingWidget.routeName,
          path: DrawingWidget.routePath,
          builder: (context, params) => const DrawingWidget(),
        ),
        FFRoute(
          name: EditPhone0Widget.routeName,
          path: EditPhone0Widget.routePath,
          builder: (context, params) => const EditPhone0Widget(),
        ),
        FFRoute(
          name: ChooseLanguageWidget.routeName,
          path: ChooseLanguageWidget.routePath,
          builder: (context, params) => const ChooseLanguageWidget(),
        ),
        FFRoute(
          name: ChangePasswordWidget.routeName,
          path: ChangePasswordWidget.routePath,
          builder: (context, params) => const ChangePasswordWidget(),
        ),
        FFRoute(
          name: SignUpWidget.routeName,
          path: SignUpWidget.routePath,
          builder: (context, params) => const SignUpWidget(),
        ),
        FFRoute(
          name: AddReExeWidget.routeName,
          path: AddReExeWidget.routePath,
          builder: (context, params) => const AddReExeWidget(),
        ),
        FFRoute(
          name: AddReMedWidget.routeName,
          path: AddReMedWidget.routePath,
          builder: (context, params) => const AddReMedWidget(),
        ),
        FFRoute(
          name: AddReWaWidget.routeName,
          path: AddReWaWidget.routePath,
          builder: (context, params) => const AddReWaWidget(),
        ),
        FFRoute(
          name: EditRemEWidget.routeName,
          path: EditRemEWidget.routePath,
          builder: (context, params) => const EditRemEWidget(),
        ),
        FFRoute(
          name: EditRemWWidget.routeName,
          path: EditRemWWidget.routePath,
          builder: (context, params) => const EditRemWWidget(),
        ),
        FFRoute(
          name: EditRemMWidget.routeName,
          path: EditRemMWidget.routePath,
          builder: (context, params) => const EditRemMWidget(),
        ),
        FFRoute(
          name: EditActionMWidget.routeName,
          path: EditActionMWidget.routePath,
          builder: (context, params) => const EditActionMWidget(),
        ),
        FFRoute(
          name: EditSavedWidget.routeName,
          path: EditSavedWidget.routePath,
          builder: (context, params) => const EditSavedWidget(),
        ),
        FFRoute(
          name: TeamSupportWidget.routeName,
          path: TeamSupportWidget.routePath,
          builder: (context, params) => const TeamSupportWidget(),
        ),
        FFRoute(
          name: RegisterCopyWidget.routeName,
          path: RegisterCopyWidget.routePath,
          builder: (context, params) => const RegisterCopyWidget(),
        ),
        FFRoute(
          name: CamerINTWidget.routeName,
          path: CamerINTWidget.routePath,
          builder: (context, params) => const CamerINTWidget(),
        ),
        FFRoute(
          name: Result1Widget.routeName,
          path: Result1Widget.routePath,
          builder: (context, params) => const Result1Widget(),
        ),
        FFRoute(
          name: Admin1Widget.routeName,
          path: Admin1Widget.routePath,
          builder: (context, params) => const Admin1Widget(),
        ),
        FFRoute(
          name: EditActionEWidget.routeName,
          path: EditActionEWidget.routePath,
          builder: (context, params) => const EditActionEWidget(),
        ),
        FFRoute(
          name: EditActionWWidget.routeName,
          path: EditActionWWidget.routePath,
          builder: (context, params) => const EditActionWWidget(),
        ),
        FFRoute(
          name: EditRemovedWidget.routeName,
          path: EditRemovedWidget.routePath,
          builder: (context, params) => const EditRemovedWidget(),
        ),
        FFRoute(
          name: FaqA2Widget.routeName,
          path: FaqA2Widget.routePath,
          builder: (context, params) => const FaqA2Widget(),
        ),
        FFRoute(
          name: MentalHealthGuidesWidget.routeName,
          path: MentalHealthGuidesWidget.routePath,
          builder: (context, params) => const MentalHealthGuidesWidget(),
        ),
        FFRoute(
          name: MedicationReminderWidget.routeName,
          path: MedicationReminderWidget.routePath,
          builder: (context, params) => const MedicationReminderWidget(),
        ),
        FFRoute(
          name: ExercisesReminderWidget.routeName,
          path: ExercisesReminderWidget.routePath,
          builder: (context, params) => const ExercisesReminderWidget(),
        ),
        FFRoute(
          name: WaterReminderWidget.routeName,
          path: WaterReminderWidget.routePath,
          builder: (context, params) => const WaterReminderWidget(),
        ),
        FFRoute(
          name: 'voice_chat_page',
          path: '/voiceChatPage',
          builder: (context, params) => const VoiceChatPageWidget(),
        ),
        FFRoute(
          name: HospitalsListWidget.routeName,
          path: HospitalsListWidget.routePath,
          builder: (context, params) => const HospitalsListWidget(),
        ),
        FFRoute(
          name: SupportCenterWidget.routeName,
          path: SupportCenterWidget.routePath,
          builder: (context, params) => const SupportCenterWidget(),
        ),
        FFRoute(
          name: FaqWidget.routeName,
          path: FaqWidget.routePath,
          builder: (context, params) => const FaqWidget(),
        ),
        FFRoute(
          name: DepressionWidget.routeName,
          path: DepressionWidget.routePath,
          builder: (context, params) => const DepressionWidget(),
        ),
        FFRoute(
          name: SocailProblemsWidget.routeName,
          path: SocailProblemsWidget.routePath,
          builder: (context, params) => const SocailProblemsWidget(),
        ),
        FFRoute(
          name: PsychologicalDisordersWidget.routeName,
          path: PsychologicalDisordersWidget.routePath,
          builder: (context, params) => const PsychologicalDisordersWidget(),
        ),
        FFRoute(
          name: DepressionDefinitionWidget.routeName,
          path: DepressionDefinitionWidget.routePath,
          builder: (context, params) => const DepressionDefinitionWidget(),
        ),
        FFRoute(
          name: AddictionCopyWidget.routeName,
          path: AddictionCopyWidget.routePath,
          builder: (context, params) => const AddictionCopyWidget(),
        ),
        FFRoute(
          name: FaqA3Widget.routeName,
          path: FaqA3Widget.routePath,
          builder: (context, params) => const FaqA3Widget(),
        ),
        FFRoute(
          name: FaqA1Widget.routeName,
          path: FaqA1Widget.routePath,
          builder: (context, params) => const FaqA1Widget(),
        ),
        FFRoute(
          name: BullyingDefinitionWidget.routeName,
          path: BullyingDefinitionWidget.routePath,
          builder: (context, params) => const BullyingDefinitionWidget(),
        ),
        FFRoute(
          name: AddictionDefinitionWidget.routeName,
          path: AddictionDefinitionWidget.routePath,
          builder: (context, params) => const AddictionDefinitionWidget(),
        ),
        FFRoute(
          name: HospitalsFamilyIssueWidget.routeName,
          path: HospitalsFamilyIssueWidget.routePath,
          builder: (context, params) => const HospitalsFamilyIssueWidget(),
        ),
      ].map((r) => r.toRoute(appStateNotifier)).toList(),
    );

extension NavParamExtensions on Map<String, String?> {
  Map<String, String> get withoutNulls => Map.fromEntries(
        entries
            .where((e) => e.value != null)
            .map((e) => MapEntry(e.key, e.value!)),
      );
}

extension NavigationExtensions on BuildContext {
  void goNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : goNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void pushNamedAuth(
    String name,
    bool mounted, {
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, String> queryParameters = const <String, String>{},
    Object? extra,
    bool ignoreRedirect = false,
  }) =>
      !mounted || GoRouter.of(this).shouldRedirect(ignoreRedirect)
          ? null
          : pushNamed(
              name,
              pathParameters: pathParameters,
              queryParameters: queryParameters,
              extra: extra,
            );

  void safePop() {
    if (canPop()) {
      pop();
    } else {
      go('/');
    }
  }
}

extension GoRouterExtensions on GoRouter {
  AppStateNotifier get appState => AppStateNotifier.instance;
  void prepareAuthEvent([bool ignoreRedirect = false]) =>
      appState.hasRedirect() && !ignoreRedirect
          ? null
          : appState.updateNotifyOnAuthChange(false);
  bool shouldRedirect(bool ignoreRedirect) =>
      !ignoreRedirect && appState.hasRedirect();
  void clearRedirectLocation() => appState.clearRedirectLocation();
  void setRedirectLocationIfUnset(String location) =>
      appState.updateNotifyOnAuthChange(false);
}

extension _GoRouterStateExtensions on GoRouterState {
  Map<String, dynamic> get extraMap =>
      extra != null ? extra as Map<String, dynamic> : {};
  Map<String, dynamic> get allParams => <String, dynamic>{}
    ..addAll(pathParameters)
    ..addAll(uri.queryParameters)
    ..addAll(extraMap);
  TransitionInfo get transitionInfo => extraMap.containsKey(kTransitionInfoKey)
      ? extraMap[kTransitionInfoKey] as TransitionInfo
      : TransitionInfo.appDefault();
}

class FFParameters {
  FFParameters(this.state, [this.asyncParams = const {}]);

  final GoRouterState state;
  final Map<String, Future<dynamic> Function(String)> asyncParams;

  Map<String, dynamic> futureParamValues = {};

  bool get isEmpty =>
      state.allParams.isEmpty ||
      (state.allParams.length == 1 &&
          state.extraMap.containsKey(kTransitionInfoKey));
  bool isAsyncParam(MapEntry<String, dynamic> param) =>
      asyncParams.containsKey(param.key) && param.value is String;
  bool get hasFutures => state.allParams.entries.any(isAsyncParam);
  Future<bool> completeFutures() => Future.wait(
        state.allParams.entries.where(isAsyncParam).map(
          (param) async {
            final doc = await asyncParams[param.key]!(param.value)
                .onError((_, __) => null);
            if (doc != null) {
              futureParamValues[param.key] = doc;
              return true;
            }
            return false;
          },
        ),
      ).onError((_, __) => [false]).then((v) => v.every((e) => e));

  dynamic getParam<T>(
    String paramName,
    ParamType type, {
    bool isList = false,
  }) {
    if (futureParamValues.containsKey(paramName)) {
      return futureParamValues[paramName];
    }
    if (!state.allParams.containsKey(paramName)) {
      return null;
    }
    final param = state.allParams[paramName];
    if (param is! String) {
      return param;
    }
    return deserializeParam<T>(
      param,
      type,
      isList,
    );
  }
}

class FFRoute {
  const FFRoute({
    required this.name,
    required this.path,
    required this.builder,
    this.requireAuth = false,
    this.asyncParams = const {},
    this.routes = const [],
  });

  final String name;
  final String path;
  final bool requireAuth;
  final Map<String, Future<dynamic> Function(String)> asyncParams;
  final Widget Function(BuildContext, FFParameters) builder;
  final List<GoRoute> routes;

  GoRoute toRoute(AppStateNotifier appStateNotifier) => GoRoute(
        name: name,
        path: path,
        redirect: (context, state) {
          if (appStateNotifier.shouldRedirect) {
            final redirectLocation = appStateNotifier.getRedirectLocation();
            appStateNotifier.clearRedirectLocation();
            return redirectLocation;
          }
          if (requireAuth && !appStateNotifier.loggedIn) {
            appStateNotifier.setRedirectLocationIfUnset(state.uri.toString());
            return '/registerCopy';
          }
          return null;
        },
        pageBuilder: (context, state) {
          fixStatusBarOniOS16AndBelow(context);
          final ffParams = FFParameters(state, asyncParams);
          final page = ffParams.hasFutures
              ? FutureBuilder(
                  future: ffParams.completeFutures(),
                  builder: (context, _) => builder(context, ffParams),
                )
              : builder(context, ffParams);
          final child = appStateNotifier.loading
              ? Center(
                  child: SizedBox(
                    width: 50.0,
                    height: 50.0,
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        FlutterFlowTheme.of(context).primary,
                      ),
                    ),
                  ),
                )
              : page;
          final transitionInfo = state.transitionInfo;
          return transitionInfo.hasTransition
              ? CustomTransitionPage(
                  key: state.pageKey,
                  child: child,
                  transitionDuration: transitionInfo.duration,
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) =>
                          PageTransition(
                    type: transitionInfo.transitionType,
                    duration: transitionInfo.duration,
                    reverseDuration: transitionInfo.duration,
                    alignment: transitionInfo.alignment,
                    child: child,
                  ).buildTransitions(
                    context,
                    animation,
                    secondaryAnimation,
                    child,
                  ),
                )
              : MaterialPage(key: state.pageKey, child: child);
        },
        routes: routes,
      );
}

class TransitionInfo {
  const TransitionInfo({
    required this.hasTransition,
    this.transitionType = PageTransitionType.fade,
    this.duration = const Duration(milliseconds: 300),
    this.alignment,
  });

  final bool hasTransition;
  final PageTransitionType transitionType;
  final Duration duration;
  final Alignment? alignment;

  static TransitionInfo appDefault() => const TransitionInfo(hasTransition: false);
}

class RootPageContext {
  const RootPageContext(this.isRootPage, [this.errorRoute]);
  final bool isRootPage;
  final String? errorRoute;

  static bool isInactiveRootPage(BuildContext context) {
    final rootPageContext = context.read<RootPageContext?>();
    final isRootPage = rootPageContext?.isRootPage ?? false;
    final location = GoRouterState.of(context).uri.toString();
    return isRootPage &&
        location != '/' &&
        location != rootPageContext?.errorRoute;
  }

  static Widget wrap(Widget child, {String? errorRoute}) => Provider.value(
        value: RootPageContext(true, errorRoute),
        child: child,
      );
}

extension GoRouterLocationExtension on GoRouter {
  String getCurrentLocation() {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }
}