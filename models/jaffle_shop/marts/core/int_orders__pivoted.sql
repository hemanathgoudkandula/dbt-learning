{#
Basic Jinja with variables 

{% set my_string = 'Jinja test' %}
{% set my_second_string = 'Learn Jinja'%}
{% set days=4%}
{{ my_second_string }} and {{ my_string }} within {{ days }} days

List in jinja

{%set my_list =[ 1,30,'learn','USA',123]%}
{{ my_list[3] }}

{% for i in my_list%}
    {{ i }}
{%endfor%}

If Else Logic condition
{% set temperature = 80.0 %}

On a day like this, I especially like 

{% if temperature > 70.0 %} 

a refreshing mango sorbet.

{% else %}

A decadent chocolate ice cream.
{% endif %}

For loop with if else block conditions

{%- set foods = ['Carrot','Cucumber','cheese','pepsi','fish'] -%}
{% for food in foods %}
    {%- if food =='cheese' -%}
        {%- set food_type ='Butter' -%}
    {%- elif food =='pepsi' -%}
        {%- set food_type ='drink' -%}
    {%- elif food =='fish' -%}
        {%- set food_type = 'Non-Veg' -%}
    {%- else -%}
        {%- set food_type='Vegetable' -%}
    {% endif %}
    {{food}} is my favorite {{food_type}}
{% endfor -%}

Dictionary in jinja
{%set my_dict ={
    'first' : 1,
    'second' : 4234,
    'jinja' : 'dbt learning'
}%}
{{ my_dict.jinja }}
{{my_dict['first']}}

{%for i in range(1000)%}
select {{i}} as number {% if not loop.last%} union all {%endif%}
{%endfor%}
#}
/*
with payments as (
    select * from {{ref('stg_payments')}}
),
pivoted as (
    select order_id,
    sum(case when payment_method ='credit_card' then amount else 0 end ) as credit_card_amount,
    sum(case when payment_method ='coupon' then amount else 0 end ) as coupon_amount,
    sum(case when payment_method ='bank_transfer' then amount else 0 end ) as bank_transfer_amount,
    sum(case when payment_method ='gift_card' then amount else 0 end ) as gift_card_amount
    from payments
    where status = 'success'
    group by 1
)
select * from pivoted
*/


{%- set payment_methods = ['bank_transfer', 'credit_card', 'coupon', 'gift_card'] -%}

with payments as (
   select * from {{ ref('stg_payments') }}
),

final as (
   select
       order_id,
       {% for payment_method in payment_methods -%}

       sum(case when payment_method = '{{ payment_method }}' then amount else 0 end)
            as {{ payment_method }}_amount

       {%- if not loop.last -%}
         ,
       {% endif -%}

       {%- endfor %}
   from {{ ref('stg_payments') }}
   group by 1
)

select * from final
