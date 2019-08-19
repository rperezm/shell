#!/bin/bash

########################################################################
############################## PARAMETERS ##############################
########################################################################

BUCKET="gs://load_event/archive/iboammx/*/*/*/low_balance*"
LOG_FILE=log_$(date '+%Y%m%d_%H%M%S')
TABLE="iboammx.low_balance_event"
DELIMITER="|"

touch $LOG_FILE

load2bq(){
	
	
	bq load --source_format=CSV --field_delimiter="${DELIMITER}" --skip_leading_rows=1 ${TABLE} $1 
}

export -f load2bq
parallel --jobs=8 load2bq ::: `gsutil ls ${BUCKET}` >> $LOG_FILE