# residuos

Revisar
https://material.io/components/data-tables/flutter#data-tables-information


<hr>

## Comandos de terminal para añadir librerias

##### Para actualizar icono predefinido

~~~ 
flutter pub pub add flutter_launcher_icons
~~~

##### NO USADO --Para instalar libreria responsiva--

~~~
flutter pub pub add responsive_grid
~~~

##### Para instalar libreria datos persistentes

~~~
flutter pub pub add shared_preferences
~~~

###Instalar http
~~~
flutter pub pub add http
~~~

###Instalar date time picker
~~~
flutter pub pub add flutter_datetime_picker
~~~

<hr>

## Añadir a  android/app/src/main/AndroidManifest.xml
~~~

<application
    ...
    android:usesCleartextTraffic="true"
    ...   >
~~~

<hr>

## Otros comandos

##### Para actualizar icono de la app cuando sea necesario cambiarlo

~~~ 
flutter pub run flutter_launcher_icons:main
~~~


###Compilar apk
 
 ~~~
flutter build apk --split-per-abi
~~~