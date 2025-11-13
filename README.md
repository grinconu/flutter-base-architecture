# Base Architecture - Flutter Clean Architecture

Este proyecto es una base arquitectónica para aplicaciones Flutter futuras, implementando **Clean Architecture** (Arquitectura Limpia) con las mejores prácticas y herramientas del ecosistema Flutter.

## Componentes Principales

Este proyecto utiliza los siguientes paquetes y librerías:

- **[Dio](https://pub.dev/packages/dio)** - Cliente HTTP potente para Dart, usado para peticiones de red y APIs REST
- **[Riverpod](https://riverpod.dev/)** - Framework de gestión de estado reactivo y robusto para Flutter
- **[go_router](https://pub.dev/packages/go_router)** - Sistema de navegación declarativa para Flutter con soporte para deep linking

## Estructura del Proyecto

El proyecto sigue los principios de Clean Architecture, organizando el código en las siguientes capas:

```
lib/
├── domain/                 # Capa de dominio (lógica de negocio)
│   ├── entities/          # Entidades del dominio
│   └── repositories/      # Interfaces de repositorios
├── infrastructure/         # Capa de infraestructura
│   ├── models/            # Modelos de datos (DTOs)
│   ├── repositories/      # Implementaciones de repositorios
│   └── datasources/       # Fuentes de datos (API, local, etc.)
├── presentation/           # Capa de presentación
│   ├── screens/           # Pantallas de la aplicación
│   ├── widgets/           # Widgets reutilizables
│   ├── providers/         # Providers de Riverpod
│   └── config/            # Configuraciones (tema, rutas, etc.)
└── main.dart              # Punto de entrada de la aplicación
```

## Estructura de Pruebas

Las pruebas están organizadas para cubrir las capas críticas del proyecto:

```
test/
├── infrastructure/        # Pruebas de la capa de infraestructura
│   ├── repositories/     # Tests de implementaciones de repositorios
│   └── datasources/      # Tests de fuentes de datos
├── presentation/          # Pruebas de la capa de presentación
│   ├── screens/          # Tests de pantallas (widget tests)
│   ├── widgets/          # Tests de widgets
│   └── providers/        # Tests de providers
```

## Getting Started

### Prerequisitos

- Flutter SDK (versión 3.0 o superior)
- Dart SDK
- IDE (VS Code, Android Studio, o IntelliJ IDEA)

### Instalación

1. Clonar el repositorio
2. Ejecutar `flutter pub get` para instalar las dependencias
3. Ejecutar `flutter run` para iniciar la aplicación

### Ejecutar Pruebas

```bash
# Ejecutar todas las pruebas
flutter test

# Ejecutar pruebas con cobertura
flutter test --coverage
```

## Recursos

- [Documentación de Flutter](https://docs.flutter.dev/)
- [Documentación de Riverpod](https://riverpod.dev/)
- [Documentación de go_router](https://pub.dev/packages/go_router)
- [Documentación de Dio](https://pub.dev/packages/dio)
