<p align="center">
  <img src="./docs/images/ghost-logo.png" width="260px" />
</p>

<h3 align="center">Best headless cms blog platform</h3>
<h4 align="center">Ghost is the fast, modern WordPress alternative, focused completely on professional publishing.</h4>
<br>
<p align="center">
  <img src="https://img.shields.io/badge/ghost-3.41.7-738A94?style=for-the-badge&logo=ghost&labelColor=20232a" />
  <a href="https://google.com">
    <img src="https://img.shields.io/badge/dockerhub-1.0.0-2496ED?style=for-the-badge&logo=docker&labelColor=20232a" />
  </a>
</p>

<br><br>

<p align="center">
  <img src="./docs/images/ghost-cover.png" />
</p>

<br><br>

# Getting Started

Este proyecto esta enfocado en utilizar ghost unicamente. La base de datos y el servidor de almacenamiento de archivos estaticos se utilizaran como microservicios. Digitalocean Spaces será el microservicio necesario para poder utilizar la imagen de docker.

Para iniciar tu proyecto con ghost simplemente puedes utilizar el siguiente comando pasando los valores a cada variable de entorno definida. Mira la seccion de requerimientos en este documento para que logres configurar cada valor necesario.

```
docker run -d --name ghost -p 2368:2368 \
-e url= \
-e database__client=mysql \
-e database__connection__host= \
-e database__connection__user= \
-e database__connection__port= \
-e database__connection__password= \
-e database__connection__database= \
-e GHATA_CONFIG=config.production.json \
-e GHATA_ENDPOINT= \
-e GHATA_BUCKET= \
-e GHATA_SUBDOMAIN= \
-e GHATA_PATH= \
-e GHATA_KEY= \
-e GHATA_SECRET= \
luisfalconmx/ghost:latest
```

<br>

### Requerimientos

Para poder utilizar la imagen de este proyecto se necesitan cumplir los siguientes requerimientos.

- Docker instalado en tu computador o en tu servidor.
- Docker compose instalado en tu computador.
- Una cuenta en digitalocean.
- Un dominio
- Un servidor de MySQL 5.7 o 8

<br>

### Crear un space en digitalocean

El microservicio principal que usaremos es digitalocean spaces. Este nos servira para alojar todos los archivos estaticos en una cdn. Para lograr esto primero vamos a nuestro panel de digitalocean, damos clic en el boton verde que dice create y seleccionamos Spaces.

![Digitalocean crear un space tutorial 1](./docs/images/do-space-01.png)

<br>
Seleccionamos la region del datacenter de nuestra preferencia.

![Digitalocean crear un space tutorial 2](./docs/images/do-space-02.png)

<br>
Habilitaremos el Content Delivery Network para que nuestros archivos estaticos sean servidos desde multiples servidores. Para este paso es necesario que agreges tu dominio a digitalocean y lo selecciones en el campo "Use a custom subdomain". Podrás usar directamente el dominio o si especificas un subdominio digitalocean lo creara por ti.

En la opción "Allow file listing?" es recomendable seleccionar "Restrict File Listing" para que solo las aplicaciones de nuestra propiedad puedan listar los contenidos del space.

![Digitalocean crear un space tutorial 3](./docs/images/do-space-03.png)

<br>

Para finalizar simplemente le damos un nombre a nuestro space. Seleccionamos el proyecto y damos clic en el boton de crear. (me sale el mensaje en rojo por que ya lo tenia creado)

![Digitalocean crear un space tutorial 4](./docs/images/do-space-04.png)

<br>

### Obtener las credenciales del Space

Una vez que tenemos el space creado ahora vamos a obtener cada uno de los valores que necesitamos para correr la imagen de docker de este proyecto.

Primero vamos a abrir el space que creamos para ver sus detalles.
![Digitalocean crear un space tutorial 5](./docs/images/do-space-05.png)

Ahora damos clic en settings.
![Digitalocean crear un space tutorial 6](./docs/images/do-space-06.png)

Y copiamos el endpoint.
![Digitalocean crear un space tutorial 7](./docs/images/do-space-07.png)

Con esto obtendremos la variable `GHATA_ENDPOINT=nyc3.digitaloceanspaces.com` - Recuerda utilizar tu endpoint.

---

Ahora podremos obtener la siguiente variable directamente del nombre del space.

` GHATA_BUCKET=static.luisfalconmx.com` - Recuerda utilizar el nombre de tu space
![Digitalocean crear un space tutorial 8](./docs/images/do-space-08.png)

---

Ahora para la siguiente variable tendremos que ir dentro del space a `settings > cdn` donde encontraremos el dominio o subdominio que utilizamos.

![Digitalocean crear un space tutorial 9](./docs/images/do-space-09.png)

`GHATA_SUBDOMAIN=static.luisfalconmx.com` - Recuerda usar tu dominio o subdominio.

---

Para la variable `GHATA_PATH` simplemente pondremos el nombre del directorio donde se almacenaran los archivos. Por ejemplo

`GHATA_PATH=ghost` - Recuerda poner tu directorio preferido

![Digitalocean crear un space tutorial 10](./docs/images/do-space-10.png)

---

Para las variables `GHATA_KEY` y `GHATA_SECRET` vamos a API.

![Digitalocean crear un space tutorial 11](./docs/images/do-space-11.png)

Vamos a la seccion Spaces and keys y damos clic en "Generate New Key"

![Digitalocean crear un space tutorial 12](./docs/images/do-space-12.png)

Al ponerle un nombre para identificar la api generada obtendremos las llaves.

![Digitalocean crear un space tutorial 13](./docs/images/do-space-13.png)

`GHATA_KEY=***` - Recuerda usar tu key

`GHATA_SECRET=***` - Recuerda usar tu secret

<br>

### Obtener las credenciales de MySQL

En los requerimientos se especifico que necesitamos un servidor de mysql 5.7 o 8. Este nos servira para poder almacenar nuestros posts.

En esta guia no cubriremos el paso a paso de como crear un servidor de mysql pero te dejo un articulo oficial de digitalocean para que puedas crearlo.

<br>

### Obtener las credenciales de las bases de datos autoadministradas

Si usas las bases de datos autoadministradas de digitalocean tendras en tu panel las credenciales que necesitas para conectarte pero antes tendras que configurar dos cosas.

1 - Se debera crear un nuevo usuario con la opcion "Password Encryption" en "Legacy - MySQL 5.x"

![Digitalocean crear un space tutorial 14](./docs/images/do-space-14.png)

2 - Necesitaras modificar la variable de mysql `sql_require_primary_key` al valor `sql_require_primary_key = off` pero este proceso no lo podrás hacer por tu cuenta. Tendras que abrir un ticket en soporte de digitalocean solicitando este cambio.

Una vez que cumplas los pasos anteriores podremos usar los siguientes datos para usarlas en las variables de entorno.

![Digitalocean conectar la base de datos 1](./docs/images/do-database-01.png)

Con los datos anteriores podremos llenar los datos de la siguiente manera. Recuerda usar los datos de tu servidor de mysql.

```
-e database__client=mysql \
-e database__connection__host=db-mysql-nyc1-50829-do-user-8682229-0.b.db.ondigitalocean.com \
-e database__connection__user=dummy \
-e database__connection__port=25060 \
-e database__connection__password=***** \
-e database__connection__database=dummy \
```
