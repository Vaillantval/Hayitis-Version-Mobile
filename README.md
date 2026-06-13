# Hayiti's — Application Mobile Android

Application e-commerce Flutter pour **Hayiti's** (`com.matstorehaiti.app`), connectée à l'API Django REST hébergée sur `https://hayitis.com/api`.

---

## Stack technique

| Couche | Technologie |
|---|---|
| UI | Flutter 3.x · Material 3 · Google Fonts (Playfair Display, Nunito) |
| State management | Riverpod 2 (AsyncNotifier / StateNotifier) |
| Navigation | GoRouter 14 |
| HTTP | Dio 5 + intercepteurs d'authentification JWT |
| Modèles | Freezed + json_serializable (code généré) |
| Images | CachedNetworkImage + shimmer |
| Paiements | Stripe (flutter_stripe) · MonCash (WebView) · paiement hors ligne |
| Push | Firebase Cloud Messaging + flutter_local_notifications |
| Stockage sécurisé | flutter_secure_storage (JWT access + refresh tokens) |

---

## Architecture

```
lib/
├── core/
│   ├── config/          # AppConfig (Tawk.to, etc.)
│   ├── network/         # Dio, endpoints, intercepteur auth
│   ├── router/          # GoRouter + guards auth
│   ├── shell/           # NavigationBar principale
│   ├── storage/         # SecureStorage
│   └── theme/           # AppColors, AppTextStyles, AppTheme
├── features/
│   ├── auth/            # Login, Register, Splash, providers JWT
│   ├── products/        # Home, Shop, ProductDetail, providers
│   ├── cart/            # Panier, providers, repository
│   ├── checkout/        # Flow commande + paiement
│   ├── orders/          # Liste commandes, suivi
│   ├── addresses/       # Carnet d'adresses
│   ├── reviews/         # Avis produits
│   ├── wishlist/        # Favoris
│   └── admin/           # Dashboard admin (produits, commandes, clients)
└── shared/
    ├── utils/           # Formatage prix, dates, debouncer
    └── widgets/         # ProductCard, shimmer, ErrorState, etc.
```

---

## Prérequis

- Flutter SDK ≥ 3.7.2
- **JDK 21** via Android Studio JBR (`C:\Program Files\Android\Android Studio\jbr`)
  ```powershell
  flutter config --jdk-dir="C:\Program Files\Android\Android Studio\jbr"
  ```
- Gradle Wrapper : 8.10.2 (déjà configuré dans `gradle-wrapper.properties`)
- AGP 8.7.3 · Kotlin 2.1.20 (déclarés dans `settings.gradle.kts`)

> **Note SSL (Windows + Avast)** : si Avast Web Shield est actif, importer son certificat racine dans le cacerts du JBR avant de builder.

---

## Installation & build

```bash
# Récupérer les dépendances
flutter pub get

# Régénérer les modèles Freezed/json_serializable si nécessaire
dart run build_runner build --delete-conflicting-outputs

# Build APK release
flutter build apk --release

# Installer sur appareil connecté
flutter install
```

L'APK de sortie se trouve dans `build/app/outputs/flutter-apk/app-release.apk`.

---

## Variables d'environnement / Configuration

Toutes les URLs sont centralisées dans `lib/core/network/endpoints.dart` :

```dart
static const String baseUrl = 'https://hayitis.com/api';
```

Les tokens JWT (access + refresh) sont stockés dans **flutter_secure_storage** et renouvelés automatiquement par `AuthInterceptor`.

---

## Fonctionnalités principales

- **Catalogue produits** — liste, filtres, recherche, détail avec galerie
- **Panier** — ajout, modification quantité, suppression, totaux en HTG/USD
- **Checkout** — sélection adresse, méthodes de paiement (Stripe, MonCash, hors ligne)
- **Commandes** — historique, suivi en temps réel, preuve de paiement
- **Wishlist** — favoris avec persistance serveur
- **Avis** — notes et commentaires sur les produits
- **Admin** — dashboard, gestion produits/commandes/clients/inventaire
- **Live chat** — intégration Tawk.to via WebView
- **Push notifications** — Firebase Cloud Messaging

---

## Écrans principaux

| Route | Écran |
|---|---|
| `/` | Home (bannières, catégories, nouveautés, vedettes) |
| `/shop` | Catalogue avec filtres |
| `/products/:slug` | Détail produit |
| `/cart` | Panier |
| `/checkout` | Tunnel de commande |
| `/orders` | Mes commandes |
| `/profile` | Profil utilisateur |
| `/admin` | Shell admin |

---

## Package name & version

```
applicationId : com.matstorehaiti.app
version       : 1.0.0+8
minSdk        : 23 (Android 6.0)
```
