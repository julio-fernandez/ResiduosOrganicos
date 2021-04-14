# residuos

Revisar
https://material.io/components/data-tables/flutter#data-tables-information


##Comandos usados

##### Para actualizar icono de la app añadir libreria

~~~ 
flutter pub pub add flutter_launcher_icons

~~~
##### Para actualizar icono de la app cuando sea necesario cambiarlo

~~~ 
flutter pub run flutter_launcher_icons:main
~~~

##### Para instalar libreria responsiva

~~~
flutter pub pub add responsive_grid
~~~
##### Para instalar libreria datos persistentes

~~~
flutter pub pub add shared_preferences
~~~

###Compilar app
 
 ~~~
flutter build apk --split-per-abi
~~~

###Instalar http
~~~
flutter pub pub add http
~~~



###Añadir a  android/app/src/main/AndroidManifest.xml
~~~

<application
    ...
    android:usesCleartextTraffic="true"
    ...   >
~~~