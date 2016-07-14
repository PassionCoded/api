module ProfileHelper
  def profile_hash(title=nil, replace_data=nil)
    return_hash = {
      first_name: "Test",
      last_name: "Last",
      profession: "Web Developer",
      tech_of_choice: "JavaScript",
      years_experience: 2,
      willing_to_manage: true
    }

    return_hash[title] = "" if title && !replace_data

    return_hash[title] = replace_data if title && replace_data

    return_hash
  end

  def post_to_profile(token, data_hash)
    post "/profile", 
      { 
        profile: {
          first_name: data_hash[:first_name], 
          last_name: data_hash[:last_name], 
          profession: data_hash[:profession], 
          tech_of_choice: data_hash[:tech_of_choice], 
          years_experience: data_hash[:years_experience], 
          willing_to_manage: data_hash[:willing_to_manage]
        }
      }, {'Authorization': token}
  end

  def parse_profile(profile)
    formatted_json = {
                       first_name: profile.first_name,
                       last_name: profile.last_name,
                       profession: profile.profession,
                       tech_of_choice: profile.tech_of_choice,
                       years_experience: profile.years_experience,
                       willing_to_manage: profile.willing_to_manage
                     }
  end

  def confirm_profile_not_saved(user)
    expect(Profile.find_by(user_id: user.id)).to be_nil
  end
end
