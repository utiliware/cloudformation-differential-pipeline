#!/bin/bash
environment="dev01"
stackname="tmp-iac-$environment"
region="us-east-1"
# profile="utiliware"
BranchName="master"
path="cloudformation"
template="$path/pipeline.yaml"
CloudformationBucket="tmp-iac-us-east-1"
RepositoryName="infrastructure"
ClassB="128"
EngineVersion="11.4"
DBInstanceClass="db.t3.micro"
DBMultiAZ="false"
EnhancedMonitoring="true"
EnablePerformanceInsights="true"
DeletionProtection="false"
EnableIAMDatabaseAuthentication="true"

# aws s3 sync . s3://$CloudformationBucket/$stackname --delete --exclude '*' --include '*.yaml' --include '*.yml' --profile $profile --region $region

for f in $path/*
do
  echo $f
  aws cloudformation validate-template --output text --profile $profile --region $region --template-body file://$f
done

aws cloudformation deploy --stack-name $stackname --profile $profile --region $region \
--capabilities CAPABILITY_IAM --template-file $template --parameter-overrides \
StackName=$stackname \
Environment=$environment \
CloudformationBucket=$CloudformationBucket \
RepositoryName=$RepositoryName \
BranchName=$BranchName \
ClassB=$ClassB \
Domain=$domain \
Path=$path \
EngineVersion=$EngineVersion \
DBInstanceClass=$DBInstanceClass \
DBMultiAZ=$DBMultiAZ \
EnhancedMonitoring=$EnhancedMonitoring \
EnablePerformanceInsights=$EnablePerformanceInsights \
DeletionProtection=$DeletionProtection \
EnableIAMDatabaseAuthentication=$EnableIAMDatabaseAuthentication