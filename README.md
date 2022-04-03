# Introduction/Context

![Docker](/assets/serverless-framework-docker.png)

Sometimes could be difficult to have all exactly same versions in all laptops. The purpose of this is to have only 1 image of docker with all software necessary, ready to be used whenever you want. In CICD or your local.

# Technologies we’ll use:

* Docker version 20.10.13
* Serverless Framework 2.38.0
* Python 3.8.10
* Node v17.7.2
* NPM 8.5.4

# Pre-requisites:
```bash
1º You need Docker installed in your laptop.  → https://www.docker.com/get-started/
2º Access KEY + Secret KEY from AWS configured in your ~/.aws/credentials
```

# Deploy:

```bash
docker build -t docker-serverless-monitoring .

docker run -it -v $HOME/.aws/credentials:/home/nroot/.aws/credentials:ro  -v  "$(pwd)":/home/nroot/  --name serverless-container docker-serverless-monitoring

serverless deploy --ENVIRONMENT 'PROD-INT-PRE'
```

![Yes](/assets/travolta_matrix.gif)


# Testing

If everything is working well, when you deploy serverless you will see something like this:

![Result](/assets/testing-to-deploy.png)

# Licence

Apache

# Information

More info --> 

https://www.serverless.com/blog/container-support-for-lambda

https://stackoverflow.com/questions/36354423/what-is-the-best-way-to-pass-aws-credentials-to-a-docker-container

David Álvarez Quiroga
