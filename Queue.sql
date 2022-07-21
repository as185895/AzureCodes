----Queueu time
----How to check Queue Time using LOGS.

ADFActivityRun
| extend queuetime = extractjson('$.durationInQueue.integrationRuntimeQueue',Output, typeof(int))
| where Status == 'Succeeded' 
| where queuetime > 0
| project Start, End, PipelineName, ActivityType, ActivityName, dur = datetime_diff('second', End, Start), queuetime, PipelineRunId, ActivityRunId, param_value = parse_json(Input)
| project Start, End, PipelineName, ActivityType, ActivityName, dur, queuetime, PipelineRunId, ActivityRunId, param_schema_name = tostring(param_value.storedProcedureParameters.schema_name.value)
, param_procedure_name = tostring(param_value.storedProcedureParameters.table_name.value)
| where param_schema_name contains 'trans_inventory'
| sort by queuetime desc