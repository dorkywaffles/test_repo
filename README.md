## BucStop-Goofin 
BucStop-Goofin is a project in __SWE II__
## __COOKED__
[Cooked Document](https://docs.google.com/document/d/1pb71CN0g1qTX_UeYtdQbtx5hV6SlRyxDWjgN2buedjY/edit?tab=t.0) 
### *ISN'T FOR PRODUCTION, still in __testing__*
BucStop-Goofin is a project worked on by the Cooked team, 
our team took __BucStop__ from another repo and made it our own.

We have made the project to be launched on __AWS and containerized and hopefully un-containerized__. 
#### We decoupled each game from the _WebApp_ including 
- [x]  __Pong__
- [x]  __Tetris__
- [x]  __Snake__
- *Each game above has been decouple* 
#### After decoupling, we utilize *Serilog* to log microservices within the terminal.

#### Some research was done on *AWS*, *Docker*, *API Gateway*, Games, etc to help us understand how to deploy the project.
- [Running Locally](https://docs.google.com/document/d/1gfUpjZNfqWyv1ohUW1IaS8fOhXp0hOx6tFQVXBADa8Q/edit?tab=t.0#heading=h.i67lbvpl08r4) 
- [Deploying](https://docs.google.com/document/d/1vDSmWI5piwHRP1R2fOEEBvh1zYa7jaa6UImI4XudnF4/edit?tab=t.0) 
- [Docker](https://docs.google.com/document/d/1_GlCmkd07uP36IxxsrnldZhiv-XDSLKP3EsULuhrdZw/edit?tab=t.0) 
- [RollBack](https://docs.google.com/document/d/11LTixLWicBxM4XUPWyNRi4D5uFsL58xRFvQ-kOm0b9s/edit?tab=t.0) 
- [MicroServices](https://docs.google.com/document/d/1614BGhXJ8EkGg9p286xH0KazdWtSf83aGFW192Is-DI/edit?tab=t.0) 
- [API Gateway](https://docs.google.com/document/d/1m4LJcpHr9dqxSf33VF9SAhiMYU3Rd17kk7AoJd5ukFE/edit?tab=t.0) 
- [Pong](https://docs.google.com/document/d/1p3vGfpwckIeig31hPE6NhEbn-q6HuiRuU59Wvp2wYyw/edit?tab=t.0) 
- [Snake](https://docs.google.com/document/d/10CIT4dCT5HjELWwAzcDBQZmu4N5H0FfeM87feEdGc6w/edit?tab=t.0) 
## How to run on AWS
### Creating an AWS Account
- Go to [AWS](https://aws.amazon.com/)
- Click on *Create an AWS Account*
- __Fill out the form__
- Verify your *email*
- Verify your *phone number*
- Choose a *support plan*
- Enter your *payment information*
- Click on *Create Account and Continue*

### Creating Security Groups
%% This may be here for now %%
- Go to the [EC2 Console](https://console.aws.amazon.com/ec2/v2/home)
- Click on *Security Groups*
- Click on *Create Security Group*
- __Fill out the form__
- Click on *Create Security Group*
- Click on *Inbound Rules*
- Click on *Edit Inbound Rules*
- Click on *Add Rule*
- __Fill out the form__
- Click on *Save Rules*
- Click on *Outbound Rules*
- Click on *Edit Outbound Rules*
- Click on *Add Rule*
- __Fill out the form__
- Click on *Save Rules*
### Creating an EC2 Instance
- Give it a *Name*
	- Name the instances to something *MeaningFul*	
- Choose the *OS Image* 
- Choose the *Instance Type*
	- Choose the smallest type, unless you can afford it
- Choose the *Security Groups*
	- Choose the *default security**
- Choose *Launch Instance**

## Running the Project instances on AWS
- Go to the [EC2 Console](https://console.aws.amazon.com/ec2/v2/home)
- Click on the *Instances* you want to run
- Click the terminal icon
- Click on the *Connect* button
- Click on the *SSH Client* tab
	- Once you are in the terminal, you can run the commands below
	- Run the following commands
	- Docker compose up 
	

# (*__CHICKEN JOCKEY__*)
![image](https://i.kym-cdn.com/entries/icons/facebook/000/053/364/chicken-jockey.jpg)