SELECT * FROM(
    SELECT s.name AS schema_name,
    p.name AS procedure_name,
    s.name+'.'+p.name AS full_name
    FROM sys.objects a
    LEFT JOIN sys.schemas s ON s.schema_id = a.schema_id
    LEFT JOIN sys.procedures p ON p.object_id = a.object_id
    LEFT JOIN sys.sql_modules mod ON mod.object_id = a.object_id
    WHERE a.[type] ='P'
    AND mod.definition LIKE N'%qs_product%'
)X