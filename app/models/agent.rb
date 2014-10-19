class Agent < ActiveRecord::Base
  has_many :contacts, :dependent => :destroy
  validates :name, presence: true, uniqueness: true
  attr_accessor :agent_ids, :phone
  accepts_nested_attributes_for :contacts, reject_if: :all_blank, :allow_destroy => true

  def default_contact
    if contacts.blank? || contacts.where(default: true).blank?
      return ""
    else
      contacts.where(default: true).first.phone 
    end
  end
end