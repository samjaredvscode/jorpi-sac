# JORPI Constructora - Sitio Web Corporativo Moderno

## 🏗️ Descripción del Proyecto

JORPI Constructora es una aplicación web moderna desarrollada en **Flutter** que sirve como sitio web corporativo profesional para una empresa de construcción. La aplicación presenta una interfaz completamente responsive con diseño moderno, animaciones fluidas y una experiencia de usuario excepcional en todos los dispositivos.

## ✨ Características Principales

### 🎨 **Diseño Moderno y Profesional**

- **AppBar con gradiente minimalista** que cambia dinámicamente al hacer scroll
- **Animaciones fluidas** con transiciones suaves en todas las secciones
- **Patrón de cuadrícula arquitectónica** en el fondo de la sección principal
- **Gradientes y sombras** para crear profundidad visual
- **Tipografía escalable** con jerarquía clara y legible

### 📱 **Diseño Completamente Responsive**

- **Mobile (< 768px)**: Layout optimizado para smartphones con navegación hamburguesa
- **Tablet (768px - 1024px)**: Diseño adaptado para tablets con elementos intermedios
- **Desktop (> 1024px)**: Experiencia completa con navegación horizontal completa
- **Breakpoints inteligentes** que se adaptan automáticamente

### 🏠 **Sección de Inicio (Hero Section)**

- **Imagen de fondo profesional** de construcción moderna
- **Badge corporativo** con logo de la empresa
- **Tipografía destacada** con efectos de sombra y gradientes
- **Botones duales**: "Contáctanos" (primario) y "Ver Proyectos" (secundario)
- **Indicador de scroll** elegante con animación
- **Layout adaptativo**: Botones en columna (mobile) vs fila (desktop)

### 👥 **Sección Nosotros**

- **Header con badge** y línea decorativa con gradiente
- **Layout responsive**: Imagen arriba en mobile, lado a lado en desktop
- **Tarjetas de características** con iconos y descripciones detalladas:
  - Experiencia Profesional (15+ años)
  - Calidad Garantizada
  - Innovación Constante
- **Estadísticas flotantes** sobre la imagen (solo desktop)
- **Tarjeta de proyectos completados** con información destacada

### 🛠️ **Servicios Ofrecidos**

- **Grid responsive**: Columna en mobile, fila en desktop
- **Tarjetas modernas** con imágenes de fondo y gradientes
- **Animaciones stagger** para entrada secuencial de elementos
- **Servicios detallados**:
  - **Construcción**: Viviendas, edificios comerciales, obras industriales
  - **Remodelación**: Renovación, ampliaciones, mejoras estructurales
  - **Diseño de Planos**: Arquitectura, interiores, planificación urbana
- **Lista de características** con checkmarks en cada servicio
- **Call-to-action** destacado con gradiente y botón de cotización

### 📋 **Portafolio de Proyectos**

- **Layout adaptativo**: Columna vertical en mobile, scroll horizontal en desktop
- **Tarjetas premium** con imágenes de alta calidad
- **Badges de categoría** y botones de acción flotantes
- **Detalles del proyecto**: Fecha, ubicación, estado
- **Chips de características** para etiquetado (Residencial, Moderno, Sustentable)
- **Estados de carga** mejorados con indicadores visuales
- **Manejo de errores** elegante con opción de reintentar

### 📞 **Sección de Contacto**

- **Layout responsive**: Formulario arriba en mobile, lado a lado en desktop
- **Formulario completo** con validación en tiempo real:
  - Nombre completo
  - Correo electrónico (con validación de formato)
  - Teléfono
  - Mensaje (área de texto expandible)
- **Información de contacto** en tarjetas modernas:
  - Email: <jorpi@jorpiconstructora.com>
  - Teléfono: +51 994 615 521
  - Ubicación: Lima, Perú
- **Horario de atención** destacado en tarjeta especial
- **Feedback visual** con SnackBar al enviar mensaje

## 🏗️ Arquitectura del Proyecto

El proyecto sigue una **arquitectura limpia (Clean Architecture)** con separación clara de responsabilidades:

### 📁 **Estructura de Carpetas**

```bash
lib/
├── core/                    # Configuraciones centrales
│   ├── di/                 # Inyección de dependencias (Get It)
│   ├── theme/              # Tema personalizado con colores corporativos
│   └── utils/              # Utilidades y helpers
├── data/                   # Capa de datos
│   ├── datasources/        # Fuentes de datos (API, local)
│   ├── models/             # Modelos de datos
│   └── repositories/       # Implementación de repositorios
├── domain/                 # Capa de dominio (lógica de negocio)
│   ├── entities/           # Entidades del dominio
│   ├── repositories/       # Interfaces de repositorios
│   └── usecases/           # Casos de uso
└── presentation/           # Capa de presentación
    ├── bloc/               # Gestión de estado (BLoC pattern)
    ├── pages/              # Páginas principales
    └── widgets/            # Componentes reutilizables y responsive
```

## 🛠️ Tecnologías Utilizadas

### **Framework y Estado**

- **Flutter 3.8+**: Framework principal para desarrollo multiplataforma
- **Flutter BLoC**: Gestión de estado reactiva y predecible
- **Get It**: Inyección de dependencias para arquitectura limpia

### **Networking y Datos**

- **Dio**: Cliente HTTP avanzado para llamadas a API
- **Equatable**: Comparación eficiente de objetos

### **Diseño y UI**

- **Material Design 3**: Sistema de diseño moderno y accesible
- **Custom Painters**: Patrones y efectos visuales personalizados
- **Animations**: Controllers y transiciones fluidas

## 🎨 Configuración del Tema

La aplicación utiliza un **tema corporativo personalizado**:

### **Paleta de Colores**

- **Color primario**: Azul corporativo (#0D47A1)
- **Color de acento**: Naranja energético (#F57F17)
- **Fondo**: Gris claro profesional (#F5F5F5)
- **Texto**: Negro suave (#212121)

### **Tipografía**

- **Display Large**: 48-72px para títulos principales
- **Title Large**: 36px para subtítulos
- **Body Medium**: 14-18px para contenido
- **Sistema escalable** que se adapta a diferentes pantallas

### **Efectos Visuales**

- **Gradientes sutiles** para profundidad
- **Sombras y elevación** para jerarquía visual
- **Border radius** consistente (8-20px)
- **Transiciones suaves** (200-1500ms)

## 📱 Características Responsive

### **Breakpoints Inteligentes**

```dart
// Mobile: < 768px
// Tablet: 768px - 1024px  
// Desktop: > 1024px
```

### **Adaptaciones por Dispositivo**

- **Tipografía escalable** con tamaños optimizados
- **Layouts adaptativos** (columna vs fila)
- **Espaciado proporcional** (padding y márgenes)
- **Navegación contextual** (hamburguesa vs horizontal)
- **Interacciones touch-friendly** (botones mín 44px)

## 🚀 Instalación y Ejecución

### **Requisitos Previos**

- Flutter SDK 3.8.1 o superior
- Dart 3.0 o superior
- Android Studio / VS Code con extensiones Flutter

### **Pasos de Instalación**

1. **Clonar el repositorio**

   ```bash
   git clone [url-del-repositorio]
   cd jorpi_sac
   ```

2. **Instalar dependencias**

   ```bash
   flutter pub get
   ```

3. **Ejecutar la aplicación**

   ```bash
   # Para desarrollo web
   flutter run -d chrome
   
   # Para dispositivos móviles
   flutter run
   
   # Para producción web
   flutter build web
   ```

## 🌐 Plataformas Soportadas

- ✅ **Web**: Navegadores modernos (Chrome, Firefox, Safari, Edge)
- ✅ **Android**: API 21+ (Android 5.0+)
- ✅ **iOS**: iOS 11.0+
- ✅ **Windows**: Windows 10+
- ✅ **macOS**: macOS 10.14+
- ✅ **Linux**: Distribuciones principales

## 📊 Características Técnicas

### **Performance**

- **Lazy loading** de imágenes y contenido
- **Animaciones optimizadas** con vsync
- **Gestión eficiente de memoria** con dispose patterns
- **Código modular** para fácil mantenimiento

### **Accesibilidad**

- **Semantic labels** para screen readers
- **Contraste adecuado** en colores
- **Navegación por teclado** compatible
- **Tamaños de touch** apropiados

### **SEO y Web**

- **Meta tags** optimizados
- **Estructura semántica** HTML
- **Performance Core Web Vitals**
- **PWA ready** para instalación

## 📞 Información de Contacto

Para más información sobre JORPI Constructora:

- **Email**: <jorpi@jorpiconstructora.com>
- **Teléfono**: +51 994 615 521
- **Ubicación**: Lima, Perú
- **Horario**: Lunes-Viernes 8:00 AM - 6:00 PM, Sábados 9:00 AM - 2:00 PM

## 🤝 Contribución

Este proyecto está diseñado para mostrar las capacidades de JORPI Constructora. Para contribuciones técnicas o mejoras, por favor contactar al equipo de desarrollo.

---

*Desarrollado con Flutter, arquitectura limpia y diseño moderno para una experiencia de usuario excepcional en todos los dispositivos.* 🚀
