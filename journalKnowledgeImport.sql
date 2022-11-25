select sys_id,
       table_name,
       element_id,
       element,
       associated_sys_id,
       journal_value,
       sys_tags,
       sys_created_on,
       sys_created_by,
       load_datetime
from warehouse_snow.curr_snow_sys_journal_field
where journal_value ~ '(?i)(Knowledge Article \[code\]<a href=.*>KB\d{7,8}</a>\[/code\])'