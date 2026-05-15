# Usamos una versión ligera de Node
FROM node:20-alpine

# Definimos el directorio de trabajo dentro del contenedor
WORKDIR /app

# Copiamos los archivos de dependencias (los crearemos en el próximo paso)
COPY package*.json ./

# Instalamos las dependencias
RUN npm install

# Copiamos el resto del código
COPY . .

# Exponemos el puerto de Express
EXPOSE 3000

# Comando para iniciar el servidor
CMD ["node", "src/server.js"]