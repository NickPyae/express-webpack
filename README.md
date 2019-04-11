# AIA iRecurit Skeleton Backend Service

### Prerequisites
1. Node v10 or higher
2. NPM v6 or higher
3. Git and Git Bash installed
4. Any IDE with eslint plugin installed
5. Install Docker 
6. Set necessary AIA Proxy
(http://sindcpljir01:8090/confluence/display/DT/Environment+Setup)

### Pull Request, Branching and Commit Messsage Standards
[Click here and follow these standards. You can also find these standards under `.azuredevops` folder too.](.azuredevops/pull_request_template.md)

### Create your new backend service from the skeleton
1. Create a new Azure repo for your new microservice. Service name should start with the project name for example: **irecruit-user-service** 
<br/>


2. Run below command to clone the skeleton service into your local folder
```
git clone https://AIAIRecruit@dev.azure.com/AIAIRecruit/iRecruitSgDev/_git/irecruit-service-skeleton SERVICE_NAME

SERVICE_NAME - the local folder path and name of your microservice
```
3. Update the package.json `name` with your service name and `version`
```
{
  "name": "SERVICE_NAME",
  "version": "0.0.1",
}
```

4. Remove the .git folder
```
rm -rf .git
```

5. run the command below to init a new git directory
```
git init
git checkout -b develop
```

6. back to your folder and run the following 
```
# Create a first commit
git add .
git commit -m "first commit"

# Set the remote to your new project (update the remote url below with your url)
git remote add origin YOUR_AZURE_REPO_URL

# Check the remote is correctly set 
git remote -v 

# Push develop branch
git push -u origin develop
```

7. Update the default branch to 'develop' and enable the branch protection policy in Azure Repo
Guide :  <https://docs.microsoft.com/en-us/azure/devops/repos/git/branch-policies?view=azure-devops>
<br/>

8. Clean this README from your project by removing the `Create your new project from the skeleton`and rename the first line title. Add important requirements, notes and how to whenever necessary.
<br/>

9. Variable names need to be modified to make the pipeline works correctly in your project. `azure-pipeline.yml` file is just the template file, you need to do some twists so it will work probably with your project. PR branches should always be to `develop`.

```
pr:
  branches:
    include:
      - master
      - develop

variables:

projectName : {your project service name}

arc: {your azure registry name}

acrConnector: {your resource group name}
```

10. Backend services are packaged by Helm and pushed to Azure Artifacts which can be used by Azure Container Service later. To make helm packaging successful, `chartPath` value at `task: HelmDeploy@0` inside `azure-pieplines.yml` file must be correct. Inside your project root folder, you must have `helm` folder. Inside this `helm` folder, you must also have sub-folder with the desired project name and all necessary helm config `.yaml` files must be in place. Helm will always look for `Chart.yaml` file based on the `chartPath` you specify. If `chartPath` is incorrect, your CI build will fail during packaging.

11. If all above steps are properly done, then you can start your development.

## Project structures

The backend skeleton project contains following structures:

 - `src`
    - `config:` 
      All the base configurations should be placed inside this folder such as database connections etc.
    - `controllers:`
      All the controllers logic such as accessing database, azure or 3rd party api should be placed inside this folder.
    - `middlewares:`
      All express and custom middlewares should be placed inside this folder.
    - `models:`
      All database models, classes etc. should be placed inside this folder.
    - `routes:`
      All express Router routes or your api routes should be placed inside this folder.
    - `server:`
      Main server file is inside this folder.
    - `services:`
      All necessary service files should be placed inside this folder.
  - `tests`
      API contract test

By convention, if you are working on `Login` feature for example, you should create a sub-folder called `login` and put related loginController, loginModel js and test files etc. under respective folders.

For example,
 ```src > controllers > login > loginController.js & loginController.test.js```

 ```src > models > login > loginModel.js & loginModel.test.js```

### How to run locally from terminal

Run these steps in order.

1. Install all the modules: ```npm i```
2. Open a new terminal and run: ```npm run build:dev```. This will generate not only `dist` folder but also `.env` file in your root folder.
3. Open another terminal and run: ```npm run start:dev```

Every time you make changes to your `src` folder, webpack will automatically bundle and update your changes. You only have to refresh your browser to see the changes.

### Testing and Linting

1. Unit test: ```npm run test``` or ```./node_modules/.bin/jest --watch```
2. API test: ```npm run api-test```
3. Check code coverage: ```npm run coverage```
4. Check linting: ```npm run lint```

### How to run inside Docker locally

By default, docker will use webpack production build files which is already optimized in production mode.

1. Start your docker daemon. Details setup can be found here.(http://sindcpljir01:8090/confluence/display/DT/Docker+Setup)
2. Log into docker application with your docker id and password. This is required since you need to pull docker base images from Docker Hub.
3. You can also execute following command to log into Docker from your terminal.
```
 docker login -u YOUR_DOCKER_ID -p YOUR_DOCKER_PASSWORD
```
4. Verify that you can pull image from Docker Hub by executing following command.
```
docker run hello-world
```
5. Always make sure you have run ``` npm i ``` to install packages for your app.

6. Paste below line inside `Dockerfile` to make sure you can download npm packages during docker build process. You must set proxy in order to make `npm i` work properly if you are using AIA Corporate network. Update url with your LANID and PASSWORD. If you are not using AIA Corporate network. You can skip this step.
Below line should be under `COPY package*.json ./` in `Dockerfile`
```
# Only for running Docker locally. Remove these 2 lines before pushing to remote.
RUN npm config set proxy http://LANID:PASSWORD@sgpriproxy.aia.biz:10938 && npm set strict-ssl false 

```
***Note:***  Do not forget to remove this proxy from `Dockerfile` before you push to remote.

7. When you run `docker build` on your windows laptop, you will encounter an error like ```not foundnv.sh``` during docker build process. This is because of different rules in `CRLF`, `LF` Windows & Linx linebreak styles since `npm build` will execute `npm run env` which is running shell scripts under ```ops > sh > .env.sh ```. This is not the case if you are using Mac or Linux. Only happening on Windows. 

There are 2 ways to fix this.
  1. First way is to execute this in your terminal ```cat ./ops/sh/.env.sh | sed '/\015/d' >.env.sh```. This will remove the CR character from CR/LF line endings form your shell script and create new `.env.sh` file under your root folder. Delete your existing file and put your new `.env.sh` file under `ops > sh` folder.
  2.  Second way is you can tell Git to convert CRLF to LF on commit but not the other way around by setting core.autocrlf to input by executing:
  ```
  git config --global core.autocrlf input
  ```

8. Build your docker image. If you have fixed `CRLF`, `LF` issue and set proxy properly, then your docker image should be built successfully without any error.
```
docker build -t YOUR_DOCKER_ID/irecruit .
```
9. Verify that you can see your docker image with the tag you specifiy.
```
docker images
```
10. Copy your IMAG_ID and run
```
docker run -p 8080:8080 -d IMAGE_ID
```
11. Verify that your docker container is running
```
docker ps
```
12. Go to your browser and paste `http://localhost:8080/api/sample`
13. You can check the logs of your container by running
```
docker logs CONTAINER_ID
```
14. Kill your docker container by running
```
docker kill CONTAINER_ID
```
15. If you refresh your localhost again, your server will be down since you already kill your container.

### Webpack and ES6+
All the files inside `src` folders are compiled with webpack. ES6+ syntaxes are supported and encouraged to use. Webpack will always automatically generate `dist` folder every time you make changes to your `src` files. You only have to refresh your browser to see changes.

## Env files
Put all the global static values such as database name, host, port etc. inside `.env.development` file under ```ops > env ```. By default, your `NODE_ENV` is set to `development` on your local machine.

Do not put sensitive information like password, access key id, token etc. inside env file.

***Note:*** 
Every time you make changes to `.env.development` file in your machine, you need to re-run  ```npm run build:dev``` to update `.env` file in your root folder.

### Using Server and Logger Module
Your main `server.start()` should be from AIA `server` module instead of `express` since server module has Azure App Insights for storing logs, catching errors etc.

For the routes, you can still use `express.Router()`.

Always put necessary logs using AIA `logger` module `logger.info` function.

### Error handling in Express
Always pass your error to `next` middleware function or `throw` an error.
Follow this error handling guide in your express application:
https://expressjs.com/en/guide/error-handling.html