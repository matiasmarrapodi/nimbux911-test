# Exercise for Nimbux911

Overview:

For this exercise I have deployed two ec2 instances on the privated subnet with nat gateway and I installed nginx on docker and apache.
I have used application load balancer in the public subnet.

* [Architecture for this solution](#Architecture-for-this-solution)

![imagen](https://user-images.githubusercontent.com/58306637/158292098-b9823fba-2925-47e5-9799-6e30e92d6407.png)

* [Run Script](#Run-Script)

terraform apply -var-file=laboratorio.tfvars

* [Outputs](#Outputs)

URL to the ALB on the web
