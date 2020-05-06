#!/bin/bash
export MYORG_ID=`gcloud organizations list --format="value(ID)"`
export BILLING_ID=`gcloud alpha billing accounts list --format="value(ACCOUNT_ID)"`
export PRJ_ID=`printf $MYORG_ID | tail -c 6` 
export PRJ_NAME="my-gcp-project"

gcloud projects create $PRJ_NAME-$PRJ_ID
gcloud alpha billing projects link $PRJ_NAME-$PRJ_ID --billing-account $BILLING_ID
gcloud services enable compute.googleapis.com --project $PRJ_NAME-$PRJ_ID
