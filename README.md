## BucStop-Goofin 
BucStop-Goofin is a project in SWE II 
## COOKED
[Cooked Document](https://docs.google.com/document/d/1pb71CN0g1qTX_UeYtdQbtx5hV6SlRyxDWjgN2buedjY/edit?tab=t.0) 
### *IS FOR PRODUCTION*
BucStop-Goofin is a project worked on by the Cooked team, 
our team took __BucStop__ from another repo and made it our own.

We have made the project to be launched on AWS and containerized and hopefully un-containerized. 
#### We decoupled each game from the _WebApp_ including 
- [x]  Pong 
- [x]  Tetris
- [x]  Snake
 *Each game above has been decouple* 
###### After decoupling, we utilize *Serilog* to log microservices within the terminal.

###### Some research was done on *AWS*, *Docker*, *API Gateway*, Games, etc to help us understand how to deploy the project.
- [Running Locally](https://docs.google.com/document/d/1gfUpjZNfqWyv1ohUW1IaS8fOhXp0hOx6tFQVXBADa8Q/edit?tab=t.0#heading=h.i67lbvpl08r4) -> Done by *404*
- [Deploying](https://docs.google.com/document/d/1vDSmWI5piwHRP1R2fOEEBvh1zYa7jaa6UImI4XudnF4/edit?tab=t.0) -> Done by *404*
- [Docker](https://docs.google.com/document/d/1_GlCmkd07uP36IxxsrnldZhiv-XDSLKP3EsULuhrdZw/edit?tab=t.0) -> Done by *Nathan Mink*
- [RollBack](https://docs.google.com/document/d/11LTixLWicBxM4XUPWyNRi4D5uFsL58xRFvQ-kOm0b9s/edit?tab=t.0) -> Done by *Nathan Mink*
- [MicroServices](https://docs.google.com/document/d/1614BGhXJ8EkGg9p286xH0KazdWtSf83aGFW192Is-DI/edit?tab=t.0) -> Done by *404*
- [API Gateway](https://docs.google.com/document/d/1m4LJcpHr9dqxSf33VF9SAhiMYU3Rd17kk7AoJd5ukFE/edit?tab=t.0) -> Done by *Curtis Reece* and *Tyler Campbell*
- [Pong](https://docs.google.com/document/d/1p3vGfpwckIeig31hPE6NhEbn-q6HuiRuU59Wvp2wYyw/edit?tab=t.0) -> Done by *Chris Oaks*
- [Snake](https://docs.google.com/document/d/10CIT4dCT5HjELWwAzcDBQZmu4N5H0FfeM87feEdGc6w/edit?tab=t.0) -> Done by*Randy Nixon*
## How to run on AWS
### Creating an AWS Account
- Go to [AWS](https://aws.amazon.com/)
- Click on *Create an AWS Account*
- Fill out the form
- Verify your email
- Verify your phone number
- Choose a support plan
- Enter your payment information
- Click on *Create Account and Continue*
### Creating an VPC 
	- [CIDR Cheat Sheet](https://www.freecodecamp.org/news/subnet-cheat-sheet-24-subnet-mask-30-26-27-29-and-other-ip-address-cidr-network-references/)
| Cidr | Subnet Mask | WildCard Mask | # of IP addresses | # of usable IP addresses |
| ---- | ----------- | ------------- | ----------------  | ------------------------ |
| /32  | 255.255.255.255 | 0.0.0.0   | 1                 |  1                       |
| /31  | 255.255.255.254 | 0.0.0.1	 | 2	             |  2                       |
| /30  | 255.255.255.252 | 0.0.0.3   | 4	             |  2                       |
| /29  | 255.255.255.248 | 0.0.0.7	 | 8	             |  6                       |
| /28  | 255.255.255.240 | 0.0.0.15  | 16	             |  14                      |
| /27  | 255.255.255.224 | 0.0.0.31  | 32                |  30                      |
| /26  | 255.255.255.192 | 0.0.0.63  | 64	             |  62                      |
| /25  | 255.255.255.128 | 0.0.0.127 | 128	             |  126                     |
| /24  | 255.255.255.0	 | 0.0.0.255 | 256               |	254                     |
| /23  | 255.255.254.0	 | 0.0.1.255 | 512               |	510                     |
| /22  | 255.255.252.0	 | 0.0.3.255 | 1,024             |	1,022                   |
| /21  | 255.255.248.0   | 0.0.7.255 | 2,048             |	2,046                   |
| /20  | 255.255.240.0   | 0.0.15.255| 4,096	         |  4,094                   |
| /19  | 255.255.224.0   | 0.0.31.255| 8,192             |	8,190                   |
| /18  | 255.255.192.0   | 0.0.63.255| 16,384            |	16,382                  |
| /17  | 255.255.128.0   | 0.0.127.255|32,768	         |  32,766                  |
| /16  | 255.255.0.0     | 0.0.255.255|65,536            |	65,534                  |
| /15  | 255.254.0.0     | 0.1.255.255|131,072			 |  131,070                 |
| /14  | 255.252.0.0     | 0.3.255.255|262,144	         |  262,142                 |
| /13  | 255.248.0.0     | 0.7.255.255|524,288	         |  524,286                 |
| /12  | 255.240.0.0     |0.15.255.255|1,048,576	     |  1,048,574               |
| /11  | 255.224.0.0     |0.31.255.255|2,097,152	     |  2,097,150               |
| /10  | 255.192.0.0     |0.63.255.255|4,194,304         |	4,194,302               |
| /9   | 255.128.0.0	 |0.127.255.255|8,388,608        | 	8,388,606               |
| /8   | 255.0.0.0       |0.255.255.255|16,777,216       | 	16,777,214              |
| /7   | 254.0.0.0       |1.255.255.255|33,554,432       |	33,554,430              |
| /6   | 252.0.0.0       |3.255.255.255|67,108,864       |  67,108,862              |
| /5   | 248.0.0.0       |7.255.255.255|134,217,728      |  134,217,726             |
| /4   | 240.0.0.0       |15.255.255.255|268,435,456     |	268,435,454             |
| /3   | 224.0.0.0       |31.255.255.255|536,870,912     |  536,870,910             |
| /2   | 192.0.0.0       |63.255.255.255|1,073,741,824   |  1,073,741,822           |
| /1   | 128.0.0.0	     |127.255.255.255|2,147,483,648  |	2,147,483,646           |
| /0   | 0.0.0.0	     |255.255.255.255|4,294,967,296  |	4,294,967,294           |
```
	HTML
	<div>
		<table>
			<thead>
				<tr>
					<th>CIDR</th>
					<th>Subnet Mask</th>
					<th>WildCard Mask</th>
					<td># of IP addresses</td>
					<td># of usable IP addresses</td>
				</tr>
			</thead>
			<tbody>
				<tr>
				<td>/32</td><td>255.255.255.255</td><td>0.0.0.0</td><td>1</td><td>1</td></tr>
				<tr>
				<td>/31</td><td>255.255.255.254</td><td>0.0.0.1</td><td>2</td><td>2*</td></tr>
				<tr>
				<td>/30</td><td>255.255.255.252</td><td>0.0.0.3</td><td>4</td><td>2</td></tr>
				<tr>
				<td>/29</td><td>255.255.255.248</td><td>0.0.0.7</td><td>8</td><td>6</td></tr>
				<tr>
				<td>/28</td><td>255.255.255.240</td><td>0.0.0.15</td><td>16</td><td>14</td></tr>
				<tr>
				<td>/27</td><td>255.255.255.224</td><td>0.0.0.31</td><td>32</td><td>30</td></tr>
				<tr>
				<td>/26</td><td>255.255.255.192</td><td>0.0.0.63</td><td>64</td><td>62</td></tr>
				<tr>
				<td>/25</td><td>255.255.255.128</td><td>0.0.0.127</td><td>128</td><td>126</td></tr>
				<tr>
				<td>/24</td><td>255.255.255.0</td><td>0.0.0.255</td><td>256</td><td>254</td></tr>
				<tr>
				<td>/23</td><td>255.255.254.0</td><td>0.0.1.255</td><td>512</td><td>510</td></tr>
				<tr>
				<td>/22</td><td>255.255.252.0</td><td>0.0.3.255</td><td>1,024</td><td>1,022</td></tr>
				<tr>
				<td>/21</td><td>255.255.248.0</td><td>0.0.7.255</td><td>2,048</td><td>2,046</td></tr>
				<tr>
				<td>/20</td><td>255.255.240.0</td><td>0.0.15.255</td><td>4,096</td><td>4,094</td></tr>
				<tr>
				<td>/19</td><td>255.255.224.0</td><td>0.0.31.255</td><td>8,192</td><td>8,190</td></tr>
				<tr>
				<td>/18</td><td>255.255.192.0</td><td>0.0.63.255</td><td>16,384</td><td>16,382</td></tr>
				<tr>
				<td>/17</td><td>255.255.128.0</td><td>0.0.127.255</td><td>32,768</td><td>32,766</td></tr>
				<tr>
				<td>/16</td><td>255.255.0.0</td><td>0.0.255.255</td><td>65,536</td><td>65,534</td></tr>
				<tr>
				<td>/15</td><td>255.254.0.0</td><td>0.1.255.255</td><td>131,072</td><td>131,070</td></tr>
				<tr>
				<td>/14</td><td>255.252.0.0</td><td>0.3.255.255</td><td>262,144</td><td>262,142</td></tr>
				<tr>
				<td>/13</td><td>255.248.0.0</td><td>0.7.255.255</td><td>524,288</td><td>524,286</td></tr>
				<tr>
				<td>/12</td><td>255.240.0.0</td><td>0.15.255.255</td><td>1,048,576</td><td>1,048,574</td></tr>
				<tr>
				<td>/11</td><td>255.224.0.0</td><td>0.31.255.255</td><td>2,097,152</td><td>2,097,150</td></tr>
				<tr>
				<td>/10</td><td>255.192.0.0</td><td>0.63.255.255</td><td>4,194,304</td><td>4,194,302</td></tr>
				<tr>
				<td>/9</td><td>255.128.0.0</td><td>0.127.255.255</td><td>8,388,608</td><td>8,388,606</td></tr>
				<tr>
				<td>/8</td><td>255.0.0.0</td><td>0.255.255.255</td><td>16,777,216</td><td>16,777,214</td></tr>
				<tr>
				<td>/7</td><td>254.0.0.0</td><td>1.255.255.255</td><td>33,554,432</td><td>33,554,430</td></tr>
				<tr>
				<td>/6</td><td>252.0.0.0</td><td>3.255.255.255</td><td>67,108,864</td><td>67,108,862</td></tr>
				<tr>
				<td>/5</td><td>248.0.0.0</td><td>7.255.255.255</td><td>134,217,728</td><td>134,217,726</td></tr>
				<tr>
				<td>/4</td><td>240.0.0.0</td><td>15.255.255.255</td><td>268,435,456</td><td>268,435,454</td></tr>
				<tr>
				<td>/3</td><td>224.0.0.0</td><td>31.255.255.255</td><td>536,870,912</td><td>536,870,910</td></tr>
				<tr>
				<td>/2</td><td>192.0.0.0</td><td>63.255.255.255</td><td>1,073,741,824</td><td>1,073,741,822</td></tr>
				<tr>
				<td>/1</td><td>128.0.0.0</td><td>127.255.255.255</td><td>2,147,483,648</td><td>2,147,483,646</td></tr>
				<tr>
				<td>/0</td><td>0.0.0.0</td><td>255.255.255.255</td><td>4,294,967,296</td><td>4,294,967,294</td></tr>
			</tbody>
		</table>
	</div>
```
- Go to the [VPC Console](https://console.aws.amazon.com/vpc/home)
- Click on *Your VPCs*
- Click on *Create VPC*
- Fill out the form
- Click on *Create VPC*
- Click on *Subnets*
- Click on *Create Subnet*
- Fill out the form
- Click on *Create Subnet*
- Click on *Route Tables*
- Click on *Create Route Table*
- Fill out the form
- Click on *Create Route Table*
- Click on *Internet Gateways*
- Click on *Create Internet Gateway*
- Fill out the form
- Click on *Create Internet Gateway*
### Creating Security Groups
- Go to the [EC2 Console](https://console.aws.amazon.com/ec2/v2/home)
- Click on *Security Groups*
- Click on *Create Security Group*
- Fill out the form
- Click on *Create Security Group*
- Click on *Inbound Rules*
- Click on *Edit Inbound Rules*
- Click on *Add Rule*
- Fill out the form
- Click on *Save Rules*
- Click on *Outbound Rules*
- Click on *Edit Outbound Rules*
- Click on *Add Rule*
- Fill out the form
- Click on *Save Rules*
### Creating an EC2 Instance
- Give it a *Name*
- Choose the *OS Image*
- Choose the *Instance Type*
- Choose the *Security Groups*
- 