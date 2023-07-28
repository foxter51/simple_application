require 'pagy/extras/overflow'
require 'pagy/extras/bootstrap'

# Instance variables
Pagy::DEFAULT[:page]   = 1                                  # default
Pagy::DEFAULT[:items]  = 10
Pagy::DEFAULT[:outset] = 0                                  # default

Pagy::DEFAULT[:overflow] = :lastpage                        # default

# When you are done setting your own default freeze it, so it will not get changed accidentally
Pagy::DEFAULT.freeze
