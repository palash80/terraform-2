region="us-east-1"
addr="10.8.0.0/16"
sdr=["10.8.128.0/18", "10.8.64.0/18"]
nam="ninja-vpc-01"
subnet_name= ["ninja-pub-sub-01", "ninja-pub-sub-02"]

#private cidr block
pdr=["10.8.0.0/25", "10.8.0.128/25"] 
#private subnet name
priname= ["ninja-pri-sub-01", "ninja-pri-sub-02"]
#ami id of instance
am="ami-06aa3f7caf3a30282"
#gateway name
gateway_name = "ninja-igw-01"

all=["0.0.0.0/0"]
