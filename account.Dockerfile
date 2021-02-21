FROM node:latest as build-env
WORKDIR /app/account
ADD . /app/account
RUN yarn install
RUN yarn run build

FROM node:14-alpine
WORKDIR /app/account
COPY --from=build-env /app/account/package.json /app/account/yarn.lock ./
COPY --from=build-env /app/account/node_modules ./node_modules
COPY --from=build-env /app/account/dist ./dist
COPY --from=build-env /app/account/apis ./apis
RUN yarn --cwd node_modules/grpc run install
CMD yarn run start:prod
