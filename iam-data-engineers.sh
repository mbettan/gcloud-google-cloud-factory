#!/bin/bash
#######################################################
# Data engineers will be granted following roles:
# - Dataflow Admin 
# - Storage Admin
# - Pub/Sub Editor
# - Notebooks Admin
# - Dataproc Admin
# - BigQuery Admin
#######################################################
# Note 1: This IAM Binding works at the Org level, for folders: https://cloud.google.com/sdk/gcloud/reference/alpha/resource-manager/folders/add-iam-policy-binding
#

export MYORG_ID=`gcloud organizations list --format="value(ID)"`
export ORG_NAME=`gcloud organizations list --format="value(displayName)"`
echo Your Organization ID is $MYORG_ID
echo Your Organization Name is $ORG_NAME

declare -a arr=("dataflow.admin" "storage.admin" "pubsub.editor" "notebooks.admin" "dataproc.admin" "bigquery.admin")
declare -a users=("data-engineer-user1" "data-engineer-user2" "data-engineer-user3")

for i in "${arr[@]}"
do
    for u in "${users[@]}"
    do
        echo "Assigning role $i at the folder level"
            gcloud alpha resource-manager folders add-iam-policy-binding "<Folder ID>" \
            --member=user:$u@$ORG_NAME \
            --role=roles/$i
    done
done
