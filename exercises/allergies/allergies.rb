class Allergies
  ALLERGENS = %w(eggs peanuts shellfish strawberries tomatoes chocolate pollen cats).freeze

  # assign them their powers of 2: 0x1, 0x10, 0x100, etc.
  ALLERGEN_MASKS = ALLERGENS.each_with_index.reduce({}) do |o, (allergen, i)|
    o[allergen] = 2 ** i
    o
  end.freeze

  @allergies

  def initialize(allergies)
    @allergies = allergies.to_i
  end

  def allergic_to?(allergen)
    (@allergies & ALLERGEN_MASKS[allergen]) > 0
  end

  def list
    ALLERGENS.select {|a| allergic_to?(a)}
  end
end
