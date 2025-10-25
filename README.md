# Ejercicio Flutter API - CIFO La Violeta

Este es un ejercicio para el curso de **CIFO de La Violeta**, propuesto por **Chema** y desarrollado por **David Portillo**.

## Objetivo

El objetivo principal de esta aplicación es demostrar cómo consumir datos de dos APIs REST diferentes y mostrarlos en una aplicación de Flutter.

La aplicación obtiene y lista:
-   **Usuarios**: Consumiendo la API de [ReqRes](https://reqres.in/).
-   **Países**: Consumiendo la API de [RestCountries](https://restcountries.com/).

## Funcionalidades

-   Una interfaz con pestañas (`TabBar`) para navegar entre la lista de usuarios y la de países.
-   Carga de datos asíncrona utilizando `FutureBuilder` para manejar los estados de carga, error y datos.
-   Visualización de los datos en listas desplazables con `ListView.builder`.
-   Una interfaz de usuario sencilla y clara para presentar la información.