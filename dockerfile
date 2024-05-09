# Usa una imagen base de Node.js
FROM node:21

# Establece el directorio de trabajo dentro del contenedor
WORKDIR /usr/src/app

# Copia el package.json y el package-lock.json a /usr/src/app
COPY . .
# Instala las dependencias
RUN npm install

# Copia el resto de los archivos de la aplicación


# Expone el puerto en el que se ejecuta la API
EXPOSE 3000

# Comando para ejecutar la aplicación
CMD ["node", "index.js"]
