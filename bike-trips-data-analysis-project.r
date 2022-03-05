{
 "cells": [
  {
   "cell_type": "code",
   "execution_count": 1,
   "id": "b2aad29f",
   "metadata": {
    "_execution_state": "idle",
    "_uuid": "051d70d956493feee0c6d64651c6a088724dca2a",
    "execution": {
     "iopub.execute_input": "2022-03-05T23:20:12.097033Z",
     "iopub.status.busy": "2022-03-05T23:20:12.094123Z",
     "iopub.status.idle": "2022-03-05T23:20:13.556906Z",
     "shell.execute_reply": "2022-03-05T23:20:13.557668Z"
    },
    "papermill": {
     "duration": 1.545752,
     "end_time": "2022-03-05T23:20:13.558051",
     "exception": false,
     "start_time": "2022-03-05T23:20:12.012299",
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
   "cell_type": "markdown",
   "id": "09de5893",
   "metadata": {
    "papermill": {
     "duration": 0.082873,
     "end_time": "2022-03-05T23:20:13.733705",
     "exception": false,
     "start_time": "2022-03-05T23:20:13.650832",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# **Data Preparation and Cleaning**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 2,
   "id": "3445b5f8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:20:13.930995Z",
     "iopub.status.busy": "2022-03-05T23:20:13.899560Z",
     "iopub.status.idle": "2022-03-05T23:20:18.909567Z",
     "shell.execute_reply": "2022-03-05T23:20:18.907897Z"
    },
    "papermill": {
     "duration": 5.095047,
     "end_time": "2022-03-05T23:20:18.909726",
     "exception": false,
     "start_time": "2022-03-05T23:20:13.814679",
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
   "id": "79c92fb4",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:20:19.153717Z",
     "iopub.status.busy": "2022-03-05T23:20:19.152327Z",
     "iopub.status.idle": "2022-03-05T23:20:43.526392Z",
     "shell.execute_reply": "2022-03-05T23:20:43.524429Z"
    },
    "papermill": {
     "duration": 24.497455,
     "end_time": "2022-03-05T23:20:43.526612",
     "exception": false,
     "start_time": "2022-03-05T23:20:19.029157",
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
   "id": "a8910dea",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:20:43.779635Z",
     "iopub.status.busy": "2022-03-05T23:20:43.777589Z",
     "iopub.status.idle": "2022-03-05T23:20:43.813995Z",
     "shell.execute_reply": "2022-03-05T23:20:43.812026Z"
    },
    "papermill": {
     "duration": 0.162231,
     "end_time": "2022-03-05T23:20:43.814155",
     "exception": false,
     "start_time": "2022-03-05T23:20:43.651924",
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
   "id": "0af17333",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:20:44.072586Z",
     "iopub.status.busy": "2022-03-05T23:20:44.070060Z",
     "iopub.status.idle": "2022-03-05T23:20:46.622250Z",
     "shell.execute_reply": "2022-03-05T23:20:46.620189Z"
    },
    "papermill": {
     "duration": 2.682492,
     "end_time": "2022-03-05T23:20:46.622411",
     "exception": false,
     "start_time": "2022-03-05T23:20:43.939919",
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
   "id": "89a55fa8",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:20:46.879281Z",
     "iopub.status.busy": "2022-03-05T23:20:46.877766Z",
     "iopub.status.idle": "2022-03-05T23:20:52.666487Z",
     "shell.execute_reply": "2022-03-05T23:20:52.664394Z"
    },
    "papermill": {
     "duration": 5.91898,
     "end_time": "2022-03-05T23:20:52.666668",
     "exception": false,
     "start_time": "2022-03-05T23:20:46.747688",
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
   "id": "617b6ba6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:20:52.950793Z",
     "iopub.status.busy": "2022-03-05T23:20:52.949227Z",
     "iopub.status.idle": "2022-03-05T23:21:09.502662Z",
     "shell.execute_reply": "2022-03-05T23:21:09.501387Z"
    },
    "papermill": {
     "duration": 16.683965,
     "end_time": "2022-03-05T23:21:09.503087",
     "exception": false,
     "start_time": "2022-03-05T23:20:52.819122",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [
    {
     "name": "stderr",
     "output_type": "stream",
     "text": [
      "value for \"which\" not specified, defaulting to c(\"rows\", \"cols\")\n",
      "\n"
     ]
    }
   ],
   "source": [
    "# Remove missing values - all the three codes do the same thing \n",
    "tripdata <- drop_na(tripdata) # from tydr packagere\n",
    "tripdata <- remove_missing(tripdata) # from ggplot2 package\n",
    "tripdata <- remove_empty(tripdata)   # from janitor"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "c553d0bc",
   "metadata": {
    "papermill": {
     "duration": 0.124875,
     "end_time": "2022-03-05T23:21:09.755575",
     "exception": false,
     "start_time": "2022-03-05T23:21:09.630700",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# **Data Transformation**\n",
    "\n",
    "1. I will create relevant columns that will be usefull for the analysis. For example, I will add date, day, month and year of each ride started which will allow us to aggregate data for each month, day or year. \n",
    "Note that time of the day needs to be converted to POSIXct because only times of class POSIXct are supported in ggplot2 package. So we should perform a two-step operation is need - first  we will need to extract time information from the datetime data and then convert the character vector time to POSIXct.\n",
    "\n",
    "2. I will calculate the trip length in seconds of each ride by  subtracting started_at from ended_at\n"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 8,
   "id": "16ae3e95",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:10.012516Z",
     "iopub.status.busy": "2022-03-05T23:21:10.010793Z",
     "iopub.status.idle": "2022-03-05T23:21:10.034334Z",
     "shell.execute_reply": "2022-03-05T23:21:10.032411Z"
    },
    "papermill": {
     "duration": 0.153673,
     "end_time": "2022-03-05T23:21:10.034520",
     "exception": false,
     "start_time": "2022-03-05T23:21:09.880847",
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
   "cell_type": "code",
   "execution_count": 9,
   "id": "0459c3dd",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:10.293879Z",
     "iopub.status.busy": "2022-03-05T23:21:10.292014Z",
     "iopub.status.idle": "2022-03-05T23:21:46.529515Z",
     "shell.execute_reply": "2022-03-05T23:21:46.527733Z"
    },
    "papermill": {
     "duration": 36.368612,
     "end_time": "2022-03-05T23:21:46.529724",
     "exception": false,
     "start_time": "2022-03-05T23:21:10.161112",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "tripdata$date <- as.Date(tripdata$started_at)\n",
    "tripdata$month <- format(as.Date(tripdata$started_at), \"%B\")\n",
    "tripdata$day <- format(as.Date(tripdata$date), \"%d\")\n",
    "tripdata$year <- format(as.Date(tripdata$date), \"%Y\")\n",
    "tripdata$weekday <- format(as.Date(tripdata$date, \"%A\"))\n",
    "tripdata$time <- format(tripdata$started_at, format=\"%H:%M\")\n",
    "tripdata$time <- as.POSIXct(tripdata$time, format=\"%H:%M\")"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 10,
   "id": "6c48e657",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:46.797020Z",
     "iopub.status.busy": "2022-03-05T23:21:46.795592Z",
     "iopub.status.idle": "2022-03-05T23:21:46.852248Z",
     "shell.execute_reply": "2022-03-05T23:21:46.850091Z"
    },
    "papermill": {
     "duration": 0.190871,
     "end_time": "2022-03-05T23:21:46.852401",
     "exception": false,
     "start_time": "2022-03-05T23:21:46.661530",
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
      " $ weekday           : chr  \"2021-01-24\" \"2021-01-23\" \"2021-01-09\" \"2021-01-09\" ...\n",
      " $ time              : POSIXct, format: \"2022-03-05 19:15:00\" \"2022-03-05 12:57:00\" ...\n"
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
   "id": "2ac5e19b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:47.118743Z",
     "iopub.status.busy": "2022-03-05T23:21:47.117151Z",
     "iopub.status.idle": "2022-03-05T23:21:47.226494Z",
     "shell.execute_reply": "2022-03-05T23:21:47.224985Z"
    },
    "papermill": {
     "duration": 0.242274,
     "end_time": "2022-03-05T23:21:47.226640",
     "exception": false,
     "start_time": "2022-03-05T23:21:46.984366",
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
   "id": "0f5fa528",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:47.495056Z",
     "iopub.status.busy": "2022-03-05T23:21:47.493327Z",
     "iopub.status.idle": "2022-03-05T23:21:47.536509Z",
     "shell.execute_reply": "2022-03-05T23:21:47.534688Z"
    },
    "papermill": {
     "duration": 0.178888,
     "end_time": "2022-03-05T23:21:47.536677",
     "exception": false,
     "start_time": "2022-03-05T23:21:47.357789",
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
      " $ weekday      : chr  \"2021-01-24\" \"2021-01-23\" \"2021-01-09\" \"2021-01-09\" ...\n",
      " $ time         : POSIXct, format: \"2022-03-05 19:15:00\" \"2022-03-05 12:57:00\" ...\n",
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
   "id": "87b234e6",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:47.834083Z",
     "iopub.status.busy": "2022-03-05T23:21:47.832521Z",
     "iopub.status.idle": "2022-03-05T23:21:47.872767Z",
     "shell.execute_reply": "2022-03-05T23:21:47.871239Z"
    },
    "papermill": {
     "duration": 0.200436,
     "end_time": "2022-03-05T23:21:47.873003",
     "exception": false,
     "start_time": "2022-03-05T23:21:47.672567",
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
   "id": "4f0a2051",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:51.264358Z",
     "iopub.status.busy": "2022-03-05T23:21:51.262825Z",
     "iopub.status.idle": "2022-03-05T23:21:51.303202Z",
     "shell.execute_reply": "2022-03-05T23:21:51.301401Z"
    },
    "papermill": {
     "duration": 3.299854,
     "end_time": "2022-03-05T23:21:51.303373",
     "exception": false,
     "start_time": "2022-03-05T23:21:48.003519",
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
      " $ weekday      : chr  \"2021-01-24\" \"2021-01-23\" \"2021-01-09\" \"2021-01-09\" ...\n",
      " $ time         : POSIXct, format: \"2022-03-05 19:15:00\" \"2022-03-05 12:57:00\" ...\n",
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
   "id": "e0a1f35e",
   "metadata": {
    "papermill": {
     "duration": 0.133944,
     "end_time": "2022-03-05T23:21:51.569915",
     "exception": false,
     "start_time": "2022-03-05T23:21:51.435971",
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
   "id": "e204113b",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:51.838627Z",
     "iopub.status.busy": "2022-03-05T23:21:51.837138Z",
     "iopub.status.idle": "2022-03-05T23:21:53.507209Z",
     "shell.execute_reply": "2022-03-05T23:21:53.505917Z"
    },
    "papermill": {
     "duration": 1.806048,
     "end_time": "2022-03-05T23:21:53.507363",
     "exception": false,
     "start_time": "2022-03-05T23:21:51.701315",
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
   "id": "3b3bd902",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:53.776113Z",
     "iopub.status.busy": "2022-03-05T23:21:53.774351Z",
     "iopub.status.idle": "2022-03-05T23:21:53.792042Z",
     "shell.execute_reply": "2022-03-05T23:21:53.790548Z"
    },
    "papermill": {
     "duration": 0.153364,
     "end_time": "2022-03-05T23:21:53.792194",
     "exception": false,
     "start_time": "2022-03-05T23:21:53.638830",
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
   "id": "11270320",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:54.065099Z",
     "iopub.status.busy": "2022-03-05T23:21:54.063421Z",
     "iopub.status.idle": "2022-03-05T23:21:54.244154Z",
     "shell.execute_reply": "2022-03-05T23:21:54.242631Z"
    },
    "papermill": {
     "duration": 0.317731,
     "end_time": "2022-03-05T23:21:54.244320",
     "exception": false,
     "start_time": "2022-03-05T23:21:53.926589",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": [
    "# Since the days of week are out of order, we need to convert them to an ordered factor \n",
    "# so that our data analysis will be consistent.\n",
    "\n",
    "tripdata$weekday <- ordered(tripdata$weekday, levels=c(\"Monday\", \n",
    "                                                       \"Tuesday\", \n",
    "                                                       \"Wednesday\",\n",
    "                                                       \"Thursday\", \n",
    "                                                       \"Friday\", \n",
    "                                                       \"Saturday\", \n",
    "                                                       \"Sunday\"))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "adad4d77",
   "metadata": {
    "papermill": {
     "duration": 0.130295,
     "end_time": "2022-03-05T23:21:54.507800",
     "exception": false,
     "start_time": "2022-03-05T23:21:54.377505",
     "status": "completed"
    },
    "tags": []
   },
   "source": [
    "# **Data Analysis**"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": 18,
   "id": "bc49cd79",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:54.781191Z",
     "iopub.status.busy": "2022-03-05T23:21:54.779396Z",
     "iopub.status.idle": "2022-03-05T23:21:55.165600Z",
     "shell.execute_reply": "2022-03-05T23:21:55.164181Z"
    },
    "papermill": {
     "duration": 0.525574,
     "end_time": "2022-03-05T23:21:55.165762",
     "exception": false,
     "start_time": "2022-03-05T23:21:54.640188",
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
   "execution_count": 19,
   "id": "ab66dc07",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:55.445225Z",
     "iopub.status.busy": "2022-03-05T23:21:55.443123Z",
     "iopub.status.idle": "2022-03-05T23:21:55.918103Z",
     "shell.execute_reply": "2022-03-05T23:21:55.916277Z"
    },
    "papermill": {
     "duration": 0.615441,
     "end_time": "2022-03-05T23:21:55.918258",
     "exception": false,
     "start_time": "2022-03-05T23:21:55.302817",
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
   "execution_count": 20,
   "id": "af1023c7",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:56.195413Z",
     "iopub.status.busy": "2022-03-05T23:21:56.193821Z",
     "iopub.status.idle": "2022-03-05T23:21:56.658218Z",
     "shell.execute_reply": "2022-03-05T23:21:56.656644Z"
    },
    "papermill": {
     "duration": 0.604911,
     "end_time": "2022-03-05T23:21:56.658413",
     "exception": false,
     "start_time": "2022-03-05T23:21:56.053502",
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
   "execution_count": 21,
   "id": "46985614",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:56.943399Z",
     "iopub.status.busy": "2022-03-05T23:21:56.941791Z",
     "iopub.status.idle": "2022-03-05T23:21:58.287757Z",
     "shell.execute_reply": "2022-03-05T23:21:58.286208Z"
    },
    "papermill": {
     "duration": 1.490984,
     "end_time": "2022-03-05T23:21:58.287931",
     "exception": false,
     "start_time": "2022-03-05T23:21:56.796947",
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
    "  summarize(min_ride=min(ride_length, na.rm = TRUE),\n",
    "            max_ride=max(ride_length, na.rm = TRUE),\n",
    "            mid_ride=median(ride_length, na.rm = TRUE),\n",
    "            avg_ride=mean(ride_length, na.rm = TRUE),\n",
    "            total_ride=sum(ride_length, na.rm = TRUE))"
   ]
  },
  {
   "cell_type": "markdown",
   "id": "de6779d7",
   "metadata": {
    "papermill": {
     "duration": 0.142408,
     "end_time": "2022-03-05T23:21:58.569701",
     "exception": false,
     "start_time": "2022-03-05T23:21:58.427293",
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
   "execution_count": 22,
   "id": "ea6d4c93",
   "metadata": {
    "execution": {
     "iopub.execute_input": "2022-03-05T23:21:58.881742Z",
     "iopub.status.busy": "2022-03-05T23:21:58.880339Z",
     "iopub.status.idle": "2022-03-05T23:21:59.383767Z",
     "shell.execute_reply": "2022-03-05T23:21:59.381952Z"
    },
    "papermill": {
     "duration": 0.665681,
     "end_time": "2022-03-05T23:21:59.383958",
     "exception": false,
     "start_time": "2022-03-05T23:21:58.718277",
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
       "<caption>A grouped_df: 2 × 8</caption>\n",
       "<thead>\n",
       "\t<tr><th scope=col>customer_type</th><th scope=col>weekday</th><th scope=col>min_ride</th><th scope=col>max_ride</th><th scope=col>mid_ride</th><th scope=col>avg_ride</th><th scope=col>num_of_rides</th><th scope=col>total_ride</th></tr>\n",
       "\t<tr><th scope=col>&lt;chr&gt;</th><th scope=col>&lt;ord&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;dbl&gt;</th><th scope=col>&lt;int&gt;</th><th scope=col>&lt;dbl&gt;</th></tr>\n",
       "</thead>\n",
       "<tbody>\n",
       "\t<tr><td>casual</td><td>NA</td><td>1</td><td>86362</td><td>999</td><td>1692.634</td><td>2046738</td><td>3464378199</td></tr>\n",
       "\t<tr><td>member</td><td>NA</td><td>1</td><td>85594</td><td>583</td><td> 790.487</td><td>2539594</td><td>2007515928</td></tr>\n",
       "</tbody>\n",
       "</table>\n"
      ],
      "text/latex": [
       "A grouped\\_df: 2 × 8\n",
       "\\begin{tabular}{llllllll}\n",
       " customer\\_type & weekday & min\\_ride & max\\_ride & mid\\_ride & avg\\_ride & num\\_of\\_rides & total\\_ride\\\\\n",
       " <chr> & <ord> & <dbl> & <dbl> & <dbl> & <dbl> & <int> & <dbl>\\\\\n",
       "\\hline\n",
       "\t casual & NA & 1 & 86362 & 999 & 1692.634 & 2046738 & 3464378199\\\\\n",
       "\t member & NA & 1 & 85594 & 583 &  790.487 & 2539594 & 2007515928\\\\\n",
       "\\end{tabular}\n"
      ],
      "text/markdown": [
       "\n",
       "A grouped_df: 2 × 8\n",
       "\n",
       "| customer_type &lt;chr&gt; | weekday &lt;ord&gt; | min_ride &lt;dbl&gt; | max_ride &lt;dbl&gt; | mid_ride &lt;dbl&gt; | avg_ride &lt;dbl&gt; | num_of_rides &lt;int&gt; | total_ride &lt;dbl&gt; |\n",
       "|---|---|---|---|---|---|---|---|\n",
       "| casual | NA | 1 | 86362 | 999 | 1692.634 | 2046738 | 3464378199 |\n",
       "| member | NA | 1 | 85594 | 583 |  790.487 | 2539594 | 2007515928 |\n",
       "\n"
      ],
      "text/plain": [
       "  customer_type weekday min_ride max_ride mid_ride avg_ride num_of_rides\n",
       "1 casual        NA      1        86362    999      1692.634 2046738     \n",
       "2 member        NA      1        85594    583       790.487 2539594     \n",
       "  total_ride\n",
       "1 3464378199\n",
       "2 2007515928"
      ]
     },
     "metadata": {},
     "output_type": "display_data"
    }
   ],
   "source": [
    "# Determine the average trip duration in seconds by each day for members and casual riders\n",
    "tripdata %>% group_by(customer_type, weekday) %>% \n",
    "                  summarize(min_ride=min(ride_length, na.rm = TRUE),\n",
    "                            max_ride=max(ride_length, na.rm = TRUE),\n",
    "                            mid_ride=median(ride_length, na.rm = TRUE),\n",
    "                            avg_ride=mean(ride_length, na.rm = TRUE),\n",
    "                            num_of_rides = n(),\n",
    "                            total_ride=sum(ride_length, na.rm = TRUE)) %>% \n",
    "                                  arrange(weekday)"
   ]
  },
  {
   "cell_type": "code",
   "execution_count": null,
   "id": "5ff2b35a",
   "metadata": {
    "papermill": {
     "duration": 0.146755,
     "end_time": "2022-03-05T23:21:59.674826",
     "exception": false,
     "start_time": "2022-03-05T23:21:59.528071",
     "status": "completed"
    },
    "tags": []
   },
   "outputs": [],
   "source": []
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
   "duration": 111.696011,
   "end_time": "2022-03-05T23:22:00.235224",
   "environment_variables": {},
   "exception": null,
   "input_path": "__notebook__.ipynb",
   "output_path": "__notebook__.ipynb",
   "parameters": {},
   "start_time": "2022-03-05T23:20:08.539213",
   "version": "2.3.3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
