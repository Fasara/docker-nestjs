FROM alpine:3.15 AS development

WORKDIR /app

COPY package*.json ./

RUN  npm install --only=development

COPY . .

RUN npm run build

FROM  alpine:3.15 AS production

ARG NODE_ENV=production

ENV NODE_ENV=${NODE_ENV}

WORKDIR /app

COPY packege*.json ./

RUN npm install --only=production

COPY . .

COPY --from=development /app/dist ./dist

CMD ["node", "dist/main"]






