# Aseguradoras
if Insurer.count.zero?
  puts 'Creating Insurers...'
  Insurer.create([
    { description: 'IMSS' },
    { description: 'ISSSTE' },
    { description: 'SEGURO POPULAR' },
    { description: 'GASTOS MEDICOS MAYORES' },
    { description: 'OTROS' }
  ])
else
  puts 'Insurers already exist, skipping creation.'
end
