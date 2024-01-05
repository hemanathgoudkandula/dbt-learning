{%-macro limit_data_in_dev( column_name,dev_data_in_dev =3)-%}
{%-if target.name == 'default'-%}
where {{column_name}} >= dateadd('day',-{{dev_data_in_dev}} , current_timestamp)
{%-endif-%}
{%-endmacro-%}