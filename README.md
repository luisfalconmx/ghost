<p align="center">
  <img src="./docs/images/ghost-logo.png" width="260px" />
</p>

<h2 align="center">Best headless blog platform</h2>
<h3 align="center">Ghost is the fast, modern WordPress alternative, focused completely on professional publishing.</h3>
<br>
<p align="center">
  <img src="https://img.shields.io/badge/ghost-3.4.5-738A94?style=for-the-badge&logo=ghost&labelColor=20232a" />
  <a href="https://google.com">
    <img src="https://img.shields.io/badge/dockerhub-1.0.0-2496ED?style=for-the-badge&logo=docker&labelColor=20232a" />
  </a>
</p>

<br><br>

<p align="center">
  <img src="./docs/images/ghost-cover.png" />
</p>

<br><br>

# Get Started

## Docker

Docker Run command

```
docker run -d --name ghost -p 2368:2368 \
-e url= \
-e database__client= \
-e database__connection__host= \
-e database__connection__user= \
-e database__connection__port= \
-e database__connection__password= \
-e database__connection__database= \
-e GHATA_CONFIG= \
-e GHATA_ENDPOINT= \
-e GHATA_BUCKET= \
-e GHATA_SUBDOMAIN= \
-e GHATA_PATH= \
-e GHATA_KEY= \
-e GHATA_SECRET= \
luisfalconmx/ghost
```

## Docker compose
