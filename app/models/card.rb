class Card < ApplicationRecord
  belongs_to :user
  has_many :memos
    
  def self.search(query)
    if query.present?
      where("company LIKE ? OR name LIKE ? OR position LIKE ? OR license LIKE ? OR mail LIKE ? OR tell LIKE ? OR company_adress LIKE ? OR memo LIKE ?", 
      "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%",
      "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%", "%#{sanitize_sql_like(query)}%")
    else
      all
    end
  end
  
  # ユーザーの専用メモを取得
  def memo_for(user)
    (JSON.parse(memo || "{}"))[user.id.to_s]
  end
  
  # ユーザー専用メモを更新
  def update_memo_for(user, content)
    current_memo = JSON.parse(memo || "{}")
    current_memo[user.id.to_s] = content
    update(memo: current_memo.to_json)
  end

end
