 ----------------------------------------------------------------
         ___        ______     ____ _                 _  ___  
        / \ \      / / ___|   / ___| | ___  _   _  __| |/ _ \ 
       / _ \ \ /\ / /\___ \  | |   | |/ _ \| | | |/ _` | (_) |
      / ___ \ V  V /  ___) | | |___| | (_) | |_| | (_| |\__, |
     /_/   \_\_/\_/  |____/   \____|_|\___/ \__,_|\__,_|  /_/ 
 ----------------------------------------------------------------- 


Hi there! Welcome to AWS Cloud9!

To get started, create some files, play with the terminal,
or visit https://docs.aws.amazon.com/console/cloud9/ for our documentation.

Happy coding!

# Deploying a NGINX website using EKS, Docker using EC2 instance and Jenkins Pipeline

Here we explain step by step deployment with prerequisities required for the project

## Prerequisites

- Must have AWS account
- [NGINX](https://www.nginx.com/resources/wiki/start/topics/tutorials/install/)
- [Tidy](https://www.html-tidy.org/)
- [Eksctl](https://docs.aws.amazon.com/eks/latest/userguide/getting-started-eksctl.html)
- [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/)
- [Docker(preinstalled if using cloud9)](https://docs.docker.com/engine/install/)
- [AWS cli](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-install.html)
- [Jenkins](https://www.jenkins.io/doc/book/installing/)
- [hadolint](https://github.com/hadolint/hadolint)

***Note:*** Expose the `80` and `8080` ports of your EC2-instance if you are using cloud9 by going in the security group associated with your cloud9 EC2
instance and changing inbound rules to allow all traffic on these ports.

### IAM role

Login as root user in AWS management console and go to IAM. Create a new security group giving access to VPC, EKS, S3, Cloud9 and relevant services.
If unsure one can proceed with giving admin access. Now go to users and create a new user having programatic and console access. Attach the security group created to the user
Download the credentials for the user in a safe place.

### HTML

Create or clone the HTMl along with `*.conf` file which will be displayed upon successful build. You can also add style and script in this scheme.

### Setup Jenkins 

Install Jenkins using the link given above. Upon successful installation, you can start jenkins using `sudo systemctl start jenkins` for ubuntu or `sudo service jenkins start`
for CentOS/Amazon-Linux. One can look for specific commands for specific OS in the installation link provided above. Upon successful installation, jenkins should ask for a secret access key
get the secret access key by typing `sudo cat /var/lib/jenkins/secrets/initialAdminPassword` in terminal. Copy and paste the output and proceed with 
suggested plugins. Create a new admin account upon prompt.
Now, Go to manage plugins options and install plugins for `blue-ocean(optional), pipeline-aws, docker, kubectl`. Restart jenkins upon succesful
installation. Log into jenkins again and go to manage `jenkins-> manage credentials-> jenkins` and add global credentials for the aws user created in the first step and docker-hub credentials.

### Create files

Create configuration files for jenkins docker and EKS cluster referring to the one in the repo. Note that it should encapsulate our `html` and config file along with exposing port `80`. Jekinsfile should have linting stage to check that `HTML` and `DOCKERFILE` are written properly.

### Deploy Website

Login into jenkins and open blue ocean. Create a new github pipeline, create github personal access token and open the repository containing the files above. 
From EC2 terminal run `createCluster.sh`. It will take some time to create the cluster. Meanwhile, run the pipeline to observe if all steps but the last is running okay.
Finally, after the EKS cluster is created build again and you should be able to access the application using the `loadbalancer` URL. 

*Note:* If you are getting the error `kubectl:command not found` just move kubectl binaries from `/usr/bin/local` to `/usr/bin` or add `/usr/local/bin` to your `PATH` variable.

