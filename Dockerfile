# Устанавливаем официальный образ Node.js
FROM node:14-alpine as build-stage

# Создаем рабочую директорию
WORKDIR /app

# Копируем package.json и package-lock.json в рабочую директорию
COPY package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем исходный код приложения
COPY . .

# Собираем приложение
RUN npm run build

# Настройка стадии production
FROM nginx:stable-alpine as production-stage

# Копируем собранные файлы приложения из стадии build-stage
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Экспонируем порт
EXPOSE 80

# Запускаем Nginx
CMD ["nginx", "-g", "daemon off;"]