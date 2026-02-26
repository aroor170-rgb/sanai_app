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

  /// Determines whether the app will refresh and build again when a sign
  /// in or sign out happens. This is useful when the app is launched or
  /// on an unexpected logout. However, this must be turned off when we
  /// intend to sign in/out and then navigate or perform any actions after.
  /// Otherwise, this will trigger a refresh and interrupt the action(s).
  bool notifyOnAuthChange = true;

  bool get loading => user == null || showSplashImage;
  bool get loggedIn => user?.loggedIn ?? false;
  bool get initiallyLoggedIn => initialUser?.loggedIn ?? false;
  bool get shouldRedirect => loggedIn && _redirectLocation != null;

  String getRedirectLocation() => _redirectLocation!;
  bool hasRedirect() => _redirectLocation != null;
  void setRedirectLocationIfUnset(String loc) => _redirectLocation ??= loc;
  void clearRedirectLocation() => _redirectLocation = null;

  /// Mark as not needing to notify on a sign in / out when we intend
  /// to perform subsequent actions (such as navigation) afterwards.
  void updateNotifyOnAuthChange(bool notify) => notifyOnAuthChange = notify;

  void update(BaseAuthUser newUser) {
    final shouldUpdate =
        user?.uid == null || newUser.uid == null || user?.uid != newUser.uid;
    initialUser ??= newUser;
    user = newUser;
    // Refresh the app on auth change unless explicitly marked otherwise.
    // No need to update unless the user has changed.
    if (notifyOnAuthChange && shouldUpdate) {
      notifyListeners();
    }
    // Once again mark the notifier as needing to update on auth change
    // (in order to catch sign in / out events).
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
          appStateNotifier.loggedIn ? NavBarPage() : RegisterCopyWidget(),
      routes: [
        FFRoute(
          name: '_initialize',
          path: '/',
          builder: (context, _) =>
              appStateNotifier.loggedIn ? NavBarPage() : RegisterCopyWidget(),
        ),
        FFRoute(
          name: LoginWidget.routeName,
          path: LoginWidget.routePath,
          builder: (context, params) => LoginWidget(),
        ),
        FFRoute(
          name: ResultWidget.routeName,
          path: ResultWidget.routePath,
          builder: (context, params) => ResultWidget(),
        ),
        FFRoute(
          name: Result2Widget.routeName,
          path: Result2Widget.routePath,
          builder: (context, params) => Result2Widget(),
        ),
        
FFRoute(
  name: 'quickAccessPin',
  path: '/quickAccessPin',
  builder: (context, params) => const QuickAccessPinWidget(),
),
        FFRoute(
          name: AboutWidget.routeName,
          path: AboutWidget.routePath,
          builder: (context, params) => AboutWidget(),
        ),
        FFRoute(
          name: TestWidget.routeName,
          path: TestWidget.routePath,
          builder: (context, params) => TestWidget(),
        ),
        FFRoute(
          name: CaleanderWidget.routeName,
          path: CaleanderWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'caleander')
              : CaleanderWidget(),
        ),
        FFRoute(
          name: HomeWidget.routeName,
          path: HomeWidget.routePath,
          builder: (context, params) =>
              params.isEmpty ? NavBarPage(initialPage: 'home') : HomeWidget(),
        ),
        FFRoute(
          name: SetiingWidget.routeName,
          path: SetiingWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'setiing')
              : SetiingWidget(),
        ),
        FFRoute(
          name: AdminWidget.routeName,
          path: AdminWidget.routePath,
          builder: (context, params) => AdminWidget(),
        ),
        FFRoute(
          name: ChatWidget.routeName,
          path: ChatWidget.routePath,
          builder: (context, params) =>
              params.isEmpty ? NavBarPage(initialPage: 'chat') : ChatWidget(),
        ),
        FFRoute(
          name: ProfileWidget.routeName,
          path: ProfileWidget.routePath,
          builder: (context, params) => params.isEmpty
              ? NavBarPage(initialPage: 'profile')
              : ProfileWidget(),
        ),
        FFRoute(
          name: RemindersWidget.routeName,
          path: RemindersWidget.routePath,
          builder: (context, params) => RemindersWidget(),
        ),
        FFRoute(
          name: AppearnceWidget.routeName,
          path: AppearnceWidget.routePath,
          builder: (context, params) => AppearnceWidget(),
        ),
        FFRoute(
          name: SignoutWidget.routeName,
          path: SignoutWidget.routePath,
          builder: (context, params) => SignoutWidget(),
        ),
        FFRoute(
          name: SignosuccessfulWidget.routeName,
          path: SignosuccessfulWidget.routePath,
          builder: (context, params) => SignosuccessfulWidget(),
        ),
        FFRoute(
          name: CameraWidget.routeName,
          path: CameraWidget.routePath,
          builder: (context, params) => CameraWidget(),
        ),
        FFRoute(
          name: DrawingWidget.routeName,
          path: DrawingWidget.routePath,
          builder: (context, params) => DrawingWidget(),
        ),
        FFRoute(
          name: EditPhone0Widget.routeName,
          path: EditPhone0Widget.routePath,
          builder: (context, params) => EditPhone0Widget(),
        ),
        FFRoute(
          name: ChooseLanguageWidget.routeName,
          path: ChooseLanguageWidget.routePath,
          builder: (context, params) => ChooseLanguageWidget(),
        ),
        FFRoute(
          name: ChangePasswordWidget.routeName,
          path: ChangePasswordWidget.routePath,
          builder: (context, params) => ChangePasswordWidget(),
        ),
        FFRoute(
          name: SignUpWidget.routeName,
          path: SignUpWidget.routePath,
          builder: (context, params) => SignUpWidget(),
        ),
        FFRoute(
          name: AddReExeWidget.routeName,
          path: AddReExeWidget.routePath,
          builder: (context, params) => AddReExeWidget(),
        ),
        FFRoute(
          name: AddReMedWidget.routeName,
          path: AddReMedWidget.routePath,
          builder: (context, params) => AddReMedWidget(),
        ),
        FFRoute(
          name: AddReWaWidget.routeName,
          path: AddReWaWidget.routePath,
          builder: (context, params) => AddReWaWidget(),
        ),
        FFRoute(
          name: EditRemEWidget.routeName,
          path: EditRemEWidget.routePath,
          builder: (context, params) => EditRemEWidget(),
        ),
        FFRoute(
          name: EditRemWWidget.routeName,
          path: EditRemWWidget.routePath,
          builder: (context, params) => EditRemWWidget(),
        ),
        FFRoute(
          name: EditRemMWidget.routeName,
          path: EditRemMWidget.routePath,
          builder: (context, params) => EditRemMWidget(),
        ),
        FFRoute(
          name: EditActionMWidget.routeName,
          path: EditActionMWidget.routePath,
          builder: (context, params) => EditActionMWidget(),
        ),
        FFRoute(
          name: EditSavedWidget.routeName,
          path: EditSavedWidget.routePath,
          builder: (context, params) => EditSavedWidget(),
        ),
        FFRoute(
          name: TeamSupportWidget.routeName,
          path: TeamSupportWidget.routePath,
          builder: (context, params) => TeamSupportWidget(),
        ),
        
        FFRoute(
          name: RegisterCopyWidget.routeName,
          path: RegisterCopyWidget.routePath,
          builder: (context, params) => RegisterCopyWidget(),
        ),
        FFRoute(
          name: CamerINTWidget.routeName,
          path: CamerINTWidget.routePath,
          builder: (context, params) => CamerINTWidget(),
        ),
        FFRoute(
          name: Result1Widget.routeName,
          path: Result1Widget.routePath,
          builder: (context, params) => Result1Widget(),
        ),
        FFRoute(
          name: Admin1Widget.routeName,
          path: Admin1Widget.routePath,
          builder: (context, params) => Admin1Widget(),
        ),
        FFRoute(
          name: EditActionEWidget.routeName,
          path: EditActionEWidget.routePath,
          builder: (context, params) => EditActionEWidget(),
        ),
        FFRoute(
          name: EditActionWWidget.routeName,
          path: EditActionWWidget.routePath,
          builder: (context, params) => EditActionWWidget(),
        ),
        FFRoute(
          name: EditRemovedWidget.routeName,
          path: EditRemovedWidget.routePath,
          builder: (context, params) => EditRemovedWidget(),
        ),
        FFRoute(
          name: FaqA2Widget.routeName,
          path: FaqA2Widget.routePath,
          builder: (context, params) => FaqA2Widget(),
        ),
        FFRoute(
          name: MentalHealthGuidesWidget.routeName,
          path: MentalHealthGuidesWidget.routePath,
          builder: (context, params) => MentalHealthGuidesWidget(),
        ),
        FFRoute(
          name: MedicationReminderWidget.routeName,
          path: MedicationReminderWidget.routePath,
          builder: (context, params) => MedicationReminderWidget(),
        ),
        FFRoute(
          name: ExercisesReminderWidget.routeName,
          path: ExercisesReminderWidget.routePath,
          builder: (context, params) => ExercisesReminderWidget(),
        ),
        FFRoute(
          name: WaterReminderWidget.routeName,
          path: WaterReminderWidget.routePath,
          builder: (context, params) => WaterReminderWidget(),
        ),
        FFRoute(
          name: VoiceChatPageWidget.routeName,
          path: VoiceChatPageWidget.routePath,
          builder: (context, params) => VoiceChatPageWidget(),
        ),
        FFRoute(
          name: HospitalsListWidget.routeName,
          path: HospitalsListWidget.routePath,
          builder: (context, params) => HospitalsListWidget(),
        ),
        FFRoute(
          name: SupportCenterWidget.routeName,
          path: SupportCenterWidget.routePath,
          builder: (context, params) => SupportCenterWidget(),
        ),
        FFRoute(
          name: FaqWidget.routeName,
          path: FaqWidget.routePath,
          builder: (context, params) => FaqWidget(),
        ),
        FFRoute(
          name: DepressionWidget.routeName,
          path: DepressionWidget.routePath,
          builder: (context, params) => DepressionWidget(),
        ),
        FFRoute(
          name: SocailProblemsWidget.routeName,
          path: SocailProblemsWidget.routePath,
          builder: (context, params) => SocailProblemsWidget(),
        ),
        FFRoute(
          name: PsychologicalDisordersWidget.routeName,
          path: PsychologicalDisordersWidget.routePath,
          builder: (context, params) => PsychologicalDisordersWidget(),
        ),
        FFRoute(
          name: DepressionDefinitionWidget.routeName,
          path: DepressionDefinitionWidget.routePath,
          builder: (context, params) => DepressionDefinitionWidget(),
        ),
        FFRoute(
          name: AddictionCopyWidget.routeName,
          path: AddictionCopyWidget.routePath,
          builder: (context, params) => AddictionCopyWidget(),
        ),
        FFRoute(
          name: FaqA3Widget.routeName,
          path: FaqA3Widget.routePath,
          builder: (context, params) => FaqA3Widget(),
        ),
        FFRoute(
          name: FaqA1Widget.routeName,
          path: FaqA1Widget.routePath,
          builder: (context, params) => FaqA1Widget(),
        ),
        FFRoute(
          name: BullyingDefinitionWidget.routeName,
          path: BullyingDefinitionWidget.routePath,
          builder: (context, params) => BullyingDefinitionWidget(),
        ),
        FFRoute(
          name: AddictionDefinitionWidget.routeName,
          path: AddictionDefinitionWidget.routePath,
          builder: (context, params) => AddictionDefinitionWidget(),
        ),
        FFRoute(
          name: HospitalsFamilyIssueWidget.routeName,
          path: HospitalsFamilyIssueWidget.routePath,
          builder: (context, params) => HospitalsFamilyIssueWidget(),
        )
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
    // If there is only one route on the stack, navigate to the initial
    // page instead of popping.
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

  // Parameters are empty if the params map is empty or if the only parameter
  // present is the special extra parameter reserved for the transition info.
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
    // Got parameter from `extras`, so just directly return it.
    if (param is! String) {
      return param;
    }
    // Return serialized value.
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

  static TransitionInfo appDefault() => TransitionInfo(hasTransition: false);
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
