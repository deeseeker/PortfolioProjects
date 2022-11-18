SELECT Doctor, Professor, Singer, Actor
FROM (
        SELECT ROW_NUMBER() OVER (PARTITION BY OCCUPATION ORDER BY NAME) As RowNumber, * FROM OCCUPATIONS) As SourceTable
PIVOT
(
  MIN(Name)  FOR OCCUPATION IN (Doctor, Professor, Singer, Actor)
) AS PivotTable;