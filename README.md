# Autozone App 🚗

**Desarrollado por:** Hideki Rafael Sarmiento Ariyama (20241453)

## Descripción
**Autozone** es una aplicación multiplataforma desarrollada en Flutter orientada a la gestión y seguimiento vehicular. Permite a los usuarios administrar el estado de sus vehículos, mantenimientos, finanzas, repuestos y mantenerse al tanto de las últimas noticias, además de contar con un apartado social de foro y catálogo.

Se integra con una API centralizada en tiempo real.

## Módulos Principales

* **Autenticación (Auth)**: Login, registro, activación de cuenta mediante token temporal, configuración y actualización de perfil (incluyendo foto y cambio de contraseña).
* **Dashboard**: Panel central y vista general del negocio o perfil del usuario.
* **Vehículos**: Alta, modificación y consulta de la flotilla/vehículos registrados.
* **Mantenimientos**: Seguimiento del historial de servicios preventivos y correctivos.
* **Finanzas**: Registro e historial de ingresos, gastos y consumos de combustible asociados a los vehículos.
* **Catálogo & Gomas**: Consulta de productos, partes y repuestos.
* **Foro & Noticias**: Módulos sociales y de actualidad con posibilidad de lectura y debate continuo.
* **Videos**: Sección de contenido multimedia.

## Tecnologías Utilizadas

* **Framework:** Flutter / Dart
* **Gestor de Estado:** Provider
* **Enrutamiento:** GoRouter
* **Consumo API HTTP:** Integración con REST API mediante peticiones multipart y estándar (`http`).
* **Persistencia Local:** `shared_preferences` para almacenar tokens y preferencias temporales.
* **Multimedia:** `image_picker` para capturar/subir avatar de usuario.

## Estructura del Proyecto

El proyecto sigue una arquitectura **Feature-Driven Architecture** (agrupada por características), dividida horizontalmente en las capas de `presentation`, `domain` y `data` para escalabilidad y mantenimiento.

```text
lib/
 ├─ core/            # Configuraciones base de la app
 │   ├─ constants/   # Endpoints, tokens, constantes globales
 │   ├─ network/     # Interceptores de red y helper de peticiones `ApiService`
 │   ├─ routing/     # Archivo central de rutas manejado por `GoRouter` 
 │   └─ utils/       # Helpers como parseador y formato de imágenes
 │
 └─ features/        # Módulos de la aplicación
     ├─ auth/
     ├─ catalogo/
     ├─ dashboard/
     ├─ fincanzas/
     ├─ foro/
     ├─ gomas/
     ├─ mantenimientos/
     ├─ noticias/
     ├─ vehiculos/
     └─ videos/
```

## Para Empezar

1. Asegúrate de tener el [SDK de Flutter](https://docs.flutter.dev/get-started/install) instalado.
2. Comprueba las dependencias del proyecto:
   ```bash
   flutter pub get
   ```
3. Ejecuta el proyecto en tu dispositivo o emulador activo:
   ```bash
   flutter run
   ```
