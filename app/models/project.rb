# coding: utf-8
class Project < ActiveRecord::Base
  default_scope order('created_at DESC')
  validates_presence_of :name 
  validates_length_of :name, :maximum => 50
  validates_length_of :description, :maximum => 512
  
  has_many :features, :dependent => :destroy

  has_many :stakeholders
  has_many :users, :through => :stakeholders

  def userstories
    Userstory.joins(:feature => :project).where("projects.id = ?", self.id).readonly(false)
  end

end
