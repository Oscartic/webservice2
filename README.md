# README

WebService2.

Para poder correr el proyecto en un ambiente de desarrollo se requiere: 

* Bundle install
* configurar credenciales de acceso a una base de datos.
* rails db:create 
* rails db:migrate

Una vez realizado, se podrá arrancar el servidor. El crud de la app esta por defecto en el root de la aplicación.

el request POST de validación se realiza en_ :

http://host/rest/verify_user/:email  