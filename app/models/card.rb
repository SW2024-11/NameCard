class Card < ApplicationRecord
  belongs_to :user
    
  def self.search(query)
    if query.present?
      where("company LIKE ? OR name LIKE ? OR position LIKE ? OR license LIKE ? OR mail LIKE ? OR tell LIKE ? OR company_adress LIKE ?", 
      "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%",
      "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%")
    else
      all
    end
  end

end
