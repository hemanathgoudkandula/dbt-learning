{{
    config(
        materialized="table"
    )
}}

{{
    dbt_utils.date_spine(
        datepart='day',
        start_date = "to_date('01/01/2023','dd/mm/yyyy')",
        end_date = "to_date('01/01/2024','dd/mm/yyyy')"
    )
}}