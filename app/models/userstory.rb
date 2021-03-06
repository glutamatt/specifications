# coding: utf-8
class Userstory < ActiveRecord::Base 
  has_paper_trail :meta => { :project_id  => Proc.new { |userstory| userstory.feature.project.id } }, :ignore => [:position, :feature_id]
  default_scope order('position ASC')
  validates_presence_of :content 
  validates_length_of :content, :maximum => 250
  validates_presence_of :feature_id
  belongs_to :feature
  has_many :comments

  acts_as_list
end
