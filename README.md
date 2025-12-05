# Bala-Balance: App de Control Financiero Personal

Aplicación móvil desarrollada con **Flutter** para gestionar ingresos, egresos y metas de ahorro, utilizando una arquitectura **MVVM** simple.

---

## Información del Proyecto

- **Tema:** Examen Final - Bala-Balance  
- **Curso:** Programación para Dispositivos Móviles  
- **Docente:** Josue Miguel Flores Parra  
- **Semestre:** VI - Ingeniería de Software  

**Integrantes:**  
- Piero Fabricio Poblete Andia

---

## 1. Introducción

Bala-Balance es una aplicación móvil diseñada para facilitar el **control financiero personal** de los usuarios. Permite registrar, clasificar y analizar ingresos y gastos de forma sencilla, ofreciendo una **visión clara y organizada** de la situación económica del usuario para ayudarle a **tomar decisiones informadas** y **establecer metas de ahorro**.

---

## 2. Objetivos de la Aplicación

### Objetivo General
Construir una aplicación funcional que permita al usuario administrar sus gastos e ingresos mediante diversas pantallas: **inicio, estadísticas, metas, categorías, registros y formularios de ingreso/egreso**.

### Objetivos Específicos
- Registrar transacciones financieras diarias (ingresos y gastos) con **monto, categoría y descripción**.  
- Clasificar las transacciones según su **categoría**.  
- Generar **reportes y estadísticas personalizadas**.  
- Establecer **metas de ahorro** y mostrar su progreso.  
- Mantener los datos durante la sesión mediante **persistencia local**.

---

## 3. Características Principales

| Funcionalidad              | Descripción                                                                 |
|-----------------------------|-----------------------------------------------------------------------------|
| **Registro de transacciones** | Permite agregar nuevas transacciones financieras (monto, tipo, categoría, descripción opcional). |
| **Clasificación por categorías** | Organiza las transacciones en categorías personalizables (alimentación, transporte, etc.). |
| **Visualización de estadísticas** | Genera reportes y gráficos que muestran la distribución de gastos por categoría utilizando `fl_chart`. |
| **Gestión de metas de ahorro** | Permite al usuario establecer y seguir el progreso de sus metas financieras. |
| **Persistencia de datos**   | Guarda la información del usuario localmente para mantener un registro histórico de todas las transacciones durante la sesión. |

---

## 4. Arquitectura y Patrón Usado (MVVM)

El proyecto sigue un patrón de diseño **MVVM (Model-View-ViewModel)**, adaptado al ecosistema de Flutter mediante el paquete `provider`.

- **Modelos (data/models):** Clases simples que representan los datos (`TransactionModel`, `CategoryModel`).  
- **Vistas/UI (screens):** Widgets que construyen la interfaz visual y reaccionan a la interacción del usuario.  
- **ViewModels (viewmodels):** Clases (`ChangeNotifier`) que gestionan el estado y la lógica de la vista, notificando a la UI mediante `Provider`.  

---

## 5. Decisiones de Diseño Clave

- **Gestión de Estado:** Se eligió `Provider` por su eficiencia, simplicidad y recomendación de la comunidad de Flutter.  
- **Navegación:** Se usa `go_router` para un manejo de rutas limpio y robusto.  
- **Modularidad:** La separación en carpetas distintas (`models`, `views`, `viewmodels`) facilita el mantenimiento del código.  

---

## Cómo ejecutar el proyecto

1. Asegúrate de tener **Flutter** instalado y configurado.  
2. Clona este repositorio.  
3. Abre el proyecto en tu IDE (**VS Code** o **Android Studio**).  
4. Ejecuta `flutter pub get` en la terminal.  
5. Conecta un dispositivo o inicia un emulador.  
6. Ejecuta `flutter run` o usa el botón Run de tu IDE.
