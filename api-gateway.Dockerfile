FROM node:14 as build-env
WORKDIR /app/api-gateway
ADD . /app/api-gateway
RUN yarn install
RUN yarn run build

FROM node:14-alpine
WORKDIR /app/api-gateway
COPY --from=build-env /app/api-gateway/package.json /app/api-gateway/yarn.lock ./
COPY --from=build-env /app/api-gateway/node_modules ./node_modules
COPY --from=build-env /app/api-gateway/dist ./dist
COPY --from=build-env /app/api-gateway/apis ./apis
RUN yarn --cwd node_modules/grpc run install
CMD yarn run start:prod
