{
 "cells": [
  {
   "cell_type": "markdown",
   "id": "eab284cc",
   "metadata": {
    "papermill": {
     "duration": 0.082424,
     "end_time": "2022-03-06T05:01:33.074116",
     "exception": false,
     "start_time": "2022-03-06T05:01:32.991692",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# **Google Data Analytics Capstone Project**\n",
    "\n",
    "\n",
    "Organized by: Tibebu Sime\n",
    "\n",
    "Date: 03/05/2022"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "6325ce9d",
   "metadata": {
    "papermill": {
     "duration": 0.081213,
     "end_time": "2022-03-06T05:01:33.236430",
     "exception": false,
     "start_time": "2022-03-06T05:01:33.155217",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "\n",
    "\n",
    "### **Objective**\n",
    "\n",
    "This capstone project is a part of the Google Data Analytics Professional Certification. The objective of this data analysis is to design marketing strategies aimed at converting casual riders into annual members. Casual riders are customers who purchase single-ride or full-day passes while members are customers who purchase annual memberships.\n",
    "Business Task\n",
    "The new marketing strategy requires us to understand the following three components: behavioral differences between annual members and casual riders, reasons why a casual rider would buy Cyclistic annual memberships, and how digital media can influence casual riders to become members. The marketing analytics team is tasked with using past historical trip data to find the behavioral differences between annual members and casual riders and report their findings to the key stakeholders.\n",
    "\n",
    "### **Stakeholders**\n",
    "\n",
    "1. ***Cyclistic***: A bike-share company based out of the City of Chicago that features more than 5800 bicycles and 600 docking stations.\n",
    "2. ***Lily Moreno***: The director of marketing department who is responsible for the development of campaigns and initiatives to promote the bike-share program through email, social media & other channels.\n",
    "3. ***Cyclistic Marketing Analytics Team***: A team of data analysts who are responsible for collecting, analyzing and reporting data that helps guide Cyclistic marketing strategy.\n",
    "4. ***Cyclistic Executive Team***: The detail-oriented executive team who will decide whether to approve the recommended marketing program. \n",
    "\n",
    "### **Data Source**\n",
    "\n",
    "The data has been made available by Motivate International Inc. & the City of Chicago under this [license](https://ride.divvybikes.com/data-license-agreement). This dataset contains the previous 12 months of trip data from Chicago's Divvy Ride Share Service for the period January to December 2021. The dataset can be downloaded from [here](https://divvy-tripdata.s3.amazonaws.com/index.html). All riders' personal information has been removed for privacy issues.\n",
    "\n",
    "### **Data Dictionary**\n",
    "\n",
    "1. `ride_id`: unique id of each ride\n",
    "2. `rideable_type`: category of bike type such as classic, electric and docked\n",
    "3. `started_at`: start time of ride\n",
    "4. `ended_at`: end time of ride\n",
    "5. `start_station_name`: name of station the ride started at\n",
    "6. `start_station_id`: unique id of station the ride started at\n",
    "7. `end_station_name`: name of station the ride ended at\n",
    "8. `end_station_id`: unique id of station the ride ended at\n",
    "9. `start_lat`: latitudinal coordinate of start station\n",
    "10. `start_lng`: longitudinal coordinate of start station\n",
    "11. `end_lat`: latitudinal coordinate of end station\n",
    "12. `end_lng`: longitudinal coordinate of end station\n",
    "13. `member_casual`: category of rider type (casual, member)\n"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "28579157",
   "metadata": {
    "papermill": {
     "duration": 0.080826,
     "end_time": "2022-03-06T05:01:33.398493",
     "exception": false,
     "start_time": "2022-03-06T05:01:33.317667",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# **A. Data Preparation and Cleaning**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "4d10f214",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2022-03-06T05:01:33.567176Z",
     "iopub.status.busy": "2022-03-06T05:01:33.566350Z",
     "iopub.status.idle": "2022-03-06T05:01:34.837915Z",
     "shell.execute_reply": "2022-03-06T05:01:34.837213Z"
    },
    "papermill": {
     "duration": 1.358305,
     "end_time": "2022-03-06T05:01:34.838060",
     "exception": false,
     "start_time": "2022-03-06T05:01:33.479755",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "── \u001b[1mAttaching packages\u001b[22m ─────────────────────────────────────── tidyverse 1.3.1 ──\n",
      "\n",
      "\u001b[32m✔\u001b[39m \u001b[34mggplot2\u001b[39m 3.3.5     \u001b[32m✔\u001b[39m \u001b[34mpurrr  \u001b[39m 0.3.4\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtibble \u001b[39m 3.1.5     \u001b[32m✔\u001b[39m \u001b[34mdplyr  \u001b[39m 1.0.7\n",
      "\u001b[32m✔\u001b[39m \u001b[34mtidyr  \u001b[39m 1.1.4     \u001b[32m✔\u001b[39m \u001b[34mstringr\u001b[39m 1.4.0\n",
      "\u001b[32m✔\u001b[39m \u001b[34mreadr  \u001b[39m 2.0.2     \u001b[32m✔\u001b[39m \u001b[34mforcats\u001b[39m 0.5.1\n",
      "\n",
      "── \u001b[1mConflicts\u001b[22m ────────────────────────────────────────── tidyverse_conflicts() ──\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mfilter()\u001b[39m masks \u001b[34mstats\u001b[39m::filter()\n",
      "\u001b[31m✖\u001b[39m \u001b[34mdplyr\u001b[39m::\u001b[32mlag()\u001b[39m    masks \u001b[34mstats\u001b[39m::lag()\n",
      "\n",
      "\n",
      "Attaching package: ‘lubridate’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:base’:\n",
      "\n",
      "    date, intersect, setdiff, union\n",
      "\n",
      "\n",
      "\n",
      "Attaching package: ‘janitor’\n",
      "\n",
      "\n",
      "The following objects are masked from ‘package:stats’:\n",
      "\n",
      "    chisq.test, fisher.test\n",
      "\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "'divvy-tripdata'"
      ],
      "text/latex": [
       "'divvy-tripdata'"
      ],
      "text/markdown": [
       "'divvy-tripdata'"
      ],
      "text/plain": [
       "[1] \"divvy-tripdata\""
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# This R environment comes with many helpful analytics packages installed\n",
    "# It is defined by the kaggle/rstats Docker image: https://github.com/kaggle/docker-rstats\n",
    "library(tidyverse) \n",
    "library(lubridate)\n",
    "library(janitor)\n",
    "\n",
    "\n",
    "# Input data files are available in the read-only \"../input/\" directory\n",
    "# For example, running this (by clicking run or pressing Shift+Enter) will list all files under the input directory\n",
    "list.files(path = \"../input\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "85225d2d",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:01:35.056441Z",
     "iopub.status.busy": "2022-03-06T05:01:35.027495Z",
     "iopub.status.idle": "2022-03-06T05:01:39.961077Z",
     "shell.execute_reply": "2022-03-06T05:01:39.959925Z"
    },
    "papermill": {
     "duration": 5.029155,
     "end_time": "2022-03-06T05:01:39.961225",
     "exception": false,
     "start_time": "2022-03-06T05:01:34.932070",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m96834\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m49622\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m228496\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m337230\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m531633\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m729595\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m822410\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m804352\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m756147\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m631226\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m359978\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n",
      "\u001b[1m\u001b[1mRows: \u001b[1m\u001b[22m\u001b[34m\u001b[34m247540\u001b[34m\u001b[39m \u001b[1m\u001b[1mColumns: \u001b[1m\u001b[22m\u001b[34m\u001b[34m13\u001b[34m\u001b[39m\n",
      "\n",
      "\u001b[36m──\u001b[39m \u001b[1m\u001b[1mColumn specification\u001b[1m\u001b[22m \u001b[36m────────────────────────────────────────────────────────\u001b[39m\n",
      "\u001b[1mDelimiter:\u001b[22m \",\"\n",
      "\u001b[31mchr\u001b[39m  (7): ride_id, rideable_type, start_station_name, start_station_id, end_...\n",
      "\u001b[32mdbl\u001b[39m  (4): start_lat, start_lng, end_lat, end_lng\n",
      "\u001b[34mdttm\u001b[39m (2): started_at, ended_at\n",
      "\n",
      "\n",
      "\u001b[36mℹ\u001b[39m Use \u001b[30m\u001b[47m\u001b[30m\u001b[47m`spec()`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to retrieve the full column specification for this data.\n",
      "\u001b[36mℹ\u001b[39m Specify the column types or set \u001b[30m\u001b[47m\u001b[30m\u001b[47m`show_col_types = FALSE`\u001b[47m\u001b[30m\u001b[49m\u001b[39m to quiet this message.\n",
      "\n"
     ]
    }
   ],
   "source": [
    "# Read the previous 12 months of the Cyclistic trip data \n",
    "tripdata1 <- read_csv(\"../input/divvy-tripdata/202101-divvy-tripdata.csv\")\n",
    "tripdata2 <- read_csv(\"../input/divvy-tripdata/202102-divvy-tripdata.csv\")\n",
    "tripdata3 <- read_csv(\"../input/divvy-tripdata/202103-divvy-tripdata.csv\")\n",
    "tripdata4 <- read_csv(\"../input/divvy-tripdata/202104-divvy-tripdata.csv\")\n",
    "tripdata5 <- read_csv(\"../input/divvy-tripdata/202105-divvy-tripdata.csv\")\n",
    "tripdata6 <- read_csv(\"../input/divvy-tripdata/202106-divvy-tripdata.csv\")\n",
    "tripdata7 <- read_csv(\"../input/divvy-tripdata/202107-divvy-tripdata.csv\")\n",
    "tripdata8 <- read_csv(\"../input/divvy-tripdata/202108-divvy-tripdata.csv\")\n",
    "tripdata9 <- read_csv(\"../input/divvy-tripdata/202109-divvy-tripdata.csv\")\n",
    "tripdata10 <- read_csv(\"../input/divvy-tripdata/202110-divvy-tripdata.csv\")\n",
    "tripdata11 <- read_csv(\"../input/divvy-tripdata/202111-divvy-tripdata.csv\")\n",
    "tripdata12 <- read_csv(\"../input/divvy-tripdata/202112-divvy-tripdata.csv\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 3,
   "id": "a133733f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:01:40.212268Z",
     "iopub.status.busy": "2022-03-06T05:01:40.210880Z",
     "iopub.status.idle": "2022-03-06T05:02:03.538098Z",
     "shell.execute_reply": "2022-03-06T05:02:03.536309Z"
    },
    "papermill": {
     "duration": 23.462175,
     "end_time": "2022-03-06T05:02:03.538310",
     "exception": false,
     "start_time": "2022-03-06T05:01:40.076135",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Combine the datasets into one using the bind_rows() from the dplyr package\n",
    "tripdata <- bind_rows(tripdata1,\n",
    "                      tripdata2,\n",
    "                      tripdata3,\n",
    "                      tripdata4,\n",
    "                      tripdata5,\n",
    "                      tripdata6,\n",
    "                      tripdata7,\n",
    "                      tripdata8,\n",
    "                      tripdata9,\n",
    "                      tripdata10,\n",
    "                      tripdata11,\n",
    "                      tripdata12)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 4,
   "id": "c63f3b9f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:03.771109Z",
     "iopub.status.busy": "2022-03-06T05:02:03.769147Z",
     "iopub.status.idle": "2022-03-06T05:02:03.802821Z",
     "shell.execute_reply": "2022-03-06T05:02:03.801057Z"
    },
    "papermill": {
     "duration": 0.150536,
     "end_time": "2022-03-06T05:02:03.802970",
     "exception": false,
     "start_time": "2022-03-06T05:02:03.652434",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 2 × 13</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>ride_id</th><th scope=col>rideable_type</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>start_station_name</th><th scope=col>start_station_id</th><th scope=col>end_station_name</th><th scope=col>end_station_id</th><th scope=col>start_lat</th><th scope=col>start_lng</th><th scope=col>end_lat</th><th scope=col>end_lng</th><th scope=col>member_casual</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>E19E6F1B8D4C42ED</td><td>electric_bike</td><td>2021-01-23 16:14:19</td><td>2021-01-23 16:24:44</td><td>California Ave &amp; Cortez St</td><td>17660</td><td>NA</td><td>NA</td><td>41.90034</td><td>-87.69674</td><td>41.89</td><td>-87.72</td><td>member</td></tr>\n",
       "\t<tr><td>DC88F20C2C55F27F</td><td>electric_bike</td><td>2021-01-27 18:43:08</td><td>2021-01-27 18:47:12</td><td>California Ave &amp; Cortez St</td><td>17660</td><td>NA</td><td>NA</td><td>41.90033</td><td>-87.69671</td><td>41.90</td><td>-87.69</td><td>member</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 2 × 13\n",
       "\\begin{tabular}{lllllllllllll}\n",
       " ride\\_id & rideable\\_type & started\\_at & ended\\_at & start\\_station\\_name & start\\_station\\_id & end\\_station\\_name & end\\_station\\_id & start\\_lat & start\\_lng & end\\_lat & end\\_lng & member\\_casual\\\\\n",
       " <chr> & <chr> & <dttm> & <dttm> & <chr> & <chr> & <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\t E19E6F1B8D4C42ED & electric\\_bike & 2021-01-23 16:14:19 & 2021-01-23 16:24:44 & California Ave \\& Cortez St & 17660 & NA & NA & 41.90034 & -87.69674 & 41.89 & -87.72 & member\\\\\n",
       "\t DC88F20C2C55F27F & electric\\_bike & 2021-01-27 18:43:08 & 2021-01-27 18:47:12 & California Ave \\& Cortez St & 17660 & NA & NA & 41.90033 & -87.69671 & 41.90 & -87.69 & member\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 2 × 13\n",
       "\n",
       "| ride_id &lt;chr&gt; | rideable_type &lt;chr&gt; | started_at &lt;dttm&gt; | ended_at &lt;dttm&gt; | start_station_name &lt;chr&gt; | start_station_id &lt;chr&gt; | end_station_name &lt;chr&gt; | end_station_id &lt;chr&gt; | start_lat &lt;dbl&gt; | start_lng &lt;dbl&gt; | end_lat &lt;dbl&gt; | end_lng &lt;dbl&gt; | member_casual &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| E19E6F1B8D4C42ED | electric_bike | 2021-01-23 16:14:19 | 2021-01-23 16:24:44 | California Ave &amp; Cortez St | 17660 | NA | NA | 41.90034 | -87.69674 | 41.89 | -87.72 | member |\n",
       "| DC88F20C2C55F27F | electric_bike | 2021-01-27 18:43:08 | 2021-01-27 18:47:12 | California Ave &amp; Cortez St | 17660 | NA | NA | 41.90033 | -87.69671 | 41.90 | -87.69 | member |\n",
       "\n"
      ],
      "text/plain": [
       "  ride_id          rideable_type started_at          ended_at           \n",
       "1 E19E6F1B8D4C42ED electric_bike 2021-01-23 16:14:19 2021-01-23 16:24:44\n",
       "2 DC88F20C2C55F27F electric_bike 2021-01-27 18:43:08 2021-01-27 18:47:12\n",
       "  start_station_name         start_station_id end_station_name end_station_id\n",
       "1 California Ave & Cortez St 17660            NA               NA            \n",
       "2 California Ave & Cortez St 17660            NA               NA            \n",
       "  start_lat start_lng end_lat end_lng member_casual\n",
       "1 41.90034  -87.69674 41.89   -87.72  member       \n",
       "2 41.90033  -87.69671 41.90   -87.69  member       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Quick overview of the dataset\n",
    "head(tripdata, 2)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 5,
   "id": "6db116c6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:04.041054Z",
     "iopub.status.busy": "2022-03-06T05:02:04.039075Z",
     "iopub.status.idle": "2022-03-06T05:02:06.401598Z",
     "shell.execute_reply": "2022-03-06T05:02:06.399980Z"
    },
    "papermill": {
     "duration": 2.482989,
     "end_time": "2022-03-06T05:02:06.401739",
     "exception": false,
     "start_time": "2022-03-06T05:02:03.918750",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 12</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>rideable_type</th><th scope=col>started_at</th><th scope=col>ended_at</th><th scope=col>start_station_name</th><th scope=col>start_station_id</th><th scope=col>end_station_name</th><th scope=col>end_station_id</th><th scope=col>start_lat</th><th scope=col>start_lng</th><th scope=col>end_lat</th><th scope=col>end_lng</th><th scope=col>member_casual</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;chr&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>E19E6F1B8D4C42ED</th><td>electric_bike</td><td>2021-01-23 16:14:19</td><td>2021-01-23 16:24:44</td><td>California Ave &amp; Cortez St</td><td>17660</td><td>NA</td><td>NA</td><td>41.90034</td><td>-87.69674</td><td>41.89</td><td>-87.72</td><td>member</td></tr>\n",
       "\t<tr><th scope=row>DC88F20C2C55F27F</th><td>electric_bike</td><td>2021-01-27 18:43:08</td><td>2021-01-27 18:47:12</td><td>California Ave &amp; Cortez St</td><td>17660</td><td>NA</td><td>NA</td><td>41.90033</td><td>-87.69671</td><td>41.90</td><td>-87.69</td><td>member</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 12\n",
       "\\begin{tabular}{r|llllllllllll}\n",
       "  & rideable\\_type & started\\_at & ended\\_at & start\\_station\\_name & start\\_station\\_id & end\\_station\\_name & end\\_station\\_id & start\\_lat & start\\_lng & end\\_lat & end\\_lng & member\\_casual\\\\\n",
       "  & <chr> & <dttm> & <dttm> & <chr> & <chr> & <chr> & <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <chr>\\\\\n",
       "\\hline\n",
       "\tE19E6F1B8D4C42ED & electric\\_bike & 2021-01-23 16:14:19 & 2021-01-23 16:24:44 & California Ave \\& Cortez St & 17660 & NA & NA & 41.90034 & -87.69674 & 41.89 & -87.72 & member\\\\\n",
       "\tDC88F20C2C55F27F & electric\\_bike & 2021-01-27 18:43:08 & 2021-01-27 18:47:12 & California Ave \\& Cortez St & 17660 & NA & NA & 41.90033 & -87.69671 & 41.90 & -87.69 & member\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 12\n",
       "\n",
       "| <!--/--> | rideable_type &lt;chr&gt; | started_at &lt;dttm&gt; | ended_at &lt;dttm&gt; | start_station_name &lt;chr&gt; | start_station_id &lt;chr&gt; | end_station_name &lt;chr&gt; | end_station_id &lt;chr&gt; | start_lat &lt;dbl&gt; | start_lng &lt;dbl&gt; | end_lat &lt;dbl&gt; | end_lng &lt;dbl&gt; | member_casual &lt;chr&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| E19E6F1B8D4C42ED | electric_bike | 2021-01-23 16:14:19 | 2021-01-23 16:24:44 | California Ave &amp; Cortez St | 17660 | NA | NA | 41.90034 | -87.69674 | 41.89 | -87.72 | member |\n",
       "| DC88F20C2C55F27F | electric_bike | 2021-01-27 18:43:08 | 2021-01-27 18:47:12 | California Ave &amp; Cortez St | 17660 | NA | NA | 41.90033 | -87.69671 | 41.90 | -87.69 | member |\n",
       "\n"
      ],
      "text/plain": [
       "                 rideable_type started_at          ended_at           \n",
       "E19E6F1B8D4C42ED electric_bike 2021-01-23 16:14:19 2021-01-23 16:24:44\n",
       "DC88F20C2C55F27F electric_bike 2021-01-27 18:43:08 2021-01-27 18:47:12\n",
       "                 start_station_name         start_station_id end_station_name\n",
       "E19E6F1B8D4C42ED California Ave & Cortez St 17660            NA              \n",
       "DC88F20C2C55F27F California Ave & Cortez St 17660            NA              \n",
       "                 end_station_id start_lat start_lng end_lat end_lng\n",
       "E19E6F1B8D4C42ED NA             41.90034  -87.69674 41.89   -87.72 \n",
       "DC88F20C2C55F27F NA             41.90033  -87.69671 41.90   -87.69 \n",
       "                 member_casual\n",
       "E19E6F1B8D4C42ED member       \n",
       "DC88F20C2C55F27F member       "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Set the column ride_id as row names\n",
    "# https://stackoverflow.com/questions/20643166/set-a-data-frame-column-as-the-index-of-r-data-frame-object\n",
    "tripdata <- tripdata %>% column_to_rownames(var = \"ride_id\")\n",
    "head(tripdata, 2)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 6,
   "id": "12e67c97",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:06.642446Z",
     "iopub.status.busy": "2022-03-06T05:02:06.640487Z",
     "iopub.status.idle": "2022-03-06T05:02:12.307208Z",
     "shell.execute_reply": "2022-03-06T05:02:12.305526Z"
    },
    "papermill": {
     "duration": 5.788443,
     "end_time": "2022-03-06T05:02:12.307378",
     "exception": false,
     "start_time": "2022-03-06T05:02:06.518935",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Remove duplicate values\n",
    "tripdata <- distinct(tripdata)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 7,
   "id": "92a1db76",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:12.546571Z",
     "iopub.status.busy": "2022-03-06T05:02:12.544628Z",
     "iopub.status.idle": "2022-03-06T05:02:23.933565Z",
     "shell.execute_reply": "2022-03-06T05:02:23.932157Z"
    },
    "papermill": {
     "duration": 11.509814,
     "end_time": "2022-03-06T05:02:23.933739",
     "exception": false,
     "start_time": "2022-03-06T05:02:12.423925",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Remove missing values - all the three codes do the same thing \n",
    "tripdata <- drop_na(tripdata) # from tydr packagere\n",
    "tripdata <- remove_missing(tripdata) # from ggplot2 package\n",
    "tripdata <- remove_empty(tripdata, which = c(\"rows\", \"cols\"), quiet = TRUE)  # from janitor package"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "626e0058",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:24.176507Z",
     "iopub.status.busy": "2022-03-06T05:02:24.175082Z",
     "iopub.status.idle": "2022-03-06T05:02:24.191691Z",
     "shell.execute_reply": "2022-03-06T05:02:24.190189Z"
    },
    "papermill": {
     "duration": 0.139218,
     "end_time": "2022-03-06T05:02:24.191831",
     "exception": false,
     "start_time": "2022-03-06T05:02:24.052613",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<style>\n",
       ".list-inline {list-style: none; margin:0; padding: 0}\n",
       ".list-inline>li {display: inline-block}\n",
       ".list-inline>li:not(:last-child)::after {content: \"\\00b7\"; padding: 0 .5ex}\n",
       "</style>\n",
       "<ol class=list-inline><li>'rideable_type'</li><li>'started_at'</li><li>'ended_at'</li><li>'start_station_name'</li><li>'start_station_id'</li><li>'end_station_name'</li><li>'end_station_id'</li><li>'start_lat'</li><li>'start_lng'</li><li>'end_lat'</li><li>'end_lng'</li><li>'member_casual'</li></ol>\n"
      ],
      "text/latex": [
       "\\begin{enumerate*}\n",
       "\\item 'rideable\\_type'\n",
       "\\item 'started\\_at'\n",
       "\\item 'ended\\_at'\n",
       "\\item 'start\\_station\\_name'\n",
       "\\item 'start\\_station\\_id'\n",
       "\\item 'end\\_station\\_name'\n",
       "\\item 'end\\_station\\_id'\n",
       "\\item 'start\\_lat'\n",
       "\\item 'start\\_lng'\n",
       "\\item 'end\\_lat'\n",
       "\\item 'end\\_lng'\n",
       "\\item 'member\\_casual'\n",
       "\\end{enumerate*}\n"
      ],
      "text/markdown": [
       "1. 'rideable_type'\n",
       "2. 'started_at'\n",
       "3. 'ended_at'\n",
       "4. 'start_station_name'\n",
       "5. 'start_station_id'\n",
       "6. 'end_station_name'\n",
       "7. 'end_station_id'\n",
       "8. 'start_lat'\n",
       "9. 'start_lng'\n",
       "10. 'end_lat'\n",
       "11. 'end_lng'\n",
       "12. 'member_casual'\n",
       "\n",
       "\n"
      ],
      "text/plain": [
       " [1] \"rideable_type\"      \"started_at\"         \"ended_at\"          \n",
       " [4] \"start_station_name\" \"start_station_id\"   \"end_station_name\"  \n",
       " [7] \"end_station_id\"     \"start_lat\"          \"start_lng\"         \n",
       "[10] \"end_lat\"            \"end_lng\"            \"member_casual\"     "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Check the list of column names\n",
    "colnames(tripdata)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ef9ffbd2",
   "metadata": {
    "papermill": {
     "duration": 0.11864,
     "end_time": "2022-03-06T05:02:24.430123",
     "exception": false,
     "start_time": "2022-03-06T05:02:24.311483",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# **B. Data Transformation & Feature Engineering**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 9,
   "id": "bdc5a1cc",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:24.676855Z",
     "iopub.status.busy": "2022-03-06T05:02:24.675293Z",
     "iopub.status.idle": "2022-03-06T05:02:44.549884Z",
     "shell.execute_reply": "2022-03-06T05:02:44.548568Z"
    },
    "papermill": {
     "duration": 19.999931,
     "end_time": "2022-03-06T05:02:44.550077",
     "exception": false,
     "start_time": "2022-03-06T05:02:24.550146",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# https://shanghai.hosting.nyu.edu/data/r/dates-and-times.html\n",
    "# https://rdrr.io/r/base/strptime.html\n",
    "# https://stackoverflow.com/questions/9839343/extracting-time-from-posixct\n",
    "# https://www.marsja.se/how-to-extract-time-from-datetime-in-r-with-examples/\n",
    "# https://stackoverflow.com/questions/9216138/find-the-day-of-a-week\n",
    "\n",
    "tripdata <- tripdata %>% mutate(date = strftime(started_at, format = \"%Y-%m-%d\"),\n",
    "                                month = strftime(started_at, format = \"%B\"),\n",
    "                                day = strftime(started_at, format = \"%d\"),\n",
    "                                year = strftime(started_at, format = \"%Y\"),\n",
    "                                weekday = strftime(started_at, format = \"%A\"),\n",
    "                                time = strftime(started_at, format = \"%H:%M\"))\n",
    "\n",
    "tripdata$date <- as.Date(tripdata$date)\n",
    "tripdata$time <- as.POSIXct(tripdata$time, format=\"%H:%M\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "520c29d2",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:44.792929Z",
     "iopub.status.busy": "2022-03-06T05:02:44.791626Z",
     "iopub.status.idle": "2022-03-06T05:02:44.841962Z",
     "shell.execute_reply": "2022-03-06T05:02:44.840730Z"
    },
    "papermill": {
     "duration": 0.173013,
     "end_time": "2022-03-06T05:02:44.842101",
     "exception": false,
     "start_time": "2022-03-06T05:02:44.669088",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t4587805 obs. of  18 variables:\n",
      " $ rideable_type     : chr  \"classic_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at        : POSIXct, format: \"2021-01-24 19:15:38\" \"2021-01-23 12:57:38\" ...\n",
      " $ ended_at          : POSIXct, format: \"2021-01-24 19:22:51\" \"2021-01-23 13:02:10\" ...\n",
      " $ start_station_name: chr  \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" \"California Ave & Cortez St\" ...\n",
      " $ start_station_id  : chr  \"17660\" \"17660\" \"17660\" \"17660\" ...\n",
      " $ end_station_name  : chr  \"Wood St & Augusta Blvd\" \"California Ave & North Ave\" \"Wood St & Augusta Blvd\" \"Wood St & Augusta Blvd\" ...\n",
      " $ end_station_id    : chr  \"657\" \"13258\" \"657\" \"657\" ...\n",
      " $ start_lat         : num  41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ start_lng         : num  -87.7 -87.7 -87.7 -87.7 -87.7 ...\n",
      " $ end_lat           : num  41.9 41.9 41.9 41.9 41.9 ...\n",
      " $ end_lng           : num  -87.7 -87.7 -87.7 -87.7 -87.7 ...\n",
      " $ member_casual     : chr  \"member\" \"member\" \"casual\" \"casual\" ...\n",
      " $ date              : Date, format: \"2021-01-24\" \"2021-01-23\" ...\n",
      " $ month             : chr  \"January\" \"January\" \"January\" \"January\" ...\n",
      " $ day               : chr  \"24\" \"23\" \"09\" \"09\" ...\n",
      " $ year              : chr  \"2021\" \"2021\" \"2021\" \"2021\" ...\n",
      " $ weekday           : chr  \"Sunday\" \"Saturday\" \"Saturday\" \"Saturday\" ...\n",
      " $ time              : POSIXct, format: \"2022-03-06 19:15:00\" \"2022-03-06 12:57:00\" ...\n"
     ]
    }
   ],
   "source": [
    "# Now check the structure of the columns\n",
    "str(tripdata)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 11,
   "id": "fea6325f",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:45.089505Z",
     "iopub.status.busy": "2022-03-06T05:02:45.087858Z",
     "iopub.status.idle": "2022-03-06T05:02:45.145296Z",
     "shell.execute_reply": "2022-03-06T05:02:45.143959Z"
    },
    "papermill": {
     "duration": 0.181497,
     "end_time": "2022-03-06T05:02:45.145436",
     "exception": false,
     "start_time": "2022-03-06T05:02:44.963939",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Select only columns necessary for our data analysis, and calculate the length of ride started\n",
    "# different stations\n",
    "tripdata <- tripdata %>% \n",
    "  select(rideable_type, started_at, ended_at, member_casual, date, month, day, year, weekday, time) %>% \n",
    "  mutate(ride_length = ended_at-started_at)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 12,
   "id": "6d3e9406",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:45.390587Z",
     "iopub.status.busy": "2022-03-06T05:02:45.388695Z",
     "iopub.status.idle": "2022-03-06T05:02:45.428407Z",
     "shell.execute_reply": "2022-03-06T05:02:45.426332Z"
    },
    "papermill": {
     "duration": 0.163692,
     "end_time": "2022-03-06T05:02:45.428561",
     "exception": false,
     "start_time": "2022-03-06T05:02:45.264869",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t4587805 obs. of  11 variables:\n",
      " $ rideable_type: chr  \"classic_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at   : POSIXct, format: \"2021-01-24 19:15:38\" \"2021-01-23 12:57:38\" ...\n",
      " $ ended_at     : POSIXct, format: \"2021-01-24 19:22:51\" \"2021-01-23 13:02:10\" ...\n",
      " $ member_casual: chr  \"member\" \"member\" \"casual\" \"casual\" ...\n",
      " $ date         : Date, format: \"2021-01-24\" \"2021-01-23\" ...\n",
      " $ month        : chr  \"January\" \"January\" \"January\" \"January\" ...\n",
      " $ day          : chr  \"24\" \"23\" \"09\" \"09\" ...\n",
      " $ year         : chr  \"2021\" \"2021\" \"2021\" \"2021\" ...\n",
      " $ weekday      : chr  \"Sunday\" \"Saturday\" \"Saturday\" \"Saturday\" ...\n",
      " $ time         : POSIXct, format: \"2022-03-06 19:15:00\" \"2022-03-06 12:57:00\" ...\n",
      " $ ride_length  : 'difftime' num  433 272 587 537 ...\n",
      "  ..- attr(*, \"units\")= chr \"secs\"\n"
     ]
    }
   ],
   "source": [
    "# Inspect the structure of the selected columns again\n",
    "str(tripdata)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 13,
   "id": "66d145b4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:45.680038Z",
     "iopub.status.busy": "2022-03-06T05:02:45.677952Z",
     "iopub.status.idle": "2022-03-06T05:02:45.701450Z",
     "shell.execute_reply": "2022-03-06T05:02:45.699871Z"
    },
    "papermill": {
     "duration": 0.150344,
     "end_time": "2022-03-06T05:02:45.701640",
     "exception": false,
     "start_time": "2022-03-06T05:02:45.551296",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Convert ride_length from Factor to numeric so that we can run calculations on the data\n",
    "tripdata$ride_length <- as.double(tripdata$ride_length)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 14,
   "id": "0c47235a",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:45.951930Z",
     "iopub.status.busy": "2022-03-06T05:02:45.950505Z",
     "iopub.status.idle": "2022-03-06T05:02:45.987733Z",
     "shell.execute_reply": "2022-03-06T05:02:45.986199Z"
    },
    "papermill": {
     "duration": 0.16289,
     "end_time": "2022-03-06T05:02:45.987897",
     "exception": false,
     "start_time": "2022-03-06T05:02:45.825007",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stdout",
     "output_type": "stream",
     "text": [
      "'data.frame':\t4587805 obs. of  11 variables:\n",
      " $ rideable_type: chr  \"classic_bike\" \"electric_bike\" \"electric_bike\" \"electric_bike\" ...\n",
      " $ started_at   : POSIXct, format: \"2021-01-24 19:15:38\" \"2021-01-23 12:57:38\" ...\n",
      " $ ended_at     : POSIXct, format: \"2021-01-24 19:22:51\" \"2021-01-23 13:02:10\" ...\n",
      " $ member_casual: chr  \"member\" \"member\" \"casual\" \"casual\" ...\n",
      " $ date         : Date, format: \"2021-01-24\" \"2021-01-23\" ...\n",
      " $ month        : chr  \"January\" \"January\" \"January\" \"January\" ...\n",
      " $ day          : chr  \"24\" \"23\" \"09\" \"09\" ...\n",
      " $ year         : chr  \"2021\" \"2021\" \"2021\" \"2021\" ...\n",
      " $ weekday      : chr  \"Sunday\" \"Saturday\" \"Saturday\" \"Saturday\" ...\n",
      " $ time         : POSIXct, format: \"2022-03-06 19:15:00\" \"2022-03-06 12:57:00\" ...\n",
      " $ ride_length  : num  433 272 587 537 609 ...\n"
     ]
    }
   ],
   "source": [
    "# Inspect the structure of the selected and manipulated columns again\n",
    "str(tripdata)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "bc4b3329",
   "metadata": {
    "papermill": {
     "duration": 0.122419,
     "end_time": "2022-03-06T05:02:46.231932",
     "exception": false,
     "start_time": "2022-03-06T05:02:46.109513",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**Remove bad data or outliers**\n",
    "\n",
    "The dataframe includes a hundred entries when bikes were taken out docks and checked for quality by Cyclistic. Negative rides and rides longer than 1 day or 1440 minutes or 86400 seconds should be filtered out."
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 15,
   "id": "2a8ee425",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:46.483101Z",
     "iopub.status.busy": "2022-03-06T05:02:46.482511Z",
     "iopub.status.idle": "2022-03-06T05:02:48.467155Z",
     "shell.execute_reply": "2022-03-06T05:02:48.465973Z"
    },
    "papermill": {
     "duration": 2.110195,
     "end_time": "2022-03-06T05:02:48.467288",
     "exception": false,
     "start_time": "2022-03-06T05:02:46.357093",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "tripdata <- filter(tripdata, ride_length > 0 & ride_length <= 86400)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 16,
   "id": "8e5f9dc3",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:48.716364Z",
     "iopub.status.busy": "2022-03-06T05:02:48.714912Z",
     "iopub.status.idle": "2022-03-06T05:02:48.731956Z",
     "shell.execute_reply": "2022-03-06T05:02:48.730526Z"
    },
    "papermill": {
     "duration": 0.142144,
     "end_time": "2022-03-06T05:02:48.732095",
     "exception": false,
     "start_time": "2022-03-06T05:02:48.589951",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Rename the column names for better readability\n",
    "tripdata <- tripdata %>% rename(bike_type = rideable_type, \n",
    "                                customer_type = member_casual,\n",
    "                                start_time = started_at,\n",
    "                                end_time = ended_at)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 17,
   "id": "64081d0b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:48.981531Z",
     "iopub.status.busy": "2022-03-06T05:02:48.979949Z",
     "iopub.status.idle": "2022-03-06T05:02:49.185243Z",
     "shell.execute_reply": "2022-03-06T05:02:49.183838Z"
    },
    "papermill": {
     "duration": 0.331614,
     "end_time": "2022-03-06T05:02:49.185399",
     "exception": false,
     "start_time": "2022-03-06T05:02:48.853785",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Since the days of week are out of order, we need to convert them to an ordered factor \n",
    "# so that our data analysis will be consistent.\n",
    "# https://stackoverflow.com/questions/10309564/reorder-factor-levels-by-day-of-the-week-in-r\n",
    "\n",
    "tripdata$weekday <- ordered(tripdata$weekday, levels=c(\"Monday\", \n",
    "                                                       \"Tuesday\", \n",
    "                                                       \"Wednesday\",\n",
    "                                                       \"Thursday\", \n",
    "                                                       \"Friday\", \n",
    "                                                       \"Saturday\", \n",
    "                                                       \"Sunday\"))\n",
    "\n",
    "\n",
    "tripdata$month <- ordered(tripdata$month, levels=c(\"January\", \n",
    "                                                   \"February\", \n",
    "                                                   \"March\", \n",
    "                                                   \"April\",\n",
    "                                                   \"May\", \n",
    "                                                   \"June\", \n",
    "                                                   \"July\", \n",
    "                                                   \"August\",\n",
    "                                                   \"September\",\n",
    "                                                   \"October\",\n",
    "                                                   \"November\", \n",
    "                                                   \"December\"))"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "57a2327b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:49.433061Z",
     "iopub.status.busy": "2022-03-06T05:02:49.431723Z",
     "iopub.status.idle": "2022-03-06T05:02:49.455663Z",
     "shell.execute_reply": "2022-03-06T05:02:49.454250Z"
    },
    "papermill": {
     "duration": 0.149424,
     "end_time": "2022-03-06T05:02:49.455809",
     "exception": false,
     "start_time": "2022-03-06T05:02:49.306385",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A data.frame: 2 × 11</caption>\n",
       "<thead>\n",
       "\t<tr><th></th><th scope=col>bike_type</th><th scope=col>start_time</th><th scope=col>end_time</th><th scope=col>customer_type</th><th scope=col>date</th><th scope=col>month</th><th scope=col>day</th><th scope=col>year</th><th scope=col>weekday</th><th scope=col>time</th><th scope=col>ride_length</th></tr>\n",
       "\t<tr><th></th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;date&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><th scope=row>B9F73448DFBE0D45</th><td>classic_bike </td><td>2021-01-24 19:15:38</td><td>2021-01-24 19:22:51</td><td>member</td><td>2021-01-24</td><td>January</td><td>24</td><td>2021</td><td>Sunday  </td><td>2022-03-06 19:15:00</td><td>433</td></tr>\n",
       "\t<tr><th scope=row>457C7F4B5D3DA135</th><td>electric_bike</td><td>2021-01-23 12:57:38</td><td>2021-01-23 13:02:10</td><td>member</td><td>2021-01-23</td><td>January</td><td>23</td><td>2021</td><td>Saturday</td><td>2022-03-06 12:57:00</td><td>272</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A data.frame: 2 × 11\n",
       "\\begin{tabular}{r|lllllllllll}\n",
       "  & bike\\_type & start\\_time & end\\_time & customer\\_type & date & month & day & year & weekday & time & ride\\_length\\\\\n",
       "  & <chr> & <dttm> & <dttm> & <chr> & <date> & <ord> & <chr> & <chr> & <ord> & <dttm> & <dbl>\\\\\n",
       "\\hline\n",
       "\tB9F73448DFBE0D45 & classic\\_bike  & 2021-01-24 19:15:38 & 2021-01-24 19:22:51 & member & 2021-01-24 & January & 24 & 2021 & Sunday   & 2022-03-06 19:15:00 & 433\\\\\n",
       "\t457C7F4B5D3DA135 & electric\\_bike & 2021-01-23 12:57:38 & 2021-01-23 13:02:10 & member & 2021-01-23 & January & 23 & 2021 & Saturday & 2022-03-06 12:57:00 & 272\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A data.frame: 2 × 11\n",
       "\n",
       "| <!--/--> | bike_type &lt;chr&gt; | start_time &lt;dttm&gt; | end_time &lt;dttm&gt; | customer_type &lt;chr&gt; | date &lt;date&gt; | month &lt;ord&gt; | day &lt;chr&gt; | year &lt;chr&gt; | weekday &lt;ord&gt; | time &lt;dttm&gt; | ride_length &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|---|---|---|---|\n",
       "| B9F73448DFBE0D45 | classic_bike  | 2021-01-24 19:15:38 | 2021-01-24 19:22:51 | member | 2021-01-24 | January | 24 | 2021 | Sunday   | 2022-03-06 19:15:00 | 433 |\n",
       "| 457C7F4B5D3DA135 | electric_bike | 2021-01-23 12:57:38 | 2021-01-23 13:02:10 | member | 2021-01-23 | January | 23 | 2021 | Saturday | 2022-03-06 12:57:00 | 272 |\n",
       "\n"
      ],
      "text/plain": [
       "                 bike_type     start_time          end_time           \n",
       "B9F73448DFBE0D45 classic_bike  2021-01-24 19:15:38 2021-01-24 19:22:51\n",
       "457C7F4B5D3DA135 electric_bike 2021-01-23 12:57:38 2021-01-23 13:02:10\n",
       "                 customer_type date       month   day year weekday \n",
       "B9F73448DFBE0D45 member        2021-01-24 January 24  2021 Sunday  \n",
       "457C7F4B5D3DA135 member        2021-01-23 January 23  2021 Saturday\n",
       "                 time                ride_length\n",
       "B9F73448DFBE0D45 2022-03-06 19:15:00 433        \n",
       "457C7F4B5D3DA135 2022-03-06 12:57:00 272        "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Quick overview\n",
    "head(tripdata, 2)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c710611f",
   "metadata": {
    "papermill": {
     "duration": 0.123694,
     "end_time": "2022-03-06T05:02:49.703459",
     "exception": false,
     "start_time": "2022-03-06T05:02:49.579765",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# **C. Data Analysis**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 19,
   "id": "b0988750",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:49.958176Z",
     "iopub.status.busy": "2022-03-06T05:02:49.956283Z",
     "iopub.status.idle": "2022-03-06T05:02:50.743963Z",
     "shell.execute_reply": "2022-03-06T05:02:50.742650Z"
    },
    "papermill": {
     "duration": 0.914675,
     "end_time": "2022-03-06T05:02:50.744087",
     "exception": false,
     "start_time": "2022-03-06T05:02:49.829412",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       " casual  member \n",
       "2046738 2539594 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Check the number of each customer type \n",
    "table(tripdata$customer_type)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 20,
   "id": "eb6ed87c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:50.999389Z",
     "iopub.status.busy": "2022-03-06T05:02:50.998261Z",
     "iopub.status.idle": "2022-03-06T05:02:51.741795Z",
     "shell.execute_reply": "2022-03-06T05:02:51.740458Z"
    },
    "papermill": {
     "duration": 0.873564,
     "end_time": "2022-03-06T05:02:51.741939",
     "exception": false,
     "start_time": "2022-03-06T05:02:50.868375",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "\n",
       " casual  member \n",
       "44.6269 55.3731 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Let us check the proportion of annual members and casual riders in percentage\n",
    "table(tripdata$customer_type)/nrow(tripdata)*100"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 21,
   "id": "85cded97",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:51.997904Z",
     "iopub.status.busy": "2022-03-06T05:02:51.996433Z",
     "iopub.status.idle": "2022-03-06T05:02:52.286503Z",
     "shell.execute_reply": "2022-03-06T05:02:52.285196Z"
    },
    "papermill": {
     "duration": 0.419918,
     "end_time": "2022-03-06T05:02:52.286651",
     "exception": false,
     "start_time": "2022-03-06T05:02:51.866733",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/plain": [
       "   Min. 1st Qu.  Median    Mean 3rd Qu.    Max. \n",
       "      1     417     732    1193    1326   86362 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Show the statistical summary of the trip duration for all riders\n",
    "summary(tripdata$ride_length)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 22,
   "id": "6b72bbcd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:52.543016Z",
     "iopub.status.busy": "2022-03-06T05:02:52.541612Z",
     "iopub.status.idle": "2022-03-06T05:02:54.147728Z",
     "shell.execute_reply": "2022-03-06T05:02:54.146141Z"
    },
    "papermill": {
     "duration": 1.735846,
     "end_time": "2022-03-06T05:02:54.147871",
     "exception": false,
     "start_time": "2022-03-06T05:02:52.412025",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A tibble: 2 × 6</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>customer_type</th><th scope=col>min_ride</th><th scope=col>max_ride</th><th scope=col>mid_ride</th><th scope=col>avg_ride</th><th scope=col>total_ride</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>1</td><td>86362</td><td>999</td><td>1692.634</td><td>3464378199</td></tr>\n",
       "\t<tr><td>member</td><td>1</td><td>85594</td><td>583</td><td> 790.487</td><td>2007515928</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A tibble: 2 × 6\n",
       "\\begin{tabular}{llllll}\n",
       " customer\\_type & min\\_ride & max\\_ride & mid\\_ride & avg\\_ride & total\\_ride\\\\\n",
       " <chr> & <dbl> & <dbl> & <dbl> & <dbl> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 1 & 86362 & 999 & 1692.634 & 3464378199\\\\\n",
       "\t member & 1 & 85594 & 583 &  790.487 & 2007515928\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A tibble: 2 × 6\n",
       "\n",
       "| customer_type &lt;chr&gt; | min_ride &lt;dbl&gt; | max_ride &lt;dbl&gt; | mid_ride &lt;dbl&gt; | avg_ride &lt;dbl&gt; | total_ride &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|\n",
       "| casual | 1 | 86362 | 999 | 1692.634 | 3464378199 |\n",
       "| member | 1 | 85594 | 583 |  790.487 | 2007515928 |\n",
       "\n"
      ],
      "text/plain": [
       "  customer_type min_ride max_ride mid_ride avg_ride total_ride\n",
       "1 casual        1        86362    999      1692.634 3464378199\n",
       "2 member        1        85594    583       790.487 2007515928"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Compare members and casual riders using min, max and average of trip duration\n",
    "tripdata %>% \n",
    "  group_by(customer_type) %>% \n",
    "  summarize(min_ride = min(ride_length, na.rm = TRUE),\n",
    "            max_ride = max(ride_length, na.rm = TRUE),\n",
    "            mid_ride = median(ride_length, na.rm = TRUE),\n",
    "            avg_ride = mean(ride_length, na.rm = TRUE),\n",
    "            total_ride = sum(ride_length, na.rm = TRUE))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8dbf26eb",
   "metadata": {
    "papermill": {
     "duration": 0.127896,
     "end_time": "2022-03-06T05:02:54.405669",
     "exception": false,
     "start_time": "2022-03-06T05:02:54.277773",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "From the above statistical summary of the trip duration for all customers and by the customer type, we can see that the average trip duration for the member riders is lower than the average trip duration for all riders while the avg trip duration of the casual riders is higher than that for all riders. This indicates that the casual riders usually take a longer trip compared the member riders. "
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 23,
   "id": "b2c9ad05",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:54.671289Z",
     "iopub.status.busy": "2022-03-06T05:02:54.669393Z",
     "iopub.status.idle": "2022-03-06T05:02:55.093795Z",
     "shell.execute_reply": "2022-03-06T05:02:55.092203Z"
    },
    "papermill": {
     "duration": 0.557547,
     "end_time": "2022-03-06T05:02:55.093951",
     "exception": false,
     "start_time": "2022-03-06T05:02:54.536404",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` has grouped output by 'customer_type'. You can override using the `.groups` argument.\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 14 × 8</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>customer_type</th><th scope=col>weekday</th><th scope=col>min_ride</th><th scope=col>max_ride</th><th scope=col>mid_ride</th><th scope=col>avg_ride</th><th scope=col>num_of_rides</th><th scope=col>total_ride</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>Monday   </td><td>1</td><td>86313</td><td>1004</td><td>1723.9833</td><td>228755</td><td>394369794</td></tr>\n",
       "\t<tr><td>member</td><td>Monday   </td><td>1</td><td>82181</td><td> 559</td><td> 763.0129</td><td>346455</td><td>264349624</td></tr>\n",
       "\t<tr><td>casual</td><td>Tuesday  </td><td>1</td><td>86145</td><td> 885</td><td>1551.8134</td><td>214793</td><td>333318661</td></tr>\n",
       "\t<tr><td>member</td><td>Tuesday  </td><td>1</td><td>75757</td><td> 554</td><td> 742.8264</td><td>388102</td><td>288292403</td></tr>\n",
       "\t<tr><td>casual</td><td>Wednesday</td><td>1</td><td>86247</td><td> 863</td><td>1462.5927</td><td>217990</td><td>318830573</td></tr>\n",
       "\t<tr><td>member</td><td>Wednesday</td><td>1</td><td>84908</td><td> 560</td><td> 747.0562</td><td>397663</td><td>297076605</td></tr>\n",
       "\t<tr><td>casual</td><td>Thursday </td><td>1</td><td>86121</td><td> 848</td><td>1446.3240</td><td>224056</td><td>324057571</td></tr>\n",
       "\t<tr><td>member</td><td>Thursday </td><td>1</td><td>84355</td><td> 554</td><td> 740.5163</td><td>373440</td><td>276538389</td></tr>\n",
       "\t<tr><td>casual</td><td>Friday   </td><td>1</td><td>86003</td><td> 931</td><td>1570.5219</td><td>289821</td><td>455170216</td></tr>\n",
       "\t<tr><td>member</td><td>Friday   </td><td>1</td><td>85594</td><td> 572</td><td> 767.3008</td><td>365748</td><td>280638721</td></tr>\n",
       "\t<tr><td>casual</td><td>Saturday </td><td>1</td><td>86362</td><td>1112</td><td>1827.6107</td><td>467948</td><td>855226767</td></tr>\n",
       "\t<tr><td>member</td><td>Saturday </td><td>1</td><td>79699</td><td> 656</td><td> 888.2230</td><td>357018</td><td>317111591</td></tr>\n",
       "\t<tr><td>casual</td><td>Sunday   </td><td>1</td><td>86086</td><td>1170</td><td>1942.1249</td><td>403375</td><td>783404617</td></tr>\n",
       "\t<tr><td>member</td><td>Sunday   </td><td>1</td><td>81053</td><td> 661</td><td> 911.1110</td><td>311168</td><td>283508595</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 14 × 8\n",
       "\\begin{tabular}{llllllll}\n",
       " customer\\_type & weekday & min\\_ride & max\\_ride & mid\\_ride & avg\\_ride & num\\_of\\_rides & total\\_ride\\\\\n",
       " <chr> & <ord> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & Monday    & 1 & 86313 & 1004 & 1723.9833 & 228755 & 394369794\\\\\n",
       "\t member & Monday    & 1 & 82181 &  559 &  763.0129 & 346455 & 264349624\\\\\n",
       "\t casual & Tuesday   & 1 & 86145 &  885 & 1551.8134 & 214793 & 333318661\\\\\n",
       "\t member & Tuesday   & 1 & 75757 &  554 &  742.8264 & 388102 & 288292403\\\\\n",
       "\t casual & Wednesday & 1 & 86247 &  863 & 1462.5927 & 217990 & 318830573\\\\\n",
       "\t member & Wednesday & 1 & 84908 &  560 &  747.0562 & 397663 & 297076605\\\\\n",
       "\t casual & Thursday  & 1 & 86121 &  848 & 1446.3240 & 224056 & 324057571\\\\\n",
       "\t member & Thursday  & 1 & 84355 &  554 &  740.5163 & 373440 & 276538389\\\\\n",
       "\t casual & Friday    & 1 & 86003 &  931 & 1570.5219 & 289821 & 455170216\\\\\n",
       "\t member & Friday    & 1 & 85594 &  572 &  767.3008 & 365748 & 280638721\\\\\n",
       "\t casual & Saturday  & 1 & 86362 & 1112 & 1827.6107 & 467948 & 855226767\\\\\n",
       "\t member & Saturday  & 1 & 79699 &  656 &  888.2230 & 357018 & 317111591\\\\\n",
       "\t casual & Sunday    & 1 & 86086 & 1170 & 1942.1249 & 403375 & 783404617\\\\\n",
       "\t member & Sunday    & 1 & 81053 &  661 &  911.1110 & 311168 & 283508595\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 14 × 8\n",
       "\n",
       "| customer_type &lt;chr&gt; | weekday &lt;ord&gt; | min_ride &lt;dbl&gt; | max_ride &lt;dbl&gt; | mid_ride &lt;dbl&gt; | avg_ride &lt;dbl&gt; | num_of_rides &lt;int&gt; | total_ride &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|\n",
       "| casual | Monday    | 1 | 86313 | 1004 | 1723.9833 | 228755 | 394369794 |\n",
       "| member | Monday    | 1 | 82181 |  559 |  763.0129 | 346455 | 264349624 |\n",
       "| casual | Tuesday   | 1 | 86145 |  885 | 1551.8134 | 214793 | 333318661 |\n",
       "| member | Tuesday   | 1 | 75757 |  554 |  742.8264 | 388102 | 288292403 |\n",
       "| casual | Wednesday | 1 | 86247 |  863 | 1462.5927 | 217990 | 318830573 |\n",
       "| member | Wednesday | 1 | 84908 |  560 |  747.0562 | 397663 | 297076605 |\n",
       "| casual | Thursday  | 1 | 86121 |  848 | 1446.3240 | 224056 | 324057571 |\n",
       "| member | Thursday  | 1 | 84355 |  554 |  740.5163 | 373440 | 276538389 |\n",
       "| casual | Friday    | 1 | 86003 |  931 | 1570.5219 | 289821 | 455170216 |\n",
       "| member | Friday    | 1 | 85594 |  572 |  767.3008 | 365748 | 280638721 |\n",
       "| casual | Saturday  | 1 | 86362 | 1112 | 1827.6107 | 467948 | 855226767 |\n",
       "| member | Saturday  | 1 | 79699 |  656 |  888.2230 | 357018 | 317111591 |\n",
       "| casual | Sunday    | 1 | 86086 | 1170 | 1942.1249 | 403375 | 783404617 |\n",
       "| member | Sunday    | 1 | 81053 |  661 |  911.1110 | 311168 | 283508595 |\n",
       "\n"
      ],
      "text/plain": [
       "   customer_type weekday   min_ride max_ride mid_ride avg_ride  num_of_rides\n",
       "1  casual        Monday    1        86313    1004     1723.9833 228755      \n",
       "2  member        Monday    1        82181     559      763.0129 346455      \n",
       "3  casual        Tuesday   1        86145     885     1551.8134 214793      \n",
       "4  member        Tuesday   1        75757     554      742.8264 388102      \n",
       "5  casual        Wednesday 1        86247     863     1462.5927 217990      \n",
       "6  member        Wednesday 1        84908     560      747.0562 397663      \n",
       "7  casual        Thursday  1        86121     848     1446.3240 224056      \n",
       "8  member        Thursday  1        84355     554      740.5163 373440      \n",
       "9  casual        Friday    1        86003     931     1570.5219 289821      \n",
       "10 member        Friday    1        85594     572      767.3008 365748      \n",
       "11 casual        Saturday  1        86362    1112     1827.6107 467948      \n",
       "12 member        Saturday  1        79699     656      888.2230 357018      \n",
       "13 casual        Sunday    1        86086    1170     1942.1249 403375      \n",
       "14 member        Sunday    1        81053     661      911.1110 311168      \n",
       "   total_ride\n",
       "1  394369794 \n",
       "2  264349624 \n",
       "3  333318661 \n",
       "4  288292403 \n",
       "5  318830573 \n",
       "6  297076605 \n",
       "7  324057571 \n",
       "8  276538389 \n",
       "9  455170216 \n",
       "10 280638721 \n",
       "11 855226767 \n",
       "12 317111591 \n",
       "13 783404617 \n",
       "14 283508595 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Determine the average trip duration in seconds by each day for members and casual riders\n",
    "# https://rstats-tips.net/2020/07/31/get-rid-of-info-of-dplyr-when-grouping-summarise-regrouping-output-by-species-override-with-groups-argument/\n",
    "tripdata %>% group_by(customer_type, weekday) %>% \n",
    "                  summarize(min_ride = min(ride_length, na.rm = TRUE),\n",
    "                            max_ride = max(ride_length, na.rm = TRUE),\n",
    "                            mid_ride = median(ride_length, na.rm = TRUE),\n",
    "                            avg_ride = mean(ride_length, na.rm = TRUE),\n",
    "                            num_of_rides = n(),\n",
    "                            total_ride = sum(ride_length, na.rm = TRUE)) %>% \n",
    "                                  arrange(weekday)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 24,
   "id": "484a2b1b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:55.361754Z",
     "iopub.status.busy": "2022-03-06T05:02:55.359895Z",
     "iopub.status.idle": "2022-03-06T05:02:55.778840Z",
     "shell.execute_reply": "2022-03-06T05:02:55.777432Z"
    },
    "papermill": {
     "duration": 0.554167,
     "end_time": "2022-03-06T05:02:55.778980",
     "exception": false,
     "start_time": "2022-03-06T05:02:55.224813",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` has grouped output by 'customer_type'. You can override using the `.groups` argument.\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 24 × 8</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>customer_type</th><th scope=col>month</th><th scope=col>min_ride</th><th scope=col>max_ride</th><th scope=col>mid_ride</th><th scope=col>avg_ride</th><th scope=col>num_of_rides</th><th scope=col>total_ride</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>January  </td><td>1</td><td>84194</td><td> 758.0</td><td>1336.6421</td><td> 14675</td><td> 19615223</td></tr>\n",
       "\t<tr><td>member</td><td>January  </td><td>1</td><td>73601</td><td> 525.0</td><td> 721.8695</td><td> 68816</td><td> 49676172</td></tr>\n",
       "\t<tr><td>casual</td><td>February </td><td>2</td><td>85658</td><td> 999.5</td><td>1862.6233</td><td>  8592</td><td> 16003659</td></tr>\n",
       "\t<tr><td>member</td><td>February </td><td>1</td><td>80253</td><td> 610.0</td><td> 881.7808</td><td> 34379</td><td> 30314741</td></tr>\n",
       "\t<tr><td>casual</td><td>March    </td><td>1</td><td>86086</td><td>1164.0</td><td>1932.7247</td><td> 75539</td><td>145996092</td></tr>\n",
       "\t<tr><td>member</td><td>March    </td><td>1</td><td>81266</td><td> 602.0</td><td> 819.1977</td><td>130034</td><td>106523549</td></tr>\n",
       "\t<tr><td>casual</td><td>April    </td><td>1</td><td>86313</td><td>1125.0</td><td>1925.6249</td><td>120294</td><td>231641118</td></tr>\n",
       "\t<tr><td>member</td><td>April    </td><td>1</td><td>84355</td><td> 627.0</td><td> 854.8186</td><td>177768</td><td>151959396</td></tr>\n",
       "\t<tr><td>casual</td><td>May      </td><td>1</td><td>86274</td><td>1179.0</td><td>1987.3164</td><td>216582</td><td>430416967</td></tr>\n",
       "\t<tr><td>member</td><td>May      </td><td>1</td><td>81893</td><td> 637.0</td><td> 859.5300</td><td>234122</td><td>201234875</td></tr>\n",
       "\t<tr><td>casual</td><td>June     </td><td>1</td><td>86279</td><td>1083.0</td><td>1844.5213</td><td>303878</td><td>560509448</td></tr>\n",
       "\t<tr><td>member</td><td>June     </td><td>1</td><td>79291</td><td> 639.0</td><td> 847.8172</td><td>304559</td><td>258210347</td></tr>\n",
       "\t<tr><td>casual</td><td>July     </td><td>1</td><td>85500</td><td>1030.0</td><td>1707.1980</td><td>369154</td><td>630218963</td></tr>\n",
       "\t<tr><td>member</td><td>July     </td><td>1</td><td>75757</td><td> 624.0</td><td> 827.4657</td><td>322870</td><td>267163859</td></tr>\n",
       "\t<tr><td>casual</td><td>August   </td><td>1</td><td>86043</td><td> 983.0</td><td>1625.4097</td><td>341293</td><td>554740961</td></tr>\n",
       "\t<tr><td>member</td><td>August   </td><td>1</td><td>80861</td><td> 605.0</td><td> 812.4073</td><td>332870</td><td>270426031</td></tr>\n",
       "\t<tr><td>casual</td><td>September</td><td>1</td><td>86362</td><td> 943.0</td><td>1571.6008</td><td>292777</td><td>460128564</td></tr>\n",
       "\t<tr><td>member</td><td>September</td><td>1</td><td>79104</td><td> 584.0</td><td> 787.8862</td><td>328154</td><td>258548018</td></tr>\n",
       "\t<tr><td>casual</td><td>October  </td><td>1</td><td>86052</td><td> 861.0</td><td>1460.6398</td><td>189001</td><td>276062386</td></tr>\n",
       "\t<tr><td>member</td><td>October  </td><td>1</td><td>84908</td><td> 530.0</td><td> 720.8661</td><td>288835</td><td>208211360</td></tr>\n",
       "\t<tr><td>casual</td><td>November </td><td>1</td><td>84452</td><td> 712.0</td><td>1210.6587</td><td> 69916</td><td> 84644411</td></tr>\n",
       "\t<tr><td>member</td><td>November </td><td>1</td><td>85594</td><td> 478.0</td><td> 655.6989</td><td>185897</td><td>121892460</td></tr>\n",
       "\t<tr><td>casual</td><td>December </td><td>1</td><td>85913</td><td> 693.0</td><td>1207.9048</td><td> 45037</td><td> 54400407</td></tr>\n",
       "\t<tr><td>member</td><td>December </td><td>1</td><td>73852</td><td> 469.0</td><td> 634.8931</td><td>131290</td><td> 83355120</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 24 × 8\n",
       "\\begin{tabular}{llllllll}\n",
       " customer\\_type & month & min\\_ride & max\\_ride & mid\\_ride & avg\\_ride & num\\_of\\_rides & total\\_ride\\\\\n",
       " <chr> & <ord> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & January   & 1 & 84194 &  758.0 & 1336.6421 &  14675 &  19615223\\\\\n",
       "\t member & January   & 1 & 73601 &  525.0 &  721.8695 &  68816 &  49676172\\\\\n",
       "\t casual & February  & 2 & 85658 &  999.5 & 1862.6233 &   8592 &  16003659\\\\\n",
       "\t member & February  & 1 & 80253 &  610.0 &  881.7808 &  34379 &  30314741\\\\\n",
       "\t casual & March     & 1 & 86086 & 1164.0 & 1932.7247 &  75539 & 145996092\\\\\n",
       "\t member & March     & 1 & 81266 &  602.0 &  819.1977 & 130034 & 106523549\\\\\n",
       "\t casual & April     & 1 & 86313 & 1125.0 & 1925.6249 & 120294 & 231641118\\\\\n",
       "\t member & April     & 1 & 84355 &  627.0 &  854.8186 & 177768 & 151959396\\\\\n",
       "\t casual & May       & 1 & 86274 & 1179.0 & 1987.3164 & 216582 & 430416967\\\\\n",
       "\t member & May       & 1 & 81893 &  637.0 &  859.5300 & 234122 & 201234875\\\\\n",
       "\t casual & June      & 1 & 86279 & 1083.0 & 1844.5213 & 303878 & 560509448\\\\\n",
       "\t member & June      & 1 & 79291 &  639.0 &  847.8172 & 304559 & 258210347\\\\\n",
       "\t casual & July      & 1 & 85500 & 1030.0 & 1707.1980 & 369154 & 630218963\\\\\n",
       "\t member & July      & 1 & 75757 &  624.0 &  827.4657 & 322870 & 267163859\\\\\n",
       "\t casual & August    & 1 & 86043 &  983.0 & 1625.4097 & 341293 & 554740961\\\\\n",
       "\t member & August    & 1 & 80861 &  605.0 &  812.4073 & 332870 & 270426031\\\\\n",
       "\t casual & September & 1 & 86362 &  943.0 & 1571.6008 & 292777 & 460128564\\\\\n",
       "\t member & September & 1 & 79104 &  584.0 &  787.8862 & 328154 & 258548018\\\\\n",
       "\t casual & October   & 1 & 86052 &  861.0 & 1460.6398 & 189001 & 276062386\\\\\n",
       "\t member & October   & 1 & 84908 &  530.0 &  720.8661 & 288835 & 208211360\\\\\n",
       "\t casual & November  & 1 & 84452 &  712.0 & 1210.6587 &  69916 &  84644411\\\\\n",
       "\t member & November  & 1 & 85594 &  478.0 &  655.6989 & 185897 & 121892460\\\\\n",
       "\t casual & December  & 1 & 85913 &  693.0 & 1207.9048 &  45037 &  54400407\\\\\n",
       "\t member & December  & 1 & 73852 &  469.0 &  634.8931 & 131290 &  83355120\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 24 × 8\n",
       "\n",
       "| customer_type &lt;chr&gt; | month &lt;ord&gt; | min_ride &lt;dbl&gt; | max_ride &lt;dbl&gt; | mid_ride &lt;dbl&gt; | avg_ride &lt;dbl&gt; | num_of_rides &lt;int&gt; | total_ride &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|\n",
       "| casual | January   | 1 | 84194 |  758.0 | 1336.6421 |  14675 |  19615223 |\n",
       "| member | January   | 1 | 73601 |  525.0 |  721.8695 |  68816 |  49676172 |\n",
       "| casual | February  | 2 | 85658 |  999.5 | 1862.6233 |   8592 |  16003659 |\n",
       "| member | February  | 1 | 80253 |  610.0 |  881.7808 |  34379 |  30314741 |\n",
       "| casual | March     | 1 | 86086 | 1164.0 | 1932.7247 |  75539 | 145996092 |\n",
       "| member | March     | 1 | 81266 |  602.0 |  819.1977 | 130034 | 106523549 |\n",
       "| casual | April     | 1 | 86313 | 1125.0 | 1925.6249 | 120294 | 231641118 |\n",
       "| member | April     | 1 | 84355 |  627.0 |  854.8186 | 177768 | 151959396 |\n",
       "| casual | May       | 1 | 86274 | 1179.0 | 1987.3164 | 216582 | 430416967 |\n",
       "| member | May       | 1 | 81893 |  637.0 |  859.5300 | 234122 | 201234875 |\n",
       "| casual | June      | 1 | 86279 | 1083.0 | 1844.5213 | 303878 | 560509448 |\n",
       "| member | June      | 1 | 79291 |  639.0 |  847.8172 | 304559 | 258210347 |\n",
       "| casual | July      | 1 | 85500 | 1030.0 | 1707.1980 | 369154 | 630218963 |\n",
       "| member | July      | 1 | 75757 |  624.0 |  827.4657 | 322870 | 267163859 |\n",
       "| casual | August    | 1 | 86043 |  983.0 | 1625.4097 | 341293 | 554740961 |\n",
       "| member | August    | 1 | 80861 |  605.0 |  812.4073 | 332870 | 270426031 |\n",
       "| casual | September | 1 | 86362 |  943.0 | 1571.6008 | 292777 | 460128564 |\n",
       "| member | September | 1 | 79104 |  584.0 |  787.8862 | 328154 | 258548018 |\n",
       "| casual | October   | 1 | 86052 |  861.0 | 1460.6398 | 189001 | 276062386 |\n",
       "| member | October   | 1 | 84908 |  530.0 |  720.8661 | 288835 | 208211360 |\n",
       "| casual | November  | 1 | 84452 |  712.0 | 1210.6587 |  69916 |  84644411 |\n",
       "| member | November  | 1 | 85594 |  478.0 |  655.6989 | 185897 | 121892460 |\n",
       "| casual | December  | 1 | 85913 |  693.0 | 1207.9048 |  45037 |  54400407 |\n",
       "| member | December  | 1 | 73852 |  469.0 |  634.8931 | 131290 |  83355120 |\n",
       "\n"
      ],
      "text/plain": [
       "   customer_type month     min_ride max_ride mid_ride avg_ride  num_of_rides\n",
       "1  casual        January   1        84194     758.0   1336.6421  14675      \n",
       "2  member        January   1        73601     525.0    721.8695  68816      \n",
       "3  casual        February  2        85658     999.5   1862.6233   8592      \n",
       "4  member        February  1        80253     610.0    881.7808  34379      \n",
       "5  casual        March     1        86086    1164.0   1932.7247  75539      \n",
       "6  member        March     1        81266     602.0    819.1977 130034      \n",
       "7  casual        April     1        86313    1125.0   1925.6249 120294      \n",
       "8  member        April     1        84355     627.0    854.8186 177768      \n",
       "9  casual        May       1        86274    1179.0   1987.3164 216582      \n",
       "10 member        May       1        81893     637.0    859.5300 234122      \n",
       "11 casual        June      1        86279    1083.0   1844.5213 303878      \n",
       "12 member        June      1        79291     639.0    847.8172 304559      \n",
       "13 casual        July      1        85500    1030.0   1707.1980 369154      \n",
       "14 member        July      1        75757     624.0    827.4657 322870      \n",
       "15 casual        August    1        86043     983.0   1625.4097 341293      \n",
       "16 member        August    1        80861     605.0    812.4073 332870      \n",
       "17 casual        September 1        86362     943.0   1571.6008 292777      \n",
       "18 member        September 1        79104     584.0    787.8862 328154      \n",
       "19 casual        October   1        86052     861.0   1460.6398 189001      \n",
       "20 member        October   1        84908     530.0    720.8661 288835      \n",
       "21 casual        November  1        84452     712.0   1210.6587  69916      \n",
       "22 member        November  1        85594     478.0    655.6989 185897      \n",
       "23 casual        December  1        85913     693.0   1207.9048  45037      \n",
       "24 member        December  1        73852     469.0    634.8931 131290      \n",
       "   total_ride\n",
       "1   19615223 \n",
       "2   49676172 \n",
       "3   16003659 \n",
       "4   30314741 \n",
       "5  145996092 \n",
       "6  106523549 \n",
       "7  231641118 \n",
       "8  151959396 \n",
       "9  430416967 \n",
       "10 201234875 \n",
       "11 560509448 \n",
       "12 258210347 \n",
       "13 630218963 \n",
       "14 267163859 \n",
       "15 554740961 \n",
       "16 270426031 \n",
       "17 460128564 \n",
       "18 258548018 \n",
       "19 276062386 \n",
       "20 208211360 \n",
       "21  84644411 \n",
       "22 121892460 \n",
       "23  54400407 \n",
       "24  83355120 "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Calculate the statistical summary of the trip duration by each month for members & casual riders\n",
    "tripdata %>% group_by(customer_type, month) %>% \n",
    "  summarize(min_ride = min(ride_length, na.rm = TRUE),\n",
    "            max_ride = max(ride_length, na.rm = TRUE),\n",
    "            mid_ride = median(ride_length, na.rm = TRUE),\n",
    "            avg_ride = mean(ride_length, na.rm = TRUE),\n",
    "            num_of_rides = n(),\n",
    "            total_ride = sum(ride_length, na.rm = TRUE)) %>% \n",
    "  arrange(month)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 25,
   "id": "65ad486c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:56.056373Z",
     "iopub.status.busy": "2022-03-06T05:02:56.054938Z",
     "iopub.status.idle": "2022-03-06T05:02:57.117394Z",
     "shell.execute_reply": "2022-03-06T05:02:57.115870Z"
    },
    "papermill": {
     "duration": 1.202772,
     "end_time": "2022-03-06T05:02:57.117552",
     "exception": false,
     "start_time": "2022-03-06T05:02:55.914780",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` has grouped output by 'customer_type'. You can override using the `.groups` argument.\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/html": [
       "<table class=\"dataframe\">\n",
       "<caption>A grouped_df: 2880 × 8</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>customer_type</th><th scope=col>time</th><th scope=col>min_ride</th><th scope=col>max_ride</th><th scope=col>mid_ride</th><th scope=col>avg_ride</th><th scope=col>num_of_rides</th><th scope=col>total_ride</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;dttm&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:00:00</td><td>13</td><td>51351</td><td>868.0</td><td>1654.6283</td><td>826</td><td>1366723</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:00:00</td><td> 2</td><td>32359</td><td>517.0</td><td> 752.6218</td><td>550</td><td> 413942</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:01:00</td><td> 9</td><td>85482</td><td>856.5</td><td>1668.4720</td><td>820</td><td>1368147</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:01:00</td><td> 2</td><td>37366</td><td>559.0</td><td> 820.8152</td><td>525</td><td> 430928</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:02:00</td><td> 3</td><td>50008</td><td>900.0</td><td>1716.0308</td><td>778</td><td>1335072</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:02:00</td><td> 3</td><td>29830</td><td>511.0</td><td> 706.4194</td><td>527</td><td> 372283</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:03:00</td><td> 3</td><td>66459</td><td>831.0</td><td>1629.2131</td><td>779</td><td>1269157</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:03:00</td><td> 1</td><td>11999</td><td>550.0</td><td> 751.3631</td><td>526</td><td> 395217</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:04:00</td><td> 1</td><td>81710</td><td>853.5</td><td>1858.5299</td><td>804</td><td>1494258</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:04:00</td><td> 3</td><td> 5975</td><td>542.5</td><td> 728.7222</td><td>522</td><td> 380393</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:05:00</td><td> 2</td><td>42751</td><td>837.5</td><td>1393.2393</td><td>794</td><td>1106232</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:05:00</td><td> 6</td><td> 6090</td><td>595.0</td><td> 749.5453</td><td>541</td><td> 405504</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:06:00</td><td> 4</td><td>69390</td><td>855.0</td><td>1997.0680</td><td>809</td><td>1615628</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:06:00</td><td> 5</td><td>47113</td><td>559.5</td><td> 799.5293</td><td>512</td><td> 409359</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:07:00</td><td> 3</td><td>41623</td><td>836.5</td><td>1435.7264</td><td>804</td><td>1154324</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:07:00</td><td> 3</td><td>21169</td><td>550.0</td><td> 785.8968</td><td>533</td><td> 418883</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:08:00</td><td> 1</td><td>59037</td><td>819.0</td><td>1486.1308</td><td>749</td><td>1113112</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:08:00</td><td> 3</td><td>64307</td><td>554.0</td><td> 898.7038</td><td>476</td><td> 427783</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:09:00</td><td> 2</td><td>66027</td><td>885.0</td><td>1637.2488</td><td>860</td><td>1408034</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:09:00</td><td> 3</td><td> 5309</td><td>536.0</td><td> 707.6362</td><td>536</td><td> 379293</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:10:00</td><td> 4</td><td>61344</td><td>803.0</td><td>1626.5700</td><td>793</td><td>1289870</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:10:00</td><td> 3</td><td>39235</td><td>559.0</td><td> 846.9280</td><td>472</td><td> 399750</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:11:00</td><td> 2</td><td>56555</td><td>792.0</td><td>1607.0809</td><td>841</td><td>1351555</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:11:00</td><td> 1</td><td> 4230</td><td>556.5</td><td> 694.4378</td><td>498</td><td> 345830</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:12:00</td><td> 2</td><td>74206</td><td>856.0</td><td>1618.9384</td><td>796</td><td>1288675</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:12:00</td><td>12</td><td> 5936</td><td>605.0</td><td> 788.8684</td><td>494</td><td> 389701</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:13:00</td><td> 2</td><td>56005</td><td>871.5</td><td>1530.1321</td><td>772</td><td>1181262</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:13:00</td><td> 2</td><td>41776</td><td>598.0</td><td> 953.8305</td><td>478</td><td> 455931</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 00:14:00</td><td> 9</td><td>74439</td><td>902.5</td><td>2063.0093</td><td>756</td><td>1559635</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 00:14:00</td><td> 1</td><td> 6004</td><td>536.5</td><td> 694.1146</td><td>480</td><td> 333175</td></tr>\n",
       "\t<tr><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td><td>⋮</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:45:00</td><td> 3</td><td>68596</td><td>889.5</td><td>1694.6316</td><td>866</td><td>1467551</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:45:00</td><td> 6</td><td>47102</td><td>573.0</td><td> 850.6749</td><td>569</td><td> 484034</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:46:00</td><td> 3</td><td>71267</td><td>920.0</td><td>1946.5260</td><td>905</td><td>1761606</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:46:00</td><td> 2</td><td>36779</td><td>529.5</td><td> 806.5064</td><td>622</td><td> 501647</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:47:00</td><td> 6</td><td>64095</td><td>862.0</td><td>1785.3710</td><td>911</td><td>1626473</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:47:00</td><td>12</td><td>10440</td><td>586.0</td><td> 750.1997</td><td>576</td><td> 432115</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:48:00</td><td> 2</td><td>38653</td><td>861.0</td><td>1446.5809</td><td>847</td><td>1225254</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:48:00</td><td> 4</td><td>32281</td><td>542.0</td><td> 808.1583</td><td>575</td><td> 464691</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:49:00</td><td> 7</td><td>53174</td><td>874.5</td><td>1586.8428</td><td>916</td><td>1453548</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:49:00</td><td> 2</td><td> 7905</td><td>593.0</td><td> 743.5756</td><td>589</td><td> 437966</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:50:00</td><td> 2</td><td>82489</td><td>849.0</td><td>1680.1189</td><td>841</td><td>1412980</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:50:00</td><td> 3</td><td> 9162</td><td>501.0</td><td> 689.4429</td><td>569</td><td> 392293</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:51:00</td><td> 2</td><td>82081</td><td>887.5</td><td>1764.4862</td><td>944</td><td>1665675</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:51:00</td><td> 4</td><td>70118</td><td>549.0</td><td> 900.3533</td><td>583</td><td> 524906</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:52:00</td><td> 2</td><td>51866</td><td>915.5</td><td>1487.9421</td><td>794</td><td>1181426</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:52:00</td><td> 2</td><td>17037</td><td>497.0</td><td> 699.9725</td><td>545</td><td> 381485</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:53:00</td><td> 8</td><td>68021</td><td>872.0</td><td>1783.2430</td><td>819</td><td>1460476</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:53:00</td><td> 4</td><td> 6598</td><td>512.0</td><td> 663.1931</td><td>549</td><td> 364093</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:54:00</td><td>12</td><td>62788</td><td>857.0</td><td>1772.2898</td><td>797</td><td>1412515</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:54:00</td><td> 4</td><td>55930</td><td>543.0</td><td> 791.1431</td><td>531</td><td> 420097</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:55:00</td><td> 3</td><td>53854</td><td>898.5</td><td>1764.0921</td><td>836</td><td>1474781</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:55:00</td><td> 7</td><td> 7623</td><td>583.0</td><td> 770.3319</td><td>467</td><td> 359745</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:56:00</td><td>13</td><td>56332</td><td>926.5</td><td>1962.9030</td><td>876</td><td>1719503</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:56:00</td><td> 4</td><td> 6741</td><td>538.0</td><td> 704.5897</td><td>563</td><td> 396684</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:57:00</td><td>12</td><td>54746</td><td>836.0</td><td>1559.7952</td><td>840</td><td>1310228</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:57:00</td><td> 2</td><td> 9200</td><td>526.0</td><td> 687.7509</td><td>570</td><td> 392018</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:58:00</td><td>14</td><td>77052</td><td>882.0</td><td>1574.0991</td><td>888</td><td>1397800</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:58:00</td><td> 3</td><td>12955</td><td>602.5</td><td> 758.7568</td><td>514</td><td> 390001</td></tr>\n",
       "\t<tr><td>casual</td><td>2022-03-06 23:59:00</td><td>15</td><td>69460</td><td>873.0</td><td>1703.8753</td><td>802</td><td>1366508</td></tr>\n",
       "\t<tr><td>member</td><td>2022-03-06 23:59:00</td><td> 7</td><td>13140</td><td>511.5</td><td> 730.7584</td><td>534</td><td> 390225</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 2880 × 8\n",
       "\\begin{tabular}{llllllll}\n",
       " customer\\_type & time & min\\_ride & max\\_ride & mid\\_ride & avg\\_ride & num\\_of\\_rides & total\\_ride\\\\\n",
       " <chr> & <dttm> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & 2022-03-06 00:00:00 & 13 & 51351 & 868.0 & 1654.6283 & 826 & 1366723\\\\\n",
       "\t member & 2022-03-06 00:00:00 &  2 & 32359 & 517.0 &  752.6218 & 550 &  413942\\\\\n",
       "\t casual & 2022-03-06 00:01:00 &  9 & 85482 & 856.5 & 1668.4720 & 820 & 1368147\\\\\n",
       "\t member & 2022-03-06 00:01:00 &  2 & 37366 & 559.0 &  820.8152 & 525 &  430928\\\\\n",
       "\t casual & 2022-03-06 00:02:00 &  3 & 50008 & 900.0 & 1716.0308 & 778 & 1335072\\\\\n",
       "\t member & 2022-03-06 00:02:00 &  3 & 29830 & 511.0 &  706.4194 & 527 &  372283\\\\\n",
       "\t casual & 2022-03-06 00:03:00 &  3 & 66459 & 831.0 & 1629.2131 & 779 & 1269157\\\\\n",
       "\t member & 2022-03-06 00:03:00 &  1 & 11999 & 550.0 &  751.3631 & 526 &  395217\\\\\n",
       "\t casual & 2022-03-06 00:04:00 &  1 & 81710 & 853.5 & 1858.5299 & 804 & 1494258\\\\\n",
       "\t member & 2022-03-06 00:04:00 &  3 &  5975 & 542.5 &  728.7222 & 522 &  380393\\\\\n",
       "\t casual & 2022-03-06 00:05:00 &  2 & 42751 & 837.5 & 1393.2393 & 794 & 1106232\\\\\n",
       "\t member & 2022-03-06 00:05:00 &  6 &  6090 & 595.0 &  749.5453 & 541 &  405504\\\\\n",
       "\t casual & 2022-03-06 00:06:00 &  4 & 69390 & 855.0 & 1997.0680 & 809 & 1615628\\\\\n",
       "\t member & 2022-03-06 00:06:00 &  5 & 47113 & 559.5 &  799.5293 & 512 &  409359\\\\\n",
       "\t casual & 2022-03-06 00:07:00 &  3 & 41623 & 836.5 & 1435.7264 & 804 & 1154324\\\\\n",
       "\t member & 2022-03-06 00:07:00 &  3 & 21169 & 550.0 &  785.8968 & 533 &  418883\\\\\n",
       "\t casual & 2022-03-06 00:08:00 &  1 & 59037 & 819.0 & 1486.1308 & 749 & 1113112\\\\\n",
       "\t member & 2022-03-06 00:08:00 &  3 & 64307 & 554.0 &  898.7038 & 476 &  427783\\\\\n",
       "\t casual & 2022-03-06 00:09:00 &  2 & 66027 & 885.0 & 1637.2488 & 860 & 1408034\\\\\n",
       "\t member & 2022-03-06 00:09:00 &  3 &  5309 & 536.0 &  707.6362 & 536 &  379293\\\\\n",
       "\t casual & 2022-03-06 00:10:00 &  4 & 61344 & 803.0 & 1626.5700 & 793 & 1289870\\\\\n",
       "\t member & 2022-03-06 00:10:00 &  3 & 39235 & 559.0 &  846.9280 & 472 &  399750\\\\\n",
       "\t casual & 2022-03-06 00:11:00 &  2 & 56555 & 792.0 & 1607.0809 & 841 & 1351555\\\\\n",
       "\t member & 2022-03-06 00:11:00 &  1 &  4230 & 556.5 &  694.4378 & 498 &  345830\\\\\n",
       "\t casual & 2022-03-06 00:12:00 &  2 & 74206 & 856.0 & 1618.9384 & 796 & 1288675\\\\\n",
       "\t member & 2022-03-06 00:12:00 & 12 &  5936 & 605.0 &  788.8684 & 494 &  389701\\\\\n",
       "\t casual & 2022-03-06 00:13:00 &  2 & 56005 & 871.5 & 1530.1321 & 772 & 1181262\\\\\n",
       "\t member & 2022-03-06 00:13:00 &  2 & 41776 & 598.0 &  953.8305 & 478 &  455931\\\\\n",
       "\t casual & 2022-03-06 00:14:00 &  9 & 74439 & 902.5 & 2063.0093 & 756 & 1559635\\\\\n",
       "\t member & 2022-03-06 00:14:00 &  1 &  6004 & 536.5 &  694.1146 & 480 &  333175\\\\\n",
       "\t ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮ & ⋮\\\\\n",
       "\t casual & 2022-03-06 23:45:00 &  3 & 68596 & 889.5 & 1694.6316 & 866 & 1467551\\\\\n",
       "\t member & 2022-03-06 23:45:00 &  6 & 47102 & 573.0 &  850.6749 & 569 &  484034\\\\\n",
       "\t casual & 2022-03-06 23:46:00 &  3 & 71267 & 920.0 & 1946.5260 & 905 & 1761606\\\\\n",
       "\t member & 2022-03-06 23:46:00 &  2 & 36779 & 529.5 &  806.5064 & 622 &  501647\\\\\n",
       "\t casual & 2022-03-06 23:47:00 &  6 & 64095 & 862.0 & 1785.3710 & 911 & 1626473\\\\\n",
       "\t member & 2022-03-06 23:47:00 & 12 & 10440 & 586.0 &  750.1997 & 576 &  432115\\\\\n",
       "\t casual & 2022-03-06 23:48:00 &  2 & 38653 & 861.0 & 1446.5809 & 847 & 1225254\\\\\n",
       "\t member & 2022-03-06 23:48:00 &  4 & 32281 & 542.0 &  808.1583 & 575 &  464691\\\\\n",
       "\t casual & 2022-03-06 23:49:00 &  7 & 53174 & 874.5 & 1586.8428 & 916 & 1453548\\\\\n",
       "\t member & 2022-03-06 23:49:00 &  2 &  7905 & 593.0 &  743.5756 & 589 &  437966\\\\\n",
       "\t casual & 2022-03-06 23:50:00 &  2 & 82489 & 849.0 & 1680.1189 & 841 & 1412980\\\\\n",
       "\t member & 2022-03-06 23:50:00 &  3 &  9162 & 501.0 &  689.4429 & 569 &  392293\\\\\n",
       "\t casual & 2022-03-06 23:51:00 &  2 & 82081 & 887.5 & 1764.4862 & 944 & 1665675\\\\\n",
       "\t member & 2022-03-06 23:51:00 &  4 & 70118 & 549.0 &  900.3533 & 583 &  524906\\\\\n",
       "\t casual & 2022-03-06 23:52:00 &  2 & 51866 & 915.5 & 1487.9421 & 794 & 1181426\\\\\n",
       "\t member & 2022-03-06 23:52:00 &  2 & 17037 & 497.0 &  699.9725 & 545 &  381485\\\\\n",
       "\t casual & 2022-03-06 23:53:00 &  8 & 68021 & 872.0 & 1783.2430 & 819 & 1460476\\\\\n",
       "\t member & 2022-03-06 23:53:00 &  4 &  6598 & 512.0 &  663.1931 & 549 &  364093\\\\\n",
       "\t casual & 2022-03-06 23:54:00 & 12 & 62788 & 857.0 & 1772.2898 & 797 & 1412515\\\\\n",
       "\t member & 2022-03-06 23:54:00 &  4 & 55930 & 543.0 &  791.1431 & 531 &  420097\\\\\n",
       "\t casual & 2022-03-06 23:55:00 &  3 & 53854 & 898.5 & 1764.0921 & 836 & 1474781\\\\\n",
       "\t member & 2022-03-06 23:55:00 &  7 &  7623 & 583.0 &  770.3319 & 467 &  359745\\\\\n",
       "\t casual & 2022-03-06 23:56:00 & 13 & 56332 & 926.5 & 1962.9030 & 876 & 1719503\\\\\n",
       "\t member & 2022-03-06 23:56:00 &  4 &  6741 & 538.0 &  704.5897 & 563 &  396684\\\\\n",
       "\t casual & 2022-03-06 23:57:00 & 12 & 54746 & 836.0 & 1559.7952 & 840 & 1310228\\\\\n",
       "\t member & 2022-03-06 23:57:00 &  2 &  9200 & 526.0 &  687.7509 & 570 &  392018\\\\\n",
       "\t casual & 2022-03-06 23:58:00 & 14 & 77052 & 882.0 & 1574.0991 & 888 & 1397800\\\\\n",
       "\t member & 2022-03-06 23:58:00 &  3 & 12955 & 602.5 &  758.7568 & 514 &  390001\\\\\n",
       "\t casual & 2022-03-06 23:59:00 & 15 & 69460 & 873.0 & 1703.8753 & 802 & 1366508\\\\\n",
       "\t member & 2022-03-06 23:59:00 &  7 & 13140 & 511.5 &  730.7584 & 534 &  390225\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 2880 × 8\n",
       "\n",
       "| customer_type &lt;chr&gt; | time &lt;dttm&gt; | min_ride &lt;dbl&gt; | max_ride &lt;dbl&gt; | mid_ride &lt;dbl&gt; | avg_ride &lt;dbl&gt; | num_of_rides &lt;int&gt; | total_ride &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|\n",
       "| casual | 2022-03-06 00:00:00 | 13 | 51351 | 868.0 | 1654.6283 | 826 | 1366723 |\n",
       "| member | 2022-03-06 00:00:00 |  2 | 32359 | 517.0 |  752.6218 | 550 |  413942 |\n",
       "| casual | 2022-03-06 00:01:00 |  9 | 85482 | 856.5 | 1668.4720 | 820 | 1368147 |\n",
       "| member | 2022-03-06 00:01:00 |  2 | 37366 | 559.0 |  820.8152 | 525 |  430928 |\n",
       "| casual | 2022-03-06 00:02:00 |  3 | 50008 | 900.0 | 1716.0308 | 778 | 1335072 |\n",
       "| member | 2022-03-06 00:02:00 |  3 | 29830 | 511.0 |  706.4194 | 527 |  372283 |\n",
       "| casual | 2022-03-06 00:03:00 |  3 | 66459 | 831.0 | 1629.2131 | 779 | 1269157 |\n",
       "| member | 2022-03-06 00:03:00 |  1 | 11999 | 550.0 |  751.3631 | 526 |  395217 |\n",
       "| casual | 2022-03-06 00:04:00 |  1 | 81710 | 853.5 | 1858.5299 | 804 | 1494258 |\n",
       "| member | 2022-03-06 00:04:00 |  3 |  5975 | 542.5 |  728.7222 | 522 |  380393 |\n",
       "| casual | 2022-03-06 00:05:00 |  2 | 42751 | 837.5 | 1393.2393 | 794 | 1106232 |\n",
       "| member | 2022-03-06 00:05:00 |  6 |  6090 | 595.0 |  749.5453 | 541 |  405504 |\n",
       "| casual | 2022-03-06 00:06:00 |  4 | 69390 | 855.0 | 1997.0680 | 809 | 1615628 |\n",
       "| member | 2022-03-06 00:06:00 |  5 | 47113 | 559.5 |  799.5293 | 512 |  409359 |\n",
       "| casual | 2022-03-06 00:07:00 |  3 | 41623 | 836.5 | 1435.7264 | 804 | 1154324 |\n",
       "| member | 2022-03-06 00:07:00 |  3 | 21169 | 550.0 |  785.8968 | 533 |  418883 |\n",
       "| casual | 2022-03-06 00:08:00 |  1 | 59037 | 819.0 | 1486.1308 | 749 | 1113112 |\n",
       "| member | 2022-03-06 00:08:00 |  3 | 64307 | 554.0 |  898.7038 | 476 |  427783 |\n",
       "| casual | 2022-03-06 00:09:00 |  2 | 66027 | 885.0 | 1637.2488 | 860 | 1408034 |\n",
       "| member | 2022-03-06 00:09:00 |  3 |  5309 | 536.0 |  707.6362 | 536 |  379293 |\n",
       "| casual | 2022-03-06 00:10:00 |  4 | 61344 | 803.0 | 1626.5700 | 793 | 1289870 |\n",
       "| member | 2022-03-06 00:10:00 |  3 | 39235 | 559.0 |  846.9280 | 472 |  399750 |\n",
       "| casual | 2022-03-06 00:11:00 |  2 | 56555 | 792.0 | 1607.0809 | 841 | 1351555 |\n",
       "| member | 2022-03-06 00:11:00 |  1 |  4230 | 556.5 |  694.4378 | 498 |  345830 |\n",
       "| casual | 2022-03-06 00:12:00 |  2 | 74206 | 856.0 | 1618.9384 | 796 | 1288675 |\n",
       "| member | 2022-03-06 00:12:00 | 12 |  5936 | 605.0 |  788.8684 | 494 |  389701 |\n",
       "| casual | 2022-03-06 00:13:00 |  2 | 56005 | 871.5 | 1530.1321 | 772 | 1181262 |\n",
       "| member | 2022-03-06 00:13:00 |  2 | 41776 | 598.0 |  953.8305 | 478 |  455931 |\n",
       "| casual | 2022-03-06 00:14:00 |  9 | 74439 | 902.5 | 2063.0093 | 756 | 1559635 |\n",
       "| member | 2022-03-06 00:14:00 |  1 |  6004 | 536.5 |  694.1146 | 480 |  333175 |\n",
       "| ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ | ⋮ |\n",
       "| casual | 2022-03-06 23:45:00 |  3 | 68596 | 889.5 | 1694.6316 | 866 | 1467551 |\n",
       "| member | 2022-03-06 23:45:00 |  6 | 47102 | 573.0 |  850.6749 | 569 |  484034 |\n",
       "| casual | 2022-03-06 23:46:00 |  3 | 71267 | 920.0 | 1946.5260 | 905 | 1761606 |\n",
       "| member | 2022-03-06 23:46:00 |  2 | 36779 | 529.5 |  806.5064 | 622 |  501647 |\n",
       "| casual | 2022-03-06 23:47:00 |  6 | 64095 | 862.0 | 1785.3710 | 911 | 1626473 |\n",
       "| member | 2022-03-06 23:47:00 | 12 | 10440 | 586.0 |  750.1997 | 576 |  432115 |\n",
       "| casual | 2022-03-06 23:48:00 |  2 | 38653 | 861.0 | 1446.5809 | 847 | 1225254 |\n",
       "| member | 2022-03-06 23:48:00 |  4 | 32281 | 542.0 |  808.1583 | 575 |  464691 |\n",
       "| casual | 2022-03-06 23:49:00 |  7 | 53174 | 874.5 | 1586.8428 | 916 | 1453548 |\n",
       "| member | 2022-03-06 23:49:00 |  2 |  7905 | 593.0 |  743.5756 | 589 |  437966 |\n",
       "| casual | 2022-03-06 23:50:00 |  2 | 82489 | 849.0 | 1680.1189 | 841 | 1412980 |\n",
       "| member | 2022-03-06 23:50:00 |  3 |  9162 | 501.0 |  689.4429 | 569 |  392293 |\n",
       "| casual | 2022-03-06 23:51:00 |  2 | 82081 | 887.5 | 1764.4862 | 944 | 1665675 |\n",
       "| member | 2022-03-06 23:51:00 |  4 | 70118 | 549.0 |  900.3533 | 583 |  524906 |\n",
       "| casual | 2022-03-06 23:52:00 |  2 | 51866 | 915.5 | 1487.9421 | 794 | 1181426 |\n",
       "| member | 2022-03-06 23:52:00 |  2 | 17037 | 497.0 |  699.9725 | 545 |  381485 |\n",
       "| casual | 2022-03-06 23:53:00 |  8 | 68021 | 872.0 | 1783.2430 | 819 | 1460476 |\n",
       "| member | 2022-03-06 23:53:00 |  4 |  6598 | 512.0 |  663.1931 | 549 |  364093 |\n",
       "| casual | 2022-03-06 23:54:00 | 12 | 62788 | 857.0 | 1772.2898 | 797 | 1412515 |\n",
       "| member | 2022-03-06 23:54:00 |  4 | 55930 | 543.0 |  791.1431 | 531 |  420097 |\n",
       "| casual | 2022-03-06 23:55:00 |  3 | 53854 | 898.5 | 1764.0921 | 836 | 1474781 |\n",
       "| member | 2022-03-06 23:55:00 |  7 |  7623 | 583.0 |  770.3319 | 467 |  359745 |\n",
       "| casual | 2022-03-06 23:56:00 | 13 | 56332 | 926.5 | 1962.9030 | 876 | 1719503 |\n",
       "| member | 2022-03-06 23:56:00 |  4 |  6741 | 538.0 |  704.5897 | 563 |  396684 |\n",
       "| casual | 2022-03-06 23:57:00 | 12 | 54746 | 836.0 | 1559.7952 | 840 | 1310228 |\n",
       "| member | 2022-03-06 23:57:00 |  2 |  9200 | 526.0 |  687.7509 | 570 |  392018 |\n",
       "| casual | 2022-03-06 23:58:00 | 14 | 77052 | 882.0 | 1574.0991 | 888 | 1397800 |\n",
       "| member | 2022-03-06 23:58:00 |  3 | 12955 | 602.5 |  758.7568 | 514 |  390001 |\n",
       "| casual | 2022-03-06 23:59:00 | 15 | 69460 | 873.0 | 1703.8753 | 802 | 1366508 |\n",
       "| member | 2022-03-06 23:59:00 |  7 | 13140 | 511.5 |  730.7584 | 534 |  390225 |\n",
       "\n"
      ],
      "text/plain": [
       "     customer_type time                min_ride max_ride mid_ride avg_ride \n",
       "1    casual        2022-03-06 00:00:00 13       51351    868.0    1654.6283\n",
       "2    member        2022-03-06 00:00:00  2       32359    517.0     752.6218\n",
       "3    casual        2022-03-06 00:01:00  9       85482    856.5    1668.4720\n",
       "4    member        2022-03-06 00:01:00  2       37366    559.0     820.8152\n",
       "5    casual        2022-03-06 00:02:00  3       50008    900.0    1716.0308\n",
       "6    member        2022-03-06 00:02:00  3       29830    511.0     706.4194\n",
       "7    casual        2022-03-06 00:03:00  3       66459    831.0    1629.2131\n",
       "8    member        2022-03-06 00:03:00  1       11999    550.0     751.3631\n",
       "9    casual        2022-03-06 00:04:00  1       81710    853.5    1858.5299\n",
       "10   member        2022-03-06 00:04:00  3        5975    542.5     728.7222\n",
       "11   casual        2022-03-06 00:05:00  2       42751    837.5    1393.2393\n",
       "12   member        2022-03-06 00:05:00  6        6090    595.0     749.5453\n",
       "13   casual        2022-03-06 00:06:00  4       69390    855.0    1997.0680\n",
       "14   member        2022-03-06 00:06:00  5       47113    559.5     799.5293\n",
       "15   casual        2022-03-06 00:07:00  3       41623    836.5    1435.7264\n",
       "16   member        2022-03-06 00:07:00  3       21169    550.0     785.8968\n",
       "17   casual        2022-03-06 00:08:00  1       59037    819.0    1486.1308\n",
       "18   member        2022-03-06 00:08:00  3       64307    554.0     898.7038\n",
       "19   casual        2022-03-06 00:09:00  2       66027    885.0    1637.2488\n",
       "20   member        2022-03-06 00:09:00  3        5309    536.0     707.6362\n",
       "21   casual        2022-03-06 00:10:00  4       61344    803.0    1626.5700\n",
       "22   member        2022-03-06 00:10:00  3       39235    559.0     846.9280\n",
       "23   casual        2022-03-06 00:11:00  2       56555    792.0    1607.0809\n",
       "24   member        2022-03-06 00:11:00  1        4230    556.5     694.4378\n",
       "25   casual        2022-03-06 00:12:00  2       74206    856.0    1618.9384\n",
       "26   member        2022-03-06 00:12:00 12        5936    605.0     788.8684\n",
       "27   casual        2022-03-06 00:13:00  2       56005    871.5    1530.1321\n",
       "28   member        2022-03-06 00:13:00  2       41776    598.0     953.8305\n",
       "29   casual        2022-03-06 00:14:00  9       74439    902.5    2063.0093\n",
       "30   member        2022-03-06 00:14:00  1        6004    536.5     694.1146\n",
       "⋮    ⋮             ⋮                   ⋮        ⋮        ⋮        ⋮        \n",
       "2851 casual        2022-03-06 23:45:00  3       68596    889.5    1694.6316\n",
       "2852 member        2022-03-06 23:45:00  6       47102    573.0     850.6749\n",
       "2853 casual        2022-03-06 23:46:00  3       71267    920.0    1946.5260\n",
       "2854 member        2022-03-06 23:46:00  2       36779    529.5     806.5064\n",
       "2855 casual        2022-03-06 23:47:00  6       64095    862.0    1785.3710\n",
       "2856 member        2022-03-06 23:47:00 12       10440    586.0     750.1997\n",
       "2857 casual        2022-03-06 23:48:00  2       38653    861.0    1446.5809\n",
       "2858 member        2022-03-06 23:48:00  4       32281    542.0     808.1583\n",
       "2859 casual        2022-03-06 23:49:00  7       53174    874.5    1586.8428\n",
       "2860 member        2022-03-06 23:49:00  2        7905    593.0     743.5756\n",
       "2861 casual        2022-03-06 23:50:00  2       82489    849.0    1680.1189\n",
       "2862 member        2022-03-06 23:50:00  3        9162    501.0     689.4429\n",
       "2863 casual        2022-03-06 23:51:00  2       82081    887.5    1764.4862\n",
       "2864 member        2022-03-06 23:51:00  4       70118    549.0     900.3533\n",
       "2865 casual        2022-03-06 23:52:00  2       51866    915.5    1487.9421\n",
       "2866 member        2022-03-06 23:52:00  2       17037    497.0     699.9725\n",
       "2867 casual        2022-03-06 23:53:00  8       68021    872.0    1783.2430\n",
       "2868 member        2022-03-06 23:53:00  4        6598    512.0     663.1931\n",
       "2869 casual        2022-03-06 23:54:00 12       62788    857.0    1772.2898\n",
       "2870 member        2022-03-06 23:54:00  4       55930    543.0     791.1431\n",
       "2871 casual        2022-03-06 23:55:00  3       53854    898.5    1764.0921\n",
       "2872 member        2022-03-06 23:55:00  7        7623    583.0     770.3319\n",
       "2873 casual        2022-03-06 23:56:00 13       56332    926.5    1962.9030\n",
       "2874 member        2022-03-06 23:56:00  4        6741    538.0     704.5897\n",
       "2875 casual        2022-03-06 23:57:00 12       54746    836.0    1559.7952\n",
       "2876 member        2022-03-06 23:57:00  2        9200    526.0     687.7509\n",
       "2877 casual        2022-03-06 23:58:00 14       77052    882.0    1574.0991\n",
       "2878 member        2022-03-06 23:58:00  3       12955    602.5     758.7568\n",
       "2879 casual        2022-03-06 23:59:00 15       69460    873.0    1703.8753\n",
       "2880 member        2022-03-06 23:59:00  7       13140    511.5     730.7584\n",
       "     num_of_rides total_ride\n",
       "1    826          1366723   \n",
       "2    550           413942   \n",
       "3    820          1368147   \n",
       "4    525           430928   \n",
       "5    778          1335072   \n",
       "6    527           372283   \n",
       "7    779          1269157   \n",
       "8    526           395217   \n",
       "9    804          1494258   \n",
       "10   522           380393   \n",
       "11   794          1106232   \n",
       "12   541           405504   \n",
       "13   809          1615628   \n",
       "14   512           409359   \n",
       "15   804          1154324   \n",
       "16   533           418883   \n",
       "17   749          1113112   \n",
       "18   476           427783   \n",
       "19   860          1408034   \n",
       "20   536           379293   \n",
       "21   793          1289870   \n",
       "22   472           399750   \n",
       "23   841          1351555   \n",
       "24   498           345830   \n",
       "25   796          1288675   \n",
       "26   494           389701   \n",
       "27   772          1181262   \n",
       "28   478           455931   \n",
       "29   756          1559635   \n",
       "30   480           333175   \n",
       "⋮    ⋮            ⋮         \n",
       "2851 866          1467551   \n",
       "2852 569           484034   \n",
       "2853 905          1761606   \n",
       "2854 622           501647   \n",
       "2855 911          1626473   \n",
       "2856 576           432115   \n",
       "2857 847          1225254   \n",
       "2858 575           464691   \n",
       "2859 916          1453548   \n",
       "2860 589           437966   \n",
       "2861 841          1412980   \n",
       "2862 569           392293   \n",
       "2863 944          1665675   \n",
       "2864 583           524906   \n",
       "2865 794          1181426   \n",
       "2866 545           381485   \n",
       "2867 819          1460476   \n",
       "2868 549           364093   \n",
       "2869 797          1412515   \n",
       "2870 531           420097   \n",
       "2871 836          1474781   \n",
       "2872 467           359745   \n",
       "2873 876          1719503   \n",
       "2874 563           396684   \n",
       "2875 840          1310228   \n",
       "2876 570           392018   \n",
       "2877 888          1397800   \n",
       "2878 514           390001   \n",
       "2879 802          1366508   \n",
       "2880 534           390225   "
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Calculate the statistical summary of the bike demand over 24 hours of the day\n",
    "tripdata %>% group_by(customer_type, time) %>% \n",
    "  summarize(min_ride=min(ride_length, na.rm = TRUE),\n",
    "            max_ride=max(ride_length, na.rm = TRUE),\n",
    "            mid_ride=median(ride_length, na.rm = TRUE),\n",
    "            avg_ride=mean(ride_length, na.rm = TRUE),\n",
    "            num_of_rides = n(),\n",
    "            total_ride=sum(ride_length, na.rm = TRUE)) %>% \n",
    "  arrange(time)"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "1e86431e",
   "metadata": {
    "papermill": {
     "duration": 0.137139,
     "end_time": "2022-03-06T05:02:57.391607",
     "exception": false,
     "start_time": "2022-03-06T05:02:57.254468",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# **D. Data Visualizations**"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "851e8242",
   "metadata": {
    "papermill": {
     "duration": 0.136619,
     "end_time": "2022-03-06T05:02:57.664605",
     "exception": false,
     "start_time": "2022-03-06T05:02:57.527986",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**1. Creating visualization for the number of rides each day of week by rider type**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 26,
   "id": "8aee11bf",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:02:57.948465Z",
     "iopub.status.busy": "2022-03-06T05:02:57.946637Z",
     "iopub.status.idle": "2022-03-06T05:02:59.538016Z",
     "shell.execute_reply": "2022-03-06T05:02:59.536915Z"
    },
    "papermill": {
     "duration": 1.734898,
     "end_time": "2022-03-06T05:02:59.538150",
     "exception": false,
     "start_time": "2022-03-06T05:02:57.803252",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` has grouped output by 'customer_type'. You can override using the `.groups` argument.\n",
      "\n"
     ]
    },
    {
     "data": {
      "image/png": "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\nnhdCKP5k9NO7bzOyQ8dbszNuye9875Y7vfTr6+fMKa71iRKls766+bJ/77nTXd063ZKRNapT\ntweG7vv6DfcuLmmWL4dpWb2SC2Uz/jIiFhsRi/1zxPha11z6+rHJFZ56auraH/Ozs55MLuzx\n5EVrXzOz++n9+22Y27VrZvmTRdUvsLIo+UQP/eGzWv/q2W7tRsRid2z5WI32umy6ugy/Oo7k\npNGdckfEYg+P/DK+fMo7x+19e37n2wvyb87Mu2uT/s+dc1Xh/76bFf/3qVePO+ivG25wa2bW\nqK4bPXrISV+9NbP2jZKomP7gzS8cOuzejbrfmpV3d9+Bjx9w9Af3Plde29OvfVg2ofoOjwaP\n/xDqtwUaKS1n46rnLP2+MWU0d0ds+/fzkgtTfjV69Xvr+IbZhPt4Uh33lAX37DYiFrtjq38n\nb77aK39ELHZrl0PX+thpu2xTNf/xJ+Pn17hv3AszQwhZm/62Q5ddB22QF0JY8mzNAz1KJ9ya\nXMjZ5rJaTn5rwBhrimE5a9SJI9LSRsRid+545pLWl/cBAJFmDo6mtHjMTY/95IrFy8urW5bP\nnDJ95pTpT//jg1uOPfq1B7rVeSbLyX884ZnLH4mv9KmxbGFh4cdjCz8e+8XNNw198rNdD9u4\niauvj5IvH3pox9OKSipCCFl1mBlz2ZvX3bfP1eWV8eTNymULi775ePw3H39x2207P/TG8GNW\nmbaj9OvRo/c45Yd5K777VS4qLHz/1cL3X/3vLff8+NM3N9uoac6CqVz06tSFJSGEnC0uTrZk\n9b6wd8EVMxaVzL/59vDre1b/k4kXvRpCiGV22efg3mt55Pjy8R9OLgohZPY6Z6vu6/7h9LBv\n1/A9v56aatM1bCQnSqc/N/Cn305dUnWzonjZ9G8n3HXt5NEvHTv17fDoeY+dfW/1GAjzZ816\n4aFZYx6b98zkPQ5dZWNWFn3ywj4HTxj3Q3XL0u++WvrdVzP+868Pbzrw0Fee2GyT/FrLru+w\nrK8GD496jf/QiC3QMKXfPJdcSMvboknKaKaOyNrst93zr/5haVnZd7fGExetPGVm3d8wm2of\nT2rC9/xa9fztoHD47BDC3FETwm49q9sri96cOG95CKHzuT8OIWz7002/GPVl+bwnpheVbtwx\nu3q1hXd8klzoeskuNR65AZ3bJMNy1qiTHr3g4ZBI5O1wxknv3p1fh1N1AADqTsDRZIr/O/L+\n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\nVBp3FX/9kzu2+ncIYdj0xUNW2rbLP/z76IPOKVxQsvqzZ/Yasv+Lz2+5TeeVG9c+LOuoXnt6\n0jqHR8PGf6j/FliTshnXj9r4ihBChwNfPuvFelwmtmFlNKwjSr49/fb+969ztfSOA3YZ+eCu\nJ++0+l0NeMOs1sh9vL57SvWY3+f7pdv3XOPFg1eXKJs9Km+j8sp4CCG9w5ALi95b05rPdMv7\ntrA4hBBi6actK+mcW/vPGA0YY/X6k+qxt/XEBQds3mnV1eOvbdXtk68XhBAG/XvKgUdsuqbX\nAgBQXxH48T9COh586Rk/fLX31edvvOOAvM7tY5m5eb026f3jk/Z65K1ffPhQjU+6IYSs3hf+\n9PaLNujbIy09LT2vQ/s+VZ8O+//ltVOe++uWBw9v37VjWnpWbveNNjz0hL0eHfuLDx/p2S1n\nnzEje2+1SWZGZvYGm3Raw4fX1iat4+Ajvph+yJ9+s/Hg/rkd8tLyOnTYfPuB5//huKnTV/92\nt8llo3/x4bO7nHl0j602y87PjaVnZnXq1nXIPttdeesJU6fVJd2oQ0FZ2V179NjniN3ufeHn\nHz5Qa7oRQuj0i8uTC5ldj2pYuhFCyOp36BEfzTzxub/vdNbPug/om9e5Y1p6Zlanbh233GnA\n6Rcc+MK4s8c/u3q6EUJIy9/hqEnf7Hv12b223iwr938HocTSeh5/9QnvjspKr2XnrdemW9Pw\nC/UfyU0rb+dTT5495aCbftd3923bdS1IS8/M7tKjx14/GnrbY2dOfaeO3+1bQN2HR73Gf2g1\nWyDlZcSy2rXr3afnvkcNu+2fp30/vtZ0IzTuDbOR+3iL7SmxrJ6De1VdjKndrpevZc0dDq06\nuCOz+ylrSjdCgzq36cZD2vCX70xen/urEw9bWFs8BADQMI7goBlV/4Jd358rW4nymbeP7H1e\nCKHniPHHX1zLF9GWVLFw9sJvZ+Rsvm37TimefoKkdQ6PqI//9UGr2scBAGikaPz+Dykx89e3\nhhBCLHPPM/unupaQ0alnt517proKVmhVw4OG0YkAAG2JU1SgdonSGS8/My2EkDPgmg071Jym\nlPWc4dEG6EQAgDZGwAGrSJT+UFZaUbFoxidnHbC4pCKE0P+uk1NdFK2F4dEG6EQAgLbKKSqw\niuLPTk/Om5CU1fv4/fZwYghVDI82QCcCALRVAg6aU1pOZn5+CCE9lupKGiR7830Pe/Ov0ayd\n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\nD9+41se37bTVWRVbztyu9/jpXW57/MX33nj+xJ7l5/bf8puisuULX9+4z7Fh95Oefu3/Hrj2\n1PfvPGeP0ROrPsKfzpP8J5YsCa7BUV5cXJKWlZ0ZS241AAAAQAhh7qTT7v56+Stz79yhYVYI\nYeMXZ/c56L6flpevnZW27pFn3XbokN5Nc0MIndqdfeJVfT5csrzxomcXlZUfdcxBW6+dFzbv\n+sL4tb/Ia1z1If50nvVycmvg2SVDQgFHvGxRQV7hVvd98coB7ZJdEAAAAPDD42/lFO5akW6E\nEOq1GPzyy4Mrbp948tEvPz7+0s+mfPvt1x+98VTFYH6rkw7+xx37rLvejr123X677Xr22uuf\nGzav+hB/Ok90JfQVlVh6w1M6N/r69neTXQ0AAAAQQigvLo+l5fxxvKx4Wp8OrQ4Yef+C9Mbd\n+hx8zYNjKsbTMprc884Pn750R99/tJr00t09N23V68zn/3TmovJ4FfNEV6KXiT339ac/2q73\nsdfkjjyqT+Ps9KTWBAAAACmuZZ+Ni84f/97iki3yM0MIS2fc027T0++Y+O0W35/yzHdFPxU9\n0SwzLYSwdOYvwcSMN68Y9cjyqy4/s/N2e5wQwsQbt+162unh4g8rts4tKa+4sXTmg/NKy0MI\n8yb/+TzRlegio332H7qs2To3nLh307z6a7dqs97/SmqJAAAAkGqabDr6n83Ke+9y5JMvv/PB\nm88cs+tJRfl9dy/Mzm78j3j58svHvvLdD9+89dxd/bqfEUKY+NXMjLUWXf2fswZccOf/ffjp\n2688Ouq6KQ077hdCCLHsrRtkjx180ftTvvt0wjOH9/h3WiwWQvireaK7ymiiZ3Dk5OSE0KJ3\n7xZJrQYAAAAIIcTS88d9+tKpg88+4cCes8oabr7LEa/cMDKEUL/Vac9e+u3xZx9w7cKMTbbs\nMWL8580P2ei87TfsNXfuM/+Zfca1Z+wwYm7DZq03737EKzecVjHV4/8d3e+Ii7ptcPmysvLt\nDrv2gJmnVz1PbT7t1RCLx+O1XcMaoby8fG5ku1hj8vPzcx6O6oK6CZq966zaLmGNkJGRUfB0\nYW1XkVx6XamgoCDjgczariK5tLtCTk5O/uP1a7uK5FrVXjdtemdyClkjxMecVtslJNcqtVuv\nI81He0XanaAmTZpUyzyVFi1a1KDBTdU758KFR9WvX3P/NMfLl82YG2/eJK/GjljDEj2Do8KU\n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"
     },
     "metadata": {
      "image/png": {
       "height": 480,
       "width": 720
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Let's visualize the number of rides each day of week by rider type\n",
    "# https://www.kaggle.com/getting-started/105201\n",
    "# https://www.kaggle.com/regressionsquirrel/resize-ggplot\n",
    "# https://stackoverflow.com/questions/34522732/changing-fonts-in-ggplot2\n",
    "# https://stackoverflow.com/questions/28243514/ggplot2-change-title-size\n",
    "\n",
    "options(repr.plot.width = 12, repr.plot.height = 8) # used to resize ggplot figure\n",
    "tripdata %>% group_by(customer_type, weekday) %>% \n",
    "  summarize(min_ride = min(ride_length, na.rm = TRUE),\n",
    "            max_ride = max(ride_length, na.rm = TRUE),\n",
    "            mid_ride = median(ride_length, na.rm = TRUE),\n",
    "            avg_ride = mean(ride_length, na.rm = TRUE),\n",
    "            num_of_rides = n(),\n",
    "            total_ride = sum(ride_length, na.rm = TRUE)) %>% \n",
    "  arrange(weekday) %>% \n",
    "  ggplot(mapping = aes(x=weekday, y=num_of_rides, fill=customer_type))+\n",
    "  geom_bar(stat = \"identity\", position = \"dodge\")+\n",
    "  scale_fill_manual(values = c(\"darkblue\", \"orange\"))+\n",
    "  labs(x = \"Day of Week\",\n",
    "       y = \"Number of Trips\", \n",
    "       title = \"Total Trips By Customer Type Per Day of Week\",\n",
    "       fill = \"Customer Type\")+\n",
    "  theme(plot.title =element_text(family = \"sans-serif\", color = \"darkred\", size = 18))+\n",
    "  scale_y_continuous(labels = function(y)format(y, scientific=FALSE))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c9b41c55",
   "metadata": {
    "papermill": {
     "duration": 0.143165,
     "end_time": "2022-03-06T05:02:59.823139",
     "exception": false,
     "start_time": "2022-03-06T05:02:59.679974",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "From the bar graph above, we can observe that casual riders are highly active on weekends because it is obvious that casual riders mostly use bike-sharing service for leisure and tourism purposes. It is interesting to note that the distribution of the number of trips among the annual members is more or less consistent over the entire but slightly goes down on weekends. This indicates members mainly use the bike-sharing services to commute work."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "296be166",
   "metadata": {
    "papermill": {
     "duration": 0.143078,
     "end_time": "2022-03-06T05:03:00.107923",
     "exception": false,
     "start_time": "2022-03-06T05:02:59.964845",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**2. Creating visualization for average trip duration each day by rider type**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 27,
   "id": "b24c7ef2",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:03:00.396931Z",
     "iopub.status.busy": "2022-03-06T05:03:00.395230Z",
     "iopub.status.idle": "2022-03-06T05:03:01.132281Z",
     "shell.execute_reply": "2022-03-06T05:03:01.131696Z"
    },
    "papermill": {
     "duration": 0.88238,
     "end_time": "2022-03-06T05:03:01.132404",
     "exception": false,
     "start_time": "2022-03-06T05:03:00.250024",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` has grouped output by 'customer_type'. You can override using the `.groups` argument.\n",
      "\n"
     ]
    },
    {
     "data": {
      "image/png": "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\nJYvHLVg87uOvbr1p8NDn9jlnh0YWX6+yb0aP3vWk2XN/+mRbtWjevPdfnff+q58Pves3/31j\ng3XyG/M8zeuaZNnUZwce+d3kZfFQsnJp8dTvvr3jmgmjXzx68tth1LmPnHVP9aER5s+Y8dxD\nM154ZO7TE3Y9cLn91uInpUZqdkc39ahv2dNXq629ibu3OSexxp9zWvaobPa5aKXWvWqrcNAL\nIYQP359zyD7rVLcnln77zZxlt6le8vjoMHTbmo+adePY1MQ2h65X3diMjmuRV9qMW08YdcHD\nIZnM+8VpJ7x7Z4Ff5QBAS2tDAcf0ix5OTWz+t+1TE9nr/bFPp6umLSorm3zD1EVXrdspp3rh\nrLVO2HSts7+eU1zy0cVLK49ul7n8pS7J8tf/NTmEkNn1oO36dlzWVjb1iU12mTKrOISQv+V+\ng47Yp3OvDmUzxk969L7JX8wt+/6Fpzbb+cipH/TqWPu9XbJ00pM7nVGY2WfQpaetv+OWBWst\new+9+LETn/yfh0MI8dzeG59yfK/N+uW2yyidPW3mq/8a9+LnycqF7x+588BFEzvm/PQOqfSb\n4SMPubqiKhHL7NDvpDPX3WZAvGz+rJcfHfvsx99cuvf0nHq6u9ll19Trno9+f3vVkid/89Dp\n74QQDps0s0f77FjGch//GtrMBiXLR+33vxVViYyO/QecdMTa/XtVzp827dmHJn04PVk++4Oj\nN89ab9r22621kicJYdJFO75424chhBDL7H3Q8X132iIns2ze+y+NfezVuY9f/tjXHVf6DI3X\nIl3ZmJ1Zy9LPh913wGWViWQIoetev91kv50LOmUXT/z8u5EP/DCjuOSTUf/ctOSMSU+0q3O3\noCXPnP78a5/Fc/sMuvD8vr/cPLNi/tyPX/3ohvtKyqsKXx/y9L2nHX5G/0Zu++cH7TzzswUZ\nnTfd5OTD1+rXo3L+lGlP/2PSxzOSVUVf/P6XsZ6T9z4k9ekivvPRff95x9cVs+6euHBY3865\nNZ8kUfLVm1/OCyHk73Rrh5yVvPUvfuPKkUdcW5VIhox2Gxx9+gY7Ds6sXDj/y/e+Gvl0acWi\nL87bKdZzwt6Hrd/I+mtJlk17fLvjZxeWh1hs7f2P32iXLfN7dKqcM3XKE/d+/960ynmfPLvT\nOedNvj+srL+a3TVzrz/4h8Xl7Tb/9dYn/2btQb2Kvv38y+uunTGzuHL+h6O337P867fj+f22\n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"
     },
     "metadata": {
      "image/png": {
       "height": 480,
       "width": 720
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "options(repr.plot.width = 12, repr.plot.height = 8)\n",
    "tripdata %>% group_by(customer_type, weekday) %>% \n",
    "  summarize(min_ride=min(ride_length, na.rm = TRUE),\n",
    "            max_ride=max(ride_length, na.rm = TRUE),\n",
    "            mid_ride=median(ride_length, na.rm = TRUE),\n",
    "            avg_ride=mean(ride_length, na.rm = TRUE),\n",
    "            num_of_rides = n(),\n",
    "            total_ride=sum(ride_length, na.rm = TRUE)) %>% \n",
    "  arrange(weekday) %>% \n",
    "  ggplot(mapping = aes(x=weekday, y=avg_ride, fill=customer_type))+\n",
    "  geom_bar(stat = \"identity\", position = \"dodge\")+\n",
    "  scale_fill_manual(values = c(\"darkblue\", \"orange\"))+\n",
    "  labs(x = \"Day of week\",\n",
    "       y = \"Average trip duration\", \n",
    "       title = \"Average trip duration by customer type per day of week\",\n",
    "       fill = \"Customer Type\")+\n",
    "  theme(plot.title =element_text(family = \"sans-serif\", color = \"darkred\", size = 18))+\n",
    "  scale_y_continuous(labels = function(y)format(y, scientific=FALSE))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8942859e",
   "metadata": {
    "papermill": {
     "duration": 0.142661,
     "end_time": "2022-03-06T05:03:01.417945",
     "exception": false,
     "start_time": "2022-03-06T05:03:01.275284",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "The bar graph above shows that the average trip duration of casual riders over the entire week is considerably longer than or more than twice that of the annual members, and takes a high peak on weekends. The distribution of the average trip duration for the members is consistent irrespective of the day of week."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "840427db",
   "metadata": {
    "papermill": {
     "duration": 0.14387,
     "end_time": "2022-03-06T05:03:01.704751",
     "exception": false,
     "start_time": "2022-03-06T05:03:01.560881",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**3. Creating visualization for the number of rides each month by rider type**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 28,
   "id": "4d79a13e",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:03:01.998180Z",
     "iopub.status.busy": "2022-03-06T05:03:01.996517Z",
     "iopub.status.idle": "2022-03-06T05:03:03.038741Z",
     "shell.execute_reply": "2022-03-06T05:03:03.038157Z"
    },
    "papermill": {
     "duration": 1.19037,
     "end_time": "2022-03-06T05:03:03.038872",
     "exception": false,
     "start_time": "2022-03-06T05:03:01.848502",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` has grouped output by 'customer_type'. You can override using the `.groups` argument.\n",
      "\n"
     ]
    },
    {
     "data": {
      "image/png": "iVBORw0KGgoAAAANSUhEUgAABaAAAAPACAIAAABM5kn/AAAABmJLR0QA/wD/AP+gvaeTAAAg\nAElEQVR4nOzddXwcZf4H8Gfj1jY1qEMFKFLcylGkuNzh7nq4FDnB/Q4vzmHF3X9AOa64uxQo\npaXUaKlL3Pb3x5ZQSZNNm2Qz9P1+8cdmdnae73znacJ+dnYmFo/HAwAAAECUpaW6AAAAAIDl\nJeAAAAAAIk/AAQAAAESegAMAAACIPAEHAAAAEHkCDgAAACDyBBwAAABA5Ak4AAAAgMjLSHUB\nrUjRW7vcsc3wxr7q6JLKDrmpb+NduZlzy6oKthl+whs7NdMQ18ZiIYQOR7579H1/aqYhklTy\n0e63bf5SCGG3acVrds5LbTFAa/ZE+9wJc8ry1n/xpC92T3UtAAA0r9S/M1+RVYx7+YfXp4QQ\n+h5+VF5my51Nk6pxaVor+HFcwXefxZgPAAAIOH6XtcpBm5+/8eJLq4s+vOrGEEJ6m403OX3n\nJV+Vm7Hs/ydd8vHVrx77Vgjh4P0Py8vMWubtRGVcmtYKfhxX8N1nMeYDAAACjt9lrXr4lpct\nvjBeOTURcKS12XzLy5Z4ekVy2KefhhDSO/VPdSEAAACwOAEHyVp5o41SXQIAAADUzReVaUDZ\nmAnJr1xTPL+qorr5iqGFVM0rm1scT2kJjZp4TSW1E7glR290e1M9JcrnFdXUpG54AACiwBkc\nTaxm/pivrr/tx5eGz/hpctn86pyVVuq08VZ99z1qg4O3Tov9vtqkg1Z77LExtT8+0jY7hJDd\n5/pTx55Zu7D8x3c+u/W+8W++O3vir2VzSzPatmvbd82ug3dd99RTu/bIX7by6h/3wTbZvxZV\ndLvj+4P/2r981PA3z7xw7PtfVbU9/bSJV4cQbslML6uqWfguKgvuZpKWe3Z1SennT7x6xuXj\n3htZXRNPz29f0LNvr932XO/sIV265C5ZRrx88ve33jrqhdd+/XZM2ezi9Dbt2vZfb5U/H7DR\nkKPb5qQ3bpdqSkbddOXIh5+ZNmZCeUVGfrfe3Xfabd0hf+vZp03tKhUTr7up19khhC7XfH3o\n2QOW3EbRGwfdMfixEELfZ8bttdeqDY5ZPWvk59fdNubF/82aMLmiOqegR5+eu+6xzqln9Fi1\nYKGV5l6bURhCWPniLw67aP0lN/JC5/zRM0py+z968vcHLrw8meYkM3+SnIoJiTtNdL1x5EHH\n5X1w7DFfPPN2WXl1LCM3r1uPHrsdOPBf53dqmxVCKP3q2ff//Z+xb31WMm1OWruVOm82eL2/\nXbnWVj3q6FG8asKDN4184pnJX/5YPG1+Ts/e7futteq+h294zO6ZSwxf/8Rb0tJ2/69v1jTq\nQC/zBG7sDtapxUZvbHsTmnxKLNuEPOT0tX664dR3hj40ffzcEItltu1QuM7Gqx160mZ//Uv6\nb69K5p9DQuXEtz684tYfh79f9Ouv8cw27dbZeLVDTtz8pL3SkzpiAAC0dgKOpjRv+NWP7XP+\nvJLK2iUlk8ZNmDRuwnP3f3TDQfu9Pqxz22QvfTf2X4c+f94jNTW/f2JaMXvGjE/fmfHpOyOv\nv3rg019u8ZdeTVz9Qsq+ffDBjY+eW1YVQshq2/D6xW9dfvd2F1VWL/iAtbp49txRn34z6tOR\nN9+86YNvDtp/kct2lH//xBNbH/nr9NLaJdVzZsz4cMSMD0d8dcOde3zxVu+k45uasp9f2mzb\n7z+dVrtk3pgv5435ctQdQwfc9OqOJ22RWJjV88yehedPnFM28/pbwtl3Lrmd0UNGhBBimR23\n27Vng4POfubCJw65an5Z1W8LSuaOmjV31Kff3nTdgBte3vGUgUkWX6emas6yTcV4+YQX1z7g\nx5/nL/ixqrR4wo8/3H7Z2CdePejnd8Ojpz524l21RznMnDz55QcnD39s+vNjt959kb5Vz/38\n5e12/eGzX2uXFP30XdFP303871MfX73z7v97svcqBaEujZ14i1nmA92oCbw8O1inFht9Gdrb\nVFNimX83fnvUhq8M+/K3auKVc2dOf+/V6e+9+s3jZx894uoks6QFNbxy2cN7XlJce45M2ewZ\nH7w244PXRj7V6E0BANA6xeLx1J6H3trFK6del9U1hJDZ7ZTTJ99cz5qlXw29c8Mzq2riIYSO\n2++/5i6DCgqzin/66sdh90+dXBxCyOy+x/HjnsnNTAsh1BTNKS+vnvfsHg8e914IYZ9xv3Rp\nkxVLz88pzAkhzH3yiLv2fyCEkJbTffWjD+u2br+c3PSyXyf+MuLpUa9+FUJIy+l1zJyf2mX/\nfrLDXbmZc8uqCrYZfsIbO9VTZP3jJj7p7Xrjy2kX7z2lqutaJx+76hYbFKzUv8fmvUM9Z3DE\n0gtzYnNKq9LbrdH/yP1WXqNb1cyJE198cNzHk0IIIS1ry/cnbr7ZSgv6WT7xkc79psyvCLHY\n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\nupl/eHTChAlbOhgAAACwsb9Yo5BaIyMppeaqX36IbLQxklQlzg//8wNValeJJKWWvNvqtf9y\n/wkWb8Hx2uU9xn6+MghWvvDMYymRPz6q4AAAAICyV2O7ftHCGeMX5V/csviCJtFLevVYfPTE\n//ZrFf9Oxj2/qOcR2xbffujWT2tsf3ON7er9892WsXgLjrPHzs1qesTsV8fvsk3tUg0EAAAA\nxCm99oG39W48cPdDskYP3HX7WrMnXjLq9R+ffqTZZu1k5gm9b8q5rWeLqq/cf93QD1eP/Khv\neu1a/3y3ZSyugiNatPajdQU9xt+g3QAAAIBy5bwn5607//Trzz5qcW5a64573//KE71rpcX/\n4clVGj074sjLru435PucFh063/zYR+e3qfXPd1v24io4IpGUbdKSV36wNDiuRWkHAgAAAIIg\nWJRbsOF2nTbT8je67MdZX64467fbSan1B97xxMA7/s6HZzY4tSD31CAI3j3zhj98+KZ2uyK/\ncLO/kjIR31VUImlPjvnPZ6MOHDnzo2jsZwMAAACUqXjPwXHm5C8bp2T3P2THy2s2qJeV+odH\nv//++y0dDAAAACBe8RYcdevWrbvvQR1KNQsAAADA3xJvwfH444+Xag4AAACAvy3egmPVqlUl\nPFqjRo0tEQYAAADg74i34KhZs2YJj0ajzj0KAAAAJEy8BcfQoUP/5360YNHXnzwxdfqKSOOh\nd1y/xWMBAAAAxC/egmPIkCF/3jjy5rd7br/nyFHzBp183BZNBQAAAOVL9sGrEx2BkiT9kw/O\naNBtwrAOy/7vtpdX5W6pQAAAAACbK94VHJuS2SQzEklulZm6RdIAAABAOVStWrVERyCGf7SC\noyh/6W1XfpCa1bFh6j/aDwAAAMA/Ee8Kjl133fVP24p++nL+wuU5XQaP3bKZAAAAADbLPzlE\nJanpjvsc2vP44YO6bbE4AAAAAJsv3oLjzTffLNUcAAAAAH+bc2cAAAAAoVfSCo7PP/88zr20\natVqS4QBAAAA+DtKKjhat24d516i0eiWCAMAAADwd5RUcAwdOrSER4vyl99/253frMtPSs7a\nwqEAAAAANkdJBceQIUM29dAXz9116mm3fLMuf+vdj797osvEAgAAAIm02ScZzfvl48HH7dZq\n3zPeXtFg0ITnv3n1/t7b1yiNZAAAAABxivcysUEQBEHRC3dfefoFN3+zvmC34wbfffuVbapX\n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\ngg=="
     },
     "metadata": {
      "image/png": {
       "height": 480,
       "width": 720
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "options(repr.plot.width = 12, repr.plot.height = 8)\n",
    "tripdata %>% group_by(customer_type, month) %>% \n",
    "  summarize(min_ride = min(ride_length, na.rm = TRUE),\n",
    "            max_ride = max(ride_length, na.rm = TRUE),\n",
    "            mid_ride = median(ride_length, na.rm = TRUE),\n",
    "            avg_ride = mean(ride_length, na.rm = TRUE),\n",
    "            num_of_rides = n(),\n",
    "            total_ride = sum(ride_length, na.rm = TRUE)) %>% \n",
    "  arrange(month) %>% \n",
    "  ggplot(mapping = aes(x=month, y=num_of_rides, fill=customer_type))+\n",
    "  geom_bar(stat = \"identity\", position = \"dodge\")+\n",
    "  theme(axis.text.x = element_text(angle = 45))+\n",
    "  scale_fill_manual(values = c(\"darkblue\", \"orange\"))+\n",
    "  labs(x = \"Month\",\n",
    "       y = \"Number of trips\", \n",
    "       title = \"Total trips by customer type per month\",\n",
    "       fill = \"Customer Type\")+\n",
    "  theme(plot.title =element_text(family = \"sans-serif\", color = \"darkred\", size = 18))+\n",
    "  scale_y_continuous(labels = function(y)format(y, scientific=FALSE))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a0b9fe8b",
   "metadata": {
    "papermill": {
     "duration": 0.175051,
     "end_time": "2022-03-06T05:03:03.360730",
     "exception": false,
     "start_time": "2022-03-06T05:03:03.185679",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "From the graph above, we can see that summer is the busiest time of the year among both annual and casual riders but the number of trips taken by the casual riders is higher than the annual members in June, July & August. The lean period of the year (November through March) shows the same trend among both type of riders but the casual riders’ bike usage is very low during this season compared to that of the annual members which is fairly good. This could be attributed to multiple factors such as bad weather condition that might impair the customers from using bikes. "
   ]
  },
  {
   "cell_type": "markdown",
   "id": "12f39d39",
   "metadata": {
    "papermill": {
     "duration": 0.145844,
     "end_time": "2022-03-06T05:03:03.652828",
     "exception": false,
     "start_time": "2022-03-06T05:03:03.506984",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**4. Creating visualization for average trip duration each month by rider type**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 29,
   "id": "80022cf7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:03:03.953643Z",
     "iopub.status.busy": "2022-03-06T05:03:03.951941Z",
     "iopub.status.idle": "2022-03-06T05:03:04.651476Z",
     "shell.execute_reply": "2022-03-06T05:03:04.650589Z"
    },
    "papermill": {
     "duration": 0.851867,
     "end_time": "2022-03-06T05:03:04.651636",
     "exception": false,
     "start_time": "2022-03-06T05:03:03.799769",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` has grouped output by 'customer_type'. You can override using the `.groups` argument.\n",
      "\n"
     ]
    },
    {
     "data": {
      "image/png": "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\nX7//0NMa/vziBVeN0XHwtynLojAlqpWCgzXLvO/GPfL48J9KFMYAsOZKJorHXHnubU980mi9\nDZrkzLz7ugH3fdKw/9DTGvw4ScexhOtcRLJUU/bSx9MqfntXli2DSpFVQsGxOnBUQnR11zuy\nfV7RbU99n+ogAEDK/Dzp+hd+bDLkynMO+teerQpCbsNNd9+swdyS1hUdxwPvz0p1wBrBdS5W\n6K9N2Z2vTa/oOJRlS1MpssooOFYHjkqogrTMIw5t/8OE2+b7mxQA1lQfPPNdi569GmdlvDnm\n8nveqz1gyIn539w/6JK7s+u2P/eKS/ts1iDVAVPMpXMjWmZTNmNG8ZKOQ1lWQaXIKqPgWB04\nKqFy5cW/jB15ywvvf1dRaTTc8vgW6TNuefWXFMcCgH8sUTbzjosve3fG4mTZ3B+L/FdHVHlZ\n6UW/LFjSbjTNychtVFg8740F5cnM/DW93QghvDx88MV3v+06Fyu0vKYshKAsW5pKkVXG31mr\nBUclVOrRi8975oefx94w5Kwh17/44dS09Lze+6035cF7SpPGBUC8pWfUXbv+vJsHXXbHpYPu\neOyrVMepWcoWLVhyO5ksfeOJe66+dMjQa2+e8PrXGx/Y8edJ19z1Rm5FuxFCWPjdt5m569bK\nSEtd3hrEdS4iqqQpCyEoy5ZQKbLKKDhiKVlWnCyb66iEFao4wPKZX1tedfGg4VcO6LpOcsz1\nF509dOSUhnsWlk658yOHwwEQc2lZPY4/s17i59e/K9p9pxapTlODJMvnX3HO2aMmfVtxb/yV\n59z5nymN19mgSdbccbdfcvM7LQ/dtlXpgi+ee+71r7768v1J4y6/5cMtDj1+ja43/nIOSNe5\nWGJ5ZdmPzQs0ZUuoFKkJMgYPHpzqDNUimUwuXrw41SmiysjIyM3NDSEsXrw4GeGwgscvP/f9\nOuvm/PrFY+MeeuH973LrNVl37YZtcz4ZP+7D3Xtsk5G22v5NkZeXl5aWVlpaWlZWFuX5Lw87\nf9TnuenF7ffp1jIzr96GnbbadftNyqZPfuzhRxeWJ6d/Nn/P3Tdb/YaVnZ2dmZmZSCSKioqW\n95zi2ZOLshtkp6eFEJLl8yfcc+NNtz/w5pTZbTdtXztjjeg9l+x0RUVFUXa6NVZVd7o1U3Z2\ndlZWVuU7Henp6Xa6KJbsdKWlpRFfsnj62x8uardjo2kPPPhasy5bNamVVa0Ja4KKnS6ZTFay\n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\nsrXJzQ16FAAAAABJRU5ErkJggg=="
     },
     "metadata": {
      "image/png": {
       "height": 480,
       "width": 720
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "options(repr.plot.width = 12, repr.plot.height = 8)\n",
    "tripdata %>% group_by(customer_type, month) %>% \n",
    "  summarize(min_ride=min(ride_length, na.rm = TRUE),\n",
    "            max_ride=max(ride_length, na.rm = TRUE),\n",
    "            mid_ride=median(ride_length, na.rm = TRUE),\n",
    "            avg_ride=mean(ride_length, na.rm = TRUE),\n",
    "            num_of_rides = n(),\n",
    "            total_ride=sum(ride_length, na.rm = TRUE)) %>% \n",
    "  arrange(month) %>% \n",
    "  ggplot(mapping = aes(x=month, y=avg_ride, fill=customer_type))+\n",
    "  geom_bar(stat = \"identity\", position = \"dodge\")+\n",
    "  theme(axis.text.x = element_text(angle = 45))+\n",
    "  scale_fill_manual(values = c(\"darkblue\", \"orange\"))+\n",
    "  labs(x = \"Month\",\n",
    "       y = \"Average trip duration\", \n",
    "       title = \"Average trip duration by customer type per month\",\n",
    "       fill = \"Customer Type\")+\n",
    "  theme(plot.title =element_text(family = \"sans-serif\", color = \"darkred\", size = 18))+\n",
    "  scale_y_continuous(labels = function(y)format(y, scientific=FALSE))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "ca34e1ef",
   "metadata": {
    "papermill": {
     "duration": 0.152185,
     "end_time": "2022-03-06T05:03:04.955707",
     "exception": false,
     "start_time": "2022-03-06T05:03:04.803522",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "The graph above shows that the average trip duration made by casual riders is still considerably longer than those of the annual members throughout the year."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "a42ac6fd",
   "metadata": {
    "papermill": {
     "duration": 0.151476,
     "end_time": "2022-03-06T05:03:05.257866",
     "exception": false,
     "start_time": "2022-03-06T05:03:05.106390",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**5. Creating visualization for bike demand throughout the day**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 30,
   "id": "5783978c",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:03:05.574956Z",
     "iopub.status.busy": "2022-03-06T05:03:05.572710Z",
     "iopub.status.idle": "2022-03-06T05:03:07.061934Z",
     "shell.execute_reply": "2022-03-06T05:03:07.062382Z"
    },
    "papermill": {
     "duration": 1.650452,
     "end_time": "2022-03-06T05:03:07.062560",
     "exception": false,
     "start_time": "2022-03-06T05:03:05.412108",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` has grouped output by 'customer_type'. You can override using the `.groups` argument.\n",
      "\n"
     ]
    },
    {
     "data": {
      "text/plain": [
       "<ScaleContinuousPosition>\n",
       " Range:  \n",
       " Limits:    0 --    1"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    },
    {
     "data": {
      "image/png": "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\n0jcc9eZVR77nzH2W7bdyycOr3jTGaVH6qA/l5d/1ujvG2qVtdyHLrowZ2YxmREZczKN6PIq8\nH8HJjbuUrOsM/yojImrUD6bU2G0pu6vZz9qqNH6pk778Kr8SKr/8TvviqstPeeAHX3jqqjuO\nfOrzN4vIEd84e5ziAQAAAMwoMzrg0PS4yG4+Ll77p18e0RGWs350wRc7bl3zu+OueuxvXz5S\nRIzw3rNMvctJfen668f7xD8Zzg1ffEZEDr3qjVP8QoMufNdF6wbyn7r7rzecOTS8pW/Dnydx\nqPji/UUe3PH430QOH/Gt33ZnqqpygqzEm3SlMt0P2CIjQoh1D28Tkfkrx2tFyadfGna0+CEi\nkun5vcg15dszvf9b89qm1KQvv8qvhMovv4XHfSOs/WbDT65yvve7S+5Zp5vt3377HhMpCgAA\nAECQzdAhKp4df71VRCIdJ42zz/wmb9EH/SsPfjOkqSe//u6fvJYSEVHm5fu22LntV/55+/Bn\nOJ84aO958+b9rHOSn+ef/u6Z39s6YEb3u8378DZlL+Rx7d57t6eM0J7lHy9FpG/Nc5M4WmKP\nT7WZWs/azzw0vKquf3zp0d5sNXVOlB7e+6w50UL65cv/tK18eyG95uK/71Sadcm+w4a0JLcN\nK3jzg18q/9KMH3xqRzTb+3/f2dRfvv2JL99b89qm1mQvvwqvhAldft4olWzv/33+f//1L/25\nuau/tXCyE7sAAAAACJ6ZG3C8+rcfn3Tyj0XkwIsvrWT/xKKzfvqx/Rx74CPv+Lw3wOCsOz8m\nIt845th7/jI4Talr9//npUff/PS6bNPpJ7SHJ1pSdufLd3z2g2/86H+LyNn/8avZxU5+31+o\nnNITe4V1O7fpjme7Sxv/+j83HHPSL0XEThcmdDQ9tPD7Z+7j2unTDzvr8VeT3sbu5399wlvH\nW86mnGtPfu6SEa7+5vEi8u13nnD/84NTWhSS6654z1tfzRYWHnfbqsTgeqXerCJ//ug12/KD\nvTzdz/30+LPvH3G0r9x8kohcduyFz/flvS3rfnvjSd9ZIyKiJvz/yN/aPJWcukmc3sldfhVe\nCRO9/E774ioRuf6kW0TklJvePtGfBQAAAECQ1WTtlmnjLROr6fHlwy1oG1zZoe2AD3blBxfJ\n3NUysaWjFbKbViUsEfngf6/zttx32bHecRYfuOrot67euyMsIqHmg+9/LemOa/BZy4ZK2muP\n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\ndsN6/6l/ScQffzYSq9d3iYn2fNakU1a3aLK82L4pN6+tyeheqSy77C+bhSid7onaCTlO5z0x\n0T8WWbdYbU+WuvzywnS6QQnnX0JlyWUXtaRQFDWyajsRAAAAAKiWWHCgRojV65+qk/hgYtx2\nq+3WyAi9osxo3KD8YZ7txgUlGgwjatce0bB+Tk6Ow+G44DENjMaPGtUXQnSNjb7gAQAAAACA\nvwMLDtQgiXr97VEXeOVXAAAAAECo8/b7agAAAAAAgJAQcs/gcK2bN3X5+q1H8/Wt2lz/wL8H\nN40IuX8CAAAAAAAIsBB7BseBRWOnzM9o3yP1+eEDo/aveW7Ehy7ZSQAAAAAAQLqQWnCoJW/M\n39Os78SUTjf8w3LzE68+Xnhi1afHCmVnAQAAAAAAyUJpwVGcu/6IzXnHHedf/MIc1+HaKNOW\ndSflVgEAAAAAAOlC6QQWJYU7hBCtI4yej1wRYVi5I1fcf/7d9evXHzx40P222Wzu06dPWFiY\nqqp+/n/1er1OpwsPD/f/cjxt2qnS/fHCqGFhYS6Xv3/xYzAYVFUNYJXZbDYajd4P9qVKCKHB\nKkVRqmuVoiieKvf17w+j0ajNqoB8D3qqTCaTZ0r4U6XX6wN7XQWkKiDXlYfJZNJ5fVFnX1T7\nKveN6P728fOiDAZDwK+rgFQFZDKIUteV/xdV7avcX+QGgyEg94sCfl0F6t6a1q4r90VV+6qA\n/PzS+HXl/0OAv+O6CsgDk0BVub+dA/Igzul0+nkJCEWhtOBwFRcKIRINf959rGXUOwpsnne/\n/vrrlStXut+Oj4/v06dPREREoP7vAbmH4abNqgDec9Vmlf8PaD2o8l1YWFigLkqbVZGRAXvh\nYW1Wmc1ms9kckIuiynfVvspkMplMpoBcFFW+q/ZVRqMxUPdAqPJdta8yGAyBugcSwIcAVPmi\nuLjY/wtByAmlBYfOFC6EyHa4ov74deI5u1Mf9+fP14SEhAYNzv8BS2xsrAjQ3s693fT/2Q2K\norgviirfq1wuV6BW3dW1SvyxNaeKKqqqRFEURVGoCukqnU4XkB9eVFWPKlVVA/WzPlB3ihRF\noYoqqi6iKiBDxv9LQCgKpQWHMfJKIdb/anU0Mp9fcGRaHbEd4jwHjBw5cuTIke633d9dubm5\n/n+bRUdHO53OoqIiPy/HaDS61y55eXn+j5Lo6GiXy1VY6O85Vg0GQ1xcXKCqoqKiVFUNbJXD\n4fC/SghRUFDg5+Xo9fr4+PhAVUVGRiqKosEqnU6Xn5/v5+XodLqEhAQhRH5+vt1u9/PSIiIi\n9Hq9BqsMBkNeXp6fl6MoSmJiohCioKCgpKTEz0sLDw83Go0arDKZTLm5uX5ejhCiVq1aQojC\nwkL/fy0TFhZmNps1WBUWFpaTk+N/VWJioqIoRUVFNput8qO9MpvN4eHhGqyKiIjIzs72vyoh\nIUGn01mtVqvV6udFmUymyMhIDVZFRUUFpCo+Pl6v19tstoDcL4qOjg5gldVqDUhVTExMQKri\n4uIMBoPNZgvI/aLY2FgNVsXFxQWwqri42P/7RQGsio2NNRqNAaly31vLycnx/yG3u6qkpMT/\n+0UBrIqJiTGZTAGpct9by8nJCchWPYBPj0WoCKWTjIbF/au+Sb9q42n3u/bCn3/IL2nbqa7c\nKgAAAAAAIF0oLTiEYnryvla/fTJh9ZZfTxzYNWP86xH1Og5sGCU7CwAAAAAASBZKf6IihGje\n+8XHit+cN2X8OZvS7OpbX5yYGlIbGgAAAAAA8LcIsQWHUPR3DBp1xyDZGQAAAAAAQEt4AgQA\nAAAAAAh5LDgAAAAAAEDIY8EBAAAAAABCHgsOAAAAAAAQ8lhwAAAAAACAkMeCAwAAAAAAhDwW\nHAAAAAAAIOSx4AAAAAAAACGPBQcAAAAAAAh5LDgAAAAAAEDIY8EBAAAAAABCHgsOAAAAAAAQ\n8lhwAAAAAACAkMeCAwAAAAAAhDwWHAAAAAAAIOSx4AAAAAAAACGPBQcAAAAAAAh5LDgAAAAA\nAEDIY8EBAAAAAABCnkF2gDSqM3f9yvRjWfmXtLruJsvlYTpFdpEQVFUFVb6jyndU+Y4q31Hl\nO6p8R5XvqPIdVb6jynfarEK1pJ8wYYLshr+FqqqKolitVlVVy3/WaTvwn9Ev/HBSjdLbvlu5\nbPman2Muu6pJrfALXpTZbFZV1W63+5mk1+vDwsKEEDabTTtVOp0ugFUmk0kIEdgql8sVkKqS\nkhL/q8LDwwNYpShKda1SFMVdVVxc7H+V0WjU6XTarCouLva/KiIiwl3ldDr9r9Lr9dW1Sgjh\nriopKfG/ymAwGAwGbVbZbLaAVLm/nR0Oh/9VRqOxGleFh4crimK32/2v0uv1JpNJm1VWqzUg\nVTqdzm63X/BnfVWrzGZzNa4KCwvT6XQOh8P/Kvf9Im1WFRUVBbDqgj/rJVbp9fpAVYWHhwfq\nFtTr9U6nU1NVZrM5UFXue2sVPYirKvcPaNQoNXTB8Vvaf9daO0yZ9HD79jd0+pfFcWjj50tX\n2Gpf26ZRTPmDg7bgkFJV6YKjSlVBW3BcRFUQVglVrQrOgkNKVaWrhCpVBW3BcRFVQVglVLUq\nOAsOKVWislVClaqCtuC4iKogrBKqWhWcBYesKu+rhCpVBW3BcRFVQVglVLUqOAsOWVXeVwlV\nqgraguMiqoKw4JBY5WXBUdWq4Cw4ZFV5X3BUqYoFB/xUPRccR48enTVr1qZNm1q0aGE0Gssf\n8NP8Jafb9Oh0VbwQQmeKaf3P2+MKdi5etExt1qFVnQtsE51O5wUfDlXJyZMnZ8+enZGR0bRp\nU/dDbi1UnT59etasWRkZGU2aNDGbzRqpOnfuXFpaWkZGRuPGjd2bDn+qVFV1uVwXfOBRJbm5\nuTNnzszIyGjQoIH7cbI/VUKIwFbVq1fvgkP8Im5B/6sKCgpmzJiRkZFRp06dqKgojVRZrdaP\nP/44IyOjVq1a0dHR/lcF5BYsKSmZNm1aRkZGQkKCdqrsdru7KjY2NjY2ViNVLpfrww8/zMjI\niIqKiouL00iVEMJdFRERER8f739VQL7ahRAff/zx5s2bzWZzQkKC/1Wqql7wYXZVzZw5c+PG\njUajMTEx0f8ql8sVkKq0tLQNGzbodLratWtrp2r27Nnr168XQtSpU0c7VXPnzv3222+dTucl\nl1ziZ5WiKIH6upo3b966devsdnvdunX9rBKB+2pfuHBhenq6zWarV6+edqoWL168Zs2aoqKi\n+vXr+18VqK+rJUuWrFmzJj8/v0GDBtqpWr58+TfffJOXl9ewYUP/qwLyi0khxIoVK77++uus\nrKzGjRsHpCog19XKlStXrVp19uzZSy+9VDtVggVHzaRWR99//73FYrFYLKdPn77gAbveGpoy\n4FW7q/THXF++NrRbz9RMq+NvqtqyZYu76tixY9qp2rFjh7vq8OHD2qnau3evuyozM1M7Vfv3\n73dX7d69WztVhw8fdldt375dO1UnTpxwV/3000/aqTp79qy7KiMjQztVubm57qr169drp6qw\nsNBdtWbNGu1U2e12d9XKlSu1U6Wqart27SwWy/LlyzVVdcMNN1gslsWLF2uq6uabb7ZYLPPn\nz9dUVceOHS0Wy5w5czRVddddd1kslpkzZ2qqKikpyWKxfPTRR5qq6t69u8VimTp1qqaqevfu\n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"
     },
     "metadata": {
      "image/png": {
       "height": 480,
       "width": 720
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "tripdata %>% group_by(customer_type, time) %>% \n",
    "  summarize(min_ride=min(ride_length, na.rm = TRUE),\n",
    "            max_ride=max(ride_length, na.rm = TRUE),\n",
    "            mid_ride=median(ride_length, na.rm = TRUE),\n",
    "            avg_ride=mean(ride_length, na.rm = TRUE),\n",
    "            num_of_rides = n(),\n",
    "            total_ride=sum(ride_length, na.rm = TRUE)) %>% \n",
    "  arrange(time) %>% \n",
    "  ggplot(mapping = aes(x=time, y=num_of_rides, color=customer_type, group=customer_type))+\n",
    "  geom_line()+\n",
    "  scale_x_datetime(date_breaks = \"1 hour\", date_labels = \"%H:%M\", expand = c(0,0))+\n",
    "  labs(x = \"Time\",\n",
    "       y = \"Number of trips\", \n",
    "       title = \"Bike Demand throughout the day\",\n",
    "       color = \"Customer Type\")+\n",
    "  theme(axis.text.x = element_text(angle = 45))\n",
    "  scale_y_continuous(labels = function(y)format(y, scientific=FALSE))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "94d3e853",
   "metadata": {
    "papermill": {
     "duration": 0.157414,
     "end_time": "2022-03-06T05:03:07.379568",
     "exception": false,
     "start_time": "2022-03-06T05:03:07.222154",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "The bike demand throughout the day shows that the usage by the members is high during the rush hours and takes a sharp drop after it peaks at 5 PM, which confirms our assumption that the majority of annual members are office-goers who use bikes to commute to work. But the bike usage by the casual riders steadily increases throughout the day and starts to steadily decrease after it peaks at 5 PM."
   ]
  },
  {
   "cell_type": "markdown",
   "id": "f339ade1",
   "metadata": {
    "papermill": {
     "duration": 0.157402,
     "end_time": "2022-03-06T05:03:07.694377",
     "exception": false,
     "start_time": "2022-03-06T05:03:07.536975",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "**6. Creating visualization for the number of each bike type used the riders**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 31,
   "id": "21a4a6d2",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-06T05:03:08.015642Z",
     "iopub.status.busy": "2022-03-06T05:03:08.014233Z",
     "iopub.status.idle": "2022-03-06T05:03:08.465966Z",
     "shell.execute_reply": "2022-03-06T05:03:08.465036Z"
    },
    "papermill": {
     "duration": 0.614258,
     "end_time": "2022-03-06T05:03:08.466112",
     "exception": false,
     "start_time": "2022-03-06T05:03:07.851854",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "`summarise()` has grouped output by 'customer_type'. You can override using the `.groups` argument.\n",
      "\n"
     ]
    },
    {
     "data": {
      "image/png": "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\n0uSrUce/+kvR4sZHTzvwqKOOmra644r8SdsjrkqPxS465YDfyipOvGnnJVct+OX+85/9+vel\n+GMX/H1eRXy3IbtWV21J3aISQsjJyQmh5X77/fVyEQAAAFgbxNLq3/vBv6Z32W9Yn92fuHXn\n/XbeqlFGyZfjX3/hvS8z6rW75z+P1P99atWex250xZAPt+h+3AXHdC/7ZfIDN9/6a9Os8EN5\nCKHRBlfs2ezuV6/cZd9vT9y+c9v47O+euee+9MyCQVdvGULIbJAZQrh72D0lnbbtdeR2dz53\n2b+7DditXdfjTz5ow7yFbz51/8sTZ3Uf8Ooevw8julLOevGOkRsdvU+7TQ86smfXDk2+eG3M\nqHFfbnbCqGPXqc4rOLIa7XJ2mwY3vjA5J7/7pe3/NB9r/VZdbz2k86SjTtq2faNP33j8qTem\nrrPtmaP2Wa+6aks24HjuueeS7xQAAADWPDlNdhn71cR7r71m1FNj//nQBwvKM9Zp3f7wUwed\nN/D8rdf5YxqULa94Y3hR72FPvnr+qY+UJRKtuh337xt+22nHl0IIsfRG//r8lQvPHPjsS6PH\njV5Qr/G6W+3c658Dr/t767wQwjrbXbf/VlNeueqczztf1uvI7dbZ7qIv31zvnCtufeq+m+eU\nZqy/ydZX3H/55SfstmrF5613+GefNbrwwmuefereZ0qz2m60ycCRL1168t+q4435k96Xbn5j\n33c2PvW6v1x+sc42N/z75A+Pv+C2ax6bnrtO217nDL3p2jOyYtVWWyyRWPmxSdYm8Xi8sLAw\n1VWsWLNmD6S6BGpPYvT5qS6BWjVjr99SXQJroJycnLy8vBDCjBkzUl0LEG0FBQWxWGz+/PnF\nxcWprgX+0LRp01SXEEII8ZK5P/xWvl7rJqkupFZ9dEmXba/97Onfig5cYtjU3PS0Fj1f/fbp\n3Wtuv8lewQEAAACslLTshuu1TnURtSteNuO04ZMatDn7wL9OClPjBBwAAABANeh3+rlFXz31\nwbzSk586p/b3LuAAAAAAqsGbY+6eWt7o2MueuGfPVn9ZddChh+Zv3axG9y7gAAAAAKrBhOnz\nlrdq9JjHa3rvVU0p232LTU9+++fKx506dRo8bbmFAgAAAKRQVVdwJxFpowAAIABJREFU/PT1\nl19dPfKdy/fOTAuTJ0/+7MP33/+5wTK33G677WqmPAAAAIAVqyrguLP/Tt2vH7jz2IGVi08e\n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\nkXcZqsSMM84wm+IAAAAASUVORK5CYII="
     },
     "metadata": {
      "image/png": {
       "height": 480,
       "width": 720
      }
     },
     "output_type": "display_data"
    }
   ],
   "source": [
    "tripdata %>% group_by(customer_type, bike_type) %>% \n",
    "    summarize(total_rides = n()) %>% \n",
    "    ggplot(mapping = aes(x=bike_type, y=total_rides, fill=customer_type))+\n",
    "    geom_bar(stat=\"identity\", position = \"dodge\")+\n",
    "    scale_fill_manual(values = c(\"darkblue\", \"orange\"))+\n",
    "    labs(x = \"Bike Type\",\n",
    "         y = \"Number of rides\", \n",
    "         title = \"Bike Type Usage by the Customers\",\n",
    "         fill = \"Customer Type\")+\n",
    "    theme(plot.title =element_text(family = \"sans-serif\", color = \"darkred\", size = 16))+\n",
    "    scale_y_continuous(labels = function(y)format(y, scientific=FALSE))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "34fbeb62",
   "metadata": {
    "papermill": {
     "duration": 0.161504,
     "end_time": "2022-03-06T05:03:08.791843",
     "exception": false,
     "start_time": "2022-03-06T05:03:08.630339",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "From the graph, we can see that members use classic bikes much more than the casual riders do.  The distribution of the use of electric is almost identical for both customers but docked bikes are more preferred by the casual riders. "
   ]
  },
  {
   "cell_type": "markdown",
   "id": "7b949d2a",
   "metadata": {
    "papermill": {
     "duration": 0.160313,
     "end_time": "2022-03-06T05:03:09.112112",
     "exception": false,
     "start_time": "2022-03-06T05:03:08.951799",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# **E. Conclusion**"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "8ed4b552",
   "metadata": {
    "papermill": {
     "duration": 0.160166,
     "end_time": "2022-03-06T05:03:09.433097",
     "exception": false,
     "start_time": "2022-03-06T05:03:09.272931",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "### **Key Takeaways**\n",
    "1. Casual riders take bike rides more than double that of annual members on average\n",
    "2. Casual riders use bike-sharing services more over the weekends for leisure while members use them consistently throughout the entire week to commute to work.\n",
    "3. Annual members predominately use classic bikes and rarely use docked bikes while casual riders are open to all kinds of bikes but prefer docked bikes.\n",
    "\n",
    "\n",
    "### **Recommendations**\n",
    "\n",
    "1. Lower the price of single-ride and full-day tickets casual rides so that they will be enticed to use bikes during the weekdays\n",
    "2. Offer attractive promotions like 20% to 30 % discount on the first year subscription to make casual riders become annual members \n",
    "3. Give a two-week free trial for casual riders who want to first try the bike-sharing service before committing to the annual plan.\n",
    "\n",
    "\n",
    "### **Additional Data for Further Analysis**\n",
    "\n",
    "1. Plans & pricing: this data can be used to optimize the cost benefit analysis for existing customers and potential new customers.  Consider creating a seasonal special price for summer and winter seasons\n",
    "2. Age and gender profile: this data can be used to study the age and gender category of the riders so that the marketing team will efficiently use their budget to target potential customers\n",
    "3. Neighborhood details: this can be used to investigate the riders’ bike usage based on the residential areas so that the marketing team create promotions or make advertisements accordingly. \n"
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "R",
   "language": "R",
   "name": "ir"
  },
  "language_info": {
   "codemirror_mode": "r",
   "file_extension": ".r",
   "mimetype": "text/x-r-source",
   "name": "R",
   "pygments_lexer": "r",
   "version": "4.0.5"
  },
  "papermill": {
   "default_parameters": {},
   "duration": 99.952032,
   "end_time": "2022-03-06T05:03:09.804185",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-03-06T05:01:29.852153",
   "version": "2.3.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
