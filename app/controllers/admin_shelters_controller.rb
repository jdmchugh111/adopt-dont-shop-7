class AdminSheltersController < ApplicationController
    def index
        @shelters = Shelter.reverse_alpha
        @shelters_pending = Shelter.filter_by_pending
    end
end