**Question 1:  Faulty Firewall**

Suppose you have a firewall that's supposed to block SSH connections, but instead lets them through. How would you debug it?
​
1. Restating the problem
    - _Firewall that Allows SSH connections when it should block them_
2. Concrete Example Scenario
    - _In Project 1 I did not allow SSH traffic to all the VMs inside the network except for one called Jump-Box-Provisioner. If you are to connect to one of the Virtual Machine's that does not accept SSH connections then you will get a rejection message._
3. Solution Requirements
    - _If one VM accepted SSH connection then it might be because of a rule that the SSH destination is only pointing to one Machine instead of multiple machines or if there is a firewall per host that is blocking the port or the VMs are disabled or "turned off" except for one. And since it's about troubleshooting SSH connections a good way to test a new configuration if it is effective is connecting locally first and then externally to deduce the problems if the connectivity is still an issue._
4. Solution Details
    - _To investigate problems with SSH connections the specific panels I would consider investigating at is first the network topology to see if the machines are connected to the right Network Security Group, next would be the Network Security Group itself to check for configurations related to the IP and Port Destinations I am trying to block SSH Connections from. Per configured setting we can easily try connecting to a machine via SSH until it works with what the goal is, which is to block SSH connections._
5. Advantages/Disadvantages of the Solution
    - _The Project 1 network is not "immune" to all unauthorized access but it will prevent or delay an attack whenever it happens._
    - _A monitoring control that I would add is a stack such as ELK, which stands for Elasticsearch, Logstash, and Kibana to monitor any suspicious activities with collected log files_