#!/bin/bash
###############################################################################
# Description: Assigning permissions at the project level for a specific group 
###############################################################################
# Data engineers will be granted following roles:
# - Dataflow Admin 
# - Storage Admin
# - Pub/Sub Editor
# - Notebooks Admin
# - Dataproc Admin
# - BigQuery Admin
#######################################################
# Note 1: This IAM Binding works at the Org level, for folders: https://cloud.google.com/sdk/gcloud/reference/alpha/resource-manager/folders/add-iam-policy-binding


export MYORG_ID=`gcloud organizations list --format="value(ID)"`
export ORG_NAME=`gcloud organizations list --format="value(displayName)"`
export MY_GROUP="<Your Group name>"
echo Your Organization ID is $MYORG_ID
echo Your Organization Name is $ORG_NAME

declare -a arr=("dataflow.admin" "storage.admin" "pubsub.editor" "notebooks.admin" "dataproc.admin" "bigquery.admin" )
for i in "${arr[@]}"
do
   echo "Assigning role $i"
         gcloud organizations add-iam-policy-binding $MYORG_ID \
        --member=group:$MY_GROUP@$ORG_NAME \
        --role=roles/$i
done
