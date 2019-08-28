class Goal < ApplicationRecord
  ALLOWABLE_TEXT_REGEX = %r{\A[a-zA-Z0-9!#$%&'*+\-/=?^_`{|},.~\s]+\z}.freeze
  ALLOWABLE_TITLE_MAX_LENGTH = 80
  ALLOWABLE_DESCRIPTION_MAX_LENGTH = 500
  ALLOWABLE_MAX_DUE_DATE_YEAR = 2100

  validates :title,
            presence: true,
            length: { maximum: ALLOWABLE_TITLE_MAX_LENGTH },
            format: { with: ALLOWABLE_TEXT_REGEX }

  validates :description,
            presence: true,
            length: { maximum: ALLOWABLE_DESCRIPTION_MAX_LENGTH },
            format: { with: ALLOWABLE_TEXT_REGEX }

  validate :due_date_cannot_be_in_the_past, :due_date_year_cannot_be_more_than_allowable, if: :due_date_changed?

  enum priority: { low: 0, medium: 1, high: 2 }

  scope :completed, -> { where(complete: true) }
  scope :incomplete, -> { where(complete: false) }

  private

  def due_date_cannot_be_in_the_past
    if due_date.present? && due_date < Time.zone.today
      errors.add(:due_date, 'cannot be earlier than today')
    end
  end

  def due_date_year_cannot_be_more_than_allowable
    if due_date.present? && due_date.to_date.year > ALLOWABLE_MAX_DUE_DATE_YEAR
      errors.add(:due_date, "a year cannot be more than #{ALLOWABLE_MAX_DUE_DATE_YEAR}")
    end
  end
end
