
select
	p.id as producto_id,
  p.reference as referencia,
  p.code as codigo,
  p.name as producto,
  u.name as unidad,
  c.id as categoria_id,
  c.name as categoria,
	a.id,
	a.name as atributo,
	aa.value as valor,
	case
		when a.name = 'Vence(AAAAMMDD)' then
			STR_TO_DATE(aa.value, '%Y%m%d')
		else
			null
	end as fecha
from stockdiary sd
	join products p
	on sd.product = p.id
	join uom u
	on p.uom = u.id
	join attributesetinstance ai
	on sd.attributesetinstance_id = ai.id
	join attributeinstance aa
	on ai.id = aa.attributesetinstance_id
	join attribute a
	on aa.attribute_id = a.id
	left outer join categories c
	on p.category = c.id
order by
    c.name asc,
    p.name asc;
