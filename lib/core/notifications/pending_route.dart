/// Stocke la route de destination d'une notification tap quand l'app était fermée.
/// La SplashScreen la consomme une fois sa redirection terminée.
class PendingRoute {
  PendingRoute._();

  static String? _route;

  static void set(String route) => _route = route;

  static String? consume() {
    final r = _route;
    _route = null;
    return r;
  }
}
