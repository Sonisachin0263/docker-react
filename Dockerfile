# Multi step docker file
FROM node:16-alpine as builder 
#tag has been given as builder using 'as' keyword

WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .

RUN npm run build

FROM nginx
# we are using first phase which is builder phase for the required files to server from nginx
# we are copying those using --from flag 
COPY --from=builder /app/build /usr/share/nginx/html 
