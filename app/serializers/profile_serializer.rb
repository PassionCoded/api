class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :profession, :tech_of_choice, :years_experience, :willing_to_manage
end
