provider "aws" {
  alias   = "source"
  profile = "source"  #named profile as exists in ~/.aws/credentials
  region  = "us-west-1"
}

provider "aws" {
  alias   = "destination"
  profile = "destination"  #named profile as exists in ~/.aws/credentials
  region  = "us-west-1"
}

data "aws_caller_identity" "source" {
  provider = aws.source   #collecting account creds from the source profile [source]
}

data "aws_iam_policy" "ec2" {   
  provider = aws.destination
  name     = "AmazonEC2FullAccess"
  #using a managed aws policy for testing. Here we are allowing any entity that uses this policy the ability to have full control over EC2 
}

data "aws_iam_policy_document" "assume_role" {
  provider = aws.destination
  statement {
    actions = [
      "sts:AssumeRole",
      "sts:TagSession",
      "sts:SetSourceIdentity"
    ]
    principals {
      type        = "AWS"

    
      
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.source.account_id}:root"]  #principal being defined is granting access to the SOURCE ACCOUNT to assume a role in the DESTINATION
      #this api is being called by the DESTINATION ACCOUNT - run this first.  
    }
  }
}

resource "aws_iam_role" "assume_role" {
  
  provider            = aws.destination
  name                = "assume_role_in_destination_account"
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = [data.aws_iam_policy.ec2.arn]
  tags                = {}
}

#this api is being called by the DESTINATION ACCOUNT - run this first.  
#creates an IAM assume role in the destination account the source account can use! 
# https://learn.hashicorp.com/tutorials/terraform/aws-assumerole


cd setter; terraform init;
terraform plan --out setter.binary;
terraform show -json setter.binary > setter.json;
checkov -f setter.json;