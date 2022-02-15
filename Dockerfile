# The 'as' acts as a tag for this phase
FROM node:16-alpine as builder 
USER node
RUN mkdir -p /home/node/app
# The working directory in the container
WORKDIR '/home/node/app'
# Copy files
COPY --chown=node:node ./package.json ./
# Install dependencies
RUN npm install
COPY --chown=node:node ./ ./
RUN npm run build

FROM nginx
COPY --from=builder /home/node/app/build /user/share/nginx/html