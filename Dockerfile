
ARG NODE_VERSION=18.18.0
FROM node:18.18.0 as build
WORKDIR /app
COPY package*.json .
RUN npm install
COPY . .
RUN npm run build

FROM node:18.18.0
WORKDIR /app
COPY package.json .
RUN npm install --only=production
COPY --from=build /app/dist ./dist
CMD npm run start:prod
# FROM base as deps
# RUN --mount=type=bind,source=package.json,target=package.json \
#     --mount=type=bind,source=package-lock.json,target=package-lock.json \
#     --mount=type=cache,target=/root/.npm \
#     npm ci --omit=dev
# FROM deps as build

# RUN --mount=type=bind,source=package.json,target=package.json \
#     --mount=type=bind,source=package-lock.json,target=package-lock.json \
#     --mount=type=cache,target=/root/.npm \
#     npm ci

# COPY . .

# RUN npm run build

# FROM base as final


# ENV NODE_ENV production

# USER node

# COPY package.json .


# COPY --from=deps /usr/src/app/node_modules ./node_modules
# COPY --from=build /usr/src/app/docker-deploy ./docker-deploy



# EXPOSE 3000

# CMD npm start
