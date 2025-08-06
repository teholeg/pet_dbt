{{ config(materialized='table') }}

select
	c."Country_name",
	sum(re.value) as sumpost
	from  {{ source('nas_pet', 'revised') }}  re
	left join {{ source('nas_pet', 'goods_classification') }} gc on re.code =gc."NZHSC_Level_2_Code_HS4"
	left join {{ source('nas_pet', 'country_code') }} c on c.code_2digit = re.country_code
	where gc."NZHSC_Level_1" is not null
	group by c."Country_name"
