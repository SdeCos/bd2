# Bases de Datos
## Índice
* [comandos](comandos/README.md) -> Snippets rápidos y ayudas extra.
* [mongodb/apuntes](mongodb/apuntes/README.md) -> Teoría y Sintaxis de MongoDB.
* [mongodb/docker-compose](mongodb/docker-compose/README.md) -> Entornos para levantar la base de datos en el examen.

## Setup Git
**1. Generar nueva clave SSH (pulsa Enter a todo para ir rápido):**

    ssh-keygen -t rsa -b 4096 -C "saul.decossanchez@alumnos.uneatlantico.es"

**2. Añadir la clave al agente:**

    eval "$(ssh-agent -s)"
    ssh-add ~/.ssh/id_rsa

**3. Copiar la clave para pegarla en GitHub (Settings -> SSH and GPG keys):**

    cat ~/.ssh/id_rsa.pub

**4. Configurar tu identidad en Git (Obligatorio):**

    git config --global user.name "SdeCos"
    git config --global user.email "saul.decossanchez@alumnos.uneatlantico.es"