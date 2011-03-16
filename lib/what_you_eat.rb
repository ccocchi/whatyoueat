# encoding: utf-8
  
# WhatYouEat
class WhatYouEat
  
  # These constants are string arrays which is simpler if you want to
  # retrieve this from a database or a file
  UNITS = [
    'g',
    'kg',
    'cl',
    'l'
  ]
  
  # Regexp as a real string
  SPECIAL_UNITS = [
    'cuill[èe]res? [àa] soupe',
    'cuill[èe]res? [àa] caf[ée]',
    'verres?',
    'bouteilles?',
    'sachets?',
    'pinc[ée]es?',
    'tasses?',
    'tranches?',
    'flacons?'
  ]
  
  NUMBERS = /un|deux|trois|quatre|cinq|six|sept|huit|neuf/

  def self.included base
    base.extend         ClassMethods
  end
  
  def initialize(options = {})
    @ingredients = []
  end
  
  module ClassMethods  
  end
  
  module InstanceMethods
    def process(recipe)
      recipe.split("\n").each { |line| 
        text_to_ingredient(line)
      }
    end
    
    def text_to_ingredient(line)
      quantity = get_quantity(line)
      return if quantity.empty?
      
      unit = get_unit(line)
    end
    
  private
    def get_quantity(line)
      quantity = line.slice!(/^\d+|\d\\\d+/)
      quantity = line.slice!(NUMBERS) if quantity.nil?
      quantity
    end
    
    def get_unit(line)
      w = line.lstrip!.split(/\s+/).first
      return w if w =~ /#{UNITS.join('|')}/
      
      line.slice!(/#{SPECIAL_UNITS.map { |u| "^#{u}"}.join('|')}/)
    end
  end
  
  include WhatYouEat::InstanceMethods
end

#WhatYouEat.process "1 poulet\n2 cuillères à café de paprika en poudre\n4 cuillères à soupe d'huile d'olive\n2 petits oignons hachés\n6 gousses d'ail hachées\n150 g de chorizo\n400 g de tomate concassées\n2 feuilles de laurier\n5 cuillères à soupe de Xeres\nsel, poivre"
#WhatYouEat.new.text_to_ingredient "3 cl"