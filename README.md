

<h1>Prueba Sisco banck -api </h1>

<h4 >Componentes Y descripcion</h4>

<p> La aplicación cuenta con los siguientes modulos:
    1	servicio de api_key
    2	servicio de gestion de usuarioAdmin( login, register, recuperacion de password)
    3	servicio de gestuin de usuario (entiendase que este usuario es distinto al usuario Admin)
    4	servicio para gestion de tipo de documento
    5	servicio para gestion tipo de persona
    6   cada servicio cuenta con su CRUD
    7   Respectivas validaciones y relaciones entre tipo de persona tipo de documento con usuario

    Cabe destacar que la aplicación está bajo entorno Ruby on Rails para Bac-kend. Utiliza postgres SQL para la base de datos, y Postman para gestor de pruebas para cada enpoint. 

    ## Rreparacion del entorno
   # Paso1: 
    1	Tener previamnete instalado Ruby 3.0.0 y Ruby on rails 7
    3   Tener base de dato para gestion postgres instalada

    Sugerencia :
    - trabajar bajo sistema operativo Linux o si es en windo utilizar extencion a linux para evitar confictos con Ruby y algunas gemas
    
    # Paso2:  
    Iniciamos entorno frond-bacend 
    - Conar repositorio
    - bundle install  --> instalara las gemas respectiva
    - rails db:create  --> creara la base de dato respectiva 
    - rails db:migrate  ---> migrara las tablas necesarias para el proyecto
    - rails db:seed  ---> creara datos de prueba esto nos servira para:
        - comprobar si la base de dato se creo de forma correcta
        - comprobar si no se rompe ninguna informacion a ingresar dato
        - poseer datos de pruebas para unificar con el entorno frontend
        - llenar de forma mas rapida la data en tablas que no requiere tanta gestion de informacion ejemplo tabla tipo personas y tabla tipo documentos
    - rails s  ---> levantara el servidor para el uso de los enpoint levantara el servidor local en el puerto :3000
    - realizar pruebas en postman
    - clonar repositorio front-end que hace uso de estos enpoit url: https://github.com/16gisell/sis-views

    Observaciones: 
    -	Este proyecto puede que requiera de mejoras en las validaciones en la informacion del usuario

    Importante: 
    - los enpoit cuentan con headers que potejen su llamado por lo que es obligatorio gestionar primero la api_key para poder hacer uso de cualquier otro dato
    - tiene uso de un modelo de correo especifico
    - para gestionar cualquier enpoint debe poser api-key y la sesion iniciada ya que requiere el token de sesion
    - Requiere de documento para credenciales esto para uso del correo si desean hacer uso de la recuperacion de password

    Mejora:
    - importante tomar en cuenta que el siguiente proyecto fue realizado en limite de tiemo por lo que requerira algunas mejoras entre ellas:
        - mejorar el uso de archivos para las validaciones esto se podria realizar utilizando un unico archivo para simplificar el codigo
        - mejorar en el llamado de algunos metodos
        - mejorar los mensajes de respuestas
        
"author": "Giss/Gisell Hernández",
</p>
