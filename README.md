<h1 align="center">
  <br/>
  <img src="https://raw.githubusercontent.com/hrool20/HackerNews/develop/HackerNews/Main/Assets.xcassets/ic_app_logo.imageset/ic_app_logo.png" alt="Markdownify" width="200">
  <br/>
  Hacker News
  <br/>
</h1>

`Hacker News` es una app donde podrás ver las últimas noticias en el mundo informático de Hackers. Para este proyecto se utilizó principalmente el patrón `MVP (Model View Presenter)`, el cual es combinado con `Routers`, `Handlers` y `Repositories`.
<br/>

Además, la app soporta dos idiomas: **español** e **ingles**. Para poder cambiar de idioma en la app, se debe cambiar el idioma del dispositivo móvil. En este proyecto se utilizaron las siguientes bibliotecas (libraries) externas:
- [**Alamofire**](https://github.com/Alamofire/Alamofire) - Utilizado para el consumo de servicios (API's).
- [**IQKeyboardManager**](https://github.com/hackiftekhar/IQKeyboardManager) - Utilizado para facilitar la gestión del Keyboard.
- [**Lottie**](https://github.com/airbnb/lottie-ios) - Utilizado para mostrar animaciones dentro de ciertos views.
- [**SDWebImage**](https://github.com/SDWebImage/SDWebImage) - Utilizado para la conversión de urls a imágenes.
- [**SwiftyJSON**](https://github.com/SwiftyJSON/SwiftyJSON) - Utilizado para la conversión de diccionarios a `JSON Objects` o `JSON Arrays`.


## Instalación

Para poder instalar las bibliotecas (libraries) externas, debes utilizar el siguiente comando:
```
pod install
```
Luego, solo debes correr el proyecto en un dispositivo físico.
> :warning: Si utilizas un simulador, puede que te aparezca un bug sobre Webview al ingresar al detalle de cada noticia.
