**Lectuland** es una aplicación móvil desarrollada con **Flutter** que permite a los amantes de la lectura llevar un seguimiento personalizado de los libros que han leído. La app no solo registra títulos y autores, sino que también captura la experiencia emocional del lector a través de reseñas detalladas y calificaciones por categorías.

---

## 🎯 ¿Para qué se utiliza?

Lectuland está diseñada para cualquier persona que desee:

- **Llevar un control organizado** de todos los libros que ha leído.
- **Recordar su experiencia de lectura** mucho después de haber terminado un libro.
- **Calificar aspectos específicos** de un libro más allá de una simple puntuación de 5 estrellas (por ejemplo: nivel de romance, humor, tristeza, intensidad, etc.).
- **Guardar frases favoritas** y **personajes memorables**.
- **Consultar rápidamente** su biblioteca personal mediante búsqueda por título.

Es ideal para lectores que quieren mantener un **diario de lecturas** en su teléfono, sin necesidad de cuadernos físicos o documentos desperdigados.

---

## ⚙️ ¿Cómo funciona?

La aplicación sigue un flujo sencillo e intuitivo:

### 1. Autenticación de usuarios
- El usuario debe **registrarse** con un nombre de usuario y una contraseña (mínimo 4 caracteres).
- Luego puede **iniciar sesión** para acceder a su biblioteca personal.
- Los datos de los usuarios se almacenan temporalmente en memoria mientras la app está abierta.

### 2. Agregar un libro
Desde la pestaña **"Agregar"**, el usuario puede ingresar:
- Título y autor.
- Tipo de libro (electrónico, tapa dura o tapa blanda).
- Número de páginas e idioma.
- Género literario (texto libre).
- Tipo de serie (autoconclusivo, saga, bilogía o trilogía).
- Fechas de inicio y fin de lectura.
- Estado de lectura (por leer, leyendo o leído).
- Calificación general (de 1 a 5 estrellas, con posibilidad de medias estrellas).
- URL opcional de la portada del libro.

### 3. Reseña detallada (Review)
Antes de guardar el libro, el usuario debe completar una **reseña emocional** que incluye:
- **Reseña escrita** (sin límite de caracteres).
- **Personajes favoritos y odiados** (lista dinámica).
- **Calificaciones emocionales** (de 0 a 5 puntos) en las siguientes categorías:
  - Amor, Gracioso, Enojo, Tristeza, Fantasía, Reflexión, Spicy, Trama, Asesinato, Final.
- **Frases favoritas** del libro (lista dinámica).

Esta reseña permite recordar no solo *qué* se leyó, sino *cómo* se sintió al leerlo.

### 4. Biblioteca personal
En la pestaña **"Biblioteca"**, el usuario puede:
- Ver todos sus libros en una **lista vertical con tarjetas**.
- Ver un **contador** con la cantidad total de libros.
- **Buscar libros por título** en tiempo real.
- Hacer clic en cualquier libro para ver su **detalle completo**.

### 5. Detalle del libro
Al seleccionar un libro, se muestra:
- Portada (si se proporcionó una URL), título, autor, calificación general, páginas e idioma.
- Fechas de lectura, género y tipo de serie.
- Reseña escrita, personajes destacados, calificaciones emocionales y frases favoritas.

Desde esta pantalla también se puede:
- ✏️ **Editar** el libro (modificar cualquier campo o la reseña completa).
- 🗑️ **Eliminar** el libro de la biblioteca.

### 6. Edición
La edición permite corregir errores o actualizar la opinión del libro después de haberlo terminado o reflexionado más tiempo.


## 🛠️ Tecnologías utilizadas

- **Flutter (Dart)** – Framework para desarrollo multiplataforma.
- **Material Design** – Estilo visual y componentes de interfaz.
- **Git / GitHub** – Control de versiones y alojamiento del código.
