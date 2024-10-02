# Используем официальный образ Go
FROM golang:1.20 AS builder

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем go.mod и go.sum
COPY go.mod go.sum ./
RUN go mod download

# Копируем исходный код
COPY . .

# Собираем приложение
RUN go build -o hello-world

# Используем минимальный образ для запуска
FROM alpine:latest

WORKDIR /root/

# Копируем скомпилированное приложение из предыдущего образа
COPY --from=builder /app/hello-world .

# Открываем порт
EXPOSE 8080

# Запускаем приложение
CMD ["./hello-world"]
