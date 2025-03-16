declare @result varchar(max) = 
(
    select
        tbs.name as td, '',
        ids.name as td, '',
        ids.type_desc as td, '',
        ty.name as td
    from sys.indexes ids
    left join sys.tables tbs
        on ids.object_id = tbs.object_id
    left join sys.columns co
        on co.object_id = ids.object_id
    left join sys.types ty
        on ty.system_type_id = co.system_type_id
    for xml path('tr')
)

-- <table>
--     ...
-- </table>
declare @html_body varchar(max) = '<table>' + @result + '</table>';

EXEC msdb.dbo.sp_send_dbmail
    @profile_name = 'profile',
    @recipients = 'v.tagayev@gmail.com',
    @subject = 'Metadata about indexes',
    @body = @html_body,
    @body_format = 'HTML';