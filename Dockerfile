FROM node:16.14.2 as build

WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
#RUN npm install -g @angular-devkit/build-angular@13.3.0
#RUN npm install -g @angular/cli@13.1.2
#RUN npm install -g @angular/compiler-cli@13.1.0

RUN npm run build --prod
# RUN npm start

FROM nginx:1.19

COPY ./nginx/nginx.conf /etc/nginx/nginx.conf
COPY --from=build /app/dist/sampleprj3/ /usr/share/nginx/html

options:
  logging: CLOUD_LOGGING_ONLY
