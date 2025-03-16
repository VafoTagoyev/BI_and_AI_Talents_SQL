drop PROCEDURE if exists getInfoDatabase;

go

create PROCEDURE getInfoDatabase @db_name varchar(max) = NULL
as
begin

    declare @temptable table (
        DatabaseName varchar(255),
        SchemaName varchar(255),
        RoutineName varchar(255),
        RoutineType varchar(255),
        Parameters varchar(max),
        ReturnType varchar(255)
    );

    declare @cmd varchar(max);


    if @db_name is not NULL
    BEGIN
            
            set @cmd = '
                SELECT r.SPECIFIC_CATALOG as DatabaseName,
                        r.SPECIFIC_SCHEMA as SchemaName,
                        r.Routine_Name as RoutineName,
                        r.ROUTINE_TYPE as RoutineType,
                        (select string_agg(concat(p.PARAMETER_NAME, '' '', p.Data_Type, ''('' + 
                                                case when p.CHARACTER_MAXIMUM_LENGTH = -1 then ''max''
                                                else cast(p.CHARACTER_MAXIMUM_LENGTH as nvarchar)
                                                end
                                                + '')''), 
                                            '', '')
                            from ' + @db_name + '.INFORMATION_SCHEMA.PARAMETERS  as p
                            where p.IS_RESULT = ''NO'' and 
                                p.SPECIFIC_CATALOG = r.SPECIFIC_CATALOG and
                                p.SPECIFIC_SCHEMA = r.SPECIFIC_SCHEMA and 
                                r.SPECIFIC_NAME = p.SPECIFIC_NAME
                        ) as Parameters,
                        concat(r.Data_Type, ''('' + 
                            case when r.CHARACTER_MAXIMUM_LENGTH = -1
                            then ''max''
                            else cast(r.CHARACTER_MAXIMUM_LENGTH as nvarchar)
                            end) as ReturnType
                FROM ' + @db_name + '.INFORMATION_SCHEMA.ROUTINES as r';
            
            insert into @temptable
            exec(@cmd);

    END
    ELSE
    BEGIN

        declare @i int = 1;

        declare @count int = (select count(1) from sys.databases);


        while @i <= @count
        begin
            ;with cte as (
                select name, ROW_NUMBER() OVER(order BY name) as rn
                from sys.databases
            )
            select @db_name = name 
            from cte
            where rn = @i;

            
            -- print @cmd;
            set @cmd = '
                SELECT r.SPECIFIC_CATALOG as DatabaseName,
                        r.SPECIFIC_SCHEMA as SchemaName,
                        r.Routine_Name as RoutineName,
                        r.ROUTINE_TYPE as RoutineType,
                        (select string_agg(concat(p.PARAMETER_NAME, '' '', p.Data_Type, ''('' + 
                                                case when p.CHARACTER_MAXIMUM_LENGTH = -1 then ''max''
                                                else cast(p.CHARACTER_MAXIMUM_LENGTH as nvarchar)
                                                end
                                                + '')''), 
                                            '', '')
                            from ' + @db_name + '.INFORMATION_SCHEMA.PARAMETERS p
                            where p.IS_RESULT = ''NO'' and 
                                p.SPECIFIC_CATALOG = r.SPECIFIC_CATALOG and
                                p.SPECIFIC_SCHEMA = r.SPECIFIC_SCHEMA and 
                                r.SPECIFIC_NAME = p.SPECIFIC_NAME
                        ) as Parameters,
                        concat(r.Data_Type, ''('' + 
                            case when r.CHARACTER_MAXIMUM_LENGTH = -1
                            then ''max''
                            else cast(r.CHARACTER_MAXIMUM_LENGTH as nvarchar)
                            end) as ReturnType
                FROM ' + @db_name + '.INFORMATION_SCHEMA.ROUTINES r';
            
            insert into @temptable
            exec(@cmd);

            set @i = @i + 1;

        end;

    END;

    select * from @temptable;

end;

exec getInfoDatabase;