FROM node:18.18.0 as build
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build
RUN npm install pm2 -g

FROM node:18.18.0
WORKDIR /app
COPY package.json .
RUN npm install --only=production
COPY --from=build /app/dist ./dist
CMD npm run start:prod




